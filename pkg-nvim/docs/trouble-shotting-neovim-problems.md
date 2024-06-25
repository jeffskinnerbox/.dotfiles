

# Show Value of NeoVim Option/Setting
Add a `?` mark after the setting name and it will show the value.
For example:

```vim
:set timeoutlen?
timeoutlen=300
```

# Trouble Shooting Key Mapping Conflicts
I executed `:checkhealth` and got this message:

```
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

```
:redir! > vim_key_mapping.txt
:silent verbose map
:redir END
```



[01]:https://stackoverflow.com/questions/7642746/is-there-any-way-to-view-the-currently-mapped-keys-in-vim
[02]:
[03]:
[04]:
[05]:
[06]:
[07]:
[08]:
[09]:
[10]:

