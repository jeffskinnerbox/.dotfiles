
-- installation of the lazy.nvim plugin
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"           -- directory location where lazy will be stored (/home/jeff/.local/share/nvim/lazy/lazy.nvim)
if not (vim.uv or vim.loop).fs_stat(lazypath) then                     -- check if lazypath exist, and if not, create the path
  vim.fn.system({                                                      -- git clone the lazy.nvim plugin into lazypath
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable",                                                 -- clone the latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)                                          -- prepend to the runtime path 'lazypath' - runtime path is for searching for plugins, data, etc. NOTE: command is equivalent to vim.opt.rtp.prepend(vim.opt.rpt, lazypath)


-- asynchronous execution of plugin install and configuration
require("lazy").setup({                                                -- within the runpath, find a directory called 'lazy' and run the 'init.lua' file and execute the setup function found there

  -- dark colorscheme inspired by famous painting of katsushika hokusai
  { "rebelot/kanagawa.nvim",                                           -- load data for color scheme https://github.com/rebelot/kanagawa.nvim
    config = function()                                                -- configuration established (i.e. callback function is called) after color scheme plugin is installed
      vim.cmd.colorscheme("kanagawa-wave")                             -- set the neovim color scheme - neovim dark colorscheme inspired by the colors of the famous painting by Katsushika Hokusai - https://en.wikipedia.org/wiki/The_Great_Wave_off_Kanagawa
    end,
  },

  -- access to tree-sitter, a parser generator tool, to assit in a wide range of features
  { "nvim-treesitter/nvim-treesitter",
    config = function()
      require("nvim-treesitter.configs").setup({
        ensure_installed = { "c", "lua", "vim", "vimdoc", "query" },   -- list of parser names, or "all" (the five parsers "c", "lua", "vim", "vimdoc", "query" should always be installed)
        auto_install = true,                                           -- automatically install missing parsers if its missing, e.g. loading a python file cause python parser to be installed
        highlight = {
          enable = true,                                               -- enable highlighting
        },

        -- module enables tree-sitter pressing of a keys and treesitter will intelligently select a region that the selection should apply
        incremental_selection = {
          enable = true,
          keymaps = {
            init_selection = "<Leader>ss",                             -- selection set, set to "false" to disable one of the mappings
            node_incremental = "<Leader>si",                           -- selection incremept
            scope_incremental = "<Leader>sc",                          -- selection change scope
            node_decremental = "<Leader>sd",                           -- selection decrement
          },
        },

        -- module enables tree-sitter selection of text-objects, module enabled by the "nvim-treesitter/nvim-treesitter-textobjects" plugin below
        textobjects = {
          select = {
            enable = true,
            lookahead = true,                                          -- automatically jump forward to textobj, similar to targets.vim
            keymaps = {
              -- You can use the capture groups defined in textobjects.scm
              ["af"] = "@function.outer",
              ["if"] = "@function.inner",
              ["ac"] = "@class.outer",
              -- You can optionally set descriptions to the mappings (used in the desc parameter of
              -- nvim_buf_set_keymap) which plugins like which-key display
              ["ic"] = { query = "@class.inner", desc = "Select inner part of a class region" },
              -- You can also use captures from other query groups like `locals.scm`
              ["as"] = { query = "@scope", query_group = "locals", desc = "Select language scope" },
            },
            -- You can choose the select mode (default is charwise 'v')
            --
            -- Can also be a function which gets passed a table with the keys
            -- * query_string: eg '@function.inner'
            -- * method: eg 'v' or 'o'
            -- and should return the mode ('v', 'V', or '<c-v>') or a table
            -- mapping query_strings to modes.
            selection_modes = {
              ['@parameter.outer'] = 'v', -- charwise
              ['@function.outer'] = 'V', -- linewise
              ['@class.outer'] = '<c-v>', -- blockwise
            },
            -- if you set this to `true` (default is `false`) then any textobject is
            -- extended to include preceding or succeeding whitespace. Succeeding
            -- whitespace has priority in order to act similarly to eg the built-in
            -- `ap`.
            --
            -- can also be a function which gets passed a table with the keys
            -- * query_string: eg '@function.inner'
            -- * selection_mode: eg 'v'
            -- and should return true or false
            include_surrounding_whitespace = true,
          },
        },

      })
    end,
  },

  -- give tree-sitter syntax aware text-objects, select, move, swap, and peek support
  { "nvim-treesitter/nvim-treesitter-textobjects", 
  }, 

})

