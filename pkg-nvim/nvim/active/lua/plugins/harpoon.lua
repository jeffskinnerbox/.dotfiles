-- luacheck: globals vim
-- luacheck: max line length 300

--[[ A plugin that displays a pop-up with possible keybindings of the command you started typing
kickstart2/lua/kickstart/plugins/autopairs.lua

  Description:
    describe what this plugin does

  Definitions:
    Definitions of phrases when it could be helpful.

  Usage:
    list the most significant commandline and keymap operations

    Commandline
      None that I'm using or aware of.
      :nmap                    - for list of normal mode key mappings

    Keymapped Commands
      None that I'm using or aware of.
      <leader>sp               - toggle spell checking

  Alternatives:

  Sources:
    [GitHub: ThePrimeagen/harpoon](https://github.com/ThePrimeagen/harpoon/tree/harpoon2)
    [harpoon - Weekly Neovim Plugin](https://www.youtube.com/watch?v=Ioxsn-tsQqo&t=32s)
    [You don’t need tabs in Neovim](https://medium.com/@jogarcia/you-dont-need-tabs-in-neovim-c6ba5ee44e3e)

   NOTE: list anything worth noting
   BUG: list any known bugs
]]


return {
  "ThePrimeagen/harpoon",
  enabled = false,                                                               -- load the plugin if 'true' but skip completely if 'false'
  lazy = true,                                                                  -- 'true' means lazy load this plugin and so it is loaded when its needed
  branch = "harpoon2",
  dependencies = {
    "nvim-lua/plenary.nvim",
    'nvim-telescope/telescope.nvim',    -- NOTE: make sure to paste this into telescope - https://github.com/ThePrimeagen/harpoon/tree/harpoon2?tab=readme-ov-file#telescope
  },
  config = function()
    require('harpoon').setup({
      global_settings = {
        save_on_toggle = false,                                                 -- sets the marks upon calling `toggle` on the ui, instead of require `:w`.
        save_on_change = true,                                                  -- saves the harpoon file upon every change. disabling is unrecommended.
        enter_on_sendcmd = false,                                               -- sets harpoon to run the command immediately as it's passed to the terminal when calling `sendCommand`.
        tmux_autoclose_windows = false,                                         -- closes any tmux windows harpoon that harpoon creates when you close Neovim.
        excluded_filetypes = { "harpoon" },                                     -- filetypes that you want to prevent from adding to the harpoon list menu.
        mark_branch = true,                                                     -- set marks specific to each git branch inside git repository, each branch will have it's own set of marked files

        -- enable tabline with harpoon marks
        tabline = false,
        tabline_prefix = "   ",
        tabline_suffix = "   ",
      }
    })

    -- harpoon key mappings
    -- NOTE: See this for more ideas - https://medium.com/@jogarcia/you-dont-need-tabs-in-neovim-c6ba5ee44e3e
    -- vim.keymap.set('n', '<leader>Hx', require('harpoon.mark').add_file)
    vim.keymap.set('n', '<leader>Hn', require('harpoon.ui').nav_next)
    vim.keymap.set('n', '<leader>Hp', require('harpoon.ui').nav_prev)
    require('utils').map('n', [[<leader>Hm]], ':Telescope harpoon marks<cr>')

    -- harpoon which-key mappings
    require("which-key").register({
      H = {                                                                     -- the first key you are pressing
        name = "Harpoon",
        x = { function()                                                        -- the second key you press
        require('harpoon.mark').add_file()
        end, "Mark file" }
      },
    }, { prefix = "<leader>" })
  end,
}

