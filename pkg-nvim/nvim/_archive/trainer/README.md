<!-- vim: ts=2 sts=2 sw=2 et                                                            -- this is called a 'modeline' - [Modeline magic](https://vim.fandom.com/wiki/Modeline_magic), [Tab settings in Vim](https://arisweedler.medium.com/tab-settings-in-vim-1ea0863c5990) -->

<!-- markdownlint-disable MD001 MD012 MD033 MD041 MD045 -->
<!-- markdownlint-configure-file { "line-length": { "line_length": 300 } } -->
<!-- markdownlint-configure-file { "hr-style": { "style": "---------------", } } -->
<!-- markdownlint-configure-file { "blanks-around-headings": { "lines_above": 2, "lines_below": 0, } } -->
<!-- see [Markdownlint Documentation](https://docs.superoffice.com/contribute/markdown-guide/markdownlint.html) -->


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


# Notes for "Understanding Neovim"
Following the [Understanding Neovim][01] series of videos.


#### Step 1: Intall NeoVim
Follow the proceed ure loutline on the [NeoVim website](https://neovim.io/).


#### Step 2: Check the NeoVim Installation

```bash
# check your neovim version
$ nvim --version
NVIM v0.10.0
Build type: RelWithDebInfo
LuaJIT 2.1.1713484068
Run "nvim -V1 -v" for more info

# more information neovim
$ nvim -V1 -v
NVIM v0.10.0
Build type: RelWithDebInfo
LuaJIT 2.1.1713484068
Compilation: /usr/bin/cc -O2 -g -Og -g -flto -fno-fat-lto-objects -Wall -Wextra -pedantic -Wno-unused-parameter -Wstrict-prototypes -std=gnu99 -Wshadow -Wconversion -Wvla -Wdouble-promotion -Wmissing-noreturn -Wmissing-format-attribute -Wmissing-prototypes -fsigned-char -fstack-protector-strong -Wno-conversion -fno-common -Wno-unused-result -Wimplicit-fallthrough -fdiagnostics-color=always  -DUNIT_TESTING -DHAVE_UNIBILIUM -D_GNU_SOURCE -DINCLUDE_GENERATED_DECLARATIONS -I/build/nvim/parts/nvim/build/.deps/usr/include/luajit-2.1 -I/build/nvim/parts/nvim/build/.deps/usr/include -I/build/nvim/parts/nvim/build/build/src/nvim/auto -I/build/nvim/parts/nvim/build/build/include -I/build/nvim/parts/nvim/build/build/cmake.config -I/build/nvim/parts/nvim/build/src -I/usr/include

   system vimrc file: "$VIM/sysinit.vim"
  fall-back for $VIM: "/usr/share/nvim"

Run :checkhealth for more info

# for more information, execute the command below within neovim
:checkhealth
```


#### Step X: Help, Configuration Directory
We need to build an `init.lua` file for NeoVim but we need to kow where it can reside.
To find this information, do the following:

```bash
# read the help pages for the standard configuration path
:help stdpath

# have nvim echo back the path to the configuration directory
:echo stdpath("config")

# have nvim echo back the path to data is stored
:echo stdpath("data")

# what are your neovim command options
:options
```


#### Step X: Build `init.lua` and `options.lua` File
`init.lua` is executed when NeoVim start.
This file should `require()` all the other parts that define you NeoVim editor.


#### Step X: Install Plugin Manager and a Color Scheme
Plugin Manager [`lazy.nvim`](https://github.com/folke/lazy.nvim)
[What's The Vim Runtime? A Guide With Examples](https://thevaluable.dev/vim-runtime-guide-example/)

```bash
# documentation about the runtime path
:help runtimepath

# neovim's runtimepath
:lua print(vim.inspect(vim.api.nvim_list_runtime_paths()))
# OR
:set runtimepath?

# neovim's 'config' path
:echo stdpath("config")
/home/jeff/.config/nvim/lua/trainer

# neovim's 'data' path
/home/jeff/.local/share/nvim/lua/trainer

# set the color scheme and select from the menu
:colorscheme <tab>
```


#### Step X: Increased Stability via Proper Project Structure


#### Step X: Treesitter

```bash
# treesitter is already part of neovim
:lua vim.print(vim.treesitter)
```


#### Step X: xxx


#### Step X: xxx


#### Step X: xxx


#### Step X: xxx


#### Step X: xxx



[01]:https://www.youtube.com/playlist?list=PLx2ksyallYzW4WNYHD9xOFrPRYGlntAft
[02]:
[03]:
[04]:
[05]:

