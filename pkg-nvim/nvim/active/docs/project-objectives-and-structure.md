<!--
Maintainer:   jeffskinnerbox@yahoo.com / www.jeffskinnerbox.me
Version:      0.0.1
-->

<div align="center">
<img src="https://raw.githubusercontent.com/jeffskinnerbox/blog/main/content/images/banners-bkgrds/work-in-progress.jpg" title="These materials require additional work and are not ready for general use." align="center" width=420px height=219px>
</div>

-------

My code skills started in the 1970's.
I was a sophomore in college in 1976 when, at MIT, Richard Stallman and Guy Steele
wrote the first version of [Emacs][01].
And over at Berkeley, Bill Joy wrote with Chuck Haley [Vi][02]
(though it was called 'ex' and wouldn’t be called 'vi' for a few years yet).
Frankly, I was unaware of all this until serveral years later (when I had a **real** job),
but these two tools will set the stage for what [NeoVim][03] would become some 40+ years later.

What proceeded all this, at least for me, is the line editor called [`ed`][04].
[Line editors][05] and [teleprinters][06] are a things of the past (maybe),
but the functionality of the 50+ years old `ed` can still be found
in the command line grammar of `vim` and `nvim`
(You can find more `vim` facts & history [here][17] and [here][18]).

So [my coding-life style spans][07] `ed` to `vi` to `vim` to `nvim`,
and in all cases, I built my own configuration file.
Yes, I did significant copy & paste from other users, textbook, and online sources but
I understood & maintained my configuration and I was very pleased with what I created.
When it was time for me to move to NeoVim (aka `nvim`),
I didn't even consider using a pre-configured NeoVim distribution.
In fact, at the time, I didn't know they even existed.
I plunged head first into the NeoVim world.

When I started, I had very limited knowledge of Lua, Vim/NeoVim plugins,
and a lack of detail documentation on how to assemble a configuration file.
In fact, I believed I needed NeoVim features like Treesitter and LSP,
and I didsn't know they were already supported within Vim.
This lack of knowledge did not stop me in the past and I saw no reason why it should this time.
I initiated my journey, much like I have in the past,
by building the configuration file in increments.
Each increment built on it predecessor, each having a more useful functionality,
and each gaining increasing scope & complexity.
**What a slog it was**!

About halfway to my goal, and after some quick successes
(I had a working `nvim` editor and I completely abandoned `vim`),
I bogged down into a state of not really knowing how NeoVim + Lua + Plugins + LSP + ... worked.
I was using Parker for Plugin Management but the way I implemented it was giving me problems.
I was **not** confident enough to installed LSP or Telescope or Treesitter,
and my keymapping where a confusing mess.
Sure, I had some good things working but I could not get ride of some persistent bugs
and it was not clear to me how I should be layering on additional functionality.

When building my first NeoVim configuration, I started by building a simple editor
and I incrementally adding functionality in an effort to reach IDE status.
This approach appeared to be part of my downfall.
To build an IDE-like `nvim`,
you really need to have a solid executable vision of the very things I left for last ... my end goal.
It appear that the more elementary foundation I had already built
wasn't up to the task of supporting this more sophisticated functionality of LSP and Treesitter.
I asked myself, should I setup my own NeoVim configuration or use one of the preconfigured NeoVim distributions?
As I often do, I searched the web for some insight
and I found two opinions that influenced me the most:

