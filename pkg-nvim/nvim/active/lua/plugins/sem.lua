-- sem: semantic file search (~/src/sem/nvim)
return {
  {
    dir = "~/src/sem/nvim",
    name = "sem",
    dependencies = { "nvim-telescope/telescope.nvim" },
    cmd = "Sem",
    config = function()
      require("sem").setup({ max_results = 15 })
    end,
    keys = {
      {
        "<leader>fs",
        function()
          require("sem").picker()
        end,
        desc = "Semantic search",
      },
    },
  },
}
