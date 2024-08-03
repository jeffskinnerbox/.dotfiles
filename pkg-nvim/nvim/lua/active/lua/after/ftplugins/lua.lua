-- vim: set ts=2 sw=2 sts=2 et ai:                                                 -- modeline, equvalent to 'vim: set tabstop=2 shiftwidth=2 softtabstop=2 expandtab autoindent filetype=markdown:'

-- luacheck: globals vim
-- luacheck: max line length 300

-- to get a files tyle use this command :echo &filetype
-- [Difference between adding "vim/after/ftplugin" vs "vim/ftplugin"](https://vi.stackexchange.com/questions/26169/difference-between-adding-vim-after-ftplugin-vs-vim-ftplugin)
-- [What are filetypes in Neovim? (and how to configure)](https://www.youtube.com/watch?v=NecszftvMFI)
-- [Changing A Filetype On Open](https://www.reddit.com/r/neovim/comments/12qzsu1/changing_a_filetype_on_open/)
-- [How to add custom filetype detection to various “.env” files?](https://neovim.discourse.group/t/how-to-add-custom-filetype-detection-to-various-env-files/4272)
-- [filetype.lua (@gpanders): nvim 0.8](https://www.youtube.com/watch?v=S3wLkKnLwCo)
-- [Vim’s ftplugin system](https://ejmastnak.com/tutorials/vim-latex/ftplugin/)
-- [The Power of (Neo)vim AutoCommands: Guide with Practical Examples](https://www.youtube.com/watch?v=wX-KpX8tax8)

vim.opt.shiftwidth = 2
vim.opt.expandtab = true
