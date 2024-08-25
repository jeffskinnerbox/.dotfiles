<!-- markdownlint-disable MD001 MD012 MD033 MD041 MD045 -->
<!-- markdownlint-configure-file { "line-length": { "line_length": 300 } } -->
<!-- markdownlint-configure-file { "hr-style": { "style": "---------------", } } -->
<!-- markdownlint-configure-file { "blanks-around-headings": { "lines_above": 2, "lines_below": 0, } } -->
<!-- see [Markdownlint Documentation](https://docs.superoffice.com/contribute/markdown-guide/markdownlint.html) -->

<!--
Maintainer:   jeffskinnerbox@yahoo.com / www.jeffskinnerbox.me
Version:      0.0.1
-->

<div align="center">
<img src="https://raw.githubusercontent.com/jeffskinnerbox/blog/main/content/images/banners-bkgrds/work-in-progress.jpg" title="These materials require additional work and are not ready for general use." align="center" width=420px height=219px>
</div>

---------------


# My Approach

Fundamental to my building approach for my 2nd generation NeoVim configuration
where the following points:

1. **Start With The End In Mind** - Build from the beginning the infrastructure to support
   [Treesitter][05] (support for Syntax Highlighting, Fuzzy Finding, and make it generally Language Aware), and
   [Language Server Protocol (LSP)][06] (support for Auto-completion, Go to Definition,
   Documentation on Hover, Linters, Formatters, Debuggers, and make it generally Language Intelligent).
2. **Up-Graded Plugin Manager** - Use the [Lazy.nvim Plugin Manager][01], the most modern, capable,
   and well support plugin manager in the NeoVim ecosystem.
3. **Highly Configurable IDE Look & Feel** - NeoVim can support window splits to create an
   [Integrated Development Environment (IDE)][02] screen layouts
   but what is really needed is a true terminal multiplexer like [Tmux][03]
   and a highly configurable terminal like [Alacritty][04].
4. **Concurrent Operation of Multiple Versions** - As I attempted (but failed) in my 1st generation NeoVim,
   I want to support the concurrent operation of multiple version of NeoVim configurations.
   This will allow me, if I choose, to have things like a version of NeoVim for text editing,
   a version for a [Second Brain][07], and another version for code debugging.
5. **Embrace Modal Text Editing** - Vim/NeoVim is a [modal text editor][08]
   but I didn't closely follow that paradigm in my 1st generation NeoVim.
   In this 2nd attempt, I want to fully embrace it.
6. **Easy Maintenance** - In 1st generation NeoVim, even minor maintenance actions on the code
   could cause side effects that break the code.

Some of the inspiration for my approach was provided by the following sources:

- [Rewriting my Neovim config in Lua](https://www.jonashietala.se/blog/2023/10/01/rewriting_my_neovim_config_in_lua/)
- [My approach to Neovim](https://dev.to/thedenisnikulin/my-approach-to-neovim-3625) - DONE
- [A brief and incomplete history of modal text editors][08] - DONE
- [NEOVIM: MIGRATING TO LAZY.NVIM AND GO.NVIM](https://mariocarrion.com/2024/05/20/neovim-migrating-to-lazy-and-go-nvim.html) - DONE


## Start With The End In Mind

What is a Parser? -- A parser converts unstructured data from one format to another. It is generally done to make the existing, unreadable data more comprehensible.
What is Grammar? -- Grammar is defined as a system of language rules that allows you to combine individual words to make complex meanings. Grammar rules concern the use of clauses, phrases, and words.
What is Syntax? -- Syntax is the study of how linguistic elements (such as words) are put together to form constituents (such as phrases or clauses) to create a connected, orderly system.
What is Semantics? -- Semantics is the branch of linguistics and logic concerned with meaning of a word, phrase, sentence, or text. It examines what meaning is, how words get their meaning, and how the meaning of a complex expression depends on its parts.
What's the Difference Between Syntax and Grammar? -- Syntax is a subdivision of grammar. Grammar comprises the entire system of rules for a language, including syntax. Syntax deals with the way that words are put together to form phrases, clauses, and sentences.
What's the Difference Between Syntax and Semantics? -- Syntax is the structure of language. Elements of syntax include word order and sentence structure, which can help reveal the function of an unknown word. Semantics is the meaning of individual words. If one word is unknown, the meanings of surrounding words can give clues to the word's probable meaning.
What is a Syntax Error? -- Syntax errors are mistakes in using the language. Examples of syntax errors are missing a comma or a quotation mark, or misspelling a word.
What is a Syntax Tree? -- A syntax tree is a visual representation of a source code's syntactic structure, or grammatical hierarchy. It's often used in compiler design to make the code structure easier to analyze and manipulate. A syntax tree is created by the compiler based on the parse tree after the parser has finished processing the source code.


### Treesitter

It looks at one file at a time and provides information about the text.
Treesitter and LSP are unrelated.

1. LSP is looking at your code at the semantic level. It looks at you whole project, all the files, to extract meaning. It then provides definitiaions, completions that are accurate.
2. Treesitter is a praser generator tool to understand a single files grammar. It know nothing about the language at a semantic level, it only know about the text.
   Treesiter isn't an interpreter, its just a library for interacting with text.

What is Treesitter then ...

1. It is a parser generator tool. This parser is then loaded into what ever application that could benefit from it
2. The parser automatically get an increment error recovering for the grammar. You don't have to provide this adaptive recovery process.
3. Query engine for the syntax tree allowing you to ask questions about that syntax tree. Treesitter just cares about text and helps use ask questions about that text.

So what is this all good for? It allows you to actively edit your file and Treesitter will provide near real-time feedback about errors in what your writing (grammar erros, highlighting, indenting, folding)
and do things structural editing (edit parentheses in one operation).

- [tree-sitter-explained](https://teej.tv/presentations/tree-sitter-explained)
- [Understanding Neovim #4 - Treesitter](https://www.youtube.com/watch?v=kYXcxJxJVxQ)


### LSP Client & Servers

LSP goes beyond what Treesitter provides and try's to understand your code at the semantic level.
It looks at your whole project, all the files.

- [Demystifying the Language Server Protocol](https://medium.com/@weidagang/demystifying-the-language-server-protocol-70689719850f)
- [LSP Explained (in 5 Minutes)](https://www.youtube.com/watch?v=LaS32vctfOY)
- [LSP Basics in Neovim](https://www.youtube.com/watch?v=3a1PCir_aHs)
- [Configure Linting, Formatting, and Autocompletion in Neovim](https://www.youtube.com/watch?v=y1WWOaLCNyI)
- [Basic Neovim LSP Setup (with Treesitter and Completion)](https://www.youtube.com/watch?v=Ku-m7eEbWas)

- [How I Setup LSP In Neovim For An Amazing Dev Experience - Full Guide](https://www.youtube.com/watch?v=NL8D8EkphUw)
- [The perfect Neovim setup for C++](https://www.youtube.com/watch?v=lsFoZIg-oDs)

The majority of my inspiration came from the following sources:

- As an IDE Using LSP
  - Using LSP Installer [`mason.nvim`](https://github.com/williamboman/mason.nvim)
  - [Neovim for Beginners — Package Manager Plugin](https://alpha2phi.medium.com/neovim-for-beginners-packer-manager-plugin-e4d84d4c3451)
  - [Learn How To Use NeoVim As an IDE](https://programmingpercy.tech/blog/learn-how-to-use-neovim-as-ide/)
  - [Configure Mason Nvim - Portable Package Manager For Neovim](https://www.youtube.com/watch?v=2iczAXDdgTE&list=PLIHtvvGZ1O3jBXdp9Id02vRuOEOWIGB_w&index=9)
  - [Configuring Language Server Protocol in Neovim](https://blog.codeminer42.com/configuring-language-server-protocol-in-neovim/)
  - [Getting Started with Neovim’s LSP](https://raygervais.dev/articles/2021/3/neovim-lsp/)
  - [Neovim - Null-ls: a quick explanation](https://www.youtube.com/watch?v=e3xxkEbhG0o)
  - Using LSP Installer [`nvim-lsp-installer`](https://github.com/williamboman/nvim-lsp-installer) (deprecated, Mason recoomend in its place)
  - [Neovim - LSP Setup Tutorial (Built in LSP 100% Lua)](https://www.youtube.com/watch?v=6F3ONwrCxMg)
  - [Setup nvim-lspconfig + nvim-cmp](https://vonheikemen.github.io/devlog/tools/setup-nvim-lspconfig-plus-nvim-cmp/)
  - [Neovim for Beginners — LSP (Part 1)](https://alpha2phi.medium.com/neovim-for-beginners-lsp-part-1-b3a17ddbe611)
  - [Neovim for Beginners — LSP (Part 2)](https://alpha2phi.medium.com/neovim-for-beginners-lsp-part-2-37f9f72779b6)


## Up-Graded Plugin Manager


## Highly Configurable IDE Look & Feel


## Concurrent Operation of Multiple Versions


## Embrace Modal Text Editing


### Ed / Vi / Vim / NeoVim

Jumping into NeoVim without any knowledge of it predecessor, Vim, is difficult to impossible.
It is wise to spend the time getting familiar with the Vim editor first.

Is there a Vim language? - Vim has a language or grammar behind its shortcuts. Instead, remember a thousand shortcuts; you can learn a couple and combine them. These are sometimes called the Vim language or Vim motions for moving around. This has nothing to do with the editor yet; they are universal and available in other editors as well.
What is a Vim motion? - Vim motions are how you navigate, whether you navigate to the end of the word or back to the start of the document; these are all motions. These are the first thing you start learning (and hating) when you start learning. It's extra hard to know initially, but something you want everywhere when you get used to it.

Sources:

- [vim](https://www.ssp.sh/brain/vim/)
- [The Vim Language (and Motions)](https://www.ssp.sh/brain/vim-language-and-motions/)
- [Why Vim Is More than Just an Editor – Vim Language, Motions, and Modes Explained](https://www.ssp.sh/blog/why-using-neovim-data-engineer-and-writer-2023/)
- [Vim Essentials Cheatsheet & Guide](https://www.josean.com/posts/vim-essentials-cheatsheet)

- Vim Commands
  - [A Beginner Guide with Examples](https://thevaluable.dev/vim-commands-beginner/)
  - [A Vim Guide for Intermediate Users](https://thevaluable.dev/vim-intermediate/)
  - [A Vim Guide for Advanced Users](https://thevaluable.dev/vim-advanced/)
  - [A Vim Guide for Adept Users](https://thevaluable.dev/vim-adept/)
  - [A Vim Guide For Veteran Users](https://thevaluable.dev/vim-veteran/)
  - [A Vim Guide For Experts](https://thevaluable.dev/vim-expert/)


## Easy Maintenance


### Directory Structure

/core - The things that move you from vanilla NeoVim to your personalized text editing environment, no use of LSP
/lsp - There are a host of features that you can enable once you setup your LSP in Neovim. Configuring a linter, formatter, and autocompletion are what I’d call the main features most users are looking for but you can configure almost anything you can imagine thanks to the extensibility of Neovim.
/advanced - Things that leverage LSP
/ide - DP, sessions, workspaces, special UIs

---------------


# Study Plan


## 1st ... Get With The Religion

- [History and effective use of Vim](https://begriffs.com/posts/2019-07-19-history-use-vim.html#third-party-plugins)
- [The Zen of Vim](https://medium.com/@gilbenherut/the-zen-of-vim-a44082fb8115)
- [Vim’s Big Idea](https://medium.com/@mkozlows/why-atom-cant-replace-vim-433852f4b4d1)
- [Your problem with vim is that you don’t grok vi](https://gist.github.com/nifl/1178878)
- [Coming Home to Vim](https://stevelosh.com/blog/2010/09/coming-home-to-vim/)
- [Vim Novice Videos](http://derekwyatt.org/vim/tutorials/novice/)
- [Vimcasts Episodes](http://vimcasts.org/episodes/archive/)
- [The Best Editor](https://www.youtube.com/watch?v=WgXO2cvmdQc)
- [Vim Essentials Cheatsheet & Guide](https://www.josean.com/posts/vim-essentials-cheatsheet)
- [Vim Tutorials](https://www.youtube.com/playlist?list=PLRjzjpJ02WDMJOTsrdByXynk8h0ScMK9R)


## 2nd ... Read The Map Before You Travel

- [Understanding Neovim](https://www.youtube.com/playlist?list=PLx2ksyallYzW4WNYHD9xOFrPRYGlntAft)
- [Neovim](https://www.youtube.com/playlist?list=PLXJ0on0Dau77NO_jXpRuhIScIFDMzGnNX)
- [Neovim](https://www.youtube.com/playlist?list=PLOIdWGSU_Wcp9_w8euHJaux8DEIBCvYGc)
- [Neovim Weekly Plugin Series](https://www.youtube.com/playlist?list=PLrgztVx4lZIova0vq7Nb_ZcmgU_MZ3NlJ)
- [Vim and Tmux](https://www.youtube.com/playlist?list=PL-v3vdeWVEsXo87wHeVSP_x1KTX4G1l8Y)
- [Neovim LSP Basics](https://levelup.gitconnected.com/neovim-lsp-basics-b0ade96fe96d)
- [Overhauling my Neovim LSP and lazy.nvim configurations](https://kevinfeng-cs88.medium.com/overhauling-my-neovim-lsp-and-lazy-nvim-configurations-605eaa908b62)
- [I Can’t Seem to Quit Vim](https://medium.com/nerd-for-tech/i-cant-seem-to-quit-vim-a9dd29e58269)


## 3rd ... Listen to Your Travel Guide

Using Kickstart

1. [The Only Video You Need to Get Started with Neovim](https://www.youtube.com/watch?v=m8C0Cq9Uv9o&t=103s) - DONE
2. [How I Setup Neovim To Make It AMAZING in 2024: The Ultimate Guide](https://www.youtube.com/watch?v=6pAG3BHurdM&t=1906s) - DONE
3. [Neovim Lazy Lua IDE - my simple but powerful setup for 2024](https://www.youtube.com/watch?v=VljhZ0e9zGE&t=519s)

Other Travelers

1. [Building A Powerful Neovim Configuration](https://harrisoncramer.me/building-a-powerful-neovim-configuration/) - [dotfiles](https://github.com/harrisoncramer/nvim/tree/main)
2. [My Forever Dev Workflow](https://www.youtube.com/watch?v=_YaI2vDbk0o)

- Other Gems

  - [My Neovim Config! (as of January 2024)](https://www.youtube.com/watch?v=oo_I5lAmdi0&t=87s)
  - [How to setup Neovim from Scratch - Complete Guide (Including TMUX, Lazy and LSP)](https://www.youtube.com/watch?v=ZjMzBd1Dqz8)
  - [How To Use lazy.nvim For A Simple And Amazing Neovim Config](https://www.youtube.com/watch?v=6mxWayq-s9I)
  - [My Dev Environment & Workflow](https://www.youtube.com/playlist?list=PLnu5gT9QrFg36OehOdECFvxFFeMHhb_07)
  - [How I Setup LSP In Neovim For An Amazing Dev Experience - Full Guide](https://www.youtube.com/watch?v=NL8D8EkphUw)
  - [How To Setup Linting/Formatting In Neovim & Replace null-ls](https://www.youtube.com/watch?v=ybUE4D80XSk)
  - [Learn How To Use NeoVim As An IDE - With Better Sound & Speed](https://www.youtube.com/watch?v=Ymr6bU5Uf8I)
  - [Basic Neovim LSP Setup (with Treesitter and Completion)](https://www.youtube.com/watch?v=Ku-m7eEbWas)
  - [Ultimate Neovim Setup Guide: lazy.nvim Plugin Manager](https://dev.to/slydragonn/ultimate-neovim-setup-guide-lazynvim-plugin-manager-23b7)
  - [Neovim Starter Setup Guide](https://www.youtube.com/watch?v=Co7gcSvq6jA)
  - [Neovim - Plugin Deep Dive, Lazyloading, Autoinstall, 100% Lua with Packer.nvim](https://www.youtube.com/watch?v=gd_wapDL0V0)
  - [Configure Linting, Formatting, and Autocompletion in Neovim](https://www.youtube.com/watch?v=y1WWOaLCNyI)

- Focus on Coding
  - [The perfect Neovim setup for C++](https://www.youtube.com/watch?v=lsFoZIg-oDs)
  - [Configuring NeoVim as a Python IDE](https://www.playfulpython.com/configuring-neovim-as-a-python-ide/)
  - [A modern Neovim configuration with full battery for Python, Lua, C++, Markdown, LaTeX, and more...](https://github.com/jdhao/nvim-config)
  - [My ultimate Neovim configuration for Python development](https://ramezanpour.net/post/2021/04/24/My-ultimate-Neovim-configuration-for-Python-development)
  - [How to run Python on Neovim like Jupyter](https://dev.to/rnrbarbosa/how-to-run-python-on-neovim-like-jupyter-3ln0)
  - [A Complete Guide to Neovim Configuration for Python Development](https://jdhao.github.io/2018/12/24/centos_nvim_install_use_guide_en/)


## 4th ... Do Some Off-Roading

dotfiles, tmux, alacritty

- [How To Use and Configure Tmux Alongside Neovim](https://www.josean.com/posts/tmux-setup)
- [Vim and Tmux](https://www.youtube.com/playlist?list=PL-v3vdeWVEsXo87wHeVSP_x1KTX4G1l8Y)


## 5th ... If You Get Lost, Repeat

---------------

Include the text from "/home/jeff/blogging/content/ideas/my-integrated-development-environment.md"

- Collections of awesome neovim plugins: [Awesome Neovim](https://github.com/rockerBOO/awesome-neovim)

- [Our favorite fonts for the Linux terminal](https://opensource.com/article/23/4/linux-terminal-fonts)

- [Build A Portable Development Environment With Nix Package Manager](https://www.youtube.com/watch?v=70YMTHAZyy4)

---------------

- NeoVim Tutorials - Comprehensive Source of Tutorials & Ideas
  - SmartTech101
    - [SmartTech101: NeoVim](https://smarttech101.com/category/neovim/)
    - [How to Use Vim/Neovim](https://smarttech101.com/how-to-use-vim-neovim/)
    - [How to Configure Colorscheme in Vim/Neovim](https://smarttech101.com/how-to-configure-colorscheme-in-vim-neovim/)
    - [How to Configure Neovim](https://smarttech101.com/how-to-configure-neovim/)
    - [Nvim lsp: set up null-ls for beginners](https://smarttech101.com/nvim-lsp-set-up-null-ls-for-beginners/)
    - [Nvim lsp autocompletion: mapping, snippets, fuzzy search](https://smarttech101.com/nvim-lsp-autocompletion-mapping-snippets-fuzzy-search/)
    - [Nvim lsp: configure language servers, shortcuts, highlights](https://smarttech101.com/nvim-lsp-configure-language-servers-shortcuts-highlights/)
    - [Nvim lsp diagnostics – keybindings, signs, virtual texts](https://smarttech101.com/nvim-lsp-diagnostics-keybindings-signs-virtual-texts/)
  - Truff Gniuz
    - [Configuring Neovim](https://www.youtube.com/playlist?list=PLIHtvvGZ1O3jBXdp9Id02vRuOEOWIGB_w)
  - Alpha2Phi
    - [Learn Neovim The Practical Way](https://alpha2phi.medium.com/learn-neovim-the-practical-way-8818fcf4830f)
    - [Learn Neovim The Practical Way: All articles on how to configure and program Neovim](https://alpha2phi.medium.com/learn-neovim-the-practical-way-8818fcf4830f)
    - [Neovim Tips for a Better Coding Experience](https://alpha2phi.medium.com/neovim-tips-for-a-better-coding-experience-3d0f782f034e)
  - Christian Chiarulli (aka Chris@Machine)
    - [Christian Chiarulli](https://www.chrisatmachine.com/) Creator and lead maintainer of 🌙 LunarVim
    - [Configuring Neovim](https://www.youtube.com/watch?v=qb6fPgZMRF4&list=PLIHtvvGZ1O3jBXdp9Id02vRuOEOWIGB_w)
    - [Neovim Configuration](https://www.youtube.com/playlist?list=PLsz00TDipIffxsNXSkskknolKShdbcALR)
    - [Neovim from Scratch](https://www.youtube.com/playlist?list=PLhoH5vyxr6Qq41NFL4GvhFp-WLd5xzIzZ)
  - Example NeoVim Configurations
    - [dotfyle: Discover and share Neovim configs](https://dotfyle.com/)
    - [Neovim for Beginners](https://alpha2phi.medium.com/learn-neovim-the-practical-way-8818fcf4830f#545a)
    - [GitHub: alpha2phi/neovim-for-beginner](https://github.com/alpha2phi/neovim-for-beginner/tree/50-package-manager)
    - [Neovim from Scratch](https://www.youtube.com/playlist?list=PLhoH5vyxr6Qq41NFL4GvhFp-WLd5xzIzZ)
    - [Neovim from scratch](https://github.com/LunarVim/Neovim-from-scratch)
    - [LunarVim](https://github.com/LunarVim/LunarVim)
    - [LunarVim](https://www.youtube.com/playlist?list=PLhoH5vyxr6QqGu0i7tt_XoVK9v-KvZ3m6)
    - [A Basic Stable IDE config for Neovim](https://github.com/LunarVim/nvim-basic-ide)
    - [kickstart.nvim](https://github.com/nvim-lua/kickstart.nvim)
    - [Effective Neovim: Instant IDE](https://www.youtube.com/watch?v=stqUbv-5u2s)
    - [NvChad](https://github.com/NvChad/NvChad)
    - [AstroNvim](https://github.com/AstroNvim/AstroNvim)

---------------

Sources:

- The Vim Language
  Vim motions are how you navigate, whether you navigate to the end of the word or back to the start of the document; these are all motions.
  - [vim](https://www.ssp.sh/brain/vim/)
  - [Neovim](https://www.ssp.sh/brain/neovim/)
  - [The Vim Language (and Motions)](https://www.ssp.sh/brain/vim-language-and-motions/)
  - [Mastering the Vim Language](https://www.youtube.com/watch?v=wlR5gYd6um0) \* [Why Vim Is More than Just an Editor – Vim Language, Motions, and Modes Explained](https://www.ssp.sh/blog/why-using-neovim-data-engineer-and-writer-2023)
- Vim vs. NeoVim
  - [Compare NeoVim vs Vim: Which Editor is Best for You?](https://www.sysprobs.com/compare-neovim-vs-vim-best-editor)
  - [7 Reasons Why Developers Prefer NeoVim Over Vim](https://linuxhandbook.com/neovim-vs-vim/)
  - [Why Neovim is so much better than Vim now... (Neovim vs Vim)](https://www.youtube.com/watch?v=qQvFC0wRiRE)
- NeoVim
  - [Meet Neovim](http://vimcasts.org/episodes/meet-neovim/)
  - [Neovim](https://neovim.io/)
  - [How to Install Neovim on Ubuntu 22.04](https://linuxopsys.com/topics/install-neovim-ubuntu-and-plugins)
  - [How I Setup Neovim On My Mac To Make It Amazing - Complete Guide](https://www.youtube.com/watch?v=vdn_pKJUda8)
  - [Everything you need to know to configure neovim using lua](https://vonheikemen.github.io/devlog/tools/configuring-neovim-using-lua/)
  - [Configuring Neovim With Lua (It's Easy!)](https://www.youtube.com/watch?v=m62UCkdQ8Ck)
    [Build your first Neovim configuration in lua](https://vonheikemen.github.io/devlog/tools/build-your-first-lua-config-for-neovim/)
- Vim-plug
  - [How to Install Plugins in Neovim](https://linuxopsys.com/topics/install-plugins-in-neovim)
  - [Vim-plug: A Minimalist Vim Plugin Manager](https://www.ostechnix.com/vim-plug-a-minimalist-vim-plugin-manager/)
  - [VIM Plug – The easy way to install plugins in VIM](https://www.linuxfordevices.com/tutorials/linux/vim-plug-install-plugins)
- NeoVim and Lua Referance Docs
  - [Nvim Documentation](https://neovim.io/doc/)
  - [Nvim Documentation: Lua](https://neovim.io/doc/user/lua.html)
  - [Nvim Documentation: Options](https://neovim.io/doc/user/options.html)
  - [Lua](https://www.lua.org/docs.html)
- NeoVim Plugins
  - [Awesome Neovim](https://github.com/rockerBOO/awesome-neovim)
  - [neovimcraft](https://neovimcraft.com/)


## Choose Core NeoVim Package and Plugin Manager


### Core NeoVim Package: Kickstart


### Plugin Manager: Lazy.nvim

- [Ultimate Neovim Setup Guide: lazy.nvim Plugin Manager](https://dev.to/slydragonn/ultimate-neovim-setup-guide-lazynvim-plugin-manager-23b7)
- [Zero to IDE with LazyVim](https://www.youtube.com/watch?v=N93cTbtLCIM&t=5s)
- [Lazy.nvim Documentation](https://lazy.folke.io/) - DONE


### Personalization of Core

Colorscheme, Filesystem Navigation, Screen layout, Key Mappings


#### Key Mapping

- [Setting Key Mappings](https://tui.ninja/neovim/customizing/keymaps/setting/)
- [Mapping keys in Vim - Tutorial](<https://vim.fandom.com/wiki/Mapping_keys_in_Vim_-_Tutorial_(Part_1)>)
- [Neovim key map helper in lua](https://willcodefor.beer/posts/luamap)
- [How I Setup Neovim To Make It AMAZING in 2024: The Ultimate Guide](https://www.youtube.com/watch?v=6pAG3BHurdM&t=631s)
- [Neovim - ~25 Custom Keymaps set with Lua](https://www.youtube.com/watch?v=435-amtVYJ8)
- [Neovim Lua Key Mapping](https://www.youtube.com/watch?v=IMXhsdBjveU)
- [In NeoVim/Vim, how to know all used key combination?](https://stackoverflow.com/questions/73841647/in-neovim-vim-how-to-know-all-used-key-combination)
- [Neovim for Beginners — Key Mappings and WhichKey](https://alpha2phi.medium.com/neovim-for-beginners-key-mappings-and-whichkey-31dbf58f9f87)
- [Must-Have Neovim Keymaps](https://medium.com/linux-with-michael/must-have-neovim-keymaps-51c283394070)
- [which-key.nvim - Weekly Neovim Plugin](https://www.youtube.com/watch?v=hB-k7VOCONs)
- [Install and Set Up Which Key in Neovim/Nvim And Never Forget Your Key Mappings](https://linovox.com/install-and-set-up-which-key-in-neovim-nvim/)
- [Which-Key for Neovim](https://medium.com/@shaikzahid0713/which-key-7554ac347c9d)
- [Vim Key Bindings – Vim Keys List Reference](https://www.freecodecamp.org/news/vim-key-bindings-reference/)

- [In NeoVim/Vim, how to know all used key combination?](https://stackoverflow.com/questions/73841647/in-neovim-vim-how-to-know-all-used-key-combination)
- [The Underrated Square Bracket (NeoVim Conf 2023)](https://www.joshmedeski.com/posts/underrated-square-bracket/)


#### Telescope

- [telescope.nvim -Weekly Neovim Plugin](https://www.youtube.com/watch?v=Mk47CZaGeWw)
- [Neovim - Telescope: a highly extendable fuzzy finder](https://www.youtube.com/watch?v=OhnLevLpGB4)
- [Configure Telescope in Neovim](https://www.youtube.com/watch?v=u_OORAL_xSM)


##### AutoSuggestions & Code Completions


##### Lint & Formating

- [LazyVim: Linting and Formatting](https://www.youtube.com/watch?v=a_ZpTPaSn38)
- [Code formatting in Neovim](https://imbmax.com/code-formatting-in-neovim)
- [Code Formatting in Neovim for Beginners](https://beetbox.io/posts/code-formatting-in-neovim-for-beginners/)
- [How To Setup Linting & Formatting In Neovim And Replace null-ls](https://www.josean.com/posts/neovim-linting-and-formatting)
- [stevearc/conform.nvim](https://github.com/stevearc/conform.nvim)
- [JohnnyMorganz/StyLua](https://github.com/JohnnyMorganz/StyLua)
- [Modern Format on Save in Neovim](https://www.mitchellhanberg.com/modern-format-on-save-in-neovim/)


#### Comments


#### Completion

- [Code Completion for Neovim using Lazy](https://medium.com/@shaikzahid0713/code-completion-for-neovim-6127401ebec2)
- [How to Install and Use nvim cmp Autocompletion](https://linovox.com/install-and-use-nvim-cmp/)
- [Filepath Completion in Neovim](https://pype.dev/filepath-completion-in-neovim/)


#### Sessions & Workspaces & Projects

- [Boost Your Productivity with This Neovim Plugin for Project Management!](https://dev.to/saltaformajo/boost-your-productivity-with-this-neovim-plugin-for-project-management-2bd8)
- [Switching between projects in Neovim](https://sgoel.dev/posts/switching-between-projects-in-neovim/)
  - A simple session manager plugin: [natecraddock/sessions.nvim](https://github.com/natecraddock/sessions.nvim)
  - A simple plugin to manage workspace directories in neovim: [natecraddock/workspaces.nvim](https://github.com/natecraddock/workspaces.nvim)


#### Diagnostics

- [NEOVIM DIAGNOSTICS](https://www.barbarianmeetscoding.com/notes/neovim/diagnostics/)
- [Neovim diagnostics with nvim-lspconfig](https://discourse.julialang.org/t/neovim-diagnostics-with-nvim-lspconfig/74130)
- [Nvim lsp diagnostics – keybindings, signs, virtual texts](https://smarttech101.com/nvim-lsp-diagnostics-keybindings-signs-virtual-texts/)
- [Neovim LSP Diagnostics In Your Statusline 🦀 ⚙](https://www.youtube.com/watch?v=hPMKLXZIe-s)
- [Pull Diagnostic Support for Neovim](https://atlee.ca/posts/pull-diagnostic-support-for-neovim/)
- [Workspace diagnostics in Neovim](https://artem.rocks/posts/workspace_diagnostics_nvim)
- [Printing Diagnostics in Neovim](https://www.matthewherman.net/programming/2023/06/18/neovim-print-diagnostics.html)
- A pretty diagnostics, references, telescope results, quickfix and location list to help you solve all the trouble your code is causing: [GitHub: folke/trouble.nvim](https://github.com/folke/trouble.nvim)
- LSP diagnostics in virtual text at the top right of your screen [GitHub: dgagn/diagflow.nvim]


#### NeoVim IDE

- [Effective Neovim: Instant IDE](https://www.youtube.com/watch?v=stqUbv-5u2s&t=7s)
- [PDE: A different take on editing code](https://www.youtube.com/watch?v=QMVIJhC9Veg)
- [NeoVim IDE setup from scratch](https://hackmd.io/@0V3cv8JJRnuK3jMwbJ-EeA/r1XR_hZL3)
- [Building And Debugging C++ In Neovim](https://igorlfs.github.io/neovim-cpp-dbg)


#### Debugging

- [VIM _IS_ AN IDE // The PERFECT Neovim & Golang Setup](https://www.youtube.com/watch?v=aeQn9MRTjxc)
  - A full featured IDE layer for Neovim. Heavily inspired by VSCode - [GitHub: ldelossa/nvim-ide](https://github.com/ldelossa/nvim-id)
- [Transform Your Neovim into a IDE: A Step-by-Step Guide](https://martinlwx.github.io/en/config-neovim-from-scratch/)
- [DEBUG in Neovim. Like a BOSS.](https://www.youtube.com/watch?v=RziPWdTzSV8)
  - A UI for nvim-dap: [rcarriga/nvim-dap-ui](https://github.com/rcarriga/nvim-dap-ui)
- [GitHub: ray-x/navigator.lua](https://github.com/ray-x/navigator.lua) See [NEOVIM: MIGRATING TO LAZY.NVIM AND GO.NVIM](https://mariocarrion.com/2024/05/20/neovim-migrating-to-lazy-and-go-nvim.html)
- [GitHub: theHamsta/nvim-dap-virtual-text](https://github.com/theHamsta/nvim-dap-virtual-text)


#### Interactive Code Runner

- [Neovim 101— Interactive Code Runner](https://alpha2phi.medium.com/neovim-101-interactive-code-runner-dfbc37ff6fe7)


#### Marks

- [Marks in Vim Are A Game Changer](https://www.youtube.com/watch?v=XT_kFia3Ua4)
- [GitHub: chentoast/marks.nvim](https://github.com/chentoast/marks.nvim)


#### NeoVim & Tmux

- [I Love TMUX and you should too](https://www.youtube.com/watch?v=-B5VDp50daI)
- [Vim and tmux](https://www.youtube.com/playlist?list=PL-v3vdeWVEsXo87wHeVSP_x1KTX4G1l8Y)
- [How To Use and Configure Tmux Alongside Neovim](https://www.josean.com/posts/tmux-setup)
- [Be a tmux KING with Tmuxifier | My FAVORITE tmux tool](https://www.youtube.com/watch?v=ceRYL271cao)

- [I'm Never Using Tmux The Same Again!](https://www.youtube.com/watch?v=JFipv1_ycqU)


#### Workspaces & Sessions

- [Switching between projects in Neovim](https://sgoel.dev/posts/switching-between-projects-in-neovim/)
- [GitHub: natecraddock/workspaces.nvim](https://github.com/natecraddock/workspaces.nvim)
- [GitHub: natecraddock/sessions.nvim](https://github.com/https://github.com/natecraddock/sessions.nvim)


#### Markdown Files

- [Paste or Drag-n-Drop Images to your Neovim documents](https://www.youtube.com/watch?v=4crDKASq9Nc)


#### Large Language Models (LLM)

- [Local LLMs in Neovim: gen.nvim](https://www.youtube.com/watch?v=FIZt7MinpMY)
  - Neovim plugin to generate text using LLMs with customizable prompts - [GitHub: David-Kunz/gen.nvim](https://github.com/David-Kunz/gen.nvim)


#### Note Taking

- [Is Neovim the ULTIMATE note taking tool?](https://www.youtube.com/watch?v=vdBkQ4jT2OE)


#### ChatGPT Inside Neovim

- [Running chatGPT inside Neovim](https://medium.com/@soares.alisson/running-chatgpt-inside-neovim-2c56205ec4bc)
- [Awesome plugin: ChatGPT with NeoVim](https://dev.to/xxxuutaxxx/awesome-plugin-chatgpt-with-neovim-571d)

[01]: https://dev.to/vonheikemen/lazynvim-plugin-configuration-3opi
[02]: https://en.wikipedia.org/wiki/Integrated_development_environment
[03]: https://www.redhat.com/sysadmin/introduction-tmux-linux
[04]: https://alacritty.org/
[05]: https://tree-sitter.github.io/tree-sitter/
[06]: https://microsoft.github.io/language-server-protocol/
[07]: https://fortelabs.com/blog/basboverview/
[08]: https://carlosbecker.com/posts/ed/

[09]:
[10]:
