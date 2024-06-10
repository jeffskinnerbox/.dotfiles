<!--
Maintainer:   jeffskinnerbox@yahoo.com / www.jeffskinnerbox.me
Version:      0.0.1
-->


<div align="center">
<img src="https://raw.githubusercontent.com/jeffskinnerbox/blog/main/content/images/banners-bkgrds/work-in-progress.jpg" title="These materials require additional work and are not ready for general use." align="center" width=420px height=219px>
</div>


------


# Debugging NeoVim


## NeoVim Messages
To see messages that my have rolled of the screen or writen over, use the following:

* `:messages` historical listing of command messages
* `:Notifications` historical listing of notification from plugin `nvim-notify`
* `g<` command can be used to see the last page of previous command output.
Note: If the output has been stopped with "q" at the more prompt, it will only
be displayed up to this point.

## NeoVim Health Check
* `:checkhealth`        full health check of NeoVim and its plugins
* `:checkhealth foo`    run healthcheck for the `foo` plugin
* `:checkhealth nvim`   run only the standard NeoVim healthcheck
* `:checkhealth which-key`
* `:checkhealth lsp`    to see the status or to troubleshoot
* `:checkhealth mason`

* `:LspInfo`

Sources
* [Dive Into Neovim :Checkhealth](https://thoughtbot.com/upcase/videos/neovim-checkhealth)

## Mason Messages

## Log Files
Log files are located in `$HOME/.local/state/nvim/*.log`
run `:LspLog` shows the status of active and configured language servers
run `:MasonLog`



