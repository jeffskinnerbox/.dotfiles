
<!--
Maintainer:   jeffskinnerbox@yahoo.com / www.jeffskinnerbox.me
Version:      0.0.1
-->

<div align="center">
<img src="https://raw.githubusercontent.com/jeffskinnerbox/blog/main/content/images/banners-bkgrds/work-in-progress.jpg" title="These materials require additional work and are not ready for general use." align="center" width=420px height=219px>
</div>


---------------

Within NeoVim, your going to what different settings/options for file linting, formatting, etc. for different buffer filetypes.
NeoVim can detect filetype using the [file extension convention][01] `<filename>.<filetype>` and set these things for you.
NeoVim does this well but you have limited control,
and there are files which NeoVim can't detect a filetype and make the right settings.
For example, the `luacheck` configuration file `.luacheckrc` should be formatted as a Lua file
but, out of the box, NeoVim doesn't know this and treats it as a plan text file.

To deal with this, you can use [ftplugins][02] for this case!
A ftplugin is a file type plugin (really a Lua module)
that will be run automatically when NeoVim detects you're editing a file of that type.

Sources:

* [What are filetypes in Neovim? (and how to configure)][02]
* [filetype.lua (@gpanders): nvim 0.8](https://www.youtube.com/watch?v=S3wLkKnLwCo)
* [Lua module: vim.filetype](https://neovim.io/doc/user/lua.html#vim.filetype.add())
* [How to add custom filetype detection to various “.env” files?](https://neovim.discourse.group/t/how-to-add-custom-filetype-detection-to-various-env-files/4272)
* [Vim’s ftplugin system](https://ejmastnak.com/tutorials/vim-latex/ftplugin/)
* [The Power of (Neo)vim AutoCommands: Guide with Practical Examples](https://www.youtube.com/watch?v=wX-KpX8tax8)


To get the file type of your Neovim buffer,
use this command `:echo &filetype`.

[01]:https://en.wikipedia.org/wiki/Filename_extension
[02]:https://www.youtube.com/watch?v=NecszftvMFI

