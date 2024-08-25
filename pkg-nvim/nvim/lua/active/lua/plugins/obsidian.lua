-- luacheck: globals vim
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
    [GitHub: epwalsh/obsidian.nvim](https://github.com/epwalsh/obsidian.nvim)
    [The Holy Grail of Neovim Note Taking](https://www.youtube.com/watch?v=5ht8NYkU9wQ)
    [Ultimate Notetaking: My Neovim Zettelkasten Based on Obsidian - Complete Walkthrough](https://www.youtube.com/watch?v=zIGJ8NTHF4k)

   NOTE: list anything worth noting
   BUG: list any known bugs
]]


return {
  'epwalsh/obsidian.nvim',
  enabled = false,                                                               -- load the plugin if 'true' but skip completely if 'false'
}

