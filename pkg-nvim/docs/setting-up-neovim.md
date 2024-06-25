<!--
Maintainer:   jeffskinnerbox@yahoo.com / www.jeffskinnerbox.me
Version:      0.0.1
-->


<div align="center">
<img src="https://raw.githubusercontent.com/jeffskinnerbox/blog/main/content/images/banners-bkgrds/work-in-progress.jpg" title="These materials require additional work and are not ready for general use." align="center" width=420px height=219px>
</div>


------



* [Migrate from Packer to lazy.nvim](https://www.youtube.com/watch?v=cGZdvEIeiSg&list=PLOIdWGSU_Wcp9_w8euHJaux8DEIBCvYGc&index=15)
* [Migrating from Packer.nvim to Lazy.nvim](https://jdhao.github.io/2023/09/02/from_packer_to_lazy_nvim/)
    * [Migrating from Packer.nvim to Lazy.nvim](https://www.youtube.com/watch?v=aqlxqpHs-aQ)


I decided to finally put the time into learning/using Neovim to explore its
new LSP and Treesitter features.
I found it very difficult to find the information needed to set it up.
Some of this stuff is really new and not very stable.
And as often with fast-moving stuff written by tech people for other tech people,
good explanation what/why/how thing work is in short supply.
I tried just copy-pasting some NeoVim configs,
but that often resulted in failure or having something that worked
but I didn't have insight into how it worked or what it could do.

Particularly with LSP,
there are so many plugins, standards, random pieces of things,
and so little clarity over who’s doing what and why.
Here are some observations,
requiring of me weeks of investigation (and a flash of insight from [here][15]),
that are helpful to get properly oriented:

* Neovim provides inside a LSP client ready for integration with an LSP server.
So in principle, you could manually hook up to the appreciate language servers.
But this manual effort requires considerable understanding of LSP.
* Most of us don’t want to do all this manual work,
so `neovim/nvim-lspconfig` was created to provides pre-built configurations
for an enormous list of language servers.
* With `neovim/nvim-lspconfig`, the manual work is reduced but is still considerable.
So `williamboman/nvim-lsp-installer` was created to make this even more manageable,
but this plugin is now been deprecated.
* The plugin `nvim-lsp-installer` is being replaced by [`williamboman/manson.nvim`][233].
`williamboman/manson.nvim` provides a handy way to  install support for languages.
Never the less, `nvim-lsp-installer` is in wide use and you will find many tutorials on its use
(cause me much confusion).
* You may think nirvana has been reached,
but it would be much nicer to just declare a list of LSP servers
and have them automatically installed and attached to NeoVim (not manually),
so [`williamboman/mason-lspconfig.nvim`][231] was created to do that.
* While its not obvious,
none of this work has provided the require infrastructure to support
formatters, linters, and diagnostics.
So the plugin `null-ls.nvim` was added,
which allows us to hook any of its supporting tools
(e.g. [black][01], [eslint][02], [ruff][03]) into the LSP system.
* But not all desired formatters and linters where addressed,
so `mason-null-ls.nvim` was created for what got forgotten.
* Oh, but lets not forget to support autocomplete.
So the legacy plugins of `ms-jpq/coq_nvim` and [`hrsh7th/nvim-cmp`][224]
had to be integrated into this mess,
requiring a fair amount of manual customization,
so the plugin [`VonHeikemen/lsp-zero.nvim`][230] was created to handle this.
* And then there is debugging support via the Debug Adapter Protocol (DAP)
using the `mfussenegger/nvim-dap` plugin.

NeoVim is hard enough to get your head around,
and this setup process is certainly not making it easier.
It was very tempting for me to just settle for using pre-configured
NeoVim instance like [LazyVim][21], [LunarVim][04], [NvChad][07], or [AstroNvim][09].
Each one provides an excellent framework you can jump on and quickly be productive.
In fact, I did try out two of these (NvChad & LazyVim) in the middle of my of
journey of exploration and self study.

But I want my editor to be set up my way.
Many of the plugins seemed to me of little value and I had a strong preferance for
key mapping, colors, and workflow.
And most of all,  a have a strong desire to understand what’s going on under the hood.
I to know how it all worked.
Onec you customized a tool like NeoVim, you will break things and only you can fix it.

The end result was many hours reviewing tutorials on the web concerning configuring NeoVim,
written at different times by different authors
many of them being inconsistent with each other.
The NeoVim ecosystem is actively being developed and many tools and approaches are evident.
If you attempt to blend these different tools / approaches,
your likely to run into configuration problems.
There is no simple resolution for me to reach my goals,
other than pick one approach follow it,
cautiously make modifications, and hopefully getting a successful outcome.

To educate myself on some of these tools & approaches on NeoVim configuration,
I reviewed the video tutorials below.
I was a novice (and I still think I'm a novice) at the setup, configuration, and use of NeoVim,
so I viewed these tutorials in there entirety, and resisted jump between them.
I wasn't completely successful in maintaining this behavioral discipline,
but I think its a wise thing to avoid confusion and getting things to work successfully.

This discipline because most important when you are making use of LSP features of NeoVim.
LSP-enabled packages much more challenging to setup that other features
and not all LSP-enabled packages work together.

In addition, it is wise to create something small like a very, very basic editor as your first goal.
On this, perform some basic testing, build upon it by adding functionality to create a new editor, and repeat.
That is basically what I did and is evident in my project file structure
where I keep my major build iterations.
This give me something to fall back on when things go badly,
and a clear record of what has worked in the past.


## Namespaces
* `editor-basic` - NeoVim configuration establishes some foundation for `nvim` automation,
options, key-mappings, and very basic plugins
* `editor-enhanced` - functionality of `editor-enhanced` + use of Nerd Fonts, enhancements
to status-line and buffer tabs, more functional screen formatting & navigation,
filesystem navigation and file finding, and an embedded terminal emulator.
* `editor-advanced` - functionality of `editor-enhanced` + utility to inject/remove code comments,
* `ide-enhanced` - functionality of `ide-basic` +
* `ide-advance` - functionality of `ide-enhanced` +
* `trainer` - teaching myself about NeoVim via replication of work done by
[Vhyrro](https://www.youtube.com/playlist?list=PLx2ksyallYzW4WNYHD9xOFrPRYGlntAft),
an **excellent** video series
* `active` - Version of my NeoVim configurations actively being used by myself


**Basic Editor** (`editor-basic`) > **Enhanced Editor** (`editor-enhanced`) > **Advanced Editor** (`editor-advanced`)
**Basic IDE** (`ide-basic`) > **Enhanced IDE** (`ide-enhanced`) > **Advanced IDE** (`ide-advanced`)
This all leads to the editor that I'm using on a daily bases, my **Active** (`active`) editor.

#### Features of Basic Editor (i.e. `editor-basic`) - DONE
* REMOVED - NeoVim plugin package manager _([wbthomason/packer.nvim][200])_ - DONE
* NeoVim plugin package manager _([folke/lazy.nvim][244])_ - DONE
* Status Bar on bottom of screen _([nvim-lualine/lualine.nvim][201])_ - DONE
* Tab-Line on top of screen _([akinsho/bufferline.nvim][202])_ - DONE
* Recommend line-length column _([lukas-reineke/virt-column.nvim][245])_ - DONE
* Special fonts, icon, and other 'eye-candy' for user interface _([nvim-tree/nvim-web-devicons][205])_ - DONE

#### Features of Enhanced Editor (i.e. `editor-enhanced`) - DONE
* All the features of the Basic Editor - DONE
* Install Nerd Fonts on NeoVim's host system - DONE
* Color theme for user interface, highlighting, etc. _([navarasu/onedark.nvim][204])_ - DONE
* REMOVED - Line folding at line indentation _(using Vim native line folding, `vim.opt.foldmethod = 'indent'`)_ - DONE
* Filesystem navigator & file explorer _([nvim-tree/nvim-tree.lua][210])_ - DONE
* ALTERNATIVE - Filesystem navigator & file explorer _([nvim-neo-tree/neo-tree.nvim][246])_
* REMOVED - UI components and Lua function used by plugins _([nvim-lua/popup.nvim][206], [stevearc/dressing.nvim][222])_ - DONE
* UI components and Lua function used by plugins _[MunifTanjim/nui.nvim][207], [nvim-lua/plenary.nvim][208]_ - DONE
* REMOVED - Pop-up terminal emulator _([akinsho/toggleterm.nvim][211])_ - DONE
* REMOVED - Comment out lines or blocks of text _([numToStr/Comment.nvim][212])_ - DONE
* Pop-up menu of keybindings as you started typing _([folke/which-key.nvim][217])_ - DONE

#### Features of Advanced Editor (i.e. `editor-advanced`) - DONE
* All the features of the Enhanced Editor - DONE
* Change color theme for user interface, highlighting, etc. _([rebelot/kanagawa.nvim][247])_ - DONE
* REMOVED - Line indentation guide-lines _([lukas-reineke/indent-blankline.nvim][209])_ - DONE
* REMOVED - Relative and absolute line numbers _([jeffkreeftmeijer/vim-numbertoggle][213])_ - DONE
* Fuzzy file finder / search tool _([nvim-telescope/telescope.nvim]][214])_ (works with Treesitter) - DONE
* Treesitter assisted syntax highlighting, etc. _([nvim-treesitter/nvim-treesitter][215])_ - DONE
* Direct jumps to frequently used files _([ThePrimeagen/harpoon][248])_ - DONE
* REMOVED - Engine for completion and suggestions as we type _([hrsh7th/nvim-cmp][224])_ - DONE
* Preview markdown files in browser _([iamcco/markdown-preview.nvim][218])_ - DONE
* REMOVE - Pop-up terminal emulator _([akinsho/toggleterm.nvim][211])_ - DONE
* Color highlighter for color codes and color names _([NvChad/nvim-colorizer.lua][219])_ - DONE

#### Features of Basic IDE (i.e. `ide-basic`)
* All the features of the Advanced Editor
* TURNED-OFF - Color code picker tool _([uga-rosa/ccc.nvim][220])_ - DONE
* TURNED-OFF - highlighter for color codes and color names _([NvChad/nvim-colorizer.lua][219])_ - DONE
* REMOVE - Pop-up picker for nerd font icons, symbols, and emoji _([ziontee113/icon-picker.nvim][223])_
* Install LazyGit on NeoVim's host system _([jesseduffield/lazygit][226])_ - DONE
* Git integration with NeoVim _([lewis6991/gitsigns.nvim][225], [kdheepak/lazygit.nvim][227])_ - DONE
* Fancy & configurable notification manager _([rcarriga/nvim-notify][221])_
* Automated pairings _([windwp/nvim-autopairs][216])_ - DONE
* Code folding - https://www.jackfranklin.co.uk/blog/code-folding-in-vim-neovim/
* Pop-up terminal emulator _([akinsho/toggleterm.nvim][211])_

#### Features of Enhanced IDE (i.e. `ide-enhanced`)    [How I Setup LSP In Neovim For An Amazing Dev Experience - Full Guide](https://www.youtube.com/watch?v=NL8D8EkphUw)
* All the features of the Basic IDE
* "Boilerplate Code" for plugins to work together under LSP _([VonHeikemen/lsp-zero.nvim][230])_
* Quick start LSP configuration _([neovim/nvim-lspconfig][232])_
* Package management for LSP related plugins _([williamboman/mason.nvim][233])_
* Extension to `mason.nvim` that makes it easier to use `nvim-lspconfig` _([williamboman/mason-lspconfig.nvim][231])_
* Source data for completion engine `nvim_cmp` _([hrsh7th/cmp-buffer][237])_, _([hrsh7th/cmp-path][238])_, _([hrsh7th/cmp-cmdline][239])_
* Completion source data for LSP client _([hrsh7th/cmp-nvim-lsp][234])_, _([hrsh7th/cmp-nvim-lua][242])_
* REMOVED - Snippit engine to manage snippits _([L3MON4D3/LuaSnip][235])_
* REMOVED - Snippits source data for completion engine _([saadparwaiz1/cmp_luasnip][240])_
* REMOVED - Collection of per-configured snippits _([rafamadriz/friendly-snippets][236])_

#### Features of Advance IDE (i.e. `ide-advance`)
* All the features of the Enhanced IDE
* Snippit engine to manage snippits _([L3MON4D3/LuaSnip][235])_
* Snippits source data for completion engine _([saadparwaiz1/cmp_luasnip][240])_
* Collection of per-configured snippits _([rafamadriz/friendly-snippets][236])_
* REMOVE - Automated pairings _([windwp/nvim-autopairs][216])_ - NOTE: does not work well (if at all) with hrsh7th/nvim-cmp
* Engine for completion and suggestions as we type _([hrsh7th/nvim-cmp][224])_
* folke/trouble.nvim - pretty list for showing diagnostics, references, telescope results, quickfix and location lists to help you solve all the trouble your code is causing [folke/trouble.nvim](http://neovimcraft.com/plugin/folke/trouble.nvim/index.html)


* Remove Undercurl From URLs
* [Pull of the Undercurl](https://ryantravitz.com/blog/2023-02-18-pull-of-the-undercurl/)

* Tmux Integration
* [Tmux Toggle-able Terminals in Split Panes or Floating Windows](https://dev.to/pbnj/tmux-toggle-able-terminals-in-split-panes-or-floating-windows-17pa)

* Neovide
* [Neovide](https://neovide.dev/)
* [NEOVIDE - A better front-end to Neovim](https://www.youtube.com/watch?v=wxgotSy4zfs)

* Improved NeoVim LSP UI experience _([nvimdev/lspsaga.nvim][])_
    * [Vim #104: Lspsaga](https://www.youtube.com/watch?v=nKqQJzkBPxA)
        * [LSP Keybindings & Lspsaga.nvim - Neovim Lua From scratch #21](https://www.youtube.com/watch?v=RcZadF8RjT8)
        * [glepnir/lspsaga.nvim](http://neovimcraft.com/plugin/glepnir/lspsaga.nvim/index.html)
    * [A Step-by-Step Guide to Configuring LSP in Neovim for Coding in Next.js (React), TypeScript, and TailWindCSS](https://levelup.gitconnected.com/a-step-by-step-guide-to-configuring-lsp-in-neovim-for-coding-in-next-js-a052f500da2#a999)
    * [Neovim LSP commands, LSP Saga configuration and functionalities](https://anchietajunior.hashnode.dev/neovim-lsp-commands-lsp-saga-configuration-and-functionalities)
    * [Neovim LSP Enhanced](https://alpha2phi.medium.com/neovim-lsp-enhanced-a3d313abee65)

* Code formatter, linter, diagnostic for non-LSP sources _([jose-elias-alvarez/null-ls.nvim][241])_
    * [Neovim Null-LS - Hooks For LSP | Format Code On Save](https://www.youtube.com/watch?v=ryxRpKpM9B4&list=PLIHtvvGZ1O3jBXdp9Id02vRuOEOWIGB_w&index=7)

* Language Server Protocol (LSP) support _([][])_
    * [Neovim LSP, DAP and Fuzzy Finder](https://medium.com/swlh/neovim-lsp-dap-and-fuzzy-finder-60337ef08060)
    * [Make Neovim a Smart Editor With Top 3 Addons (Plugins) to Level Up Your Development Workflow](https://levelup.gitconnected.com/top-6-neovim-plugins-to-level-up-your-development-workflow-3605deb2ed05)
    * [Neovim 101 — Contextual Semantic Highlighting](https://alpha2phi.medium.com/neovim-101-contextual-semantic-highlighting-90c605e6e72b)
    * [Make lsp-zero.nvim coexists with other plugins instead of controlling them](https://dev.to/vonheikemen/make-lsp-zeronvim-coexists-with-other-plugins-instead-of-controlling-them-2i80)
    * [Getting started with neovim's native LSP client: The easy way](https://dev.to/vonheikemen/getting-started-with-neovims-native-lsp-client-in-the-year-of-2022-the-easy-way-bp3)
* See the contents of Vim registers _([gennaro-tedesco/nvim-peekup][])_
* FileTree _([][])_
* Syntax Highlighting _([][])_
* Setup for C++ - [C++](https://www.youtube.com/playlist?list=PLf1rXVkRs4Bn974IczYbd1SmhR6bOfEVw), [Basic Lua Neovim Configuration - Part 2](https://www.youtube.com/watch?v=cAfPmPjxRQE)
* Setup for Python - [The perfect Neovim setup for Python](https://www.youtube.com/watch?v=4BnVeOUeZxc)
* [Neovim PDE — C/C++, Go, Python and Rust](https://alpha2phi.medium.com/neovim-pde-c-c-go-python-and-rust-35fe86c3517d)
* Setup for Lua - [Basic Lua based Neovim configuration](https://www.youtube.com/watch?v=ppMX4LHIuy4)

#### Features of Advanced IDE (i.e. `ide-advanced`)
* Linter/Formatter (They're not the same) _([jose-elias-alvarez/null-ls.nvim][])_, _([][])_
* Debugger DAP _([nvim-dap][])_, _([nvim-dap-ui][])_
* [Write Better in Neovim With Languagetool](https://www.rockyourcode.com/write-better-in-neovim-with-languagetool/)
* Code snips
* Window management
    * [folke/edgy.nvim](https://github.com/folke/edgy.nvim) - create and manage predefined window layouts
    * [mrjones2014/smart-splits.nvim](https://github.com/mrjones2014/smart-splits.nvim) - Smarter and more intuitive split pane management that uses a mental model of left/right/up/down instead of wider/narrower/taller/shorter for resizing
    * [Neovim Window Focus - Dim Inactive Windows In Neovim With Shade](https://www.youtube.com/watch?v=KQKsIDHmkt8&list=PLIHtvvGZ1O3jBXdp9Id02vRuOEOWIGB_w&index=8)
        * [levouh/tint.nvim](https://github.com/levouh/tint.nvim) - Tint inactive windows in Neovim using window-local highlight namespaces
* [Integrated Test Results in Neovim](https://www.youtube.com/watch?v=cf72gMBrsI0)
    * [nvim-neotest/neotest](https://github.com/nvim-neotest/neotest)
    * [vim-test/vim-test](https://github.com/vim-test/vim-test)
    * [NeoVim Testing](http://neovimcraft.com/?search=tag%3Atest)

#### More Features
* [Vim/Neovim Plugins for A Better Integrated Experience](https://alpha2phi.medium.com/vim-neovim-plugins-for-a-better-integrated-experience-6accd4c2a52c)
    * [Notes using Google Keep]()
    * [Grammar Checking]()
    * Show nvim diagnostics using virtual lines [lsp_lines.nvim](https://sr.ht/~whynothugo/lsp_lines.nvim/)
    * pretty list for showing diagnostics, references, telescope results, quickfix and location lists to help you solve all the trouble your code is causing [folke/trouble.nvim](http://neovimcraft.com/plugin/folke/trouble.nvim/index.html)
    * mouse gesture plugin [notomo/gesture.nvim](https://github.com/notomo/gesture.nvim)
    * vscode-like pictograms for neovim lsp completion items [onsails/lspkind.nvim](https://github.com/onsails/lspkind.nvim)
    * Copilot
        * [Autocompletion in Neovim using Github Copilot -- I think I love it](https://www.youtube.com/watch?v=6vBKe2mI_9c)
* view and search your undo tree [debugloop/telescope-undo.nvim](https://github.com/debugloop/telescope-undo.nvim)


-------




--------



I started my professional career using the Unix [line editor Ed][101] as my goto terminal-based file editor.
This is when I was using a [TI Silent 700][121] on my office desk, and at home,
using it with an acoustic coupler on an analog phone line conditioned for 1200 BPS data.
In time, I moved up to a [VT100][122] terminal which had a CRT display where each displayed character was addressable.
This allowed me to us the Unix [visual editor Vi][102],
which had many backward compatible commands with Ed,
but gave a full screen to navigate & display instead of Ed's single text line.
When the enhancement support for Vi became somewhat iffy,
[Vim (aka Vi Improved)][103] was created to improve and extend the existing Vi editor,
but maintained backward compatibility.
Similarly, [NeoVim (aka New Vim][104] was created to refactor and improve the existing Vim editor
but outwardly NeoVim is just like Vim.
You can find a little bit of the Unix `ed` & `vi` history [here][124] and [here][125].

Vim & NeoVim offers a wide range of editing options and commands
but out-of-the-box, they lacks some of the features of a modern text editor.
This is because Vim is a minimal program and is minimalist by design.
It is meant to run on machines with low computing and storage.
But this does not mean we cannot have extra features in Vim & NeoVim.
There is a vast community of Vim / NeoVim users with many plugins
that can help us customize Vim / NeoVim and its functionalities to your liking.

Vim & NeoVim now have a native plug manager call [Vim-Plug][108],
and even better one ([Packer][118]) targetting NeoVim,
giving me a strong incentive to move off of my current plug manager, [Pathogen][107].
Truth be told, you do not need a plugin manager to install plugins in Vim.
There is a well-known way to install Vim without any plugin manager.
But the Vim-Plug & Packer plugin managers can do more than just download packages.
It can control versions of your packages, install / update / rollback packages if required,
and create shallow clones to minimize disk space usage and download time.

## The Cult of Vim (or Vi)
No discussion of Vim (or Vi or NeoVim) is complete without some reference to
[Visual Studio][117] or [Emacs][123].
The comparisons are many and the rivalry runs deep.

* [Vim from the ground up](https://thevaluable.dev/vim-commands-beginner/)
* [Vim Best Practices For IDE Users](https://betterprogramming.pub/50-vim-mode-tips-for-ide-users-f7b525a794b3)
* [On Vim, Modal Interfaces And The Way We Interact With Computers](https://hackaday.com/2023/09/01/on-vim-modal-interfaces-and-the-way-we-interact-with-computers/)

>**NOTE:** For those developers who are already comfortable with Vim,
>and are working with a team that is using [Visual Studio][117],
>there is an extension available in the [Visual Studio Marketplace][119] called [VsVim][120].

## Compare NeoVim vs Vim
Vim and NeoVim are both powerful text editing tools excelling in different ways.
When people come to Linux for the first time, they get confused about which one to get.
For me, these are the compelling things that drive me towards NeoVim:

* NeoVim performs better than Vim out of the box due to a better configuration system, robust API, and plugin architecture.
* Vim uses Vimscript as the default for writing scripts. In NeoVim, you also have Lua natively.
Vimscript is much slower than Lua and lets you use a new class of plugins like Telescope and Treesitter on NeoVim.
* NeoVim benefits from the libuv library that ensures a small codebase. It enables asynchronous I/O operations, meaning the main thread won’t be blocked when performing multiple operations.
* One of the main goals of NeoVim developers was to make it much more extensible than the original Vim.
* Unlike Vim, NeoVim doesn’t need to support lots of widget toolkits for GUI interfaces. Instead, it implements GUI through external clients thanks to msgpack-rpc API.

### Convert Vimscript to Lua
* [Configuring Neovim With Lua (It's Easy!)](https://www.youtube.com/watch?v=m62UCkdQ8Ck)

### Vim as an IDE
Visual Studio Code (commonly referred to as VS Code)
is a source-code editor made by Microsoft with the Electron Framework, for Windows, Linux and macOS.
Features include support for debugging, syntax highlighting, intelligent code completion,
snippets, code refactoring, and embedded Git.

* [Debugging In Neovim (ft BashBunni)](https://www.youtube.com/watch?v=0moS8UHupGc)
* [Vim: Vim as an IDE (VimConf 2020 Talk)](https://www.youtube.com/watch?v=Gs1VDYnS-Ac)
* [3 Reasons Why I Switched to Neovim from VSCode](https://www.youtube.com/watch?v=5zR--Fj56Ho)

## Scripting: Vimscript vs Lua
When it comes to customizing my Vim user experience,
one of my goals is to retire my use of the obscure [Vimscript][115], as used in Vim,
and replace it with the well established [Lua][116] scripting within NeoVim.
Another goal is to improve my use of packages within Vim.
My current Vim configuration is fragile with some hidden conflicts among the packages.
NeoVim promises to provide better package management.

## NeoVim Plugins

### plugins for plugin package management
[Packer][57] GitHub repository [wbthomason/packer.nvim][200]

* [The Lazy Way in Neovim: From Packer to Lazy.nvim](https://www.youtube.com/watch?v=2ahI8lYUYgw)
* [Migrating from Packer.nvim to Lazy.nvim](https://www.youtube.com/watch?v=aqlxqpHs-aQ)
* [Zero to IDE with LazyVim](https://www.youtube.com/watch?v=N93cTbtLCIM)
* [GitHub: LazyVim / LazyVim](https://github.com/LazyVim/LazyVim)

### plugins for useful tools
### plugins for quick edit of comments
### plugins for popup help
#### Key Mappings and WhichKey
* [WhichKey](https://alpha2phi.medium.com/neovim-for-beginners-key-mappings-and-whichkey-31dbf58f9f87) [folke/which-key.nvim](https://github.com/folke/which-key.nvim) - WhichKey is a lua plugin for Neovim 0.5 that displays a popup with possible keybindings of the command you started typing.
* [Neovim for Beginners — Key Mappings and WhichKey](https://alpha2phi.medium.com/neovim-for-beginners-key-mappings-and-whichkey-31dbf58f9f87)
### other plugins
* [Boost Your Neovim Experience with These Essential Plugins](https://livecode247.com/boost-your-neovim-experience-with-these-essential-plugins#heading-additional-resources)
* [Neovim and Tree-sitter: An Overview with Examples](https://thevaluable.dev/tree-sitter-neovim-overview/)
packer.nvim
telescope.nvim
nvim-treesitter
nvim-lspconfig
nvim-cmp
null-ls
LuaSnip
nvim-tree
Bufferline [akinsho/bufferline.nvim][202]
Lualine


# Learning the Basics
[How to Install and Set Up Neovim for Code Editing](https://mattermost.com/blog/how-to-install-and-set-up-neovim-for-code-editing/)
If you’ve never used Vim, Neovim, or Lua before,
then you might want to check out the following guides:

* **[Learning Lua in One Video][62] -** This covers Data Types, Math, Conditionals, Strings, Looping, Repeat Until, getting user input, For, For In, Tables, Functions, returning multiple values, Variadic Functions, Closures, Coroutines, File I/O, Modules, Metatables, OOP, Inheritance and a lot more.
* **[Learn Vim in Y Minutes][12] -** This tutorial will quickly walk you through the basics of using Vim (and therefore Neovim).
* **[Learn Lua in Y Minutes][13] -** This tutorial will introduce the syntax for the Lua programming language.
* **[Understand NeoVim Modes][14] -** This tutorial show you how to navigate the Normal, Insert, Visual, and Command-Line modes.
* **[How to Use Vim/Neovim][61] -** Comprehensive tutorial

Many tutorials that have been written are geared towards users who are
new to Neovim but have used Vim in the past.
These tutorials show how to transition one’s configuration from the Vimscript file `init.vim` to the Neovim file `init.lua`.



-----



# NeoVim and Tree-sitter
[Tree-sitter][AA] is a general parser generator tool and an incremental parsing library.
It enables you to generate concrete syntax tree from any language it supports.
You can use it to build a concrete syntax tree for a source file
and efficiently update the syntax tree as the source file is edited.
The official site has a [full list of the supported languages and parsers][BB].

The GitHub site [nvim-treesitter/nvim-treesitter][CC] contains the NeoVim plugin
for the `nvim` text editor.

Additional features can be added that are enable by the `nvim-treesitter` plugin.
These features can be provided as [external plugins][DD].
One of these is the refactor module for nvim-treesitter called [nvim-treesitter/nvim-treesitter-refactor][EE].
This plugin enamble you to:

* Highlights definition and usages of the current symbol under the cursor
* Highlights the block from the current scope where the cursor is
* Renames the symbol under the cursor within the current scope (and current file)
* Provides "go to definition" for the symbol under the cursor, and lists the definitions from the current file

[AA]:https://tree-sitter.github.io/tree-sitter/
[BB]:https://tree-sitter.github.io/tree-sitter/#language-bindings
[CC]:https://github.com/nvim-treesitter/nvim-treesitter
[DD]:https://github.com/nvim-treesitter/nvim-treesitter/wiki/Extra-modules-and-plugins
[EE]:https://github.com/nvim-treesitter/nvim-treesitter-refactor

Sources:

* [Introductory To Treesitter](https://teknologiumum.com/posts/introductory-to-treesitter)
* [GitHub: tree-sitter/tree-sitter](https://github.com/tree-sitter/tree-sitter)
* [Neovim and Tree-sitter: An Overview with Examples](https://thevaluable.dev/tree-sitter-neovim-overview/)
* [Neovim 101 — Tree-sitter](https://alpha2phi.medium.com/neovim-101-tree-sitter-d8c5a714cb03)


-----



# Setup Test Environment

## VirtualBox
[VirtualBox][30] is a [full virtualization][31] x86 / AMD64 / Intel64 hardware architecture
(contrast this with [hardware-assisted virtualization][32]).
It creates a [virtual machine (VM)][33], aka an emulation of a computer system.
Virtual machines (VM) behave like a separate computer system,
complete with virtual hardware devices.
The VM runs as a process in a window on your current operating system.
You can boot an operating system installer disc (or live CD) inside the virtual machine,
and the operating system will be “tricked” into thinking it’s running on a real computer.
It will install and run just as it would on a real, physical machine.

## VBoxManage
[VBoxManage][34] is the command-line interface to Oracle VM VirtualBox.
With it, you can completely control Oracle VM VirtualBox from the command line of your host operating system.
It exposes all the features of the virtualization engine,
even those that cannot be accessed from the GUI.

## Vagrant
[Vagrant][35] is a tool that offers a simple and easy to use
command-line client for managing virtual environments.
It effective provides a single common management UI for many of the popular virtualization platforms, including VirtualBox.
I started using it because it made it easier for me to
standup new software solutions for testing without disrupting my working system.

Vagrant is a tool for building and managing virtual machine environments in a single workflow.
Vagrant has an easy-to-use workflow, makes automation easy, and lowers development environment setup time.
Machines are provisioned on top of VirtualBox, VMware, AWS, or any other provider.
Then, industry-standard provisioning tools such as
shell scripts, Chef, or Puppet, can automatically install
and configure software on the virtual machine.

**For developers**, Vagrant will isolate dependencies and their configuration within a
single disposable, consistent environment, without sacrificing
any of the tools you are used to working with (editors, browsers, debuggers, etc.).
Once you or someone else creates a single [Vagrantfile][36],
you just need to `vagrant up` and everything is installed and configured for you to work.

**For DevOps**, Vagrant gives you a disposable environment
and consistent workflow for developing and testing infrastructure management scripts.
You can quickly test things like shell scripts, Chef cookbooks, Puppet modules,
and more using local virtualization such as VirtualBox or VMware.
Then, with the same configuration, you can test these scripts
on remote clouds such as AWS or RackSpace with the same workflow.

So the high level difference between these two is VirtualBox is the creator of virtual machines
and Vagrant is a manager of the virtual machines environment.
Also, Vagrant and Docker suport different types of virtualisation.
Vagrant is related to virtual machines and Docker is a virtual environment tool.

Aside from reading [Vagrant's official documentation][37],
it also helps to know some of the basic terminology used by Vagrant:

* **Vagrant Box:**
A box is basically a package containing a representation of a virtual machine running a specific operating system.
To be more simple, it is a base image of any Operating System or Kernel. It may be for a specific Provider.
* **Providers:**
The Provider is the piece of software responsible for creating and managing the virtual machines used by Vagrant.
The main providers are Virtualbox and VMware, but the default one is VirtualBox, since it's free and open source.
* **Provisioners:**
Provisioner will do some task(s) using the vm instance already provided.
The provisioners are used to set up the virtual server, installing all necessary software and executing different tasks. The most used provisioners are: Puppet, Chef and Ansible.
Shell Script is also a very common option. You can find more information about vagrant provisioners here.
* **The Vagrantfile:**
The basic vagrant configuration is based in one file, the Vagrantfile. It shall be placed in your repository root.
In this file you will define which base box you want - a box is, basically,
a package with an operational system to be run in your virtual machine.

## Ansible
You may have heard of using configuration management tools
like [Chef][38], [Puppet][39], [SaltStack][40], [Terraform][41], [CFEngine][42]
or simply using Bash scripts to provision servers or Vagrant Boxes.
The major difference between other configuration management tools and Anisble,
is that underneath Ansible is just SSH.
Chef and Puppet both have dependencies that must be installed
on the server before you can use them, Ansible does not.
[Ansible is agentless][43] — meaning there are no daemons or agents needed to run a particular action.
It runs on a machine apart from from your VMs
and uses SSH to connect to the servers and run the required commands.
Hence it is a push model, meaning no additional installs are not required at the end point VMs.

Why not just use Bash scripts, then?
Ansible has an edge over Bash scripts because
it features an goal-oriented resource model that
describes the desired state of computer systems and services,
not the paths to get them to this state.
No matter what state a system is in, Ansible understands how to transform it to the desired state.
Ansible is a simple to understand [configuration management approach][44].

Ansible just uses a list of tasks to run in YAML2 format.
Ansible also comes with [idempotency][45] out of the box.
That means you can run the same operation numerous times,
and the output will remain consistent
(i.e. it won't do something twice unless you ask it to).
You can write Bash scripts this way, but it requires quite a bit more overhead.

One important feature in Ansible is that a playbook describes a
desired state in a computer system,
so a playbook can be run multiple times against a server without impacting its state.
If a certain task has already been implemented (e.g., "user system already exists"),
then Ansible simply ignores it and moves on.

* **Tasks:** A task is the smallest unit of work.
It can be an action like "Install a database," "Install a web server,"
"Create a firewall rule," or "Copy this configuration file to that server."
* **Plays:** A play is made up of tasks. For example, the play
"Prepare a database to be used by a web server" is made up of tasks
(1) Install the database package,
(2) Set a password for the database administrator,
(3) Create a database; and 4) Set access to the database.
* **Playbook:** A playbook is made up of plays.
A playbook could be "Prepare my website with a database backend" and the plays would be
(1) Set up the database server,
(2) Set up the web server.
* **Roles:** Roles are used to save and organize playbooks and allow sharing and reuse of playbooks.
Following the previous examples, if you need to fully configure a web server,
you can use a role that others have written and shared to do just that.
Since roles are highly configurable (if written correctly),
they can be easily reused to suit any given deployment requirements.
* **Ansible Galaxy:** Ansible Galaxy is an online repository where roles are uploaded so they can be shared with others. It is integrated with GitHub, so roles can be organized into Git repositories and then shared via Ansible Galaxy.

#### Step X: Create Your Directory Structure - DONE
I not only want to create a virtual machine with Vagrant to perform my NeoVim experimentation,
but also setup a directory where I can keep all my documentation and tools permanently.

```bash
# create your working directory
mkdir -p ~/src/test-env/nvim
cd ~/src/test-env/nvim

# create a directory for ansible playbooks
mkdir -p ~/src/test-env/nvim/playbooks
```

#### Step X: Create Your Vagrant Test Environment - DONE
Now create your Vagrantfile within `~/src/test-env/nvim/Vagrantfile`.
That file is listed below:

```
<---- Vagrantfile
```

While in `~/src/test-env/nvim`,
you create your virtual machine for NeoVim testing by executing `vagrant up`.
Once this process completes, you can validate your virtual machine is ready by
`vagrant ssh` which should log you into the machine.

Make sure to update the static IP addresss in the `Vagrantfile`.
This virtual machine is configured with a static IP address (`192.168.1.250`)
since this is required for smooth operation of Ansible.
You'll also notice that the `Vagrantfile` also supplies a SSH key which will be
used by Ansible to gain access to perfrom its provisioning task.

If you need to update the Vagrant box being used,
below are the commands you'll need:

```bash
# updates the current vagrant environment if there are updates available
vagrant box update

# other useful vagrant cli commands

# list the boxes you have installed
vagrant box list

# check if there are updates available for all boxes
vagrant box outdated --global

# remove the older ubuntu/xenial64 box
vagrant box remove ubuntu/xenial64 --box-version=20180410.0.0

# first destroy the vm referenced above
vagrant destroy ce0a38ee8cf347e1a125ea0cad47d28f
```



#### Step X: Establish the Ansible Playbooks
Create the following files to support Ansible:

##### Inventory File - DONE
Establish the `inventory` file which will be used by all the Ansible Playbooks:

```
<---- Inventory File
```

##### Ping & Query Playbooks - DONE
Create a `ping.yml` playbook so you can easily valiate the virtual machine is up
and the SSH keys are working:

```
<---- Ping Playbook
```

```
<---- Query Playbook
```

```bash
# run the playbooks
ansible-playbook -i inventory ping.yml
ansible-playbook -i inventory query.yml
```



-----


# Install Baseline NeoVim
# Enhance NeoVim with Basic Capabilities
# Enhance NeoVim with IDE Packages

# ???
I'm using the XDG Base Directory Specification, or "XDG Spec" for short.
The XDG Spec is a widely used specification which specifies where your files
should be located depending on their usage published by the [freedesktop.org organization][17]
(here is a [video discussion][18]).
I'm specifically making use of the environment variables below:

```bash
XDG_CONFIG_HOME = $HOME/.config          # defines the base directory relative to which user-specific configuration files should be stored
XDG_DATA_HOME = $HOME/.local/share       # defines the base directory relative to which user-specific data files should be stored
XDG_STATE_HOME = $HOME/.local/state      # defines the base directory relative to which user-specific state files should be stored
XDG_CACHE_HOME = $HOME/.cache            # defines the base directory relative to which user-specific non-essential data files should be stored
```



#### Step 1A: Uninstalling nvim for Clean Start - DONE
If you are installing NeoVim for the first time,
you can skip this step, but if your reinstalling or rebuilding NeoVim,
this is an important step.
What is done below is to backup your current `$XDG_CONFIG_HOME/nvim`,
but equally important, you have to backup (or delete)
your `$XDG_DATA_HOME/nvim`, `$XDG_CACHE_HOME/nvim`, and `$XDG_STATE_HOME/nvim`.

Doing this might become necessary after a package upgrade
or some major editing of NeoVim's configuration files.

```bash
# make a backup of your current nvim configuration folder
cp -Lr $XDG_CONFIG_HOME/nvim $HOME/tmp/nvim_backup

# clean neovim other folders - optional
cp -Lr $XDG_STATE_HOME/nvim $HOME/tmp/nvim_backup/state
cp -Lr $XDG_DATA_HOME/nvim $HOME/tmp/nvim_backup/share
cp -Lr $XDG_CACHE_HOME/nvim $HOME/tmp/nvim_backup/cache

# a full clean-up, forcing a re-install of all plugins with an empty cache & state
trash $XDG_CACHE_HOME/nvim $XDG_STATE_HOME/nvim  \
      $XDG_DATA_HOME/nvim $XDG_CONFIG_HOME/nvim/undo \
      $XDG_CONFIG_HOME/nvim/site $XDG_CONFIG_HOME/nvim/swap \
      $XDG_CONFIG_HOME/nvim/plugin $XDG_CONFIG_HOME/nvim/share

# edit the 'active' namespace configuration files, if needed
gnome-terminal --title NeoVim -- nvim ~/.dotfiles \
        $XDG_CONFIG_HOME/nvim/init.lua $XDG_CONFIG_HOME/nvim/lua/active/init.lua \
        $XDG_CONFIG_HOME/nvim/lua/active/plugins.lua

# browse neovim logs
```

The above steps will force the reinstallation of all plugins,
and remove any cache / state data that could trip you up.
You may want to also reinstall or upgrade your version of NeoVim for a complete refreash.
To do this, proceed do the next step.

#### Step 1B: Install NeoVim on Ubuntu - DONE
The Neovim version available on your operating system repository
(see "[How to Install Neovim on Ubuntu 22.04][05]")
is not always the latest available version.

##### AppImage Install (I did not use this method)
To install the absolute latest stable version of Neovim,
you must [download it from Github][06] and then install it manually
As of Septmber 2023, this NeoVim version was at 0.9.2.
For Ubuntu, this version is available only as an [AppImage][23] or source code.

To install the AppImage version of NeoVim:

```bash
# install fuse, lets non-root users mount filesystems - see https://github.com/AppImage/AppImageKit/wiki/FUSE
sudo add-apt-repository universe
sudo apt install libfuse2

# download nvim.appimage from here - see https://github.com/neovim/neovim/releases
cd ~/tmp
wget https://github.com/neovim/neovim/releases/download/stable/nvim.appimage

# extract the image
chmod u+x nvim.appimage && ./nvim.appimage

# move the executable image to your path
mv nvim.appimage $HOME/bin/nvim
```

Uninstall is very easy.
If you want to uninstall the AppImage version of NeoVim,
just delete `$HOME/bin/nvim`.

##### Snap Install (I used this method) - DONE
To install a potential more stable, but less current, version on NeoVim,
you can use Canonical [Snap Store's][19] version
(install method documented at the Snap Store and [here][20]).
As of April 2024, this NeoVim version was at 0.9.4.
To install NeoVim via the Snap Store:

```bash
# neovim nightly & stable are available on the snap store

# stable builds for i386 architecture - latest/stable v0.9.4
sudo snap install nvim --classic

# OR nightly builds for i386 architecture - latest/stable v0.9.4
sudo snap install nvim --edge --classic

# to update snap package for neovim
sudo snap refresh nvim

# check the nvim version
$ nvim --version | grep NVIM
NVIM v0.9.4
```

To remove the Snap version of NeoVim, do the following:

```bash
# to uninstall neovim
sudo snap remove nvim
```

>**NOTE:** The `snapd` daemon handles all the updates for snaps installed on a Linux system.
>Once a snap is installed, `snapd` daemon will automatically keep it up to date.
>This is done by regularly checking for updates from the snap store and installing any available updates.
>`sudo snap refresh --time` will give you the time of the last update.

If you're interested in installing a NeoVim version other than the latest,
consult the article "[How to Install Neovim on Ubuntu 22.04][05]".

<!-- ########################## REMOVE BETWEEN HERE ############################
######################### REMOVE BETWEEN HERE ############################## -->

#### Step X: Create a NeoVim Test Environment
I want to test NeoVim versions and plugins,
but I know that there will be issues where I'll need to start over from scratch.
To make this journey easier, I'm choosing a directory structure and file conventions
that takes its into consideration.

The directory structure used by NeoVim always starts within `$HOME/.config`.
The key controlling file for NeoVim execution is `$HOME/.config/nvim/init.lua`
and the contents of `$HOME/.config/nvim/lua/active`.
There may be other sub-directories within `$HOME/.config/nvim/lua`
but `init.lua` references only the `active` sub-directory.
Any other sub-directories (if they are present) are alternative configuration for NeoVim
that can be made 'active' but changing their directory name.
All the other sub-directories of `$HOME/.config/nvim` will be created by NeoVim itself
or its package manager (in my case Packer).

I can make use of this 'active' convention by changing references to 'active'
in the `init.lua` file, effectively changing the configuration of NeoVim
with very little effort.

The target directory structure is illustrated below:

```
Using command: tree -a --filesfirst ~/.dotfiles/pkg-nvim

$HOME/.config/
└── nvim
    ├── init.lua
    └── lua
        └── active
            ├── key-mapping.lua
            ├── options.lua
            ├── plugins.lua
            └── vars.lua
```

I can create this initial directory structure via:

```bash
# remove any existing neovim configuration directory
trash ~/.config/nvim

# create a new neovim configuration directory
mkdir -p ~/.config/nvim/lua/active

# create the initial neovim files (all void at this time)
touch ~/.config/nvim/init.lua
cd ~/.config/nvim/lua/active
touch key-mapping.lua options.lua plugins.lua vars.lua
```


-------



#### Step X: Configure NeoVim
Now that I got Neovim running,
it’s time to start customizing your config files.
Many tutorials are geared towards users who are new to Neovim but have used Vim in the past.
In other words, a lot of tutorials show how to transition one’s configuration from the Vimscript file `init.vim`
to the Neovim file `init.lua`.
I'm going to take advantage of Lua’s position as a first-class language inside Neovim
and build config files using this language from the start.

MORE MORE MORE

Sources:

* REMOVE [Neovim Configuration for Beginners](https://builtin.com/software-engineering-perspectives/neovim-configuration)
* [How to Install and Set Up Neovim for Code Editing](https://mattermost.com/blog/how-to-install-and-set-up-neovim-for-code-editing/)
* [Turning Neovim into a Full-Fledged Code Editor with Lua](https://mattermost.com/blog/turning-neovim-into-a-full-fledged-code-editor-with-lua/)

##### Setup Initialization File
Create your `~/.config/nvim/init.lua` file in your Neovim configuration directory.

```bash
# create a very basic init.lua file
mkdir -p ~/.config/nvim/basic/lua

# create the files for a very basic nvim experience
nvim -p ~/.config/nvim/init.lua ~/.config/nvim/lua/basic/auto.lua ~/.config/nvim/lua/basic/key-mapping.lua ~/.config/nvim/lua/basic/options.lua ~/.config/nvim/lua/basic/plugins.lua
```

Now enter the following in the `~/.config/nvim/init.lua` file:

```lua
```

ETC, ETC, ETC

#### Step X: Install Vim-plug / Packer Plugin Managers
A plugin is a way to extend `vim` functionality and
this is where the combination of Neovim + Lua really shines.
The first thing you’ll need is a plugin manager (e.g. [Vim-plug][16] and [Packer][118]).
While it’s possible to manually install these plugins yourself,
it’s much simpler to use a tool that can take care of installing, updating, and removing packages on your behalf.

`vim` categorizes plugins into "global" plugins (which load and operate unconditionally)
and "filetype" plugins (which only load and operate for specific file types).
`vim` looks for plugins in specific locations,
in your home directory at `~/.vim/plugin`,
assuming you have not altered the runtime path.
You can change this location manually or via plugins like [Pathogen][107] or [Vundle][08].

To install plugins, you must first declare them in Vim / NeoVim configuration file.
The configuration file for ordinary Vim is `~/.vimrc`
and the config file for NeoVim is `~/.config/nvim/init.vim`.



You can install tons of plugins for your `vim`,
but choosing the plugins you want from the plugin directory is the essential step.
For Vim, there is a website called [Awesome Vim][10] that provides a gist of all these plugins in a single place.
For NeoVim, xxxxxx
It is generally a good option to check if the plugin is maintained properly
and has no key binding conflict with other installed plugins.

##### Step X: Install Packer Plugin Mananger

```bash
# pre requisites for vim plug
sudo apt install git

# install the packer plug manager - for neovim - https://github.com/wbthomason/packer.nvim
git clone --depth 1 https://github.com/wbthomason/packer.nvim \
    ~/.config/nvim/site/pack/packer/start/packer.nvim
```

This should create a new folder `~/.config/nvim/site` in your Neovim configuration directory.
You can take a look at all of the new files and folders created in this directory with `tree ~/.config`.
This is where Packer will install and configure any plugins you specify.

Now you’ll need to tell NeoVim that it should use the Packer plugin for plugin management.
In your `~/.config/nvim/lua` subdirectory,
open a new file in NeoVim called `plug.lua` and add the following lines of code:

```lua
-- [[ plug.lua ]]

return require('packer').startup(function(use)
  -- [[ Plugins Go Here ]]
end,
config = {
  package_root = vim.fn.stdpath('config') .. '/site/pack'
})
```

>**NOTE:** The double dots, i.e., `..`, is the Lua syntax for string concatenation.

This code block says to load the Packer module each time NeoVim is started.
It also sets the `package_root` to the location where you cloned the Packer repository.

Next, uncomment the line that imports your plugins module in your `~/config/nvim/init.lua`
file so it looks like this:

```lua
--[[ init.lua ]]

-- LEADER
-- These keybindings need to be defined before the first /
-- is called; otherwise, it will default to "\"
vim.g.mapleader = ","
vim.g.localleader = "\\"

-- IMPORTS
require('vars')      -- Set Variables
require('opts')      -- Set Options
require('keys')      -- Key Mappings
require('plug')      -- Plugins
```

#### PackerCommands
packer provides the following commands after you've run and configured packer with require('packer').startup(...):

```lua
-- You must run this or `PackerSync` whenever you make changes to your plugin configuration
-- Regenerate compiled loader file
:PackerCompile

-- Remove any disabled or unused plugins
:PackerClean

-- Clean, then install missing plugins
:PackerInstall

-- Clean, then update and install plugins
-- supports the `--preview` flag as an optional first argument to preview updates
:PackerUpdate

-- Perform `PackerUpdate` and then `PackerCompile`
-- supports the `--preview` flag as an optional first argument to preview updates
:PackerSync

-- Show list of installed plugins
:PackerStatus

-- Loads opt plugin immediately
:PackerLoad completion-nvim ale
```


#### Step X: Install Your First Plugins
To install plugins,
you must first declare them in Vim or NeoVim configuration file as shown below.
The configuration file for ordinary Vim is `~/.vimrc`
and the configuration file for Neovim is `~/.config/nvim/init.vim`.
Also, when declaring the plugins in the configuration file,
the list should start with `call plug#begin(<PLUGIN_DIRECTORY>)` and end with `call plug#end()`.

To get started, let us install [`lightline.vim`][11] plugin.
To do so, add the following lines on top of your `~/.config/nvim/init.vim` file.

```lua
-- lightline.vim - https://github.com/itchyny/lightline.vim
call plug#begin('~/.config/nvim/plugins')
Plug 'itchyny/lightline.vim'                -- light & configurable statusline/tabline plugin for vim
call plug#end()
```

After adding the above lines in NeoVim configuration file,
perform the following on the NeoVim command line:

```bash
# reload the configuration file
#:source ~/.vimrc
:source ~/.config/nvim/init.vim

# check the plugin status
:PlugStatus

# install the plugins that you have declared in the config file earlier
:PlugInstall

# to update plugins, run
:PlugUpdate
```

#### Step X: Review / Remove / Rollback Plugins
Some times, the updated plugins may have new bugs or no longer work correctly.
To fix this, you can simply rollback the problematic plugins.

```bash
# to review the changes from the last :PlugUpdate
:PlugDiff

#  roll each plugin back to the previous state, before the update, by pressing X on each paragraph
```

To remove a plugin delete or comment out the plug commands
that you have added earlier in your NeoVim configuration file.
Then do the following:

```bash
# reload the configuration file
# OR restart Vim editor
#:source ~/.vimrc
:source ~/.config/nvim/init.vim

# run the following command to uninstall the plugins
:PlugClean
```

To upgrade the vim-plug itself, type:

```bash
# upgrade the vim plugins
:PlugUpgrade
```


------


# Do Health Check
execute `:checkhealth` and fix any problems found
`checkhealth mason`

* [CheckHealth in Neovim](http://vimcasts.org/episodes/neovim-checkhealth/)

## Getting Healthy
On a fresh install of NeoVim,
if you open `nvim` and enter the following command `:checkhealth` in Command mode
you'll get a lengthy report with some lines containing warnings and errors.
Let's fix these problems.

Make sure you have installed Neovim version 0.9 or grater.

Install Nerd Fonts.

To fix copy & paste,
install the appropriate clipboard:

```bash
# if your using X Window's X11 protocol
sudo apt install xsel

# if your using X Window's Wayland protocol
sudo apt install wl-clipboard
```

To fix complaints about lack of Python, Node.js, `ripgrep`, etc. support,
do the following installs on the machine hosting your NeoVim:

```bash
# neovim python support
pip install pynvim

# install node.js and node package manager (npm)
sudo apt install nodejs
sudo apt install npm

# add neovim node support
sudo npm install -g neovim

# add support for yarn package management
sudo npm install -g yarn

# ripgrep (executable is called `rg`) is need by for telescope
sudo apt install ripgrep

# install the alternative to 'find'
sudo apt install fd-find

# install ruby and gem
sudo apt install ruby

# add neovim ruby support
gem install neovim

# install go language support (needed by mason)
sudo apt install golang
```


------


# Nvimtree (aka Nvim-Tree)
Nvimtree is a Neovim plugin to browse the file system and other tree like structures in whatever style suits you, including sidebars, floating windows, split style, file icons or all of them at once!

replace `:netrw`

* [Neovim for Beginners — File Explorer](https://alpha2phi.medium.com/neovim-for-beginners-file-explorer-a0b2e5cf6c57)
* [Neovim - NvimTree File Explorer Written In Lua](https://www.youtube.com/watch?v=SpexCBrZ1pQ)
* [GitHug: nvim-tree/nvim-tree.lua](https://github.com/nvim-tree/nvim-tree.lua)
* [GetHub: nvim-tree/nvim-web-devicons](https://github.com/nvim-tree/nvim-web-devicons)

Alternative is [nvim-neo-tree/neo-tree.nvim](https://github.com/nvim-neo-tree/neo-tree.nvim)
[How to Set up Neovim for Windows and Linux with Lua and Packer](https://dev.to/slydragonn/how-to-set-up-neovim-for-windows-and-linux-with-lua-and-packer-2391)



------



# Adding Packages
* [numToStr / FTerm.nvim](https://github.com/numToStr/FTerm.nvim)
* A File Explorer For Neovim Written In Lua - [nvim-tree / nvim-tree.lua](https://github.com/nvim-tree/nvim-tree.lua)
* [folke / which-key.nvim](https://github.com/folke/which-key.nvim)
* [sainnhe / everforest](https://neovimcraft.com/plugin/sainnhe/everforest/index.html)
* [iamcco / markdown-preview.nvim](https://github.com/iamcco/markdown-preview.nvim)
* [ibhagwan / fzf-lua](https://github.com/ibhagwan/fzf-lua)

## ToggleTerm
* [akinsho / toggleterm.nvim](https://github.com/akinsho/toggleterm.nvim)
* [Example Setup: toggleterm.lua](https://github.com/ChristianChiarulli/nvim/blob/master/lua/user/toggleterm.lua)
* [Neovim - Toggleterm | Open terminal programs in Neovim](https://www.youtube.com/watch?v=5OD-7h7gzxU)

## Cheatsheet
* [Neovim for Beginners — Cheatsheet and Coding Assistant](https://alpha2phi.medium.com/neovim-for-beginners-cheatsheet-and-coding-assistant-137d5a15c934)
* [Neovim 101 — Coding Assistant](https://alpha2phi.medium.com/neovim-101-coding-assistant-1df31c63913e)

## Coding Assistant
* [Neovim 101 — Coding Assistant](https://alpha2phi.medium.com/neovim-101-coding-assistant-1df31c63913e)
* [Neovim for Beginners — Cheatsheet and Coding Assistant](https://alpha2phi.medium.com/neovim-for-beginners-cheatsheet-and-coding-assistant-137d5a15c934)
* [Neovim for Beginners — 3rd Party Tools](https://alpha2phi.medium.com/neovim-for-beginners-3rd-party-tools-c4a5148e501c)
* [toggleterm.nvim](https://github.com/akinsho/toggleterm.nvim)
* [Neovim Tips for a Better Coding Experience](https://alpha2phi.medium.com/neovim-tips-for-a-better-coding-experience-3d0f782f034e)

## Which Key Mapping
* [Neovim for Beginners — Key Mappings and WhichKey](https://alpha2phi.medium.com/neovim-for-beginners-key-mappings-and-whichkey-31dbf58f9f87)

## Tree Sitter
* [tree-sitter / tree-sitter](https://github.com/tree-sitter/tree-sitter)
* [nvim-treesitter / nvim-treesitter](https://github.com/nvim-treesitter/nvim-treesitter)



------



# Install Mason.nvim
* [Neovim - Null-ls: a quick explanation](https://www.youtube.com/watch?v=e3xxkEbhG0o)
null-ls is primarily focussed on running traditional command line linters and formatters, and integrating that with Neovim’s native LSP and diagnostic subsystems.

null-ls does not replace lsp-config or implement its own auto completion engine (though it can produce completion sources for integration with nvim-cmp for example).

In an ideal world there would be no need for null-ls if every language had proper full featured language servers. But we don’t live in such a world, hence null-ls.

Think of null-ls as an ALE replacement, a bridge to link traditional linters and formatters with modern Neovim LSP.

* [Configuring Language Server Protocol in Neovim](https://blog.codeminer42.com/configuring-language-server-protocol-in-neovim/)
* [Learn How To Use NeoVim As an IDE](https://programmingpercy.tech/blog/learn-how-to-use-neovim-as-ide/)
    * [Configure Mason Nvim - Portable Package Manager For Neovim](https://www.youtube.com/watch?v=2iczAXDdgTE&list=PLIHtvvGZ1O3jBXdp9Id02vRuOEOWIGB_w&index=9)

* [Configure Mason Nvim - Portable Package Manager For Neovim](https://www.youtube.com/watch?v=2iczAXDdgTE)
* [0 to LSP : Neovim RC From Scratch](https://www.youtube.com/watch?v=w7i4amO_zaE)
* [Learn How To Use NeoVim As An IDE](https://www.youtube.com/watch?v=H0J1c48NObc)
    * [Learn How To Use NeoVim As an IDE](https://programmingpercy.tech/blog/learn-how-to-use-neovim-as-ide/)
* [Getting started with neovim's native LSP client: The easy way](https://dev.to/vonheikemen/getting-started-with-neovims-native-lsp-client-in-the-year-of-2022-the-easy-way-bp3)
* [How to set up Neovim 0.5 + Modern plugins (LSP, Treesitter, Fuzzy finder, etc)](https://blog.inkdrop.app/how-to-set-up-neovim-0-5-modern-plugins-lsp-treesitter-etc-542c3d9c9887)
* [Effective Neovim: Instant IDE](https://www.youtube.com/watch?v=stqUbv-5u2s)
* [0 to LSP : Neovim RC From Scratch](https://www.youtube.com/watch?v=w7i4amO_zaE)
* [A Step-by-Step Guide to Configuring LSP in Neovim for Coding in Next.js (React), TypeScript, and TailWindCSS](https://levelup.gitconnected.com/a-step-by-step-guide-to-configuring-lsp-in-neovim-for-coding-in-next-js-a052f500da2#5a4b)
* [Neovim for Beginners — LSP (Part 1)](https://alpha2phi.medium.com/neovim-for-beginners-lsp-part-1-b3a17ddbe611)
* [Neovim for Beginners — LSP (Part 2)](https://alpha2phi.medium.com/neovim-for-beginners-lsp-part-2-37f9f72779b6)
* [Configuring Language Server Protocol in Neovim](https://blog.codeminer42.com/configuring-language-server-protocol-in-neovim/)

[Mason.nvim][233] is a replacement for [nvim-lsp-installer][27] since it is no longer maintained.
Mason adds the ability to install and manage LSP servers, DAP servers, linters, and formatters.
It builds on top of the very same foundation as `nvim-lsp-installer` and writen in Lua,
but with a majority of internals refactored to improve extensibility and testability.

## Language Server Protocol (LSP)
The [Language Server Protocol (LSP)][28] is an open, JSON-RPC-based protocol for use
between source code editors or integrated development environments (IDEs)
and servers that provide programming language-specific features like code completion,
linting, go-to-definition, syntax highlighting
and marking of warnings and errors, as well as refactoring routines.
The goal of the protocol is to allow programming language support to be implemented
and distributed independently of any given editor or IDE.
In effect, it enables an editor to "understand" the edited language it operating on.

Nvim supports the Language Server Protocol (LSP),
which means it acts as a client to LSP servers and includes a
Lua framework `vim.lsp` for building enhanced LSP tools.
Microsoft developed LSP for its VSCode,
and is now the de facto standard for hooking up editors with code completion, diagnostics, refactoring etc.

As you can imagine, this is a lot of work for something that's common to all text editors:
no matter the editor, the way a language works remains the same.
That's why Microsoft built LSP:
to define a standard protocol for this,
so that editors can hook up to "language servers"
and benefit from these features without reinventing the wheel.
The Vim ecosystem has multiple LSP clients that can attach to a LSP server:
[vim lsp][63], [ale][64], [coc][65],
and the built-in [Neovim lsp][66], introduced in Neovim 0.5.:w
So Nvim natively supports the Language Server Protocol (LSP),
which means it acts as a client to LSP servers
and includes a Lua framework `vim.lsp` for building enhanced LSP tools.

* [VonHeikemen/lsp-zero.nvim][230]  -- You might not need lsp-zero - https://www.reddit.com/r/neovim/comments/102bicr/you_might_not_need_lspzero/
* [neovim/nvim-lspconfig][232]             -- enables accessing the built-in LSP client within neovim, so you still need to set up the LSP language servers for each language you use
* [williamboman/mason.nvim][233]           -- installer & manager of LSP servers, DAP servers, linters, and formatters
ne o
* [williamboman/mason-lspconfig.nvim][231] -- extension to mason.nvim that makes it easier to use lspconfig with mason.nvim
* [jose-elias-alvarez/null-ls.nvim][243]   -- provides formatters and diagnostics servers that we don’t have built-in neovim, like prettier and rubocop
* [hrsh7th/nvim-cmp][224]                  -- this is for auto-completion and suggestions as we type
* [hrsh7th/cmp-nvim-lsp][234]              -- nvim-cmp source for neovim's built-in language server client

* [Neovim LSP and DAP using Lua](https://alpha2phi.medium.com/neovim-lsp-and-dap-using-lua-3fb24610ac9f)
* [Basic Neovim LSP Setup - Treesitter + LSP + Completion](https://www.youtube.com/watch?v=Ku-m7eEbWas)
* [Neovim - Telescope: a highly extendable fuzzy finder](https://www.youtube.com/watch?v=OhnLevLpGB4)
    * [5 Terrific Neovim Telescope Extensions for 2022](https://www.youtube.com/watch?v=indguFY7wJ0)
* [Neovim modern features: treesitter and LSP](https://blog.pabuisson.com/2022/08/neovim-modern-features-treesitter-and-lsp/)

### Installing LSP Language Servers
Language Servers, like any other servers,
run in the background of your computer and they serve-up their services
such as autocompletion, diagnostics (linting), formatting, hover information, renaming, etc.
to any client such as NeoVim (or vscode, atom, sublime, etc. if that is what your using).
These services are served by following a special communication protocol,
that being the Language Server Protocol (LSP) in our case.

To leverage the LSP(s), we must first install an appropriate LSP server for each language we want to interact with.
For my work here, I opted for the languages Lua (`lua-language-server`),
Python (`pyright` or `python-language-server`),
and Bash (`bash-language-server`).

Some of the tutorals found in at the begining of this document (e.g. [Configuring Neovim](https://www.youtube.com/playlist?list=PLIHtvvGZ1O3jBXdp9Id02vRuOEOWIGB_w))
shows you how to install the LSP client within NeoVim and servers on your host machine.
While this approach works, it is more manual than what can be done with the aid of the package [williamboman/mason.nvim][233].
`mason.nvim` is a Neovim plugin that allows you to easily manage external
editor tooling such as LSP servers, DAP servers, linters, and formatters through a single interface.





------



# Install Glow
[Glow][52] is a terminal based markdown reader that renders markdown on the CLI.

```bash
# install glow on debian/ubuntu

# add the app key to the keyring
sudo mkdir -p /etc/apt/keyrings
curl -fsSL https://repo.charm.sh/apt/gpg.key | sudo gpg --dearmor -o /etc/apt/keyrings/charm.gpg

# install referances to the glow repository
echo "deb [signed-by=/etc/apt/keyrings/charm.gpg] https://repo.charm.sh/apt/ * *" | sudo tee /etc/apt/sources.list.d/charm.list

# install glow
sudo apt update && sudo apt install glow
```

There is also a Glow NeoVim plugin,
at Github repository [ellisonleao/glow.nvim][53],
that allow you to preview markdown code directly in your NeoVim terminal.



------



# NeoVim and Fonts
So you want to increase or decrease the font size, or change the font used, or what ever?
Maybe as easily as pressing `Ctrl +` or `Ctrl -` like in every other GUI application out there?
Not so!

Most Vim users still run `vim` (or `nvim`) from the command line, with a terminal emulator.
That is what I'm doing in this document.
But if you are running Vim inside of a terminal emulator,
the font isn’t controlled by Vim or NeoVim,
it is controlled by the terminal emulator, so look up the documentation for that.

For example, I am using GNOME Terminal.
In GNOME you can adjust the font size with `Ctrl Shift +` and `Ctrl -` and it just works.
(In other terminal emulators you can often hold Ctrl and scroll the mouse wheel to adjust font size).
See ["How to adjust the GUI font size in Vim or Neovim"][60] if your using GUI Vim (aka `gvim`)
or one of the many graphical Neovim frontends.

## Types of Fonts
First, some font basics.
In general, fonts are divided into three classes namely Serif, Sans, and Mono.

* **Serif** family fonts look "sharp" with its pointy "thorns" on every character (in Latin, serif).
Examples of Serif fonts are Times New Roman, Liberation Serif, and Apple Garamond.
* **Sans** family fonts look "dull" without "thorns" (hence they're called sans-serif or no-thorns).
Example of Sans fonts are Arial, Liberation Sans, and Helvetica.
* **Mono** family fonts look "square-y" also known as "typewriter" machine style.
Examples of Mono fonts are Courier New, Liberation Mono, and Monaco.

Furthermore, fonts also divided into two forms namely Bold and Italic (aka a "thick" and "slanted" writings).
As a result, you will find combinations in every single font,
divided into several files with each one serving a specific writing purpose.

Ubuntu bundled its own fonts,
and they are all Free Libre Open Source Software licensed (FLOSS).
The fonts included by default in Ubuntu are of course different to other operating systems.
On Ubuntu, fonts installation is located in two places:
User fonts - `~/.local/share/fonts/` and System fonts - `/usr/share/fonts/`.

## Install Nerd Fonts
The terminal version of NeoVim will use what ever your font your terminal is using.
So to implement your prefered font,
you’ll need to change the font of your terminal emulator.
In my case, this is gnome-terminal.

Nerd Fonts is a project that patches developer-targeted fonts with many [glyphs][54] ([icons][55]).
It includes [programming ligatures][56] and is designed to enhance the appearance of source code.
Nerd Fonts also includes additional broad range of glyphs giving geeks more eye candy.

```bash
# list all the available fonts
fc-list

# check if any nerd fonts are already installed
fc-list | grep -i nerd
```

Npw lets install the tool, [getNF (aka `getnf`)][58],
we'll use to load Nerd Fonts on our system:

```bash
# cloning the nerd fonts installation tool 'getnf'
cd ~/src
git clone https://github.com/ronniedroid/getnf.git
cd ~/getnf
./install.sh
```

To find a font that you find appealing,
check out [programmingfonts.org](https://www.programmingfonts.org/)
and [CodingFont](https://www.codingfont.com/).

Make sure that `~/.local/bin` is in your PATH so that `getnf` is executable.
Now to install the fonts,
we'll run `getnf` and select from the menu what fonts to install.
Choose one or more fonts (by index/number) to install
Hit Return/Enter to install the selected fonts.
Type the index/number corresponding to 'Quit' to cancel.

```bash
# you can load fonts from your home directory
cd $HOME

# read the getnf help information
getnf --help

# using `gitnf`, install the following fonts:
# DejaVuSansMono, DroidSansMono, FiraCode, Inconsolata, Noto, RobotoMono,
# SourceCodePro, SpaceMono, Ubuntu, UbuntuMono, JetBrainsMono, FiraCode
getnf

# check if the nerd fonts have been added
ls ~/.local/share/fonts
```

At this point, you'll need to restart your X Windows desktop manager so the `gnome-terminal`
application picks up the change.
With that, within a `gnome-terminal` window,
click the "hamburger" menu > Preferences > Default > select your Nerd Font.

* [Our favorite fonts for the Linux terminal](https://opensource.com/article/23/4/linux-terminal-fonts)

Once the font files are copied to these locations,
you need to refresh system wide font cache to complete the installation.
To do so, run the following command: `sudo fc-cache -vf ~/.local/share/fonts`.
The fonts in `~/.local/share/fonts` are available for all apps now.

To remove fonts installed on User directory:
Go to `~/.local/share/fonts/` and delete the files with `.ttf` or `.otf` extensions.
Repeat this step for each of the targetted fonts.

Sources

* [How to Install Nerd Fonts on Linux](https://bytexd.com/how-to-install-nerd-fonts-on-linux/)
* [How to Install Nerd Fonts on Linux](https://www.geekbits.io/how-to-install-nerd-fonts-on-linux/)
* [Nerd Fonts](https://www.nerdfonts.com/#home)
* [GitHub: ryanoasis/nerd-fonts](https://github.com/ryanoasis/nerd-fonts)
* [Add Icons to your Fonts with Nerd Fonts](https://www.youtube.com/watch?v=fR4ThXzhQYI)
* [Neovim 101 — Fonts](https://alpha2phi.medium.com/neovim-101-fonts-da575bd4eda9)
* [Installing system nerd-fonts with ansible](https://waylonwalker.com/ansible-install-fonts/)
    * [No More Missing Fonts | ansible-playbook](https://www.youtube.com/watch?v=2MEmsinxRK4)



------



# Using AstroNvim with NeoVim

Sources:

* [Neovim With AstroNvim | Your New Advanced Development Editor](https://www.youtube.com/watch?v=GEHPiZ10gOk)
* [Astro Vim - All in one Nvim config!!](https://www.youtube.com/watch?v=JQLZ7NJRTEo)
* [AstroNvim](https://astronvim.com/)

#### Step X: Backup NeoVim Files
```bash
# make a backup of your current nvim folder
mv ~/.config/nvim ~/.config/nvim.bak

# clean neovim folders - optional but recommended
mv ~/.local/share/nvim ~/.local/share/nvim.bak
mv ~/.local/state/nvim ~/.local/state/nvim.bak
mv ~/.cache/nvim ~/.cache/nvim.bak
```

#### Step X: Install and Confgure AstroNvim
```bash
# clone the astronvim repository
git clone --depth 1 https://github.com/AstroNvim/AstroNvim ~/.config/nvim
```


------


# Using Buffers, Windows, and Tabs Efficiently in Vim
* [Using buffers, windows, and tabs efficiently in Vim](https://dev.to/iggredible/using-buffers-windows-and-tabs-efficiently-in-vim-56jc#tabs)
* [Why do Vim experts prefer buffers over tabs?](https://stackoverflow.com/questions/26708822/why-do-vim-experts-prefer-buffers-over-tabs/26745051#26745051)

```bash
# create 3 buffers, one for each only one tab/window
vim file1 file2 file3

# create 3 buffers and each file in there own tab
vim -p file1 file2 file3
```

```vim
" turn buffers into tab page in neovim
:tab ball
```

# NeoVim Copy & Paste
Vi, Vim, and NeoVim have there own clipboard system meaning if you copy (aka 'yank' in `nvim`) something,
you won’t be able to just paste it in other apps because the clipboard is only available inside the editor.
There are many times when you want to copy & paste `nvim` to/from another application.
To do this, you must have access to your OS clipboard.

in Linux, you would think this is straight-forward, but it's not.
It depends on the window system that is being used: [Wayland][50] or [X11][51].

```bash
# environment variables & applications that provide information about your system's graphics environment

# check whether Wayland or Xorg is in use
echo $XDG_SESSION_TYPE

# check desktop envirnment
echo $XDG_CURRENT_DESKTOP

# displays the OS name, kernel version, hostname, display resolution, shell name
sudo apt install neofetch
neofetch
```

In my case, I'm running with X11.
For X11 window system, you need to install `xclip`
on both your source & target systems for the copy & paste.
you also need to set the 'clipboard' option as shown below:

```bash
# install `xclip` on both source & target systems
sudo apt install xclip
```

```lua
-- in the neovim `options.lua` file add
vim.o.clipboard = "unnamedplus"
```

With this, you should be able to copy & paste to/from non-NeoVim applications and `nvim`.
For me, the clipboard copy & paste keys are:
`"+y` (copy) and `"+p` (paste).

Also note there also appears to be an

```vim
" paste into vim by gnome-terminal's shortcut for paste.
<Ctrl>+<Shift>+v
```

https://stackoverflow.com/questions/67598285/cannot-paste-from-clipboard-in-neovim-nightly
Neovim doesn't have any code to access OS clipboard directly (or to process X Window events). Instead it delegates to external utilities/plugins. You're expected to execute :checkhealth command to see the current state. If you don't have any supported tool on your PATH then you'll not be able to access the clipboard.

As a shameless plug, I wrote [plugin](https://github.com/matveyt/neoclip) that consists of dynamic library providing direct access to clipboard. This is to avoid extra process creation for every copy/paste operation (btw. setting clipboard=unnamed[plus] is bad for more than just this single reason). However, the library must be built from source before use.

As of Wayland, its IPC mechanism is clearly different from X but at least in GNOME or KDE you may expect both selections being synchronized transparently. Otherwise you need specific utils to access Wayland clipboard, such as wl-copy/wl-paste.

Sources:

* [How to Check if You are Using Wayland or Xorg?](https://itsfoss.com/check-wayland-or-xorg/)
* [How to access OS clipboard in neovim](https://ramezanpour.net/post/2022/07/24/access-os-clipboard-in-neovim)
* [WSL NeoVim Copy & Paste](https://lloydrochester.com/post/vim/wsl-neovim-copy-paste/)



------



# Terminal Debugger
* [Neovim for Beginners — Terminal Debugger](https://alpha2phi.medium.com/neovim-for-beginners-terminal-debugger-77e48428378d)
* [Debugging in Vim](https://www.dannyadam.com/blog/2019/05/debugging-in-vim/)
* [Debugging in Neovim](https://harrisoncramer.me/debugging-in-neovim/)
* [Debugging In Neovim (ft BashBunni)](https://www.youtube.com/watch?v=0moS8UHupGc)
* [Neovim — Debugging Application](https://alpha2phi.medium.com/neovim-debugging-application-70c525754064)



------



# Framework for Testing NeoVim
A framework for interacting with tests within NeoVim.

* [GitHub: nvim-neotest/neotest](https://github.com/nvim-neotest/neotest)
* [Debugging Neovim with Neovim and nvim-dap](https://zignar.net/2023/02/17/debugging-neovim-with-neovim-and-nvim-dap/)
* [Neovim for Beginners — Testing (Part 2)](https://alpha2phi.medium.com/neovim-for-beginners-testing-part-2-10d4aa8f25d6)



------



# Install LazyGit
Lazygit is a simple terminal UI for `git` commands,
written in Go (runs on Linux, macOS, FreeBSD, and Windows).
Lazygit is fast, easy to use, and enables you to have a feeling of [Sourcetree][118]
but in a terminal-centric environment.

```bash
# install lazygit's prerequsits
sudo apt-get install build-essential libssl-dev libreadline-dev zlib1g-dev

# get the version number of the latest version of lazygit
LAZYGIT_VERSION=$(curl -s "https://api.github.com/repos/jesseduffield/lazygit/releases/latest" | grep -Po '"tag_name": "v\K[^"]*')

# print the lazygit version number
$ echo $LAZYGIT_VERSION
0.38.2

# download the installer file
cd ~/tmp
curl -Lo lazygit.tar.gz "https://github.com/jesseduffield/lazygit/releases/latest/download/lazygit_${LAZYGIT_VERSION}_Linux_x86_64.tar.gz"

# move the lazygit executable to the desired location
sudo tar -xf lazygit.tar.gz -C /home/jeff/bin/

# your version of lazygit
$ lazygit --version
commit=5149b24ab3dfad3860e2300519c7c583dcc8c9ff, build date=2023-05-03T08:00:22Z, build source=binaryRelease, version=0.38.2, os=linux, arch=amd64, git version=2.34.1
```

To uninstall LazyGit, just do the following: `rm -rf /home/jeff/bin/lazygit`.

Sources:
* [GitHub: jesseduffield/lazygit][226]
* [How to Install LazyGit on Ubuntu](https://tipsonunix.com/2023/02/06/how-to-install-lazygit-on-ubuntu/)
* [Install and Use lazygit – A simple terminal UI for git commands](https://computingforgeeks.com/how-to-install-and-use-lazygit-a-simple-terminal-ui-for-git-commands/)

Tutorials:
* [Make advanced Git tasks simple with Lazygit](https://opensource.com/article/20/3/lazygit)
* [15 Lazygit Features In Under 15 Minutes](https://www.youtube.com/watch?v=CPLdltN7wgE)
* [Enhanced Productivity with This Terminal UI for Git Commands](https://bootcamp.uxdesign.cc/enhanced-productivity-with-this-terminal-ui-for-git-commands-ee7af02b63af)
* [LazyGit Keybindings](https://github.com/jesseduffield/lazygit/tree/master/docs/keybindings)



[01]:https://black.readthedocs.io/en/stable/
[02]:https://eslint.org/
[03]:https://beta.ruff.rs/docs/
[04]:https://github.com/LunarVim/LunarVim
[05]:https://linuxopsys.com/topics/install-neovim-ubuntu-and-plugins
[06]:https://github.com/neovim/neovim/releases/tag/stable
[07]:https://github.com/NvChad/NvChad
[08]:https://linuxhint.com/installing_vim_vundle_plugin_ubuntu/
[09]:https://github.com/AstroNvim/AstroNvim
[10]:https://vimawesome.com/
[11]:https://github.com/itchyny/lightline.vim
[12]:https://learnxinyminutes.com/docs/vim/
[13]:https://learnxinyminutes.com/docs/lua/
[14]:https://hackernoon.com/understand-neovim-modes-once-and-navigate-them-like-a-pro-heres-how
[15]:https://rdrn.me/neovim/
[16]:https://github.com/junegunn/vim-plug
[17]:https://specifications.freedesktop.org/basedir-spec/basedir-spec-0.6.html
[18]:https://www.youtube.com/watch?v=wT85Ynk-0MY
[19]:https://snapcraft.io/nvim
[20]:https://github.com/neovim/neovim/wiki/Installing-Neovim#snap
[21]:https://www.lazyvim.org/
[22]:
[23]:https://appimage.org/
[24]:
[25]:
[26]:
[27]:https://github.com/williamboman/nvim-lsp-installer
[28]:https://microsoft.github.io/language-server-protocol/
[29]:
[30]:https://www.virtualbox.org/
[31]:https://www.virtualbox.org/wiki/Virtualization
[32]:https://en.wikipedia.org/wiki/Hardware-assisted_virtualization
[33]:https://en.wikipedia.org/wiki/Virtual_machine
[34]:https://docs.oracle.com/cd/E97728_01/E97727/html/vboxmanage-intro.html
[35]:https://www.vagrantup.com/
[36]:https://www.vagrantup.com/docs/vagrantfile/
[37]:https://www.vagrantup.com/docs/
[38]:https://www.chef.io/
[39]:https://puppet.com/
[40]:https://saltstack.com/
[41]:https://www.terraform.io/
[42]:https://cfengine.com/
[43]:https://medium.com/@cabot_solutions/ansible-and-docker-the-best-combination-for-an-efficient-software-product-management-28c86cfebe90
[44]:https://www.ansible.com/use-cases/configuration-management
[45]:https://stackoverflow.com/questions/1077412/what-is-an-idempotent-operation
[46]:
[47]:
[48]:
[49]:
[50]:https://wayland.freedesktop.org/
[51]:https://www.x.org/wiki/
[52]:https://github.com/charmbracelet/glow
[53]:https://github.com/ellisonleao/glow.nvim/tree/main
[54]:https://en.wikipedia.org/wiki/Glyph
[55]:https://en.wikipedia.org/wiki/Icon_(computing)
[56]:https://practicaltypography.com/ligatures-in-programming-fonts-hell-no.html
[57]:https://www.youtube.com/watch?v=NkfMBI1tVwY
[58]:https://github.com/ronniedroid/getnf
[59]:
[60]:https://www.codetinkerer.com/2023/01/16/how-to-adjust-gui-font-size-vim-neovim.html
[61]:https://smarttech101.com/how-to-use-vim-neovim/
[62]:https://www.youtube.com/watch?v=iMacxZQMPXs
[63]:https://github.com/prabirshrestha/vim-lsp
[64]:https://github.com/dense-analysis/ale
[65]:https://github.com/neoclide/coc.nvim
[66]:https://neovim.io/doc/user/lsp.html
[67]:
[68]:
[69]:
[70]:

[101]:https://www.redhat.com/sysadmin/introduction-ed-editor
[102]:https://www.redhat.com/sysadmin/introduction-vi-editor
[103]:https://www.redhat.com/sysadmin/beginners-guide-vim
[104]:https://neovim.io/
[105]:
[106]:
[107]:https://gist.github.com/romainl/9970697
[108]:https://www.linuxfordevices.com/tutorials/linux/vim-plug-install-plugins
[109]:
[110]:
[111]:
[112]:
[113]:
[114]:
[115]:https://learnvimscriptthehardway.stevelosh.com
[116]:https://www.lua.org/docs.html
[117]:https://visualstudio.microsoft.com/vs/
[118]:https://www.sourcetreeapp.com/
[119]:https://marketplace.visualstudio.com/
[120]:https://marketplace.visualstudio.com/items?itemName=JaredParMSFT.VsVim
[121]:https://en.wikipedia.org/wiki/Silent_700
[122]:https://en.wikipedia.org/wiki/VT100
[123]:https://www.gnu.org/software/emacs/
[124]:https://en.wikipedia.org/wiki/Ed_(text_editor)
[125]:https://begriffs.com/posts/2019-07-19-history-use-vim.html#third-party-plugins

[200]:https://github.com/wbthomason/packer.nvim
[201]:https://github.com/nvim-lualine/lualine.nvim
[202]:https://github.com/akinsho/bufferline.nvim

[204]:https://github.com/navarasu/onedark.nvim
[205]:https://github.com/nvim-tree/nvim-web-devicons
[206]:https://github.com/nvim-lua/popup.nvim
[207]:https://github.com/MunifTanjim/nui.nvim
[208]:https://github.com/nvim-lua/plenary.nvim
[209]:https://github.com/lukas-reineke/indent-blankline.nvim
[210]:https://github.com/nvim-tree/nvim-tree.lua
[211]:https://github.com/akinsho/toggleterm.nvim
[212]:https://github.com/numToStr/Comment.nvim
[213]:https://github.com/jeffkreeftmeijer/vim-numbertoggle
[214]:https://github.com/nvim-telescope/telescope.nvim
[215]:https://github.com/nvim-treesitter/nvim-treesitter
[216]:https://github.com/windwp/nvim-autopairs
[217]:https://github.com/folke/which-key.nvim
[218]:https://github.com/iamcco/markdown-preview.nvim
[219]:https://github.com/NvChad/nvim-colorizer.lua
[220]:https://github.com/uga-rosa/ccc.nvim
[221]:https://github.com/rcarriga/nvim-notify
[222]:https://github.com/stevearc/dressing.nvim
[223]:https://github.com/ziontee113/icon-picker.nvim
[224]:https://github.com/hrsh7th/nvim-cmp
[225]:https://github.com/lewis6991/gitsigns.nvim
[226]:https://github.com/jesseduffield/lazygit
[227]:https://github.com/kdheepak/lazygit.nvim
[228]:https://github.com/mrjones2014/legendary.nvim
[229]:https://github.com/kkharji/sqlite.lua
[230]:https://github.com/VonHeikemen/lsp-zero.nvim
[231]:https://github.com/williamboman/mason-lspconfig.nvim
[232]:https://github.com/neovim/nvim-lspconfig
[233]:https://github.com/williamboman/mason.nvim
[234]:https://github.com/hrsh7th/cmp-nvim-lsp
[235]:https://github.com/L3MON4D3/LuaSnip
[236]:https://github.com/rafamadriz/friendly-snippets
[237]:https://github.com/hrsh7th/cmp-buffer
[238]:https://github.com/hrsh7th/cmp-path
[239]:https://github.com/hrsh7th/cmp-cmdline
[240]:https://github.com/saadparwaiz1/cmp_luasnip
[241]:https://github.com/jose-elias-alvarez/null-ls.nvim
[242]:https://github.com/hrsh7th/cmp-nvim-lua
[243]:https://github.com/jose-elias-alvarez/null-ls.nvim
[244]:https://github.com/folke/lazy.nvim
[245]:https://github.com/lukas-reineke/virt-column.nvim
[246]:https://github.com/nvim-neo-tree/neo-tree.nvim
[247]:https://github.com/rebelot/kanagawa.nvim
[248]:https://github.com/ThePrimeagen/harpoon/tree/harpoon2

