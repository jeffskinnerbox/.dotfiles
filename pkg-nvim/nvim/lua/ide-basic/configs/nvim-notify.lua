
--------------------------------------------------------------------------------
-- ide-basic/notify.lua

-- This plugin provides better notification that is fancy and configurable.
-- Other plugins can use the 'notify' notification windows by setting it as
-- your default notify function by putting 'vim.notify = require("notify")'
-- in your 'settings.lua' file. 'notify' also integrates with Telescope so you
-- can search the history using the ':Telescope notify command'.

-- Commandline
--    :Notifications        -- this will give you history list of notifications
--    :Telescope notify     -- this will give you history list of notifications you can search with Telescope

-- Sources:
--    [Neovim Plugin (Fancy Notifications And More Fancy Plugins) - Configuring Neovim #3](https://www.youtube.com/watch?v=819HwPQWWJo)
--    [GitHub: rcarriga/nnvim-notify](https://github.com/rcarriga/nvim-notify)
--------------------------------------------------------------------------------


-- if you haven't loaded this plugin, do no operation and return
local status_ok, run = pcall(require, "notify")
if not status_ok then
  print("'configs/nvim-notify.lua' module had an error")
  return
end


require('notify').setup {
  background_colour = "NotifyBackground",
  fps = 30,
  icons = {
    DEBUG = "",
    ERROR = "",
    INFO = "",
    TRACE = "✎",
    WARN = ""
  },
  level = 2,
  minimum_width = 50,
  render = "default",             -- valid values: default, minimal, simple, compact
  stages = "fade_in_slide_out",   -- valid values: fade_in_slide_out, fade, slide, static
  timeout = 5000,                 -- display notification for this many milliseconds,  0 to make them sticky
  top_down = true
}

-- replace native notification handler (:messages) by plugin 'notify'
vim.notify = require("notify")

