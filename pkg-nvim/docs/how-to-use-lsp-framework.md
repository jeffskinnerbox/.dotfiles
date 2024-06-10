<!--
Maintainer:   jeffskinnerbox@yahoo.com / www.jeffskinnerbox.me
Version:      0.0.1
-->


<div align="center">
<img src="https://raw.githubusercontent.com/jeffskinnerbox/blog/main/content/images/banners-bkgrds/work-in-progress.jpg" title="These materials require additional work and are not ready for general use." align="center" width=420px height=219px>
</div>


------

NeoVim supports the [Language Server Protocol (LSP)][01], which means it acts as a client to LSP servers.
LSP facilitates features like go-to-definition, find-references, hover,
completion, rename, format, refactor, etc., using semantic whole-project analysis.

So, what is `nvim-lspconfig`?
`nvim-lspconfig` supports the [configurations][03] for the [Nvim LSP client][02].

## Do You Know LSP?
Put simply, within LSP there are two entities (language server & a client to that server) and a protocal between them.
The Language Server Protocol (LSP) specifications, is a set of rules (protocal using [JSON-RPC][05])
that define how language servers and clients communicate.
The LSP specification defines what type of messages a language server can receive,
and also how it should respond.
The idea here is that any tool that follows the LSP specification can communicate with a language server.

The LSP's goal is to allow language intelligence tools (text editors but [it can be any tool][06]),
like code completion, syntax highlighting, and refactoring,
to be implemented and distributed independently of any specific editor or IDE.
This allows language feature creators to focus on their specialty while editor creators can do the same.

So you want to trouble shoot a LSP problem?
Fine ... but do you really understand what is going on with the NeoVim LSP client, the server, etc?
To learn, try writing a simple client without any NeoVim plugins.

[Intelephense][04] is one of many LSPs supporting the PHP language.
When this LSP server is paired with a LSP client capable editor,
it can provide a reach set of features (see [Intelephense][04] website).
If you want to experimanet by manually creating a custom LSP client,
checkout the sources below:

* [A guide on Neovim's LSP client](https://vonheikemen.github.io/devlog/tools/neovim-lsp-client-guide/)
* [Understanding Language Server Protocol - autocomplete, formatting - Adrian Hesketh](https://www.youtube.com/watch?v=EkK8Jxjj95s)
* [Understanding the Language Server Protocol](https://medium.com/@malintha1996/understanding-the-language-server-protocol-5c0ba3ac83d2)

## Trouble Shooting LSP
The most common reasons a language server does not start or attach are:

1. The language server is not installed.
`nvim-lspconfig` does not install language servers for you.
You should be able to run the `cmd` defined in each server's Lua module from the command line
and see that the language server starts.
2. Missing filetype plugins.
Certain languages are not detecting by Vim/NeoVim because they have not yet been added to the filetype detection system.
Ensure `:set ft?` shows the filetype and not an empty value.
3. Not triggering root detection.
Some language servers will only start if it is opened in a directory, or child directory,
containing a file which signals the root of the project.
Most of the time, this is a .git folder, but each server defines the root config in the lua file.
See `server_configurations.md` or the source for the list of root directories.
4. You must pass capabilities for each `setup {}` if you want these to take effect.
5. Do not call `setup {}` twice for the same server. The second call to `setup {}` will overwrite the first.

check your logs and the output of `:LspInfo`.
Add the following to your init.vim to enable logging:

```lua
-- set the log level to debug - log files are located in `$HOME/.local/state/nvim/*.log`
:lua vim.lsp.set_log_level("debug")

-- see content of lsp logs
:LspLog
```

* `:checkhealth lsp`        to see the status or to troubleshoot
* `:LspInfo`                shows the status of active and configured language servers
* `:LspLog`                 see the contents of the LSP log file
* `:LspStart <config_name>` Start the requested server name. Will only successfully start if the command detects a root directory matching the current config. Pass autostart = false to your .setup{} call for a language server if you would like to launch clients solely with this command. Defaults to all servers matching current buffer filetype.
* `:LspStop <client_id>`    Defaults to stopping all buffer clients.
* `:LspRestart <client_id>` Defaults to restarting all buffer clients.



[01]:https://microsoft.github.io/language-server-protocol/
[02]:https://neovim.io/doc/user/lsp.html
[03]:https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md
[04]:https://intelephense.com/
[05]:https://www.jsonrpc.org/
[06]:https://www.youtube.com/watch?v=p0Vlz66AFNw


