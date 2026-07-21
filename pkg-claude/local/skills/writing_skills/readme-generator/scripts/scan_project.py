#!/usr/bin/env python3
"""
scan_project.py — deterministic project scanner for README generation.

Walks a project directory and extracts structured facts: languages present,
parsed manifest data (deps, scripts, entry points), license, CI config,
test setup, Docker usage, existing README, and a trimmed directory tree.

Usage:
    python scan_project.py <project_root> [--max-depth 3] [--max-entries 400]

Outputs a single JSON object to stdout. This script is deliberately dumb —
it reports what's on disk, it does not guess what the project *does*.
That interpretive step is left to the calling model (see SKILL.md).
"""
import argparse
import json
import os
import re
import sys

try:
    import tomllib  # Python 3.11+
except ModuleNotFoundError:
    tomllib = None

IGNORE_DIRS = {
    ".git", "node_modules", "venv", ".venv", "env", "__pycache__",
    "dist", "build", ".next", "target", "vendor", ".idea", ".vscode",
    "coverage", ".pytest_cache", ".mypy_cache", ".tox", ".ruff_cache",
    "site-packages", ".eggs", "htmlcov",
}
IGNORE_SUFFIXES = (".egg-info", ".dist-info")

LANG_BY_EXT = {
    ".py": "Python", ".ipynb": "Python",
    ".js": "JavaScript", ".jsx": "JavaScript", ".mjs": "JavaScript",
    ".ts": "TypeScript", ".tsx": "TypeScript",
    ".go": "Go", ".rs": "Rust", ".rb": "Ruby", ".php": "PHP",
    ".java": "Java", ".kt": "Kotlin", ".c": "C", ".h": "C",
    ".cpp": "C++", ".cc": "C++", ".hpp": "C++",
    ".cs": "C#", ".swift": "Swift", ".m": "Objective-C",
    ".sh": "Shell", ".sql": "SQL", ".r": "R", ".scala": "Scala",
}

LICENSE_KEYWORDS = [
    ("MIT License", "MIT"),
    ("Apache License", "Apache-2.0"),
    ("GNU GENERAL PUBLIC LICENSE", "GPL"),
    ("GNU LESSER GENERAL PUBLIC LICENSE", "LGPL"),
    ("BSD 3-Clause", "BSD-3-Clause"),
    ("BSD 2-Clause", "BSD-2-Clause"),
    ("Mozilla Public License", "MPL-2.0"),
    ("The Unlicense", "Unlicense"),
    ("ISC License", "ISC"),
]


def should_ignore(dirname):
    return dirname in IGNORE_DIRS or dirname.startswith(".") and dirname not in {".github"}


def walk(root, max_depth, max_entries):
    """Return (tree_lines, all_files) with common noise directories pruned."""
    tree_lines = []
    all_files = []
    entry_count = 0

    def _walk(path, depth, prefix):
        nonlocal entry_count
        if depth > max_depth or entry_count >= max_entries:
            return
        try:
            entries = sorted(os.listdir(path))
        except PermissionError:
            return
        dirs = [e for e in entries if os.path.isdir(os.path.join(path, e)) and not should_ignore(e)
                and not e.endswith(IGNORE_SUFFIXES)]
        files = [e for e in entries if os.path.isfile(os.path.join(path, e)) and not e.startswith(".DS_Store")]

        for f in files:
            if entry_count >= max_entries:
                tree_lines.append(f"{prefix}... (truncated)")
                return
            tree_lines.append(f"{prefix}{f}")
            all_files.append(os.path.relpath(os.path.join(path, f), root))
            entry_count += 1

        for d in dirs:
            if entry_count >= max_entries:
                tree_lines.append(f"{prefix}... (truncated)")
                return
            tree_lines.append(f"{prefix}{d}/")
            entry_count += 1
            _walk(os.path.join(path, d), depth + 1, prefix + "    ")

    _walk(root, 0, "")
    return tree_lines, all_files


def read(path):
    try:
        with open(path, "r", encoding="utf-8", errors="ignore") as f:
            return f.read()
    except OSError:
        return ""


