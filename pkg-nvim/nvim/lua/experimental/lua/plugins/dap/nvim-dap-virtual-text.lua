-- luacheck: globals vim
-- luacheck: max line length 300

-- Inline Debug Text
return {
  'theHamsta/nvim-dap-virtual-text',                                            -- https://github.com/theHamsta/nvim-dap-virtual-text
  enabled = false,                                                               -- load the plugin if 'true' but skip completely if 'false'
  lazy = true,
  opts = {
    commented = true,                                                           -- display debug text as a comment
    -- customize virtual text
    display_callback = function(variable, buf, stackframe, node, options)
      if options.virt_text_pos == 'inline' then
        return ' = ' .. variable.value
      else
        return variable.name .. ' = ' .. variable.value
      end
    end,
  }
}
