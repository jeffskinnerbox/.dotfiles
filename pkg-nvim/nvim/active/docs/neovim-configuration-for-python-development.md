<!--
Maintainer:   jeffskinnerbox@yahoo.com / www.jeffskinnerbox.me
Version:      0.0.1
-->

<div align="center">
<img src="https://raw.githubusercontent.com/jeffskinnerbox/blog/main/content/images/banners-bkgrds/work-in-progress.jpg" title="These materials require additional work and are not ready for general use." align="center" width=420px height=219px>
</div>

---

This is specifically for Python but can be used as a guide for other languages.

Sources:

* [Neovim Starter Kit for Python][01]
* [How I Setup LSP In Neovim For An Amazing Dev Experience - Full Guide][02]
* [How To Setup Linting And Formatting In Neovim To Replace null-ls][03]
* [Neovim Starter Kit for Python](https://github.com/bcampolo/nvim-starter-kit/tree/python#neovim-starter-kit-for-python-)
* [The perfect Neovim setup for Python](https://www.youtube.com/watch?v=4BnVeOUeZxc)


#### Step 1: Syntax Highlighting

Within `nvim-treesitter.lua` plugin, set the `auto_install` to `true`.
This will automatically install languages syntax support
when a new filetype is encountered (like  file extension `py` for python.)


#### Step 2: Python LSP

There are several LSP server for Python
To see this, execute `:Mason`, enter `2`, and then search for python by entering `/python`.
I choose `pyright` as my Python LSP server.
Within `nason.lua`, enter `pyright` into where the LSP servers are loaded,
specificagly into the `mason_lspconfig.setup()` code block.

While in the `mason.lua` file, lets enter other tools we will be needing for Python development.
Within the `mason_tool_installer.setup()` code block,
enter `pylint`, `isort`, `black`, `flake8`, `debugpy`, and `mypy`.
Also, make sure to install these tools on you computer:

```bash
# add python linting, formatting, debugging tools
pip install pylint isort black flake8 debugpy mypy
```

These are linting, formatting, and debugging tools that we will be leveraging for Python development.


#### Step 3: Auto-completion

Auto-completion, that is, language specific suggestions as you type,
is supplied via the LSP you installed.
For configuration of auto-completion,
take a look at the configuration discussed in the videos
["Neovim Starter Kit for Python"][01],
["How I Setup LSP In Neovim For An Amazing Dev Experience - Full Guide"][02],
and ["How To Setup Linting And Formatting In Neovim To Replace null-ls"][03].
Specifically, the code listed [here][04] and [here][05].


#### Step 4: Snippets

Snippets a template for common coding patterns that can help you find the code you need
and automatically insert a template for you to fill in.
This saves you time and lessens the need to look up things in a languages reference manual.

See the same videos & code listings discussed in Step 3 above.


#### Step 5: Formatting

See the videos discussed in Step 3 and the code listings [here][06] and [here][07].


#### Step 6: Linting

Linting is about validating syntax and enforcing language style guides.


#### Step 7: Debugging

To add debugiing to the NeoVim configuration,
I'll make use of the [debugpy][08] tool ([GitHub repository][09]).

* `nvim-dap.lua`
    * see your kickstart2
    * <https://github.com/mfussenegger/nvim-dap>
* `nvim-dap-ui.lua`
    * <https://github.com/bcampolo/nvim-starter-kit/blob/python/.config/nvim/lua/plugins/nvim-dap-ui.lua>
    * <https://github.com/rcarriga/nvim-dap-ui>
* `nvim-dap-python.lua`
    * <https://github.com/bcampolo/nvim-starter-kit/blob/python/.config/nvim/lua/plugins/nvim-dap-python.lua>
    * <https://github.com/mfussenegger/nvim-dap-python>
* `nvim-dap-virtual-text.lua`
    * <https://github.com/bcampolo/nvim-starter-kit/blob/python/.config/nvim/lua/plugins/nvim-dap-virtual-text.lua>
    * <https://github.com/theHamsta/nvim-dap-virtual-text>
* nvim-neotest/nvim-nio
    * see your kickstart2
    * <https://github.com/nvim-neotest/nvim-nio>


#### Step 8: Unit Testing

**NOTE:** Make sure that `nvim-lspconfig.lua`, `mason.lua`, `conform.lua`, and `nvim-lint.lua` all agree on what LSP server, linter & formatter will be used for each filetype

[01]:https://www.youtube.com/watch?v=jWZ_JeLgDxU
[02]:https://www.youtube.com/watch?v=NL8D8EkphUw
[03]:https://www.youtube.com/watch?v=ybUE4D80XSk
[04]:https://github.com/bcampolo/nvim-starter-kit/blob/python/.config/nvim/lua/plugins/nvim-cmp.lua
[05]:https://github.com/josean-dev/dev-environment-files/blob/main/.config/nvim/lua/josean/plugins/nvim-cmp.lua
[06]:https://github.com/bcampolo/nvim-starter-kit/blob/python/.config/nvim/lua/plugins/nvim-lspconfig.lua
[07]:https://github.com/josean-dev/dev-environment-files/blob/main/.config/nvim/lua/josean/plugins/lsp/lspconfig.lua
[08]:https://pypi.org/project/debugpy/
[09]:https://github.com/microsoft/debugpy
