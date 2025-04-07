-- luacheck: globals vim
-- luacheck: max line length 300

--[[ plugin for calling lazygit from within neovim
kickstart2/lua/custom/plugins/lazygit.lua

  Description:
    This git user interface tool can add files easily, resolve merge conflicts,
    checkout recent branches, view logs and diffs of branches, commits and stashes.
    Plus quick push and pull, with squash and commit renaming, and interactive rebasing!

  Definitions:
    Definitions of phrases when it could be helpful.

  Usage:
    list the most significant commandline and keymap operations

    Commandline
      None that I'm using or aware of.
      :nmap                    - for list of normal mode key mappings

    Keymapped Commands
      <leader>gl               - popup terminal window with lazygit in the current working directory
      LazyGit CLI Tool Keybindings can be found [here](https://github.com/jesseduffield/lazygit/blob/master/docs/keybindings/Keybindings_en.md)

  Sources:
    The CLI Tool - [GitHub: jesseduffield/lazygit](https://github.com/jesseduffield/lazygit)
    The NeoVim Plugin - [GitHub: kdheepak/lazygit.nvim](https://github.com/kdheepak/lazygit.nvim)
    [Make advanced Git tasks simple with Lazygit](https://opensource.com/article/20/3/lazygit)
    [Enhanced Productivity with This Terminal UI for Git Commands]https://bootcamp.uxdesign.cc/enhanced-productivity-with-this-terminal-ui-for-git-commands-ee7af02b63af
    [lazygit deep dive: a productive terminal git UI](https://oliverguenther.de/2021/04/lazygit-an-introduction-series/)
    [LazyGit: The Git Interface That Everyone Keeps Asking For](https://www.youtube.com/watch?v=uXv4poPOdvM)
    [Lazygit - The Best Way To Use Git On The Terminal & Neovim](https://www.youtube.com/watch?v=Ihg37znaiBo)
]]


return {
  "kdheepak/lazygit.nvim",
  enabled = true,                                                               -- load the plugin if 'true' but skip completely if 'false'
  cmd = {
    "LazyGit",                                                                  -- start a floating window with lazygit in the current working directory
    "LazyGitConfig",                                                            -- open the configuration file for lazygit directly within neovim, if the file does not exist it'll load the defaults for you
    "LazyGitCurrentFile",                                                       -- start a floating window with lazygit in the project root of the current file
    "LazyGitFilter",                                                            -- open project commits with lazygit directly from neovim in floating window
    "LazyGitFilterCurrentFile",                                                 -- open buffer commits with lazygit directly from vim in floating window
  },
  dependencies = {
    "nvim-lua/plenary.nvim",                                                    -- optional for floating window border decoration
  },
  keys = {                                                                      -- setting the keybinding for LazyGit with 'keys' is recommended in order to load the plugin when the command is run for the first time
    { "<leader>hl", "<cmd>LazyGit<cr>", desc = "Terminal With [L]azy[G]it" }
  }
}

