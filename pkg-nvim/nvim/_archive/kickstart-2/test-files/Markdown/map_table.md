<!-- vim: ts=2 sts=2 sw=2 et                                                            -- this is called a 'modeline' - [Modeline magic](https://vim.fandom.com/wiki/Modeline_magic), [Tab settings in Vim](https://arisweedler.medium.com/tab-settings-in-vim-1ea0863c5990) -->

<!-- markdownlint-disable MD001 MD012 MD033 MD041 MD045 -->
<!-- markdownlint-configure-file { "line-length": { "line_length": 300 } } -->
<!-- markdownlint-configure-file { "hr-style": { "style": "---------------", } } -->
<!-- markdownlint-configure-file { "blanks-around-headings": { "lines_above": 2, "lines_below": 0, } } -->
<!-- see [Markdownlint Documentation](https://docs.superoffice.com/contribute/markdown-guide/markdownlint.html) -->

---------------


#### remap function

| Key | Function |
|-----|----------|


#### function for normal mode

| Key | Function |
|-----|----------|


#### function for insert mode

| Key | Function |
|-----|----------|


#### function for visual mode

| Key | Function |
|-----|----------|


#### map leader to space

| Key | Function |
|-----|----------|


#### map esc in normal mode to write and delete highlighting

| Key | Function |
|-----|----------|
| \<esc\> | :w\<CR\>:noh\<CR\> |


#### map semicolon to colon because we are lazy

| Key | Function |
|-----|----------|


#### Panel switching

| Key | Function |
|-----|----------|
| \<leader\>h | :wincmd h\<CR\> |
| \<leader\>j | :wincmd j\<CR\> |
| \<leader\>k | :wincmd k\<CR\> |
| \<leader\>l | :wincmd l\<CR\> |
| \<leader\>H | :wincmd H\<CR\> |
| \<leader\>J | :wincmd J\<CR\> |
| \<leader\>K | :wincmd K\<CR\> |
| \<leader\>L | :wincmd L\<CR\> |


#### buffer switching

| Key | Function |
|-----|----------|
| gb | :BufferLinePick\<CR\> |
| \<leader\>bx | :BufferLinePickClose\<CR\> |


#### Split resizing

| Key | Function |
|-----|----------|
| \<C-Right\> | \<C-w\>\> |
| \<C-Left\> | \<C-w\>\< |
| \<C-Up\> | \<C-w\>+ |
| \<C-Down\> | \<C-w\>- |


#### remove seach highlighting

| Key | Function |
|-----|----------|
| \<leader\>n | :noh\<CR\> |


#### Split panel

| Key | Function |
|-----|----------|
| \<leader\>v | \<C-w\>v |
| \<leader\>ws | \<C-w\>s |


#### close panels

| Key | Function |
|-----|----------|
| \<leader\>x | \<C-w\>c |


#### Line moving

| Key | Function |
|-----|----------|
| \<C-j\> | :m .+1\<CR\>== |
| \<C-k\> | :m .-2\<CR\>== |
| \<C-j\> | \<ESC\>:m .+1\<CR\>==gi |
| \<C-k\> | \<ESC\>:m .-2\<CR\>==gi |
| \<C-j\> | :m '\>+1\<CR\>gv=gv |
| \<C-k\> | :m '\<-2\<CR\>gv=gv |


#### Remap for yanking into clipboard

| Key | Function |
|-----|----------|


#### in visual mode

| Key | Function |
|-----|----------|


#### paste with correct indent

| Key | Function |
|-----|----------|
| p | ]p |


#### fix indentaion

| Key | Function |
|-----|----------|
| \<leader\>i | gg=G\<C-o\> |


#### navigate quickfix

| Key | Function |
|-----|----------|
| \<leader\>\<leader\>j | :cn\<CR\> |
| \<leader\>\<leader\>k | :cp\<CR\> |
| \<leader\>\<leader\>q | :copen\<CR\> |
| \<leader\>\<leader\>l | :.cc\<CR\> |


#### Markdown Preview control

| Key | Function |
|-----|----------|
| \<leader\>m | :MarkdownPreview\<CR\> |


#### map spelling

| Key | Function |
|-----|----------|
| \<F8\> | :setlocal spell spelllang=de,en \<return\> |
| \<F9\> | :set nospell \<return\> |


#### ctrl l to correct the last spelling mistake

| Key | Function |
|-----|----------|
| \<C-l\> | \<c-g\>u\<Esc\>[s1z=`]a\<c-g\>u |


#### open Lazygit window

| Key | Function |
|-----|----------|
| \<leader\>g | :LazyGit\<CR\> |


#### swap parameters around

| Key | Function |
|-----|----------|
| \<leader\>sw | :ISwap\<CR\> |


#### switch between the last two files with bs

| Key | Function |
|-----|----------|
| \<BS\> | \<C-^\> |


#### vimtex mappings

| Key | Function |
|-----|----------|
| \<leader\>tt | :VimtexCompile\<CR\> |
| \<leader\>tv | :VimtexView\<CR\> |
| \<leader\>tc | :VimtexTocToggle\<CR\> |
| \<leader\>te | :VimtexErrors\<CR\> |


#### Telescope mappings

| Key | Function |
|-----|----------|
| \<leader\>ff | \<cmd\>Telescope find_files\<cr\> |
| \<leader\>fp | \<cmd\>Telescope git_files\<cr\> |
| \<leader\>fg | \<cmd\>Telescope live_grep\<cr\> |
| \<leader\>fb | \<cmd\>Telescope buffers\<cr\> |
| \<leader\>fh | \<cmd\>Telescope search_history\<cr\> |
| \<leader\>fc | \<cmd\>Telescope command_history\<cr\> |
| \<leader\>fq | \<cmd\>Telescope quickfix\<cr\> |
| \<leader\>fr | \<cmd\>Telescope registers\<cr\> |
| \<leader\>fs | \<cmd\>Telescope spell_suggest\<cr\> |
| \<leader\>fo | \<cmd\>Telescope oldfiles\<cr\> |
| \<leader\>fm | \<cmd\>Telescope marks\<cr\> |
| \<leader\>fk | \<cmd\>Telescope keymaps\<cr\> |


#### Dashboard mappings

| Key | Function |
|-----|----------|
| \<leader\>fn | \<cmd\>DashboardNewFile\<cr\> |


#### Comment mappings

| Key | Function |
|-----|----------|
| \<leader\>c\<leader\> | :CommentToggle\<CR\> |
| \<leader\>c\<leader\> | :CommentToggle\<CR\> |


#### NvimTree Toggle

| Key | Function |
|-----|----------|


#### nmap("<C-b>", ":NvimTreeToggle<CR>")

| Key | Function |
|-----|----------|
| \<C-b\> | :Neotree dir=./ toggle position=left \<CR\> |


#### LSP Mappings

| Key | Function |
|-----|----------|
| gD | :lua vim.lsp.buf.declaration()\<CR\> |


#### nmap("gd", ":lua vim.lsp.buf.definition()<CR>")

| Key | Function |
|-----|----------|
| \<c-q\> | :lua vim.lsp.buf.hover()\<CR\> |
| gi | :lua vim.lsp.buf.implementation()\<CR\> |


#### nmap("<C-a>", ":lua vim.lsp.buf.signature_help()<CR>")

| Key | Function |
|-----|----------|
| \<leader\>D | :lua vim.lsp.buf.type_definition()\<CR\> |


#### nmap("<leader>rn", ":lua vim.lsp.buf.rename()<CR>")

| Key | Function |
|-----|----------|
| gr | :lua vim.lsp.buf.references()\<CR\> |
| [d | :lua vim.diagnostic.goto_prev()\<CR\> |
| ]d | :lua vim.diagnostic.goto_next()\<CR\> |
| \<leader\>q | :lua vim.lsp.diagnostic.set_loclist()\<CR\> |


#### nmap("<A-CR>", ":lua vim.lsp.buf.code_action()<CR>")

| Key | Function |
|-----|----------|


#### nmap("<A-CR>", ":CodeActionMenu <CR>")

| Key | Function |
|-----|----------|


#### Lspsaga Mappings

| Key | Function |
|-----|----------|


#### Lsp finder find the symbol definition implement reference

| Key | Function |
|-----|----------|


#### when you use action in finder like open vsplit then you can

| Key | Function |
|-----|----------|


#### use <C-t> to jump back

| Key | Function |
|-----|----------|


#### Code action

| Key | Function |
|-----|----------|


#### Rename

| Key | Function |
|-----|----------|


#### Definition preview

| Key | Function |
|-----|----------|


#### Show line diagnostics

| Key | Function |
|-----|----------|


#### Show cursor diagnostic

| Key | Function |
|-----|----------|


#### Diagnsotic jump can use `<c-o>` to jump back

| Key | Function |
|-----|----------|


#### Outline

| Key | Function |
|-----|----------|


#### Hover Doc

| Key | Function |
|-----|----------|


#### Show diagnostics

| Key | Function |
|-----|----------|


#### Flutter Developement

| Key | Function |
|-----|----------|
| \<leader\>Fa | \<cmd\>FlutterRun\<CR\> |
| \<leader\>Fq | \<cmd\>FlutterQuit\<CR\> |
| \<leader\>Fr | \<cmd\>FlutterReload\<CR\> |
| \<leader\>FR | \<cmd\>FlutterRestart\<CR\> |
| \<leader\>FD | \<cmd\>FlutterVisualDebug\<CR\> |
| \<leader\>FF | \<cmd\>FlutterCopyProfilerUrl\<CR\> |


#### ToggleTerm

| Key | Function |
|-----|----------|


#### Code formatter

| Key | Function |
|-----|----------|
| \<leader\>fr | :Neoformat\<CR\> |


#### Dap debugger

| Key | Function |
|-----|----------|


#### nmap("<leader>br", ":lua require('dap').toggle_breakpoint()<CR>")

| Key | Function |
|-----|----------|


#### nmap("<leader>co", ":lua require('dap').continue()<CR>")

| Key | Function |
|-----|----------|


#### nmap("<leader>so", ":lua require('dap').step_over()<CR>")

| Key | Function |
|-----|----------|


#### nmap("<leader>si", ":lua require('dap').step_into()<CR>")

| Key | Function |
|-----|----------|


#### nmap("<leader>re", ":lua require('dap').repl.open()<CR>")

| Key | Function |
|-----|----------|


#### nmap("<leader>re", ":lua require('dap').repl.open()<CR>")

| Key | Function |
|-----|----------|


#### nmap("<c-x>", ':lua require("dapui").toggle()<CR>')

| Key | Function |
|-----|----------|


#### Session saving and loading

| Key | Function |
|-----|----------|
| \<Leader\>ss | :\<C-u\>SessionSave\<CR\> |
| \<Leader\>sl | :\<C-u\>SessionLoad\<CR\> |


#### Edit the snippet files

| Key | Function |
|-----|----------|
| \<Leader\>se | :SnippetsEdit\<CR\> |


#### shortcut to write and close all buffers

| Key | Function |
|-----|----------|
| ZA | :wqa\<CR\> |


#### searching with leap

| Key | Function |
|-----|----------|
| \<Leader\>a | \<Plug\>(leap-forward) |
| \<Leader\>A | \<Plug\>(leap-backward) |


#### spell suggest

| Key | Function |
|-----|----------|


#### nmap("\\s", "a<C-X><C-S>")

| Key | Function |
|-----|----------|


#### clear all notifications

| Key | Function |
|-----|----------|
| \<Leader\>\<Leader\>x | :lua require('notify').dismiss()\<cr\> |


#### toggle virtual text

| Key | Function |
|-----|----------|
| \<Leader\>u | :VirtualTextToggle\<CR\> |


#### Compile and run code

| Key | Function |
|-----|----------|


#### Neorg maps

| Key | Function |
|-----|----------|


#### grapple.nvim

| Key | Function |
|-----|----------|
