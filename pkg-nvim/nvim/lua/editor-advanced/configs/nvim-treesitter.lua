
--------------------------------------------------------------------------------
-- editor-advanced/nvim-treesitter.lua

-- nvim-treesiter can provide both a simple and easy way to use the interface
-- for tree-sitter in Neovim and to provide some basic functionality such as
-- highlighting based on it.

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
--   (2) Users of packer.nvim have reported that when using treesitter for folds, they sometimes receive an error "No folds found", or that treesitter highlighting does not apply.

-- Sources:
--   [Tree-sitter for Dummies](https://www.youtube.com/watch?v=oSrXK8ovBfQ)
--   [Neovim and Tree-sitter: An Overview with Examples](https://thevaluable.dev/tree-sitter-neovim-overview/)
--   [GitHub: nvim-treesitter/nvim-treesitter](https://github.com/nvim-treesitter/nvim-treesitter)
--------------------------------------------------------------------------------


-- if you haven't loaded this plugin, do no operation and return
--local status_ok, treesitter = pcall(require, "nvim-treesitter.configs")
local status_ok, configs = pcall(require, "nvim-treesitter.configs")
if not status_ok then
  print("'configs/nvim-treesitter.lua' module had an error")
  return
end


require("nvim-treesitter.configs").setup {
  ensure_installed = { "awk", "bash", "c", "cpp", "lua", "arduino", "dockerfile", "vimdoc", "gitignore", "make", "regex", "html", "javascript", "json", "lua", "python",  "css",  "java", "yaml", "markdown", "markdown_inline" }, -- install these languges - find supported languages at https://github.com/nvim-treesitter/nvim-treesitter#supported-languages
  sync_install = false,            -- install parsers synchronously, only applied to 'ensure_installed'
  auto_install = false,            -- automatically install missing parsers when entering buffer, recommendation - set to false if you don't have `tree-sitter` CLI installed locally
}


-- THIS APPEARS TO CAUSE PROBLEMS
--require("nvim-treesitter.configs").setup({
--  ensure_installed = { "awk", "bash", "c", "cpp", "lua", "arduino", "dockerfile", "vimdoc", "gitignore", "make", "regex", "html", "javascript", "json", "lua", "python",  "css",  "java", "yaml", "markdown", "markdown_inline" }, -- supported languages - https://github.com/nvim-treesitter/nvim-treesitter#supported-languages
--	ignore_install = { "phpdoc" },   -- list of parsers to ignore installing (for when install "all")
--  sync_install = false,            -- install parsers synchronously, only applied to 'ensure_installed'
--  auto_install = false,            -- automatically install missing parsers when entering buffer, recommendation - set to false if you don't have `tree-sitter` CLI installed locally
--	highlight = {
--		enable = true,                 -- false will disable the whole extension
--		disable = { "corn" },          -- list of language that will be disabled, potentially because its not being maintained
--	},
--	autopairs = {
--		enable = true,
--	},
--	indent = { enable = true, disable = { "tsx", "css" } },
--})

