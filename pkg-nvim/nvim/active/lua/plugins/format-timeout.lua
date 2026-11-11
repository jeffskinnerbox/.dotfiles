-- markdownlint-cli2 is a node CLI; startup + lint often exceeds conform's
-- default 1000ms timeout on :w. Raise the format-on-save timeout.
return {
  {
    "stevearc/conform.nvim",
    optional = true,
    opts = {
      default_format_opts = { timeout_ms = 5000 },
    },
  },
}
