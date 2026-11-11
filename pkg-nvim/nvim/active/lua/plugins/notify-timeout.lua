-- keep notifications (incl. formatter errors) on screen longer (ms)
return {
  {
    "folke/snacks.nvim",
    opts = {
      notifier = { timeout = 10000 },
    },
  },
  {
    "folke/noice.nvim",
    optional = true,
    opts = {
      routes = {
        {
          -- error-level messages stay even longer
          filter = { event = "notify", error = true },
          opts = { timeout = 20000 },
        },
      },
    },
  },
}
