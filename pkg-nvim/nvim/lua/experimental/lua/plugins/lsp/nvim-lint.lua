-- luacheck: globals vim
-- luacheck: max line length 300

--[[ asynchronous linter plugin for Neovim complementary to the built-in Language Server Protocol support
kickstart2/lua/kickstart/plugins/nvim-lint.lua

  Description:
    describe what this plugin does

  Usage:
    list the most significant commandline and keymap operations

    Commandline
      None that I'm using or aware of.
      :nmap                    - for list of normal mode key mappings

    Keymapped Commands
      None that I'm using or aware of.
      <leader>sp               - toggle spell checking

  Sources:
    nvim-lint
      [GitHub: mfussenegger/nvim-lint](https://github.com/mfussenegger/nvim-lint)
      [How I Setup LSP In Neovim For An Amazing Dev Experience - Full Guide](https://www.youtube.com/watch?v=NL8D8EkphUw)
      [How To Setup Linting And Formatting In Neovim To Replace null-ls](https://www.youtube.com/watch?v=ybUE4D80XSk)
      [Configure Linting, Formatting, and Autocompletion in Neovim](https://www.youtube.com/watch?v=y1WWOaLCNyI)
    Lua Linter
      [LuaCheck Documentation: Inline Options](https://luacheck.readthedocs.io/en/stable/inline.html)
    Markdown Linter
      [MarkdownLint Documentation](https://docs.superoffice.com/contribute/markdown-guide/markdownlint.html)
      [markdownlint: A Node.js style checker and lint tool for Markdown/CommonMark files](https://www.npmjs.com/package/markdownlint)
      [markdownlint-cli: Command Line Interface for MarkdownLint](https://www.npmjs.com/package/markdownlint-cli)
      [Notes on Markdown linting - part 1](https://qmacro.org/blog/posts/2021/05/13/notes-on-markdown-linting-part-1/)

  NOTE: Make sure that nvim-lspconfig.lua, mason.lua, conform.lua, and nvim-lint.lua all agree on what linter & formatter will be used for each filetype
]]

-- function that wraps 'vim.api.nvim_set_keymap' command into something easy to use, or better yet, uses 'vim.keymap.set' - keymap(<mode>, <key-to-bind>, <action-wanted>, <options>)
-- [vim.api.nvim_set_keymap() vs. vim.keymap.set() - what's the difference?](https://www.reddit.com/r/neovim/comments/xvp7c5/vimapinvim_set_keymap_vs_vimkeymapset_whats_the/)
local keymap = function(mode, key, result, options)
  vim.keymap.set(
    mode,                                                                       -- aka {mode},  can be 'n' = normal mode, 'i' = insert mode, 'v' = visual mode, 'x' = visual block mode, 't' = term mode, 'c' = command mode
    key,                                                                        -- aka {lhs}, key sequence to trigger result
    result,                                                                     -- aka {rhs}, command or key subsituation to be made
    { desc = 'Linter: ' .. options, }                                           -- aka {opts}, keymap discription, 'Linter:' means this is a code formatting function
  )
end

return {
  'mfussenegger/nvim-lint',
  enabled = true,                                                               -- load the plugin if 'true' but skip completely if 'false'
  event = { "BufReadPre", "BufNewFile" },                                       -- load the plugin when you read an existing file or new buffer is created
  config = function()
    local lint = require('lint')
    lint.linters_by_ft = {                                                      -- for each file type, set which linters you plan to use
      -- list of filetypes supported with linting (NOTE: currently supporting only lua, python, sh, markdown, yaml, json)
      lua = { 'luacheck' },                                                     -- linter for lua language
      python = { 'pylint' },                                                    -- linter for python language
      sh = { "shellcheck" },                                                    -- linter for bash shell language
      --sh = { "shellharden" },                                                   -- linter and formatter for bash shell language
      --cpp = { 'cpplint' },                                                      -- linter for c++ language
      markdown = { 'markdownlint' },                                            -- linter and formatter for markdown language
      yaml = { 'yamllint' },                                                    -- linter and formatter for yaml
      json = { 'jsonlint' },                                                    -- linter and formatter for json
      --javascript = { 'ast-grep' },                                              -- linter and formatter for javascript, you can use a sub-list to tell conform to run *until* a formatter is found, e.g. javascript = { { "prettierd", "prettier" } },
      --css = { 'ast-grep' },                                                     -- linter and formatter for css
      --html = { 'ast-grep' },                                                    -- linter and formatter for html
      --cmake = { "cmakelang" },                                                  -- linter and formatter for the cmake language
      --makefile = { 'checkmake' },                                               -- linter for makefile language
      --ansible = { 'ansible-lint' },                                             -- linter for ansible language
      --docker = { 'hadolint' },                                                  -- linter for docker language
    }

    -- create autocommand which carries out the actual linting on the specified events
    local lint_augroup = vim.api.nvim_create_augroup('lint', { clear = true })  -- 'clear = true' removes any pre-exsiting auggroup
    vim.api.nvim_create_autocmd({ 'BufEnter', 'BufWritePost', 'InsertLeave' }, {  -- trigger linting on these events
      group = lint_augroup,
      callback = function()
        lint.try_lint()                                                           -- do the linting when the events are triggered
      end,
    })

    -- setup a keymap so user can trigger linting manually
    keymap('n', '<leader>cl', function()
      lint.try_lint()
    end, 'Trigger [C]ode [L]inter for Current Buffer' )
  end,
}
