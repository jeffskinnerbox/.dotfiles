--[[ A plugin that displays a pop-up with possible keybindings of the command you started typing
kickstart2/lua/kickstart/plugins/autopairs.lua

  Description:
    The goal of this plugin is both to provide a simple and easy way to use
    the interface for the command-line tool 'tree-sitter' within Neovim
    and to provide some basic functionality such as highlighting based on it.

    Neovim supports semantic highlighting by default but several things particularly
    helpful about the Tree-sitter integration in Neovim:
        * Text Objects -- Navigating things like a function, a parameter, a class,
          a conditional statement, a loop, ..., becomes the same in every language.
          No more need for (potentially complex) language-specific text objects.
        * Nested Syntax -- Particularly useful for snippets nested inside documentation
          such as markdown, or inside CI configurations for GitHub Actions
          and similar CI oriented tools.
        * Accurate Syntax Highlighting -- It is almost always precise and
          the colorschemes manages to cleverly take advantage of the richness
          of highlight groups often increase readability.
        * Treesitter Econsystem -- It sets the foundation for some great plugins
          that are language aware.

  Usage:
    list the most significant commandline and keymap operations

    Commandline
      :TSInstall <language>    - install the parser for <language>
      :TSInstallInfo           - list information about currently installed parsers
      :TSModuleInfo            - list the state for all modules for the current session in a new buffer

    Keymapped Commands
      None that I'm using or aware of.

  Sources:
    [GitHub: nvim-treesitter/nvim-treesitter](https://github.com/nvim-treesitter/nvim-treesitter)
    [Trtee-sitter](https://tree-sitter.github.io/tree-sitter/)
    [tree-sitter explained](https://www.youtube.com/watch?v=09-9LltqWLY)
    [Tree-sitter for Dummies](https://www.youtube.com/watch?v=oSrXK8ovBfQ)
    [Understanding Neovim #4 - Treesitter](https://www.youtube.com/watch?v=kYXcxJxJVxQ)
    [LSP Explained (in 5 Minutes)](https://www.youtube.com/watch?v=LaS32vctfOY)
]]

return {
  { -- Highlight, edit, and navigate code
    'nvim-treesitter/nvim-treesitter',
    enabled = true,
    build = ':TSUpdate',
    dependencies = {
      { 'nvim-treesitter/nvim-treesitter-textobjects' }, -- syntax aware text-objects
      {
        'nvim-treesitter/nvim-treesitter-context', -- show code context
        opts = {
          enable = true,
          mode = 'topline',
          line_numbers = true,
        },
      },
    },
    opts = {
      ensure_installed = {
        'bash',
        'c',
        'diff',
        'html',
        'lua',
        'luadoc',
        'markdown',
        'vim',
        'vimdoc',
        'csv',
        'dockerfile',
        'gitignore',
        'go',
        'javascript',
        'markdown',
        'python',
      },
      -- Autoinstall languages that are not installed
      auto_install = true,
      highlight = {
        enable = true,
        -- Some languages depend on vim's regex highlighting system (such as Ruby) for indent rules.
        --  If you are experiencing weird indenting issues, add the language to
        --  the list of additional_vim_regex_highlighting and disabled languages for indent.
        additional_vim_regex_highlighting = { 'ruby' },
      },
      indent = { enable = true, disable = { 'ruby' } },
      textobjects = { select = { enable = true, lookahead = true } },
    },
    config = function(_, opts)
      -- [[ Configure Treesitter ]] See `:help nvim-treesitter`

      -- Prefer git instead of curl in order to improve connectivity in some environments
      require('nvim-treesitter.install').prefer_git = true
      ---@diagnostic disable-next-line: missing-fields
      require('nvim-treesitter.configs').setup(opts)

      -- There are additional nvim-treesitter modules that you can use to interact
      -- with nvim-treesitter. You should go explore a few and see what interests you:
      --
      --    - Incremental selection: Included, see `:help nvim-treesitter-incremental-selection-mod`
      --    - Show your current context: https://github.com/nvim-treesitter/nvim-treesitter-context
      --    - Treesitter + textobjects: https://github.com/nvim-treesitter/nvim-treesitter-textobjects
    end,
  },
}

-- vim: ts=2 sts=2 sw=2 et                                                      -- this is called a 'modeline' - [Modeline magic](https://vim.fandom.com/wiki/Modeline_magic), [Tab settings in Vim](https://arisweedler.medium.com/tab-settings-in-vim-1ea0863c5990)