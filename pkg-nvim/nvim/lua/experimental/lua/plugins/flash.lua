
--[[
  [GitHub: folke/flash.nvim](https://github.com/folke/flash.nvim)
  [Which is Better Flash.nvim OR Leap.nvim?](https://www.youtube.com/watch?v=eJ3XV-3uoug)
--]]


return {
  "folke/flash.nvim",
  enabled = false,                                                               -- load the plugin if 'true' but skip completely if 'false'
  event = "VeryLazy",
  ---@type Flash.Config
  opts = {},
  -- stylua: ignore
  keys = {
    { "s", mode = { "n", "x", "o" }, function() require("flash").jump() end, desc = "Flash" },
    { "S", mode = { "n", "x", "o" }, function() require("flash").treesitter() end, desc = "Flash Treesitter" },
    { "r", mode = "o", function() require("flash").remote() end, desc = "Remote Flash" },
    { "R", mode = { "o", "x" }, function() require("flash").treesitter_search() end, desc = "Treesitter Search" },
    { "<c-s>", mode = { "c" }, function() require("flash").toggle() end, desc = "Toggle Flash Search" },
  },
}

