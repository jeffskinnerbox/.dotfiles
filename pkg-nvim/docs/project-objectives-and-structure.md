<!--
Maintainer:   jeffskinnerbox@yahoo.com / www.jeffskinnerbox.me
Version:      0.0.1
-->


<div align="center">
<img src="https://raw.githubusercontent.com/jeffskinnerbox/blog/main/content/images/banners-bkgrds/work-in-progress.jpg" title="These materials require additional work and are not ready for general use." align="center" width=420px height=219px>
</div>



-------

Restart Here:
* [How to setup Neovim from Scratch - Complete Guide (Including TMUX, Lazy and LSP](https://www.youtube.com/watch?v=ZjMzBd1Dqz8)

* [The perfect Neovim setup for C++](https://www.youtube.com/watch?v=lsFoZIg-oDs)

* [Configuring NeoVim as a Python IDE](https://www.playfulpython.com/configuring-neovim-as-a-python-ide/)
* [My ultimate Neovim configuration for Python development](https://ramezanpour.net/post/2021/04/24/My-ultimate-Neovim-configuration-for-Python-development)
* [How to run Python on Neovim like Jupyter](https://dev.to/rnrbarbosa/how-to-run-python-on-neovim-like-jupyter-3ln0)
* [A Complete Guide to Neovim Configuration for Python Development](https://jdhao.github.io/2018/12/24/centos_nvim_install_use_guide_en/)

* [Codeium in Vim / Neovim](https://codeium.com/vim_tutorial)

* [Josean Martinez: Coding, Tech, Life](https://www.youtube.com/@joseanmartinez)
    * [My Dev Environment & Workflow](https://www.youtube.com/playlist?list=PLnu5gT9QrFg36OehOdECFvxFFeMHhb_07)
    * [How I Setup LSP In Neovim For An Amazing Dev Experience - Full Guide](https://www.youtube.com/watch?v=NL8D8EkphUw)
    * [How To Setup Linting/Formatting In Neovim & Replace null-ls](https://www.youtube.com/watch?v=ybUE4D80XSk)
* [History and effective use of Vim](https://begriffs.com/posts/2019-07-19-history-use-vim.html#third-party-plugins)

Include the text from "/home/jeff/blogging/content/ideas/my-integrated-development-environment.md"


* Collections of awesome neovim plugins: [Awesome Neovim](https://github.com/rockerBOO/awesome-neovim)




* [Our favorite fonts for the Linux terminal](https://opensource.com/article/23/4/linux-terminal-fonts)




* [Build A Portable Development Environment With Nix Package Manager](https://www.youtube.com/watch?v=70YMTHAZyy4)



---------



# Pre-configured Distro or Manual?
Months ago I asked my self,
should I setup my own NeoVim configuration or use one of the preconfigured NeoVim distributions?
Here are two opinions, and I choose to follow #2:

1. [Beginners should use a preconfigured Neovim distribution](https://dev.to/ratiu5/beginners-should-use-a-preconfigured-neovim-distribution-253p)
2. [You Should Use A Neovim Distro If You Are New](https://www.youtube.com/watch?v=6qSzFWRz6Ck)

[My coding-life style spans][AA] `ed` to `vi` to `vim`, and in all cases,
I built my own configuration file.
Yes, I did significant copy & paste from online sources but
it was my own creation and I was very pleased with what I created.
When it was time for me to move to `nvim`,
I didn't even consider using a pre-configured NeoVim distribution.
In fact, at the time, I didn't know they even existed.
I plunged head first into the NeoVim world.

When I started, I had very limited knowledge of Lua, Vim/NeoVim plugins,
and a lack of detail documentation on how to assemble a configuration file.
This lack of knowledge did stop me in the past and I saw no reason why it should this time.
I initiated my journey, much like I have in the past, by building the configuration file in increments.
Each increment built on it predecessor, each having a more useful functionality, and each gaining increasing scope & complexity.
**What a slog it was**!

About halfway to my goal, and after some quick successes (I had a working `nvim` editor and I abandoned `vim`),
I bogged down into a state of not really knowing how NeoVim + Lua + Plugins worked.
Sure, I had some good things working but I could not get ride of some persistent bug
and it was not clear to me how I should be layering on additional functionality.

I resorted to firing up some pre-configured NeoVim distributions (NvChad and LazyVim)
and following their documentation in the hopes of find the secret sauce to my problem.
This only caused me more pain, suffering, and moments of despair.

Then one glorious day, I stumble upon the Youtube series
["Understanding Neovim"](https://www.youtube.com/playlist?list=PLx2ksyallYzW4WNYHD9xOFrPRYGlntAft).
This gave me the bits of insights that I needed.
The video series is excellent and the author has real insight into what was challenging me.
This video series should be helpful to NeoVim beginner
and experienced user alike (I'm personally exhibit A).

Another very helpful gem is the post ["Switching Configs in Neovim"](https://michaeluloth.com/neovim-switch-configs/).
To incrementally build the NeoVim editor, your going to want to concurrently use `nvim`
(what better way to test a text editor than to use it every day)
and concurrently build a significantly enhanced version of itself.
Two instances of NeoVim, each with its own radically different configuration,
running on the same box.
This is a challenge and this post show you how to do it.



# Helix and Others
I became aware of [Helix](https://dev.to/thedenisnikulin/my-approach-to-neovim-3625)
while read the post ["My approach to Neovim"](https://dev.to/thedenisnikulin/my-approach-to-neovim-3625).
This post also references [kickstart.nvim](https://github.com/nvim-lua/kickstart.nvim),
which I embraced earlier, but the posting help confirm to me it was good approach for me.



# Kick-Start NeoVim
This is a starting point for Neovim.
It is meant to be used as by YOU to begin your Neovim journey;
remove the things you don't use and add what you miss.

* [Effective Neovim: Instant IDE](https://www.youtube.com/watch?v=stqUbv-5u2s)
    * [nvim-lua/kickstart.nvim](https://github.com/nvim-lua/kickstart.nvim)
* [Why Would You Use NeoVim?: Personal Development Environment (PDE)](https://www.youtube.com/watch?v=QMVIJhC9Veg)




The majority of my inspiration came from the following sources:

* General Guidance - How to structure you files, etc.
    * [Better Neovim plugin setup! Use Packer, break your init.lua into modules, look like a hero!](https://www.youtube.com/watch?v=NkfMBI1tVwY)
    * [How to Set up Neovim for Windows and Linux with Lua and Packer](https://dev.to/slydragonn/how-to-set-up-neovim-for-windows-and-linux-with-lua-and-packer-2391)
    * [Getting Started with Neovim](https://bryankegley.me/posts/nvim-getting-started/)
* Themes & Color Schemes
    * [The BEST Neovim color themes; some with support for Terminals and the latest Lua plugins](https://www.youtube.com/watch?v=_evGrg4l3CY)
* As an IDE Using LSP
    * Using LSP Installer [`mason.nvim`](https://github.com/williamboman/mason.nvim)
        * [Modern Neovim for the faint of heart](https://rdrn.me/neovim/)
        * [Neovim for Beginners — Package Manager Plugin](https://alpha2phi.medium.com/neovim-for-beginners-packer-manager-plugin-e4d84d4c3451)
        * [Learn How To Use NeoVim As an IDE](https://programmingpercy.tech/blog/learn-how-to-use-neovim-as-ide/)
        * [Configure Mason Nvim - Portable Package Manager For Neovim](https://www.youtube.com/watch?v=2iczAXDdgTE&list=PLIHtvvGZ1O3jBXdp9Id02vRuOEOWIGB_w&index=9)
        * [Configuring Language Server Protocol in Neovim](https://blog.codeminer42.com/configuring-language-server-protocol-in-neovim/)
        * [Getting Started with Neovim’s LSP](https://raygervais.dev/articles/2021/3/neovim-lsp/)
        * [Neovim - Null-ls: a quick explanation](https://www.youtube.com/watch?v=e3xxkEbhG0o)
    * Using LSP Installer [`nvim-lsp-installer`](https://github.com/williamboman/nvim-lsp-installer) (deprecated, Mason recoomend in its place)
        * [Neovim - LSP Setup Tutorial (Built in LSP 100% Lua)](https://www.youtube.com/watch?v=6F3ONwrCxMg)
        * [Setup nvim-lspconfig + nvim-cmp](https://vonheikemen.github.io/devlog/tools/setup-nvim-lspconfig-plus-nvim-cmp/)
        * [Neovim for Beginners — LSP (Part 1)](https://alpha2phi.medium.com/neovim-for-beginners-lsp-part-1-b3a17ddbe611)
        * [Neovim for Beginners — LSP (Part 2)](https://alpha2phi.medium.com/neovim-for-beginners-lsp-part-2-37f9f72779b6)
* NeoVim Tutorials - Comprehensive Source of Tutorials & Ideas
    * SmartTech101
        * [SmartTech101: NeoVim](https://smarttech101.com/category/neovim/)
        * [How to Use Vim/Neovim](https://smarttech101.com/how-to-use-vim-neovim/)
        * [How to Configure Colorscheme in Vim/Neovim](https://smarttech101.com/how-to-configure-colorscheme-in-vim-neovim/)
        * [How to Configure Neovim](https://smarttech101.com/how-to-configure-neovim/)
        * [Nvim lsp: set up null-ls for beginners](https://smarttech101.com/nvim-lsp-set-up-null-ls-for-beginners/)
        * [Nvim lsp autocompletion: mapping, snippets, fuzzy search](https://smarttech101.com/nvim-lsp-autocompletion-mapping-snippets-fuzzy-search/)
        * [Nvim lsp: configure language servers, shortcuts, highlights](https://smarttech101.com/nvim-lsp-configure-language-servers-shortcuts-highlights/)
        * [Nvim lsp diagnostics – keybindings, signs, virtual texts](https://smarttech101.com/nvim-lsp-diagnostics-keybindings-signs-virtual-texts/)
    * Truff Gniuz
        * [Configuring Neovim](https://www.youtube.com/playlist?list=PLIHtvvGZ1O3jBXdp9Id02vRuOEOWIGB_w)
    * Alpha2Phi
        * [Learn Neovim The Practical Way](https://alpha2phi.medium.com/learn-neovim-the-practical-way-8818fcf4830f)
        * [Learn Neovim The Practical Way: All articles on how to configure and program Neovim](https://alpha2phi.medium.com/learn-neovim-the-practical-way-8818fcf4830f)
        * [Neovim Tips for a Better Coding Experience](https://alpha2phi.medium.com/neovim-tips-for-a-better-coding-experience-3d0f782f034e)
    * Christian Chiarulli (aka Chris@Machine)
        * [Christian Chiarulli](https://www.chrisatmachine.com/) Creator and lead maintainer of 🌙 LunarVim
        * [Configuring Neovim](https://www.youtube.com/watch?v=qb6fPgZMRF4&list=PLIHtvvGZ1O3jBXdp9Id02vRuOEOWIGB_w)
        * [Neovim Configuration](https://www.youtube.com/playlist?list=PLsz00TDipIffxsNXSkskknolKShdbcALR)
        * [Neovim from Scratch](https://www.youtube.com/playlist?list=PLhoH5vyxr6Qq41NFL4GvhFp-WLd5xzIzZ)
* Example NeoVim Configurations
    * [dotfyle: Discover and share Neovim configs](https://dotfyle.com/)
    * [Neovim for Beginners](https://alpha2phi.medium.com/learn-neovim-the-practical-way-8818fcf4830f#545a)
        * [GitHub: alpha2phi/neovim-for-beginner](https://github.com/alpha2phi/neovim-for-beginner/tree/50-package-manager)
    * [Neovim from Scratch](https://www.youtube.com/playlist?list=PLhoH5vyxr6Qq41NFL4GvhFp-WLd5xzIzZ)
        * [Neovim from scratch](https://github.com/LunarVim/Neovim-from-scratch)
    * [LunarVim](https://github.com/LunarVim/LunarVim)
        * [LunarVim](https://www.youtube.com/playlist?list=PLhoH5vyxr6QqGu0i7tt_XoVK9v-KvZ3m6)
        * [A Basic Stable IDE config for Neovim](https://github.com/LunarVim/nvim-basic-ide)
    * [kickstart.nvim](https://github.com/nvim-lua/kickstart.nvim)
        * [Effective Neovim: Instant IDE](https://www.youtube.com/watch?v=stqUbv-5u2s)
    * [NvChad](https://github.com/NvChad/NvChad)
    * [AstroNvim](https://github.com/AstroNvim/AstroNvim)

Sources:

* Vim vs. NeoVim
    * [Compare NeoVim vs Vim: Which Editor is Best for You?](https://www.sysprobs.com/compare-neovim-vs-vim-best-editor)
    * [7 Reasons Why Developers Prefer NeoVim Over Vim](https://linuxhandbook.com/neovim-vs-vim/)
    * [Why Neovim is so much better than Vim now... (Neovim vs Vim)](https://www.youtube.com/watch?v=qQvFC0wRiRE)
* NeoVim
    * [Meet Neovim](http://vimcasts.org/episodes/meet-neovim/)
    * [Neovim](https://neovim.io/)
    * [How to Install Neovim on Ubuntu 22.04](https://linuxopsys.com/topics/install-neovim-ubuntu-and-plugins)
    * [How I Setup Neovim On My Mac To Make It Amazing - Complete Guide](https://www.youtube.com/watch?v=vdn_pKJUda8)
    * [Everything you need to know to configure neovim using lua](https://vonheikemen.github.io/devlog/tools/configuring-neovim-using-lua/)
    * [Configuring Neovim With Lua (It's Easy!)](https://www.youtube.com/watch?v=m62UCkdQ8Ck)
    * [Build your first Neovim configuration in lua](https://vonheikemen.github.io/devlog/tools/build-your-first-lua-config-for-neovim/)
* Vim-plug
    * [How to Install Plugins in Neovim](https://linuxopsys.com/topics/install-plugins-in-neovim)
    * [Vim-plug: A Minimalist Vim Plugin Manager](https://www.ostechnix.com/vim-plug-a-minimalist-vim-plugin-manager/)
    * [VIM Plug – The easy way to install plugins in VIM](https://www.linuxfordevices.com/tutorials/linux/vim-plug-install-plugins)
* NeoVim and Lua Referance Docs
    * [Nvim Documentation](https://neovim.io/doc/)
    * [Nvim Documentation: Lua](https://neovim.io/doc/user/lua.html)
    * [Nvim Documentation: Options](https://neovim.io/doc/user/options.html)
    * [Lua](https://www.lua.org/docs.html)
* NeoVim Plugins
    * [Awesome Neovim](https://github.com/rockerBOO/awesome-neovim)
    * [neovimcraft](https://neovimcraft.com/)




------




# Project Structure
If you want to load Lua files on demand, you can place them in the `lua`
directory in your [`runtimepath`](https://neovim.io/doc/user/options.html#'runtimepath')
default is `~/.config/nvim/lua`)
and load them with a `require` statement.

* [Neovim IDE Crash Course](https://www.chrisatmachine.com/posts/01-ide-crash-course)
* [How I Setup Neovim Plugins With Lua](https://www.youtube.com/watch?v=jREkuPTResw)
* [Building A Powerful Neovim Configuration](https://harrisoncramer.me/building-a-powerful-neovim-configuration/)
* [Lua User Guide: Lua modules](https://neovim.io/doc/user/lua-guide.html#lua-guide)
* [Modern Neovim — Configuration Hacks](https://alpha2phi.medium.com/modern-neovim-configuration-hacks-93b13283969f)

This is where your nvim configuration lives:
namespace

```
Using command: tree -a --filesfirst ~/.dotfiles/pkg-nvim

~/.dotfiles/pkg-nvim/
├── init.lua                              <-- entry point for `nvim` to access your configuration files
├── lua                                   <-- the directory where all of your lua code and plugin config goes (i.e. in your runtime path)
│   ├── active                            <-- my namespace directory to avoid collisions with other plugins and lua modules, (i.e. currently 'active' nvim configuration)
│   │   ├── auto.lua
│   │   ├── key-mapping.lua
│   │   ├── options.lua
│   │   ├── plugins.lua
│   │   └── configs
│   │       ├── comment.lua
│   │       ├── indent-blankline.lua
│   │       ├── lightline.lua
│   │       ├── nightfox.lua
│   │       ├── nvim-tree.lua
│   │       └── toggleterm.lua
│   │       └── lsp                       <-- lsp is complicated enough to warrant it’s own separate directory
│   │           └── settings              <-- specific settings for your Language Server
│   │               ├── pyright.lua
│   │               └── sumneko_lua.lua
│   ├── <other namespaces>                <-- other instances of nvim using other plugins
├── plugin                                <-- plugin folder & its files are the output of Packer plugin manager
│   └── packer_compiled.lua
├── swap
└── undo
```

The configuration structure is relatively simple:

* `init.lua`: the entry point for `nvim` to access your configuration files
* `lua/`: the directory where all the `nvim` lua code and plugin config goes
* `lua/active`: a namespace to avoid collisions with other plugins and lua modules
* `lua/active/core`:
* `lua/active/configs`:
* `lua/active/lsp`: lsp is complicated enough to warrant it’s own separate directory
* `lua/active/lsp/settings`: specific settings for your Language Server, to find more settings for your language server read more [here](https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md)

You will find plugins here under `~/.local/share/nvim/site/pack/packer`.
You will also find other useful plugin data

cache: `~/.cache` You can find logs here

state: `~/.local/state` You can find state about Neovim as well as other plugins here

Use the following to execute Neovim: `alias vi="gnome-terminal --title NeoVim -- nvim -p"`
Use the following to cleanout Neovim:
`trash ~/.cache/nvim ~/.local/state/nvim ~/.local/share/nvim ~/.config/nvim/undo \
      ~/.config/nvim/site ~/.config/nvim/swap ~/.config/nvim/plugin ~/.config/nvim/share`

* `~/.config/nvim`: This is where your config lives
* `~/.local/share`: You will find plugins here under: `~/.local/share/nvim/site/pack/packer`.
You will also find other useful plugin data.
* `~/.cache`: You can find logs here
* `~/.local/state`: You can find state about Neovim as well as other plugins here.

* **LSP** stands for Language Server Protocol, and it provides:
    * Completions
    * Diagnostics
    * (GOTO Definition, Find References etc..)
    * Code actions
    * Autoimport
    * Sometimes formatters
* **Formatters** help keep a consistent style across your codebase (ex. prettier, black, stylua)
* **Linters** add extra diagnostics in addition to your language server,
often they will provide stylistic suggestions (ex. eslint, flake8, shellcheck):
* **Treesitter** at basic level provides syntax highlighting and indentation,
but also provides much more when combined with other features



[AA]:https://carlosbecker.com/posts/ed/

<!-- vim: ts=4 sts=4 sw=4 et                                                    -- this is called a 'modeline' - [Modeline magic](https://vim.fandom.com/wiki/Modeline_magic), [Tab settings in Vim](https://arisweedler.medium.com/tab-settings-in-vim-1ea0863c5990) -->
