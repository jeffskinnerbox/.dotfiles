
require('options')                    -- assign values to neovim options
require('plugins')                    -- installs all your plugin via lazy.nvim


-- TODO: remove this code
-- manually start a C language server
vim.api.nvim_create_autocmd("BufEnter", {
    callback = function()
        vim.lsp.start({
            name = "clangd",
            cmd = { "/home/jeff/tmp/clangd/clangd_18.1.3/bin/clangd" },
            root_dir = vim.fn.getcwd(),
        })
    end,
})

