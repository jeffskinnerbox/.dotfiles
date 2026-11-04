-- prettier for json/jsonc only (not the full formatting.prettier extra,
-- which also hooks markdown, yaml, css, js, etc.)
return {
  {
    "mason-org/mason.nvim",
    opts = { ensure_installed = { "prettier" } },
  },
  {
    "stevearc/conform.nvim",
    optional = true,
    opts = {
      formatters_by_ft = {
        json = { "prettier" },
        jsonc = { "prettier" },
      },
    },
  },
}
