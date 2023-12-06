
--------------------------------------------------------------------------------
-- editor-advanced/whichkey.lua

-- Nobody is going to remember all the key bindings available in Neovim.
-- WhichKey is a lua plugin that displays a popup with possible key bindings
-- of the command you started typing.
--
-- Built-in plugins:
--    marks: shows your marks when you hit one of the jump keys.
--    registers: shows a list of your buffer local and global registers when you hit " in NORMAL mode, or <c-r> in INSERT mode.
--    presets: Built-in key binding help for motions, text-objects, operators, windows, nav, z and g
--    spelling: Hooks into 'z=' and replaces the full-screen spelling suggestions window by a list of suggestions within WhichKey

-- You can manually open WhichKey for a certain prefix:
--    :WhichKey                - show all mappings
--    :WhichKey <leader>       - show all <leader> mappings
--    :WhichKey <leader> v     - show all <leader> mappings for VISUAL mode
--    :WhichKey v              - show ALL mappings for VISUAL mode

-- NOTE:
-- You can run `:checkhealth which-key` to see if there's any conflicting keymaps
-- that will prevent triggering WhichKey

-- Sources:
--    [GitHub: folke/which-key.nvim](https://github.com/folke/which-key.nvim)
--    [Neovim for Beginners — Key Mappings and WhichKey](https://alpha2phi.medium.com/neovim-for-beginners-key-mappings-and-whichkey-31dbf58f9f87)
--------------------------------------------------------------------------------


-- if you haven't loaded this plugin, do no operation and return
local status_ok, lightline = pcall(require, "which-key")
if not status_ok then
  print("'configs/which-key.lua' module had an error")
  return
end


-- with this, when we press the <leader> key, WhichKey will displays a popup with the key mappings we defined
local M = {}

function M.setup()
  local whichkey = require "which-key"

  local conf = {
    window = {
      border = "single",              -- nllowed values: one, single, double, shadow
      position = "bottom",            -- allowed values: bottom, top
    },
  }

  local opts = {
    mode = "n",                       -- normal mode
    prefix = "<leader>",
    buffer = nil,                     -- global mappings. specify a buffer number for buffer local mappings
    silent = true,                    -- use `silent` when creating keymaps
    noremap = true,                   -- use `noremap` when creating keymaps
    nowait = false,                   -- use `nowait` when creating keymaps
  }

  local mappings = {
    ["w"] = { "<cmd>update!<CR>", "Save" },
    ["q"] = { "<cmd>q!<CR>", "Quit" },

    b = {
      name = "Buffer",
      c = { "<Cmd>bd!<Cr>", "Close current buffer" },
      D = { "<Cmd>%bd|e#|bd#<Cr>", "Delete all buffers" },
    },

    z = {
      name = "Packer",
      c = { "<cmd>PackerCompile<cr>", "Compile" },
      i = { "<cmd>PackerInstall<cr>", "Install" },
      s = { "<cmd>PackerSync<cr>", "Sync" },
      S = { "<cmd>PackerStatus<cr>", "Status" },
      u = { "<cmd>PackerUpdate<cr>", "Update" },
    },

    g = {
      name = "Git",
      s = { "<cmd>Neogit<CR>", "Status" },
    },
  }

  whichkey.setup(conf)
  whichkey.register(mappings, opts)
end

return M

