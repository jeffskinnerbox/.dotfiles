<!--
Maintainer:   jeffskinnerbox@yahoo.com / www.jeffskinnerbox.me
Version:      0.0.1
-->

<div align="center">
<img src="https://raw.githubusercontent.com/jeffskinnerbox/blog/main/content/images/banners-bkgrds/work-in-progress.jpg" title="These materials require additional work and are not ready for general use." align="center" width=420px height=219px>
</div>

---------------

# Unit Test Cases

# Unit Test Cases

Ultimately, your going to need to run test cases on your NeoVim instance to validate it is working as expected.
A tool that can help you here is a[Neotest][02]

Sources:

- [GitHub: nvim-neotest/neotest][02]
- [Neovim - Test, Neotest](https://www.youtube.com/watch?v=O6jJacmBCwY)
- [Integrated Test Results in Neovim](https://www.youtube.com/watch?v=cf72gMBrsI0)
- [Run and Debug TypeScript Unit Tests in Neovim](https://www.youtube.com/watch?v=7Nt8n3rjfDY)

- Neotest
  - [Building A Powerful Neovim Configuration](https://harrisoncramer.me/building-a-powerful-neovim-configuration/) - [dotfiles](https://github.com/harrisoncramer/nvim/tree/main)
    - [lua/plugins/neotest.lua](https://github.com/harrisoncramer/nvim/blob/main/lua/plugins/neotest.lua)

---------------

# Debugging NeoVim

## NeoVim Messages

To see messages that my have rolled of the screen or writen over, use the following:

- `:messages` historical listing of command messages
- `:Notifications` historical listing of notification from plugin `nvim-notify`
- `g<` command can be used to see the last page of previous command output.
  Note: If the output has been stopped with "q" at the more prompt, it will only
  be displayed up to this point.

## NeoVim Health Check

- `:checkhealth` full health check of NeoVim and its plugins
- `:checkhealth foo` run healthcheck for the `foo` plugin
- `:checkhealth nvim` run only the standard NeoVim healthcheck
- `:checkhealth which-key`
- `:checkhealth lsp` to see the status or to troubleshoot
- `:checkhealth mason`

- `:LspInfo`

Sources

- [Dive Into Neovim :Checkhealth](https://thoughtbot.com/upcase/videos/neovim-checkhealth)

## Lazy Messages

## Mason Messages

## Log Files

Log files are located in `$HOME/.local/state/nvim/*.log`
run `:LspLog` shows the status of active and configured language servers
run `:MasonLog`

---------------

# Trouble Shooting

## Show Value of NeoVim Option/Setting

Add a `?` mark after the setting name and it will show the value.
For example:

```vim
:set timeoutlen?
timeoutlen=300
```

## Trouble Shooting Key Mapping Conflicts

I executed `:checkhealth` and got this message:

```vim
which-key: require("which-key.health").check()

WhichKey: checking conflicting keymaps ~
- WARNING conflicting keymap exists for mode **"n"**, lhs: **"gb"**
- rhs: `<Plug>(comment_toggle_blockwise)`
- WARNING conflicting keymap exists for mode **"n"**, lhs: **"gc"**
- rhs: `<Plug>(comment_toggle_linewise)`
```

Appears that the key sequences `gb` and `gc` are defined more than once.
I could resolve this problem if I could find where I'm defining the repeatedly
or maybe its conflicting with an NeoVim internal key mapping.
What I need is tabular [view of my current mapping of keys][01] within my NeoVim.
You can do this with the `:map` command, which give you the lengthy but complete view of things.
I prefer the output be directed to a buffer or a file so I can search it.
I can get this same information into a file via the following:

```vim
:redir! > vim_key_mapping.txt
:silent verbose map
:redir END
```

[01]: https://stackoverflow.com/questions/7642746/is-there-any-way-to-view-the-currently-mapped-keys-in-vim
[02]: https://github.com/nvim-neotest/neotest

[03]:
[04]:
[05]:
[06]:
[07]:
[08]:
[09]:
[10]:
