-- luacheck: globals vim
-- luacheck: max line length 300

--[[ Lightweight yet powerful formatter plugin for Neovim
kickstart2/lua/kickstart/plugins/conform.lua

  Description:
    This is is a lightweight, yet powerful, formatter plugin for Neovim.
    It is a good alternative to null-ls.nvim in terms of formatting.

  Definitions:
    Definitions of phrases when it could be helpful.

  Usage:
    Commandline
      None that I'm using or aware of.

    Keymapped Commands
      None that I'm using or aware of.

  Sources:
    [GitHub: stevearc/conform.nvim](https://github.com/stevearc/conform.nvim)
    [How I Setup LSP In Neovim For An Amazing Dev Experience - Full Guide](https://www.youtube.com/watch?v=NL8D8EkphUw)
    [How To Setup Linting And Formatting In Neovim To Replace null-ls](https://www.youtube.com/watch?v=ybUE4D80XSk)
    [Configure Linting, Formatting, and Autocompletion in Neovim](https://levelup.gitconnected.com/configure-linting-formatting-and-autocompletion-in-neovim-a2cf15e2e04d)
    [Neovim Plugins and Configuration Recipes | 3](https://alpha2phi.medium.com/neovim-plugins-and-configuration-recipes-3-c597be9d46ac)
    [feat: Command to disable formatting #192](https://github.com/stevearc/conform.nvim/issues/192)
    [How to disable autoformating on save on LazyVim?](https://vi.stackexchange.com/questions/42597/how-to-disable-autoformating-on-save-on-lazyvim)

  NOTE: Make sure that nvim-lspconfig.lua, mason.lua, conform.lua, and nvim-lint.lua all agree on what linter & formatter will be used for each filetype
]]

-- function that wraps 'vim.api.nvim_set_keymap' command into something easy to use, or better yet, uses 'vim.keymap.set' - keymap(<mode>, <key-to-bind>, <action-wanted>, <options>)
-- [vim.api.nvim_set_keymap() vs. vim.keymap.set() - what's the difference?](https://www.reddit.com/r/neovim/comments/xvp7c5/vimapinvim_set_keymap_vs_vimkeymapset_whats_the/)
local keymap = function(mode, key, result, options)
	vim.keymap.set(
		mode, -- aka {mode},  can be 'n' = normal mode, 'i' = insert mode, 'v' = visual mode, 'x' = visual block mode, 't' = term mode, 'c' = command mode
		key, -- aka {lhs}, key sequence to trigger result
		result, -- aka {rhs}, command or key subsituation to be made
		{ desc = "Formatter: " .. options } -- aka {opts}, keymap discription, 'Formatter:' means this is a code formatting function
	)
end

return {
	"stevearc/conform.nvim",
	enabled = true, -- load the plugin if 'true' but skip completely if 'false'
	event = { "BufReadPre", "BufNewFile" }, -- load the plugin when you read an existing file or new buffer is created
	config = function()
		local conform = require("conform")
		conform.setup({
			-- NOTE: make sure all these formatters are are loaded by Mason
			formatters_by_ft = { -- this table maps filetypes (like lua, python, markdown) to a list of formatters that should be used for that filetype, the formatter must be on the list given by ' :help conform-formatters'
				markdown = { "markdownlint_cli2" }, -- formatter for markdown language
				lua = { "stylua" }, -- formatter for the Lua language
				--python = { 'isort', 'black' },                                          -- conform can also run multiple formatters sequentially, order is important
				--bash = { "beautysh" },                                                    -- formatter for bash shell language
				--json = { 'prettier' },                                                  -- formatter for json
				--yaml = { 'prettier' },                                                  -- formatter for yaml
				--yaml = { 'yamlfix' },                                                   -- formatter for yaml
				--cpp = { 'ast-grep' },                                                   -- formatter for the c++ language
				--cpp = { 'clang-format' },                                               -- formatter for the c++ language
				--css = { 'prettier' },                                                   -- formatter for css
				--html = { 'prettier' },                                                  -- formatter for html
				-- add other filetypes & formatters as needed here
			},

			-- NOTE: make sure all these formatters are are loaded by Mason
			formatters = { -- this table defines the configuration for each individual formatter
				markdownlint_cli2 = {
					command = "markdownlint-cli2", -- the executable command to run
					--args = { "--fix", vim.fn.fnameescape(vim.fn.expand("%:p")) },           -- '--fix' tells markdownlint-cli2 to automatically fix any linting issues it can, 'vim.fn.fnameescape(vim.fn.expand("%"))' get the currently open file's path and escapes any special characters to ensure it's passed correctly to the command
					--args = { "--fix", "-" },                                              -- '-' reads from stdin, '--fix' applies fixes
					args = { "--fix", "--config", vim.fn.expand("~/.config/nvim/.markdownlint-cli2.jsonc"), "-" }, -- cat *.md | markdownlint-cli2 --fix, --config /home/jeff/.markdownlint-cli2.jsonc -
					require_cwd = false, -- can run without being in project root (optional)
					--cwd = vim.fn.getcwd(),                                                  -- this sets the current working directory for the command, 'vim.fn.getcwd()' will be current working directory of the neovim process
					--local cwd = vim.fn.getcwd(),                                                  -- this sets the current working directory for the command, 'vim.fn.getcwd()' will be current working directory of the neovim process
					--print("Current working directory: ", cwd)
					stdin = true, -- set to 'true' because 'conform.nvim' will pipe the buffer content to 'markdownlint-cli2'
				},
				lua = {},
				python = {},
				bash = {},
				json = {},
				-- add additional formatters as needed
			},

			format_on_save = { -- should you format when you save the file
				lsp_fallback = vim.g.auto_format_on_save, -- 'false' means do not format on save, you must request via keymap below, 'true' means if a formatter is not available for the file type then fallback to formatting via the LSP, 'false' means no fallback to LSP
				async = false, -- when set to 'false' formatting will not be asynchronous
				timeout_ms = 500, -- timeout when 'async = true' (default is 1000)
			},
		})

		keymap({ "n", "v" }, "<leader>cf", function()
			conform.format({
				lsp_fallback = true, -- 'false' means do not format on save, you must request via keymap below, 'true' means if a formatter is not available for the file type then fallback to formatting via the LSP, 'false' means no fallback to LSP
				async = false, -- when set to 'false' formatting will not be asynchronous
				timeout_ms = 500, -- timeout when 'async = true' (default is 1000)
			})
		end, "[C]ode [F]ormatting for Whole File or Range")

		-- disable auto formatting on save, see [feat: Command to disable formatting #192](https://github.com/stevearc/conform.nvim/issues/192)
		vim.api.nvim_create_user_command("ToggleFormatting", function(args)
			if args.bang then -- ToggleFormatting! will toggle formatting just for this buffer
				if vim.b.disable_autoformat then
					vim.b.disable_autoformat = false -- enable formatting for just this buffer
				else
					vim.b.disable_autoformat = true -- disable formatting for just this buffer
				end
			else
				if vim.g.disable_autoformat then
					vim.g.disable_autoformat = false -- enable formatting for all buffer
				else
					vim.g.disable_autoformat = true -- disable formatting for all buffer
				end
			end
		end, {
			desc = "Toggle Autoformatting on Save (aka ToggleFormatting)",
			bang = true,
		})

		-- toggle on/off auto formatting on save, default is 'no formatting'
		keymap("n", "<leader>Tfa", "<cmd>ToggleFormatting<cr>", { desc = "[T]oggle [F]Formatting on [A]ll Buffers" }) -- toggle code formatting for all languages & buffers
		keymap("n", "<leader>Tfb", "<cmd>ToggleFormatting!<cr>", { desc = "[T]oggle [F]Formatting Only This [B]uffer" }) -- toggle code formatting for only this buffer
	end,
}

--[[
return {
	"stevearc/conform.nvim",
	enabled = true, -- load the plugin if 'true' but skip completely if 'false'
	event = { "BufReadPre", "BufNewFile" }, -- load the plugin when you read an existing file or new buffer is created
	config = function() -- configuration established (i.e. callback function is called) after plugin has completed its instalation
    local conform = require('conform')
    conform.setup({ -- setup will over-ride the plugin's default options & features
			-- NOTE: make sure all these formatters are are loaded by Mason
			conform.formatters_by_ft = { -- this table maps filetypes (like lua, python, markdown) to a list of formatters that should be used for that filetype, the formatter must be on the list given by ' :help conform-formatters'
				markdown = { "markdownlint_cli2" }, -- formatter for markdown language
				lua = { "stylua" }, -- formatter for the Lua language
				--python = { 'isort', 'black' },                                          -- conform can also run multiple formatters sequentially, order is important
				--bash = { "beautysh" },                                                    -- formatter for bash shell language
				--json = { 'prettier' },                                                  -- formatter for json
				--yaml = { 'prettier' },                                                  -- formatter for yaml
				--yaml = { 'yamlfix' },                                                   -- formatter for yaml
				--cpp = { 'ast-grep' },                                                   -- formatter for the c++ language
				--cpp = { 'clang-format' },                                               -- formatter for the c++ language
				--css = { 'prettier' },                                                   -- formatter for css
				--html = { 'prettier' },                                                  -- formatter for html
				-- add other filetypes & formatters as needed here
			},

			-- NOTE: make sure all these formatters are are loaded by Mason
			conform.formatters = { -- this table defines the configuration for each individual formatter
				markdownlint_cli2 = {
					command = "markdownlint-cli2", -- the executable command to run
					--args = { "--fix", vim.fn.fnameescape(vim.fn.expand("%:p")) },           -- '--fix' tells markdownlint-cli2 to automatically fix any linting issues it can, 'vim.fn.fnameescape(vim.fn.expand("%"))' get the currently open file's path and escapes any special characters to ensure it's passed correctly to the command
					--args = { "--fix", "-" },                                              -- '-' reads from stdin, '--fix' applies fixes
					args = { "--fix", "--config", vim.fn.expand("~/.config/nvim/.markdownlint-cli2.jsonc"), "-" }, -- cat *.md | markdownlint-cli2 --fix, --config /home/jeff/.markdownlint-cli2.jsonc -
					require_cwd = false, -- can run without being in project root (optional)
					--cwd = vim.fn.getcwd(),                                                  -- this sets the current working directory for the command, 'vim.fn.getcwd()' will be current working directory of the neovim process
					--local cwd = vim.fn.getcwd(),                                                  -- this sets the current working directory for the command, 'vim.fn.getcwd()' will be current working directory of the neovim process
					--print("Current working directory: ", cwd)
					stdin = true, -- set to 'true' because 'conform.nvim' will pipe the buffer content to 'markdownlint-cli2'
				},
      lua = {
      },
      python = {
      },
      bash = {
      },
      json = {
      },
      -- add additional formatters as needed
			},

			format_on_save = { -- should you format when you save the file
				lsp_fallback = vim.g.auto_format_on_save, -- 'false' means do not format on save, you must request via keymap below, 'true' means if a formatter is not available for the file type then fallback to formatting via the LSP, 'false' means no fallback to LSP
				async = false, -- when set to 'false' formatting will not be asynchronous
				timeout_ms = 500, -- timeout when 'async = true' (default is 1000)
			},
		})
		-- add other conform.nvim plugin features

		-- request formatting via keymap in normal and visual modes
		keymap({ "n", "v" }, "<leader>cf", function()
			require("conform").format({
				lsp_fallback = true, -- 'false' means do not format on save, you must request via keymap below, 'true' means if a formatter is not available for the file type then fallback to formatting via the LSP, 'false' means no fallback to LSP
				async = false, -- when set to 'false' formatting will not be asynchronous
				timeout_ms = 500, -- timeout when 'async = true' (default is 1000)
			})
		end, "[C]ode [F]ormatting for Whole File or Range")

		-- request formatting via keymap in normal and visual modes
		keymap({ "n", "v" }, "<leader>cf", "<cmd>Conform<CR>", "[C]ode [F]ormatting for Whole File or Range")

		-- toggle on/off auto formatting on save, default is 'off' aka 'no formatting'
		keymap("n", "<leader>Tfa", "<cmd>ToggleFormatting<cr>", { desc = "[T]oggle [F]Formatting on [A]ll Buffers" }) -- toggle code formatting for all languages & buffers
		keymap("n", "<leader>Tfb", "<cmd>ToggleFormatting!<cr>", { desc = "[T]oggle [F]Formatting Only This [B]uffer" }) -- toggle code formatting for only this buffer
	end,
}
]]
--
