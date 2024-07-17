<!-- vim: ts=2 sts=2 sw=2 et                                                            -- this is called a 'modeline' - [Modeline magic](https://vim.fandom.com/wiki/Modeline_magic), [Tab settings in Vim](https://arisweedler.medium.com/tab-settings-in-vim-1ea0863c5990) -->
<!-- markdownlint-disable-file MD007 MD012 MD013 MD022 MD033 MD035 MD041 MD045          -- for the linter 'markdownlint', disable these linting rule, See [Markdownlint Documentation](https://docs.superoffice.com/contribute/markdown-guide/markdownlint.html) -->

<!--
Maintainer:   jeffskinnerbox@yahoo.com / www.jeffskinnerbox.me
Version:      0.0.1
-->


<!--
<div align="center">
<img src="https://raw.githubusercontent.com/jeffskinnerbox/blog/main/content/images/banners-bkgrds/work-in-progress.jpg" title="These materials require additional work and are not ready for general use." align="center" width=420px height=219px>
</div>
-->

------

This directory contains all the NeoVim versions I have create to ultimately get to my "production" NeoVim configuration.
This has been a long and winding road with may stops & starts, do overs, and tool changes.

This versions include:

* **`trainer`** - This NeoVim version resulted from my studing the [YouTube Videos: Understanding Neovim](https://www.youtube.com/playlist?list=PLx2ksyallYzW4WNYHD9xOFrPRYGlntAft). The sole perpose of this configuration was to get a deeper understanding of NeoVim's consturction.
* **`kickstart`** - This is NeoVim configuration specifically intended to help you launch your personal NeoVim configuration.  It give you a working version of NeoVim containing LSP assisted autocompletion, linting, formatting, and debugging features.  Kickstart has built & supported by members of the NeoVim development team to ease the adoption of new and established users of NeoVim.  You can find this Kickstart configuration at [GitHub: nvim-lua/kickstart.nvim].
* **`kickstart2`** - This is my highly personalized version of Kickstart.  I made no significant changes to Kickstart's structure or workflow but I did add several features that I personally need to make it usable as basic text/code editor. The intent is to make continuing (and likely very significant) changes to make it into a Python/C++ Integrated Development Environment (IDE).
* **`active`** - This is the NeoVim configuration that I use on a daily basis. Its origin is one of the other listed configurations and intended to be a stable version that I can use daily.


# Install LuaRocks

```bash
sudo apt install lua-check
```
