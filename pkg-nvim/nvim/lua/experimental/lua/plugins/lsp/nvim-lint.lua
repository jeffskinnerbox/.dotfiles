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
      [How I Setup LSP In Neovi:with For An Amazing Dev Experience - Full Guide](https://www.youtube.com/watch?v=NL8D8EkphUw)
      [How To Setup Linting And Formatting In Neovim To Replace null-ls](https://www.youtube.com/watch?v=ybUE4D80XSk)
      [Configure Linting, Formatting, and Autocompletion in Neovim](https://www.youtube.com/watch?v=y1WWOaLCNyI)
    Lua Linter
      [LuaCheck Documentation: Inline Options](https://luacheck.readthedocs.io/en/stable/inline.html)
    Markdown Linter
      Major Clue - :with[Setup nvim-lint with pylint in neovim+mason to work in virtualenv](https://gist.github.com/Norbiox/652befc91ca0f90014aec34eccee27b2)
      [Linting your Markdown Files](https://blog.scottlowe.org/2024/03/01/linting-your-markdown-files/)
      [GitHub: DavidAnson/markdownlint-cli2](https://github.com/DavidAnson/markdownlint-cli2)
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
		mode, -- aka {mode},  can be 'n' = normal mode, 'i' = insert mode, 'v' = visual mode, 'x' = visual block mode, 't' = term mode, 'c' = command mode
		key, -- aka {lhs}, key sequence to trigger result
		result, -- aka {rhs}, command or key subsituation to be made
		{ desc = "Linter: " .. options } -- aka {opts}, keymap discription, 'Linter:' means this is a code formatting function
	)
end

--[[
return {
  'mfussenegger/nvim-lint',
  enabled = true,                                                               -- load the plugin if 'true' but skip completely if 'false'
  event = { "BufReadPre", "BufNewFile" },                                       -- load the plugin when you read an existing file or new buffer is created
  config = function()
    local lint = require('lint')
    lint.linters_by_ft = {                                                      -- for each file type, set which linters you plan to use, (NOTE: currently supporting only lua, python, sh, markdown, yaml, json)
      lua = { 'luacheck' },                                                     -- linter for lua language
      python = { 'pylint' },                                                    -- linter for python language
      sh = { "shellcheck" },                                                    -- linter for bash shell language
      --bash = { "shellcheck" },                                                  -- linter for bash shell language
      --sh = { "shellharden" },                                                   -- linter and formatter for bash shell language
      --cpp = { 'cpplint' },                                                      -- linter for c++ language
      --go = { "golangci-lint" },
      --markdown = { 'markdownlint' },                                            -- linter and formatter for markdown language
      --markdown = { ['markdownlint-cli2'] = { args = { "--no-globs", "--config", os.getenv("HOME") .. "/.dotfiles/checker-files/.markdownlint-cli2.jsonc" }, }, },
      yaml = { 'yamllint' },                                                    -- linter and formatter for yaml
      json = { 'jsonlint' },                                                    -- linter and formatter for json
      --javascript = { 'ast-grep' },                                              -- linter and formatter for javascript, you can use a sub-list to tell conform to run *until* a formatter is found, e.g. javascript = { { "prettierd", "prettier" } },
      --css = { 'ast-grep' },                                                     -- linter and formatter for css
      --html = { 'ast-grep' },                                                    -- linter and formatter for html
      --cmake = { "cmakelang" },                                                  -- linter and formatter for the cmake language
      --makefile = { 'checkmake' },                                               -- linter for makefile language
      --ansible = { 'ansible-lint' },                                             -- linter for ansible language
      --docker = { 'hadolint' },                                                  -- linter for docker language
      markdown = { 'markdownlint-cli2' },                                       -- linter and formatter for markdown language
]]
--
return {
	"mfussenegger/nvim-lint",
	enabled = true, -- load the plugin if 'true' but skip completely if 'false'
	event = { "BufReadPre", "BufNewFile" }, -- linter and formatter for markdown language
	config = function() -- configuration established (i.e. callback function is called) after plugin has completed its instalation
		require("lint").setup({ -- setup will over-ride the plugin's default options & features
			linters_by_ft = {
				markdown = { "markdownlint_cli2" }, -- linter and formatter for markdown language
				lua = { "luacheck" }, -- linter for lua language
				--python = { 'pylint' },                                                    -- linter for python language
				--sh = { "shellcheck" },                                                    -- linter for bash shell language
				--json = { "jsonlint" },                                                    -- linter for json language
				--yaml = { "yamllint" },                                                    -- linter for yaml language
				--html = { "htmllint" },                                                    -- linter for html language
				-- add additional filetypes and their coresponding linter here
			},

			linters = {
				markdown = {
					markdownlint_cli2 = {
						command = "markdownlint-cli2", -- linter and formatter for markdown language
						--args = { "-" },                                                         -- '-' reads from stdin
						--args = { vim.fn.fnameescape(vim.fn.expand("%")) },                      -- these arguments passed to command,  only need the filename for linting assuming configuration file is in your home directory
						--args = { vim.fn.fnameescape(vim.fn.expand("%:p")) },                      -- these arguments passed to command,  only need the filename for linting assuming configuration file is in your home directory
						args = { "--config", vim.fn.expand("~/.config/nvim/.markdownlint-cli2.jsonc") },
						require_cwd = false, -- can run without being in project root (optional)
						--cwd = vim.fn.getcwd,                                                    -- this sets the working directory for the command, 'vim.fn.getcwd' will give you the directory of the current file, this can be useful if your '.markdownlint-cli2.jsonc' is relative to your project.
						stdin = true, -- set to 'true' because 'nvim-lint' will pipe the buffer content to 'markdownlint-cli2'
						stream = "stdout", -- markdownlint-cli2 outputs diagnostics to stdout
						-- NOTE: The default parser might work if markdownlint-cli2 outputs in a
						-- standard format that nvim-lint recognizes (like filename:line:column: message [rule-id]).
						-- If not, you'll need to write a custom parser function to process the output
						-- and create diagnostic tables that nvim-lint can understand.
						-- You should inspect the output of markdownlint-cli2 when run on a file to determine the format.
						-- Custom Parser Example:
						-- parser = function(output)
						--   local diagnostics = {}
						--   for line in output:gmatch("([^:]+):(%d+):(%d+): (.+) %[(.+)]") do
						--     local filename, lnum, col, message, code = line:match("([^:]+):(%d+):(%d+): (.+) %[(.+)]")
						--     if filename and tonumber(lnum) and tonumber(col) and message and code then
						--       table.insert(diagnostics, {
						--         row = tonumber(lnum) - 1, -- nvim-lint uses 0-based indexing
						--         col = tonumber(col) - 1,
						--         message = message .. " [" .. code .. "]",
						--         severity = "W", -- Or "E" for error, adjust as needed
						--         code = code,
						--       })
						--     end
						--   end
						--   return diagnostics
						-- end,
					},
				},
				--[[
      lua = {
        luacheck = {
          command = "luacheck",                                                 -- linter for lua language
        },
      },
      python = {
        pylint = {
          command = "pylint",                                                   -- linter for python language
        },
      },
      sh = {
        shellcheck = {
          command = "schellcheck",                                              -- linter for bash shell language
        },
      },
      json = {
        jsonlint = {
          command = "jsonlint",                                              -- linter for json language
        },
      },
]]
				--

				-- define other linters if you haven't already
			},
			-- add other nvim-lint.nvim plugin options
		})

		--[[
-- Function to manually request linting of the current buffer
function! ManuallyLintBuffer()
  lua require('lint').try_lint()
endfunction
:watch
vim.api.nvim_create_user_command('Lint', 'ManuallyLintBuffer', {})
]]
		--

		--[[
-- configure nvim-lint to trigger linting whenever you save the fil
vim.api.nvim_create_autocmd("BufWritePost", {
  --group = vim.api.nvim_create_augroup("lint_on_save", { clear = true }),
  callback = function()
    require('lint').try_lint()
    print("try_lint triggered")
  end,
})
]]
		--

		--[[
  -- create autocommand which carries out the actual linting on the specified events
  local lint_augroup = vim.api.nvim_create_augroup('lint', { clear = true })  -- 'clear = true' removes any pre-exsiting auggroup
  vim.api.nvim_create_autocmd({ 'BufEnter', 'BufWritePost', 'InsertLeave' }, {  -- trigger linting on these events
    group = lint_augroup,
    callback = function()
      require('lint').try_lint()
    end,
  })
]]
		--

		--[[
]]
		--
		-- create autocommand which carries out the actual linting on the specified events
		-- if you *do* want automatic linting on specific events (e.g., save), configure it here
		vim.api.nvim_create_autocmd({ "BufWritePost", "BufReadPost", "InsertLeave" }, {
			group = vim.api.nvim_create_augroup("nvim-lint", { clear = true }),
			--callback = function(args)
			--require('lint').try_lint(':', { bufnr = args.buf })
			callback = function()
				require("lint").try_lint()
			end,
		})

		-- request linting via keymap in normal and visual modes
		keymap("n", "<leader>cl", function()
			require("lint").try_lint()
		end, "Trigger [C]ode [L]inter for Current Buffer")
	end,
}

--[[
return {
  'mfussenegger/nvim-lint',
  enabled = true,                                                                -- load the plugin if 'true' but skip completely if 'false'
  event = { "BufReadPre", "BufNewFile" },                                        -- load the plugin when you read an existing file or new buffer is created
  config = function()
    local lint = require('lint')
    lint.linters_by_ft = {                                                       -- set up linters for specific file types
      markdown = { 'markdownlint' },                                             -- linter and formatter for markdown language
      python = { 'pylint' }
    }

    -- create autocommand which carries out the automatic linting on specified events
    local lint_augroup = vim.api.nvim_create_augroup('lint', { clear = true })   -- 'clear = true' removes any pre-exsiting auggroup
    vim.api.nvim_create_autocmd({ 'BufEnter', 'BufWritePost', 'InsertLeave' }, { -- trigger linting on these events
      group = lint_augroup,
      callback = function()
        lint.try_lint()                                                         -- try_lint() without arguments runs the linters defined in `linters_by_ft` for the current filetype, try_lint(<linter-name>) with a linter name or a list of names independent of the `linters_by_ft` configuration
      end,
    })

    -- setup a keymap so user can trigger linting manually
    keymap('n', '<leader>cl', function()
      lint.try_lint()                                                           -- try_lint() without arguments runs the linters defined in `linters_by_ft` for the current filetype, try_lint(<linter-name>) with a linter name or a list of names independent of the `linters_by_ft` configuration
    end, 'Trigger [C]ode [L]inter for Current Buffer' )

    -- linting executable and its arguments used on python files
    --require('lint').linters.python.cmd = 'python'
    --require('lint').linters.python.args = { '-m', 'pylint', '-f', 'json' }
    require('lint').linters.pylint.cmd = 'pylint'
    require('lint').linters.pylint.args = { '--output-format', 'json', '--score', 'no' }
    -- print("DEBUG: Linting Executable: " .. vim.inspect(require('lint').linters.pylint.cmd))           -- debug posted to ':messages'
    -- print("DEBUG: Linting Executable: " .. vim.inspect(require('lint').linters.pylint.args))          -- debug posted to ':messages'

    -- linting executable and its arguments used on markdown files
    require('lint').linters.markdownlint.cmd = 'markdownlint-cli2'
    require('lint').linters.markdownlint.args = { "--no-globs", "--config", os.getenv("HOME") .. "/.markdownlint-cli2.jsonc" }
    -- print("DEBUG: Linting Executable: " .. vim.inspect(require('lint').linters.markdownlint.cmd))     -- debug posted to ':messages'
    -- print("DEBUG: Linting Executable: " .. vim.inspect(require('lint').linters.markdownlint.args))    -- debug posted to ':messages'

  end,
}
--]]

--[[
    -- Markdownlint-cli2 configuration
    lint.linters.markdownlint = {
      cmd = 'markdownlint-cli2',
      stdin = true, -- Use stdin for input
      args = { '--config', vim.fn.expand('~/.markdownlint-cli2.yaml') },
      stream = 'stdout',
      ignore_exitcode = true,
      parser = require('lint.parser').from_json({
        attributes = {
          source = "markdownlint",
          severity = vim.diagnostic.severity.WARN,
        },
      }),
    }

    -- Pylint configuration
    lint.linters.pylint = {
      cmd = 'pylint',
      stdin = false, -- Pylint does not support stdin input
      args = {
        '--output-format', 'json',
        '--score', 'no', -- Disable score output
      },
      stream = 'stdout',
      ignore_exitcode = true,
      parser = function(output, bufnr)
        local decoded = vim.json.decode(output)
        local diagnostics = {}

        if not decoded then
          return diagnostics
        end

        for _, item in ipairs(decoded) do
          table.insert(diagnostics, {
            lnum = item.line - 1,  -- Convert to 0-based indexing
            col = item.column or 0,
            end_lnum = item.endLine and (item.endLine - 1) or nil,
            end_col = item.endColumn or nil,
            severity = vim.diagnostic.severity.WARN,
            message = item.message,
            source = "pylint",
          })
        end
        return diagnostics
      end,
    }
--]]

--[[
return {
  'mfussenegger/nvim-lint',
  enabled = true,                                                               -- load the plugin if 'true' but skip completely if 'false'
  optional = true,
  opts = {
    linters = {
      ["markdownlint-cli2"] = {
        args = { "--config", os.getenv("HOME") .. "/.markdownlint-cli2.jsonc", "--" },
      },
      ["luacheck"] = {},
    },
  },
--]]

--[[
    -- debug message to inspect linter output for markdownlint
    vim.api.nvim_create_user_command("LintDebug", function()
      print("DEBUG: Linter output: " .. vim.inspect(lint.linters_by_ft.markdownlint))  -- debug posted to ':messages'
    end, {})
--]]