def detect_languages(all_files):
    counts = {}
    for rel in all_files:
        ext = os.path.splitext(rel)[1].lower()
        lang = LANG_BY_EXT.get(ext)
        if lang:
            counts[lang] = counts.get(lang, 0) + 1
    return dict(sorted(counts.items(), key=lambda kv: -kv[1]))


def parse_package_json(root):
    p = os.path.join(root, "package.json")
    if not os.path.isfile(p):
        return None
    try:
        data = json.loads(read(p))
    except json.JSONDecodeError:
        return {"error": "package.json present but failed to parse"}
    return {
        "name": data.get("name"),
        "version": data.get("version"),
        "description": data.get("description"),
        "scripts": data.get("scripts", {}),
        "dependencies": list(data.get("dependencies", {}).keys()),
        "devDependencies": list(data.get("devDependencies", {}).keys()),
        "bin": data.get("bin"),
        "main": data.get("main"),
        "license": data.get("license"),
        "repository": data.get("repository"),
    }


def parse_pyproject(root):
    p = os.path.join(root, "pyproject.toml")
    if not os.path.isfile(p):
        return None
    raw = read(p)
    if tomllib:
        try:
            data = tomllib.loads(raw)
        except Exception:
            data = {}
        proj = data.get("project", {})
        poetry = data.get("tool", {}).get("poetry", {})
        if proj:
            return {
                "name": proj.get("name"),
                "version": proj.get("version"),
                "description": proj.get("description"),
                "dependencies": proj.get("dependencies", []),
                "scripts": proj.get("scripts", {}),
                "license": proj.get("license"),
                "requires_python": proj.get("requires-python"),
                "build_backend": "pep621",
            }
        if poetry:
            return {
                "name": poetry.get("name"),
                "version": poetry.get("version"),
                "description": poetry.get("description"),
                "dependencies": list(data.get("tool", {}).get("poetry", {}).get("dependencies", {}).keys()),
                "scripts": poetry.get("scripts", {}),
                "license": poetry.get("license"),
                "build_backend": "poetry",
            }
    # Fallback: crude regex if tomllib unavailable or section missing
    name = re.search(r'name\s*=\s*"([^"]+)"', raw)
    desc = re.search(r'description\s*=\s*"([^"]+)"', raw)
    return {"name": name.group(1) if name else None,
            "description": desc.group(1) if desc else None,
            "note": "parsed via regex fallback, may be incomplete"}


def parse_requirements_txt(root):
    p = os.path.join(root, "requirements.txt")
    if not os.path.isfile(p):
        return None
    lines = [l.strip() for l in read(p).splitlines() if l.strip() and not l.strip().startswith("#")]
    return lines


def parse_cargo_toml(root):
    p = os.path.join(root, "Cargo.toml")
    if not os.path.isfile(p):
        return None
    raw = read(p)
    if tomllib:
        try:
            data = tomllib.loads(raw)
            pkg = data.get("package", {})
            return {
                "name": pkg.get("name"),
                "version": pkg.get("version"),
                "description": pkg.get("description"),
                "license": pkg.get("license"),
                "dependencies": list(data.get("dependencies", {}).keys()),
            }
        except Exception:
            pass
    name = re.search(r'name\s*=\s*"([^"]+)"', raw)
    return {"name": name.group(1) if name else None, "note": "regex fallback"}


def parse_go_mod(root):
    p = os.path.join(root, "go.mod")
    if not os.path.isfile(p):
        return None
    raw = read(p)
    module = re.search(r'^module\s+(\S+)', raw, re.MULTILINE)
    go_version = re.search(r'^go\s+(\S+)', raw, re.MULTILINE)
    requires = re.findall(r'^\s*([\w./-]+)\s+v[\d.]+', raw, re.MULTILINE)
    return {
        "module": module.group(1) if module else None,
        "go_version": go_version.group(1) if go_version else None,
        "requires": requires[:20],
    }


