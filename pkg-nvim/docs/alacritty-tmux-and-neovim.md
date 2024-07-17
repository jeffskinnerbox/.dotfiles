<!-- vim: ts=2 sts=2 sw=2 et                                                            -- this is called a 'modeline' - [Modeline magic](https://vim.fandom.com/wiki/Modeline_magic), [Tab settings in Vim](https://arisweedler.medium.com/tab-settings-in-vim-1ea0863c5990) -->
<!-- markdownlint-disable-file MD007 MD012 MD013 MD022 MD033 MD035 MD041 MD045          -- for the linter 'markdownlint', disable these linting rule, See [Markdownlint Documentation](https://docs.superoffice.com/contribute/markdown-guide/markdownlint.html) -->

<!--
Maintainer:   jeffskinnerbox@yahoo.com / www.jeffskinnerbox.me
Version:      0.0.1
-->


<div align="center">
<img src="https://raw.githubusercontent.com/jeffskinnerbox/blog/main/content/images/banners-bkgrds/work-in-progress.jpg" title="These materials require additional work and are not ready for general use." align="center" width=420px height=219px>
</div>

------

* [My Development Setup (Neovim, Tmux, Alacritty & Rust-based CLI Tools](https://www.youtube.com/watch?v=stCXFxC4OH0)
* [My Forever Dev Workflow](https://www.youtube.com/watch?v=_YaI2vDbk0o)

```bash
function alacritty-terminal-with-nvim {
    ( alacritty --title 'NeoVim' --option 'font.size=9.0' --option 'window.dimensions.columns=200' --option 'window.dimensions.lines=60' --command nvim $* & )
}
#alias vi="NVIM_APPNAME=nvim/lua/kickstart2/ alacritty-terminal-with-nvim"
alias vi=alacritty-terminal-with-nvim
```