1. [Beginners should use a preconfigured Neovim distribution](https://dev.to/ratiu5/beginners-should-use-a-preconfigured-neovim-distribution-253p)
2. [You Should Use A Neovim Distro If You Are New](https://www.youtube.com/watch?v=6qSzFWRz6Ck)

So I started on my 2nd NeoVim engineering effort by first explored some pre-configured NeoVim distributions
([LumarVim][13], [NvChad][14], [AstroNvim][15], [LazyVim][16])
and I rummaged through their documentation in the hopes of find the secret sauce to my problem.
But as it turned out,
all these distributions where engineered to give me a very functional `nvim`
but not teach me to understand it so I could further extend and maintain it myself,
which is the very thing I wanted / needed.
This only caused me more pain, suffering, and moments of despair.

Then one glorious day, I stumble upon the Youtube series ["Understanding Neovim"][08].
This gave me some bits of insights that I needed.
The video series is excellent and the author has real insight into what was challenging me.
Following these video closely, and coding as I watched,
I created a very basic `nvim` that did some of the things I wanted.
I was using Lazy as my plugin manager and I call this NeoVim adventure
'trainer' since it was really just that,
a coding exercise to train me in the finer points of the NeoVim arts.

Another very helpful gem is the post ["Switching Configs in Neovim"][09].
To incrementally build the NeoVim editor, your going to want to concurrently use `nvim`
(what better way to test a text editor than to use it every day)
and concurrently build a significantly enhanced version of itself.
Two instances of NeoVim, each with its own radically different configuration,
running on the same box.
This is a challenge and this post show you how to do it.

The coding I did for 'trainer' was an major step forward for me
but the biggest epiphany occurred while investigating [Helix][10]
and reading the post ["My approach to Neovim"][11].
This post also references [`kickstart.nvim`][12],
which I jumped on immediately,
and it quickly became clear to me it was my next step forward.


# Kickstart NeoVim

While `kickstart.nvim` was just want I needed,
I strongly feel all the reading, exploration,
and wondering around in the dark did more goods than harm.
I learned a great deal and knew enough to ask the smart questions.
So I don't think `kickstart.nvim` is a starting point for a `vim`/`nvim` novice,
but it was an excellent fit for me.

So below is a starting point for Kickstart Neovim.
It is meant to be used by YOU to continue your Neovim journey;
remove the things you don't use and add what you miss.
That is what I did and I created the 'kickstart2' development tread within a week
and got my `nvim` into a stable state with more functionality,
and personal understanding of the code, they ever before.

Kickstart Sources:

* [Why Would You Use NeoVim?: Personal Development Environment (PDE)](https://www.youtube.com/watch?v=QMVIJhC9Veg)
* [The Only Video You Need to Get Started with Neovim](https://www.youtube.com/watch?v=m8C0Cq9Uv9o)
* [Effective Neovim: Instant IDE](https://www.youtube.com/watch?v=stqUbv-5u2s)
* [GitHub: nvim-lua/kickstart.nvim](https://github.com/nvim-lua/kickstart.nvim)
* [Effective Neovim: Instant IDE](https://www.youtube.com/watch?v=stqUbv-5u2s&t=7s)
* [PDE: A different take on editing code](https://www.youtube.com/watch?v=QMVIJhC9Veg)

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

```text
.config/nvim
  init.lua
  lazy-lock.json
  /lua
    lazy.lua
    /core
      init.lua
      keymaps.lua
      options.lua
    /plugins
      /lsp
      alpha-nvim.lua
      .
      .
      .



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

[01]:https://en.wikipedia.org/wiki/GNU_Emacs
[02]:https://en.wikipedia.org/wiki/Vi_(text_editor)
[03]:https://en.wikipedia.org/wiki/Vim_(text_editor)#Neovim
[04]:https://en.wikipedia.org/wiki/Ed_(software)
[05]:https://en.wikipedia.org/wiki/Line_editor
[06]:https://en.wikipedia.org/wiki/Teleprinter
[07]:https://carlosbecker.com/posts/ed/
[08]:https://www.youtube.com/playlist?list=PLx2ksyallYzW4WNYHD9xOFrPRYGlntAft.
[09]:https://michaeluloth.com/neovim-switch-configs/
[10]:ttps://dev.to/thedenisnikulin/my-approach-to-neovim-3625
[11]:https://dev.to/thedenisnikulin/my-approach-to-neovim-3625
[12]:https://github.com/nvim-lua/kickstart.nvim
[13]:https://github.com/LunarVim/LunarVim
[14]:https://github.com/NvChad/NvChad
[15]:https://github.com/AstroNvim/AstroNvim
[16]:https://www.lazyvim.org/
[17]:https://www.youtube.com/watch?v=c6vjFQBlxvY
[18]:https://pikuma.com/blog/origins-of-vim-text-editor
[19]:
[20]:

<!-- vim: ts=4 sts=4 sw=4 et                                                    -- this is called a 'modeline' - [Modeline magic](https://vim.fandom.com/wiki/Modeline_magic), [Tab settings in Vim](https://arisweedler.medium.com/tab-settings-in-vim-1ea0863c5990) -->