def parse_gemfile(root):
    p = os.path.join(root, "Gemfile")
    if not os.path.isfile(p):
        return None
    gems = re.findall(r'gem\s+["\']([^"\']+)["\']', read(p))
    return {"gems": gems}


def parse_composer_json(root):
    p = os.path.join(root, "composer.json")
    if not os.path.isfile(p):
        return None
    try:
        data = json.loads(read(p))
    except json.JSONDecodeError:
        return {"error": "composer.json present but failed to parse"}
    return {
        "name": data.get("name"),
        "description": data.get("description"),
        "require": list(data.get("require", {}).keys()),
        "license": data.get("license"),
    }


def detect_license(root):
    for fname in ("LICENSE", "LICENSE.md", "LICENSE.txt", "COPYING"):
        p = os.path.join(root, fname)
        if os.path.isfile(p):
            text = read(p)[:2000]
            for needle, spdx in LICENSE_KEYWORDS:
                if needle.lower() in text.lower():
                    return {"file": fname, "spdx_guess": spdx}
            return {"file": fname, "spdx_guess": None}
    return None


def detect_ci(root):
    found = []
    gh_workflows = os.path.join(root, ".github", "workflows")
    if os.path.isdir(gh_workflows):
        found.append({"system": "GitHub Actions", "files": sorted(os.listdir(gh_workflows))})
    for fname, system in [
        (".gitlab-ci.yml", "GitLab CI"),
        (".travis.yml", "Travis CI"),
        ("Jenkinsfile", "Jenkins"),
        (".circleci/config.yml", "CircleCI"),
        ("azure-pipelines.yml", "Azure Pipelines"),
    ]:
        if os.path.isfile(os.path.join(root, fname)):
            found.append({"system": system, "files": [fname]})
    return found


def detect_tests(root, all_files):
    signals = []
    for rel in all_files:
        base = os.path.basename(rel)
        if base in ("pytest.ini", "tox.ini", "jest.config.js", "jest.config.ts", "karma.conf.js"):
            signals.append(base)
    has_test_dir = any(part in ("test", "tests", "__tests__", "spec") for f in all_files for part in f.split(os.sep)[:-1])
    return {"config_files": signals, "has_test_directory": has_test_dir}


def detect_docker(root):
    files = [f for f in ("Dockerfile", "docker-compose.yml", "docker-compose.yaml", "compose.yaml")
             if os.path.isfile(os.path.join(root, f))]
    return files or None


def detect_readme(root):
    for fname in ("README.md", "README.rst", "README.txt", "README"):
        p = os.path.join(root, fname)
        if os.path.isfile(p):
            content = read(p)
            return {"file": fname, "length_chars": len(content), "first_500_chars": content[:500]}
    return None


def main():
    ap = argparse.ArgumentParser()
    ap.add_argument("project_root")
    ap.add_argument("--max-depth", type=int, default=3)
    ap.add_argument("--max-entries", type=int, default=400)
    args = ap.parse_args()

    root = os.path.abspath(args.project_root)
    if not os.path.isdir(root):
        print(json.dumps({"error": f"not a directory: {root}"}))
        sys.exit(1)

    tree_lines, all_files = walk(root, args.max_depth, args.max_entries)

    result = {
        "project_root": root,
        "project_name_guess": os.path.basename(root),
        "directory_tree": "\n".join(tree_lines),
        "file_count_scanned": len(all_files),
        "languages": detect_languages(all_files),
        "manifests": {
            "package_json": parse_package_json(root),
            "pyproject_toml": parse_pyproject(root),
            "requirements_txt": parse_requirements_txt(root),
            "cargo_toml": parse_cargo_toml(root),
            "go_mod": parse_go_mod(root),
            "gemfile": parse_gemfile(root),
            "composer_json": parse_composer_json(root),
        },
        "license": detect_license(root),
        "ci": detect_ci(root),
        "tests": detect_tests(root, all_files),
        "docker": detect_docker(root),
        "existing_readme": detect_readme(root),
    }
    print(json.dumps(result, indent=2))


if __name__ == "__main__":
    main()
