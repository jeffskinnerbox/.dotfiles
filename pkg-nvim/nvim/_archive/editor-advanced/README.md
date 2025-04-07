<!--
Maintainer:   jeffskinnerbox@yahoo.com / www.jeffskinnerbox.me
Version:      0.0.1
-->


<div align="center">
<img src="https://raw.githubusercontent.com/jeffskinnerbox/blog/main/content/images/banners-bkgrds/work-in-progress.jpg" title="These materials require additional work and are not ready for general use." align="center" width=420px height=219px>
</div>


------


* [Neovim modern features: treesitter and LSP](https://blog.pabuisson.com/2022/08/neovim-modern-features-treesitter-and-lsp/)

nvim-treesitter gives Neovim better language parsing capabilities. The most noticeable improvement is a better and more precise syntax highlighting, but it also brings other improvements to folding and indentation. It does that by building a syntax tree of our code rather than relying on regexps and patterns.

LSP means Language Server Protocol.
To support features such as autocompletion, linting, go-to-definition, each editor needs to "understand" the edited language. Before LSP, each editor had to implement these features, for each language.
The Vim ecosystem has multiple LSP clients that can attach to a LSP server:
vim lsp and built-in Neovim lsp, introduced in Neovim 0.5

