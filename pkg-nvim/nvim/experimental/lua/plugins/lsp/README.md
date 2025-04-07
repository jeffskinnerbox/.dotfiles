
<!--
Maintainer:   jeffskinnerbox@yahoo.com / www.jeffskinnerbox.me
Version:      0.0.1
-->

<div align="center">
<img src="https://raw.githubusercontent.com/jeffskinnerbox/blog/main/content/images/banners-bkgrds/work-in-progress.jpg" title="These materials require additional work and are not ready for general use." align="center" width=420px height=219px>
</div>

---------------

NOTE: Make sure that nvim-lspconfig.lua, mason.lua, conform.lua, and nvim-lint.lua all agree on what linter & formatter will be used for each filetype
NOTE: currently supporting only lua, python, sh, markdown, yaml, json

| NeoVim Module        | Function |
|:---------------------|:---------|
| `mason.lua`          |          |
| `nvim-lspconfig.lua` |          |
| `nvim-lint.lua`      |          |
| `conform.lua`        |          |

|             |           `mason.lua`                | `nvim-lspconfig.lua`  |  `nvim-lint.lua`   |  `conform.lua`    |
|:------------|:-------------------------------------|:---------------------:|:-----------------:|:------------------:|
|**Language** | **LSP**  /  **Tools**                |        **LSP**        | **Linter**        |  **Formatter**     |
| Markdown    | marksman /  markdownlint-cli2        |        marksman       | markdownlint-cli2 |  markdownlint-cli2 |
| Lua         | lua_ls   /  luacheck, stylua         |        lua_ls         | luacheck          |  stylua            |
<!--
| Markdown    | marksman /  markdownlint             |        marksman       | markdownlint      |  markdownlint      |
| Python      | pyright  /  pylint, isort, black     |        pyright        | pylint            |  isort, black      |
| Shell       | bashls   /  shellcheck, beautysh     |        bashls         | shellcheck        |  beautysh          |
| Yaml        | yamlls   /  yamllint, yamlfix        |        yamlls         | yamllint          |  yamlfix           |
| Json        | jsonls   /  jsonlint, prettier       |        jsonls         | jsonlint          |  prettier          |
| HTML        | emmet_ls /  htmllint, htmlbeautifier |        emmet_ls       |        ???        |  ???               |
-->     

