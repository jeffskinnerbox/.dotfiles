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
    [GitHub: Shatur/neovim-session-manager](https://github.com/Shatur/neovim-session-manager)
    [Boost Your Productivity with This Neovim Plugin for Project Management!](https://dev.to/saltaformajo/boost-your-productivity-with-this-neovim-plugin-for-project-management-2bd8)

   NOTE: list anything worth noting
   BUG: list any known bugs
]]


return {
  'Shatur/neovim-session-manager',
  enabled = false,                                                               -- load the plugin if 'true' but skip completely if 'false'
}

