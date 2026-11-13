-- shared config checker-files/.markdownlint-cli2.jsonc has "globs": ["**/*.md"] and "fix": true,
-- so `markdownlint-cli2 --fix <file>` also lints (and may rewrite) every *.md under the project
-- root: ~2s in ~/.dotfiles, minutes from $HOME -> conform "Formatter 'markdownlint-cli2' timeout".
-- --no-globs limits the run to the file being saved (~0.3s). the shared config is left untouched,
-- so a bare `markdownlint-cli2` on the command line still lints the whole repo.
-- the same applies to the live-diagnostics linter (nvim-lint), which runs `markdownlint-cli2 -`
-- from the project root (~1.9s -> ~0.4s with --no-globs).
return {
  {
    "stevearc/conform.nvim",
    optional = true,
    opts = {
      formatters = {
        ["markdownlint-cli2"] = {
          args = { "--fix", "--no-globs", "$FILENAME" },
        },
      },
    },
  },
  {
    "mfussenegger/nvim-lint",
    optional = true,
    opts = {
      linters = {
        ["markdownlint-cli2"] = {
          args = { "--no-globs", "-" },
        },
      },
    },
  },
}
