
--------------------------------------------------------------------------------
-- active/markdown-preview.lua

-- Preview markdo on your modern browser with synchronised scrolling,
-- flexible configuration, and fast asynchronous updates.

-- Commandline
--    :MarkdownPreview'         - open markdown preview
--    :MarkdownPreviewStop'     - stop the preview
--    :MarkdownPreviewToggle'   - toggle open/close markdown preview
--    :MarkdownPreviewClose'    - close markdown preview

-- Sources:
--   [GitHub: iamcco/markdown-preview.nvim](https://github.com/iamcco/markdown-preview.nvim)
--   [Markdown Preview](https://docs.rockylinux.org/books/nvchad/plugins/md_preview/#markdown-preview)
--------------------------------------------------------------------------------


-- if you haven't loaded this plugin, do no operation and return
--local status_ok, nvim_tree = pcall(require, 'markdown_preview')
--if not status_ok then
  --print("'configs/markdown-preview.lua' module had an error")
  --return
--end


-- function that wraps vim.api.nvim_set_keymap command into something easy to use
-- keymap(<mode>, <key-to-bind>, <action-wanted>, <options>)
-- example:  keymap('n', '<leader>sp', ':setlocal spell!<cr>', opts)  -- toggle on/off spell checking
local keymap = function(mode, key, result, options)
  vim.api.nvim_set_keymap(
    mode,                 -- mode can be 'n' = normal mode, 'i' = insert mode, 'v' = visual mode, 'x' = visual block mode, 't' = term mode, 'c' = command mode
    key,                  -- key sequence to trigger result
    result,               -- command or key subsituation to be made
    options               -- keymap options
  )
end

-- potential values for 'options'
local opts = { noremap = true, silent = true }
local expr_opts = { noremap = true, expr = true, silent = true }
local term_opts = { silent = true }


-- key mappings for markdown preview in modern browser
keymap('n', '<leader>mp', '<cmd>MarkdownPreview<cr>', opts)       -- open markdown preview
keymap('n', '<leader>mt', '<cmd>MarkdownPreviewToggle<cr>',opts)  -- toggle open/close markdown preview
keymap('n', '<leader>mc', '<cmd>MarkdownPreviewStop<cr>',opts)    -- close markdown preview


-- ********************** IT APPEARS THIS CAUSE PROBLEMS ***********************

---- alias the vim.opt meta-accessor to a local Lua variable
--local o = vim.opt                      -- globally scoped editor variables
--local g = vim.g                        -- globally scoped editor variables
--local b = vim.bo                       -- buffer scoped
--local w = vim.wo                       -- window scoped
--
---- set to 1, nvim will open the preview window after entering the markdown buffer
--g.mkdp_auto_start = 0                  -- default: 0
--
---- set to 1, the nvim will auto close current preview window when change from markdown buffer to another buffer
--g.mkdp_auto_close = 1                  -- default: 1
--
---- set to 1, the vim will refresh markdown when save the buffer or leave from insert mode, default 0 is auto refresh markdown as you edit or move the cursor
--g.mkdp_refresh_slow = 0                -- default: 0
--
---- set to 1, the MarkdownPreview command can be use for all files, by default it can be use in markdown file
--g.mkdp_command_for_global = 0          -- default: 0
--
---- set to 1, preview server available to others in your network by default, the server listens on localhost (127.0.0.1)
--g.mkdp_open_to_the_world = 0           -- default: 0
--
---- use custom IP to open preview page useful when you work in remote vim and preview on local browser more detail see: https://github.com/iamcco/markdown-preview.nvim/pull/9
--g.mkdp_open_ip = ''                    -- default: ''
--
---- specify browser to open preview page for path with space - valid: `/path/with\ space/xxx`, invalid: `/path/with\\ space/xxx`
--g.mkdp_browser = '/usr/bin/google-chrome' -- default: ''
--
---- set to 1, echo preview page url in command line when open preview page
--g.mkdp_echo_preview_url = 0            -- default: 0
--
---- a custom vim function name to open preview page this function will receive url as param
--g.mkdp_browserfunc = ''                -- default: ''
--
---- use a custom markdown style must be absolute path like '/Users/username/markdown.css' or expand('~/markdown.css')
--g.mkdp_markdown_css = ''
--
---- use a custom highlight style must absolute path like '/Users/username/highlight.css' or expand('~/highlight.css')
--g.mkdp_highlight_css = ''
--
---- use a custom port to start server or empty for random
--g.mkdp_port = ''
--
---- preview page title ${name} will be replace with the file name
--g.mkdp_page_title = '「${name}」'
--
---- recognized filetypes these filetypes will have MarkdownPreview... commands
--g.mkdp_filetypes = 'markdown'
--
---- set default theme (dark or light), by default the theme is define according to the preferences of the system
--g.mkdp_theme = 'light'
--
---- options for markdown rendering
----     mkit: markdown-it options for render
----     katex: katex options for math
----     uml: markdown-it-plantuml options
----     maid: mermaid options
----     disable_sync_scroll: if disable sync scroll, default 0
----     sync_scroll_type: 'middle', 'top' or 'relative', default value is 'middle'
----         middle: mean the cursor position alway show at the middle of the preview page
----         top: mean the vim top viewport alway show at the top of the preview page
----         relative: mean the cursor position alway show at the relative positon of the preview page
----     hide_yaml_meta: if hide yaml metadata, default is 1
----     sequence_diagrams: js-sequence-diagrams options
----     flowchart_diagrams: js-flowchart-diagrams options
----     content_editable: if enable content editable for preview page, default: v:false
----     disable_filename: if disable filename header for preview page, default: 0
--vim.cmd([[let g:mkdp_preview_options = {
--    \ 'mkit': {},
--    \ 'katex': {},
--    \ 'uml': {},
--    \ 'maid': {},
--    \ 'disable_sync_scroll': 0,
--    \ 'sync_scroll_type': 'middle',
--    \ 'hide_yaml_meta': 1,
--    \ 'sequence_diagrams': {},
--    \ 'flowchart_diagrams': {},
--    \ 'content_editable': v:false,
--    \ 'disable_filename': 0,
--    \ 'toc': {}
--    \ }]])

