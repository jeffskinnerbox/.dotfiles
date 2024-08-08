-- luacheck: globals vim
-- luacheck: max line length 300


--[[ short discription of the module or plugin
path/to/the/module-or-plugin

  Description:
    describe what this module or plugin does

  Definitions:
    definitions of phrases when it could be helpful

  Usage:
    list the most significant commandline and keymap operations

    Commandline
      none that I'm using or aware of or ....
      :echo &filetype          - to get a files tyle use this command

    Keymapped Commands
      none that I'm using or aware of or ...
      <leader>sp               - toggle spell checking

  Alternatives:
      any similar modules or plugins

  Sources:
    [GitHub: nvim-plugin](https://github.com/nvim-plugin)
    [some-document](https://xxx)

to get a files tyle use this command :echo &filetype
    [Difference between adding "vim/after/ftplugin" vs "vim/ftplugin"](https://vi.stackexchange.com/questions/26169/difference-between-adding-vim-after-ftplugin-vs-vim-ftplugin)
    [What are filetypes in Neovim? (and how to configure)](https://www.youtube.com/watch?v=NecszftvMFI)
    [Changing A Filetype On Open](https://www.reddit.com/r/neovim/comments/12qzsu1/changing_a_filetype_on_open/)
    [How to add custom filetype detection to various “.env” files?](https://neovim.discourse.group/t/how-to-add-custom-filetype-detection-to-various-env-files/4272)
    [filetype.lua (@gpanders): nvim 0.8](https://www.youtube.com/watch?v=S3wLkKnLwCo)
    [Vim’s ftplugin system](https://ejmastnak.com/tutorials/vim-latex/ftplugin/)
    [The Power of (Neo)vim AutoCommands: Guide with Practical Examples](https://www.youtube.com/watch?v=wX-KpX8tax8)

   NOTE: list anything worth noting
   BUG: list any known bugs
]]


vim.opt.shiftwidth = 2
vim.opt.expandtab = true
