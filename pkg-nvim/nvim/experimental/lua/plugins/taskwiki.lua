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
    [GitHub: tools-life/taskwiki](https://github.com/tools-life/taskwiki)
    [Productivity Setup with Vimwiki, Taskwarrior and MDwiki: Part 1](https://www.youtube.com/watch?v=A1YgbAp5YRc)
    [Productivity Setup with Vimwiki, Part 2: Taskwarrior Integration](https://www.youtube.com/watch?v=UuHJloiDErM)
    [Taskwarrior](https://taskwarrior.org/)

   NOTE: list anything worth noting
   BUG: list any known bugs
]]


return {
  'tools-life/taskwiki',  -- should I stick to vimwiki/vimwiki, seems bettter supported
  enabled = false,                                                               -- load the plugin if 'true' but skip completely if 'false'
}

