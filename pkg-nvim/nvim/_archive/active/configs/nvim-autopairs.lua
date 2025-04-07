
--------------------------------------------------------------------------------
-- active/nvim-autopairs.lua

-- This plugin does auto-pairing. Auto-pairing is when you type in a character
-- that should be paired in code, and the editor automatically ensures the
-- paired character is also inserted. Auto-pairing is done for the characters
-- '(', '{', '[', '"', and ' itself.

-- Sources:
--    [GitHub: windwp/nvim-autopairs](https://github.com/windwp/nvim-autopairs)
--    [Neovim for Beginners— Auto Pairs](https://alpha2phi.medium.com/neovim-for-beginner-auto-pairs-c09e87a4d511)
--    [Neovim - Autopairs automatically close () [] {} '' ""](https://www.youtube.com/watch?v=_hbvvBgXlBo)
--------------------------------------------------------------------------------


-- if you haven't loaded this plugin, do no operation and return
local status_ok, npairs = pcall(require, 'nvim-autopairs')
if not status_ok then
  print("'configs/nvim-autopairs.lua' module had an error")
  return
end


npairs.setup {
  check_ts = true,
  ts_config = {                                                    -- make it telescope aware
    lua = { 'string', 'source' },
    javascript = { 'string', 'template_string' },
    java = false,
  },
  disable_filetype = { 'TelescopePrompt', 'spectre_panel' },       -- disable for these filetypes
  fast_wrap = {
    map = '<M-e>',
    chars = { '{', '[', '(', '"', "'" },                           -- characters that are auto-paired
    pattern = string.gsub([[ [%'%'%)%>%]%)%}%,] ]], '%s+', ''),
    offset = 0, -- Offset from pattern match
    end_key = '$',                                                 -- end-of-line key
    keys = 'qwertyuiopzxcvbnmasdfghjkl',
    check_comma = true,
    highlight = 'PmenuSel',
    highlight_grey = 'LineNr',
  },
}

-- cmp completions integration (un-comment below if you are using cmp)
--local cmp_autopairs = require 'nvim-autopairs.completion.cmp'
--local cmp_status_ok, cmp = pcall(require, 'cmp')
--if not cmp_status_ok then
  --return
--end
--cmp.event:on('confirm_done', cmp_autopairs.on_confirm_done { map_char = { tex = '' } })

