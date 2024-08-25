
-- luacheck: max line length 300


--[[ short discription of the module or plugin

  Description:
    describe what this module or plugin does

  Definitions:
    definitions of phrases when it could be helpful

  Usage:
    list the most significant commandline and keymap operations

    Commandline
      none that I'm using or aware of or ....
      :nmap                    - for list of normal mode key mappings

    Keymapped Commands
      none that I'm using or aware of or ...
      <leader>sp               - toggle spell checking

  Alternatives:
      any similar modules or plugins

  Sources:
    [GitHub: serenevoid/kiwi.nvim](https://github.com/serenevoid/kiwi.nvim)
    [kiwi.nvim - A simple markdown note taking plugin](https://serenevoid.github.io/blog/my-note-taking-plugin/)

   NOTE: list anything worth noting
   BUG: list any known bugs
]]


return {
  'serenevoid/kiwi.nvim',
  enabled = false,                                                               -- load the plugin if 'true' but skip completely if 'false'
  lazy = true,                                                                  -- make sure to load this at startup if main colorscheme, aka 'false' means don't lazy-load this plugin
  dependencies = { 'nvim-lua/plenary.nvim' },
  opts = {
      { name = "project",
        path = "/home/jeff/.dotfiles/pkg-nvim/nvim/lua/experimental/docs/wiki"
      },
      { name = "personal",
        --path = "/home/jeff/blogging/content/ideas"
        path = "/home/jeff/wiki"
      }
  },
  keys = {
      { "<leader>kw", ":lua require(\"kiwi\").open_wiki_index(\"project\")<CR>", desc = "Open Index of Project Wiki" },
      { "<leader>kp", ":lua require(\"kiwi\").open_wiki_index(\"personal\")<CR>", desc = "Open Index of Personal Wiki" },
      { "T", ":lua require(\"kiwi\").todo.toggle()<CR>", desc = "Toggle Markdown Task" }
  },
}

