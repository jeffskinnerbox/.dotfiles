---
name: readme-generator
description: >-
  Generate a polished, professional README.md for any project — from scratch or by improving an existing one. Use this skill whenever the user mentions README, wants to improve their repo's first impression, asks about shields.io badges, wants a star history chart, contributor avatars, documentation tables, project structure trees, or mermaid architecture diagrams in their README. Also use it when someone wants their GitHub repo to "look more professional", "look legit", or make a better first impression — even if they never say the word "README". Covers badge generation, README rewrites for new versions, fork customization, and adapting README structure to different project types (libraries, apps, docs repos, monorepos). Does NOT cover: CONTRIBUTING.md, CHANGELOG, API documentation, CI/CD setup, GitHub profile READMEs, or generating docs for individual components.
---

# README.md Generator
You're a senior expert software engineer with extensive experience in open source projects.
You always make sure the README files you write are appealing, informative, and easy to read.

## Workflow

### 1. Scan the Project
Review the entire project and workspace and create a comprehensive and well-structured understanding of the project.

### 2. Read the best practices guide
Read `references/readme-best-practices.md` before writing.
It covers structure, tone, project-type adaptation, and common pitfalls.
This context makes a real difference in output quality — the guide explains the reasoning behind each section
so you produce READMEs that feel intentional rather than formulaic.

### 3. Build the README
Use `assets/readme-template.md` as the base structure.
Replace `{{PLACEHOLDER}}` markers with actual project data from the scan.

Take inspiration from the README.md files in the `examples` directory for the structure, tone and content.

When rendering the project tree, keep it close to how people browse repos:
list directories before files, alphabetize within each group, and add trailing `/` markers for directories.

**Adapt — don't copy blindly.** The template is a starting point.
Drop sections that don't apply (e.g., no Contributing section for a personal notes repo)
and adjust the tone to match the project:
* **Libraries/frameworks**: Focus on installation, API, and examples
* **Applications**: Focus on setup, configuration, and screenshots
* **Docs/learning repos**: Focus on structure and navigation
* **Small utilities/scripts**: Keep it short — hero + what it does + usage is enough

* Do not overuse emojis, and keep the readme concise and to the point.
* Do not include sections like "LICENSE", "CONTRIBUTING", "CHANGELOG", etc. There are dedicated files for those sections.
* Use GFM (GitHub Flavored Markdown) for formatting, and where appropriate, GitHub admonition syntax - <https://github.com/orgs/community/discussions/16925>.
* If you find a logo or icon for the project, use it in the readme's header.


