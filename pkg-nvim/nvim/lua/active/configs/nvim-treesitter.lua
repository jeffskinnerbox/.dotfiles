
--------------------------------------------------------------------------------
-- active/nvim-treesitter.lua

-- nvim-treesiter can provide both a simple and easy way to use the interface
-- for tree-sitter in Neovim and to provide some basic functionality such as
-- highlighting code.

-- Commandline
--    :TSInstallInfo             - use this command to check if the {lang} language is installed
--    :TSInstall {lang}          - install one or more treesitter parsers
--    :TSUpdate {lang}           - update the installed parser for one more {{lang} language}
--    :TSUpdate                  - update the installed parser for all languages
--    :TSBufEnable {lang}        - enable {lang} language on current buffer
--    :TSBufDisable {lang}       - disable {lang} language on current buffer
--    :TSEnable {lang} [{ft}]    - enable {lang} language on every buffer. if filetype is specified, enable only for {ft} filetype.
--    :TSDisable {lang} [{ft}]   - disable {lang} language on every buffer. if filetype is specified, disable only for {ft} filetype.

-- NOTE:
--   (1) Set nvim native syntax highlighting to 'off' (vim.opt.syntax = 'off') when using treesitter
--   (2) Users of packer.nvim have reported that when using treesitter for folds, they sometimes receive an error 'No folds found', or that treesitter highlighting does not apply.

-- Sources:
--    [Tree-sitter for Dummies](https://www.youtube.com/watch?v=oSrXK8ovBfQ)
--    [Neovim and Tree-sitter: An Overview with Examples](https://thevaluable.dev/tree-sitter-neovim-overview/)
--    [GitHub: nvim-treesitter/nvim-treesitter](https://github.com/nvim-treesitter/nvim-treesitter)
--    [GitHub: nvim-treesitter/nvim-treesitter-refactor](https://github.com/nvim-treesitter/nvim-treesitter-refactor)
--------------------------------------------------------------------------------


-- if you haven't loaded this plugin, do no operation and return
--local status_ok, treesitter = pcall(require, 'nvim-treesitter.configs')
local status_ok, configs = pcall(require, 'nvim-treesitter.configs')
if not status_ok then
  print("'configs/nvim-treesitter.lua' module had an error")
  return
end


require('nvim-treesitter.configs').setup {
  ensure_installed = { 'awk', 'bash', 'c', 'cpp', 'lua', 'arduino',
    'dockerfile', 'vimdoc', 'gitignore', 'make', 'regex', 'html', 'javascript',
    'json', 'python', 'css',  'java', 'yaml', 'markdown', 'markdown_inline' }, -- install these languges - find supported languages at https://github.com/nvim-treesitter/nvim-treesitter#supported-languages
  sync_install = false,            -- install parsers synchronously, only applied to 'ensure_installed'
  auto_install = false,            -- automatically install missing parsers when entering buffer, recommendation - set to false if you don't have `tree-sitter` CLI installed locally
  ignore_install = { 'matlab', 'sql' },   -- list of parsers to ignore installing (for 'all')
	highlight = {
	  enable = true,                 -- false will disable the whole extension
    additional_vim_regex_highlighting = false,
  },
  indent = {
	  enable = true,                 -- enable automatic indentation (default is false)
  },
  refactor = {                     -- features provided by nvim-treesitter/nvim-treesitter-refactor plugin
    highlight_definitions = {      -- highlights the block from the current scope where the cursor is
      enable = true,
      clear_on_cursor_move = true, -- set to false if you have an `updatetime` of ~100
    },
    smart_rename = {               -- renames the symbol under the cursor within the current scope (and current file)
      enable = true,
      keymaps = {                  -- assign keymaps to false to disable them, e.g. `smart_rename = false`
        smart_rename = 'grr',
      },
    },
    navigation = {                 -- provides 'go to definition' for the symbol under the cursor, and lists the definitions from the current file
      enable = true,
      keymaps = {                  -- assign keymaps to false to disable them, e.g. `goto_definition = false`
        goto_definition = 'gnd',
        list_definitions = 'gnD',
        list_definitions_toc = 'gO',
        goto_next_usage = '<a-*>',
        goto_previous_usage = '<a-#>',
      },
    },
  },
}


-- alias the vim.opt meta-accessor to a local Lua variable
local o = vim.opt                            -- globally scoped editor variables
local g = vim.g                              -- globally scoped editor variables
local b = vim.bo                             -- buffer scoped
local w = vim.wo                             -- window scoped

-- line folding (this overrides neovim native folding)
o.foldmethod = 'expr'                        -- no longer using native neovim folding
o.foldexpr = 'nvim_treesitter#foldexpr()'    -- treesitter will provided folding

