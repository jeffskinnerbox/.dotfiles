-- luacheck: globals vim
-- luacheck: max line length 300

-- Add custom file types to NeoVim's filetype table

--See: https://neovim.io/doc/user/lua.html#vim.filetype.add%28%29
-- [What are filetypes in Neovim? (and how to configure)](https://www.youtube.com/watch?v=NecszftvMFI)

vim.filetype.add({
	extension = { },                                                              -- put here any file extensions you want to specify and ust to map its filetype
	filename = {                                                                  -- put here any file names you want to specify and ust to map its filetype
    -- lua files
		[".luacheckrc"] = "lua",

    -- bash files
		[".bash_login"] = "sh",
		[".bash_logout"] = "sh",
		[".bash_profile"] = "sh",
		[".bashrc"] = "sh",
		[".inputrc"] = "sh",
		["bash_aliases"] = "sh",
		["bash_colors"] = "sh",
		["bash_prompt"] = "sh",

    -- stow files
		[".stow-local-ignore"] = "gitignore",
	},
	pattern = { },                                                                -- put here any file contents you want to specify and ust to map its filetype
})

