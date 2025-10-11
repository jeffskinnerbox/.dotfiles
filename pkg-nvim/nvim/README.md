
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
A driving motive for me has been the need to create a personalized NeoVim configuration
that I truly understood and could maintain.
Taking someone else's creation and making do was not a compromise I wanted to make.

The major hurtle for me has been the lack of step-by-step example of how to create a custom NeoVim configuration
**AND** an example that embodied a structure that was easy to follow & maintain.
The Lua language and NeoVim plugin architecture provide significant opportunity
for example configuration to look and behave differently.
This make cherry picking the best ideas from existing configuration difficult
since code snippets don't fit together.
I don't think I really ever found what I was looking for
but the journey I took gave me the clues I needed to succeed (to a large extent).

What is contained here are the "skeleton remains" of my journey to a NeoVim configuration that worked for my needs.
These remains don't tell the whole story, which included a lot of reading, learning, and experimenting that isn't exposed here.
Never the less, I think following the path I took could benefit someone who is looking to create a custom NeoVim configuration.


# Contents
This directory contains as it foundation the [LazyVim][06] configuration, unmodified.
Its became my starting point after several false starts and redos.
All the NeoVim configurations I have imported for consideration are not, but are located in the `_archive` directory.
What is contained here are my working version in vering stages of refinement.
The one I created for current use, that is my "production version" of NeoVim configuration,
is contained in the `active` directory.
The other directories are earlier version of `active`.

This directory includes:

1. **`active`** - This is the NeoVim configuration that I use on an ongoing bases.
Its origin is the `beta` configurations listed above
and is intended to be a stable version that I can use daily.

1. **`beta`** - This version is intended to become the `active` version
but will be used for sometime to validate its stability and free of bugs.

1. **`experimental`** - Here is where I experiment with the Neovim configuration.
It is here that I place all the things I learned from my journey to try them out.
I'll sometimes use it for my daily work but it could be buggy.
It it is successful, I'll move it to `beta`.

1. **`lazyvim`** - This is the foundation of versions `active`, `beta`, and `experimental`.
It is unmodified from what was availabile on the web as of April 2025
(NeoVim version 0.11.0, LazVim version 14.14.0).
See the [LazyVim][06] documentation for more information.

1. **`kickstart`** - This is NeoVim configuration specifically intended to help you launch your personal NeoVim configuration.
It give you a working version of NeoVim containing LSP assisted autocompletion, linting, formatting, and debugging features.
Kickstart is built & supported by members of the NeoVim development team to ease the adoption of new and established users of NeoVim.
You can find this Kickstart configuration at [GitHub: nvim-lua/kickstart.nvim][02] and a [video on Youtube][04].
I believe the only modification was to the `<leader>` key to be `,`.

1. **`nvim-starter-kit`** - This is the [Neovim Starter Kit][03] claims to have
a directory structure is much easier to maintain than Kickstart.
It also have a very detailed [Youtube video series][05].
A nice feature of this work are the configuration variants of the normal Neovim Starter Kit
specialized for things like Python development.

>**NOTE:** Here's one way to see the version of your LazyVim:
>
>1. In normal mode, type `:Lazy`
>2. Go to the log by typing `L`
>3. Hit `/` to search and type `LazyVim<Enter>`. That should bring you to the LazyVim plugin's most recent commits
>4. Hit `<Enter>` again and it expands a little bit to show, among other things, the version.
>
>To upgrade, enter `:Lazy` and type `S`. This'll upgrade **all** your plugins.




[02]:https://github.com/nvim-lua/kickstart.nvim
[03]:https://github.com/bcampolo/nvim-starter-kit/tree/main
[04]:https://www.youtube.com/watch?v=m8C0Cq9Uv9o
[05]:https://www.youtube.com/playlist?list=PLD3V7KEd2M-tUghtES9iyl_ERa7sc1-HF
[06]:https://www.lazyvim.org/

