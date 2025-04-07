
<!-- markdownlint-configure-file { "default": "true" } -->
<!-- markdownlint-configure-file { "ul-indent": { "indent": 4, "start_indented": false, "start_indent": 4, } } -->
<!-- markdownlint-configure-file { "line-length": { "line_length": 300 } } -->
<!-- markdownlint-configure-file { "blanks-around-headings": { "lines_above": 2, "lines_below": 0, } } -->
<!-- markdownlint-configure-file { "hr-style": { "style": "---------------", } } -->
<!-- markdownlint-disable MD001 MD012 MD033 MD041 MD045 -->
<!-- see [Markdownlint Documentation](https://docs.superoffice.com/contribute/markdown-guide/markdownlint.html) -->
<!-- see [Markdownlint Schema](https://github.com/DavidAnson/markdownlint/blob/main/schema/.markdownlint.jsonc) -->

<!--
Maintainer:   jeffskinnerbox@yahoo.com / www.jeffskinnerbox.me
Version:      0.0.1
-->

<!--
<div align="center">
<img src="https://raw.githubusercontent.com/jeffskinnerbox/blog/main/content/images/banners-bkgrds/work-in-progress.jpg" title="These materials require additional work and are not ready for general use." align="center" width=420px height=219px>
</div>
-->

---------------


# Background
For me to get a satisfactory NeoVim configuration that I could use on a daily bases
has been a long and winding road with many stops & starts, do-overs, and tool changes.
There is no sugar coating it, configuring you own NeoVim is hard!
I say this even as a long time vi/vim user.
A driving motive for me has been the need to create a personalized NeoVim configuration That I truly understood and could maintain.
Taking someone else's creation and making do was not a compromise I wanted to make.

The major hurtle for me has been the lack of step-by-step example of how to create a custom NeoVim configuration
**AND** an example that embodied a structure that was easy to follow & maintain.
The Lua language and NeoVim plugin architecture provide significant opportunity
for example configuration to look and behave differently.
This make cherry picking the best ideas from existing configuration difficult
since code snippits don't fit together.
I don't think I really ever found what I was looking for
but the journey I took gave me the clues I needed to succeed (to a large extent).

What is contained here are the "skeleton remains" of my journey to a NeoVim configuration that worked for my needs.
These remains don't tell the whole story, which included a lot of reading, learning, and experimenting that isn't exposed here.
Never the less, I think following the path I took could benefit someone who is looking to create a custom NeoVim configuration.


# Contents
This directory contains all the NeoVim configurations I have imported for consideration,
and the one I created to ultimately give me my "production" NeoVim configuration (contained in the `active` directory).
The numbering scheme used below has meaning; its the sequence of steps I took on my journey.
I think following these steps is instructive.
Its tempting to rush to the finished work but doing so will limit what you ultimately learn.

`NVIM_APPNAME=nvim/lua/lazyvim alacritty-terminal-with-nvim`

This directory includes:

1. **`trainer`** - I personally crafted this NeoVim configuration while studying the YouTube videos [Understanding Neovim][01].
   The sole purpose of this configuration was to get a deeper understanding of NeoVim's configuration.
   The author does an excellent job!
2. **`lazyvim`** - [LazyVim Docs: Getting Started][06]
2. **`kickstart`** - This is NeoVim configuration specifically intended to help you launch your personal NeoVim configuration.
   It give you a working version of NeoVim containing LSP assisted autocompletion, linting, formatting, and debugging features.
   Kickstart is built & supported by members of the NeoVim development team to ease the adoption of new and established users of NeoVim.
   You can find this Kickstart configuration at [GitHub: nvim-lua/kickstart.nvim][02] and a [video on Youtube][04].
3. **`kickstart-1`** - This is Kickstart, with very minor modifications, to make it more user friendly for me.
   I believe the only modification was to the `<leader>` key.
4. **`kickstart-2`** - This is my highly personalized version of Kickstart.
   I made no significant changes to Kickstart's structure or workflow
   but I did add several features that I personally need to make it usable as basic text/code editor with aome IDE features.
5. **`nvim-starter-kit`** - This is the [Neovim Starter Kit][03] claims to have
   a directory structure is much easier to maintain than Kickstart.
   It also have a very detailed [Youtube video series][05].
   A nice feature of this work are the configuration variants of the normal Neovim Starter Kit
   specialized for things like Python development.
6. **`experimental`** - Here is where I experiment with the Neovim configuration.
   It is here that I place all the things I learned from my journey to try them out.
   I'll sometimes use it for my daily work but it could be buggy.
7. **`active`** - This is the NeoVim configuration that I use on an ongoing bases.
   Its origin is the experimental configurations listed above
   and is intended to be a stable version that I can use daily.



[01]:https://www.youtube.com/playlist?list=PLx2ksyallYzW4WNYHD9xOFrPRYGlntAft
[02]:https://github.com/nvim-lua/kickstart.nvim
[03]:https://github.com/bcampolo/nvim-starter-kit/tree/main
[04]:https://www.youtube.com/watch?v=m8C0Cq9Uv9o
[05]:https://www.youtube.com/playlist?list=PLD3V7KEd2M-tUghtES9iyl_ERa7sc1-HF
[06]:https://www.lazyvim.org/

