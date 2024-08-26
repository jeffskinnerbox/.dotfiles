-- luacheck: max line length 300

--[[ suda is a plugin to read or write files with sudo command

  Description:
    This plugin was built because the standard Vim trick ':w !sudo tee % > /dev/null'
    does not work on NeoVim.

  Usage:
    list the most significant commandline and keymap operations

    Commandline
      :SudaRead /etc/sudoers      - open /etc/sudoers with sudo
      :SudaRead                   - re-open a current file with sudo
      :SudaWrite /etc/profile     - write contents to /etc/profile
      :SudaWrite                  - forcedly save a current file with sudo

    Keymapped Commands
      none that I'm using or aware of

  Alternatives:
      vim-scripts/sudo.vim

  Sources:
    [GitHub: lambdalisue/vim-suda](https://github.com/lambdalisue/vim-suda)
    [What is the proper way to install Vim plugin to NeoVim?](https://www.reddit.com/r/neovim/comments/1afmcws/what_is_the_proper_way_to_install_vim_plugin_to/)
]]


return {
  'lambdalisue/vim-suda',
  enabled = true,                                                               -- load the plugin if 'true' but skip completely if 'false'
}

