-- luacheck: globals vim
-- luacheck: max line length 300

return {
  'mfussenegger/nvim-dap-python',                                               -- https://github.com/mfussenegger/nvim-dap-python
  enabled = false,                                                               -- load the plugin if 'true' but skip completely if 'false'
  ft = 'python',
  dependencies = {
    'mfussenegger/nvim-dap',                                                    -- https://github.com/mfussenegger/nvim-dap
  },
  config = function ()
    require('dap-python').setup('/home/jeff/.miniconda3/bin/python3')           -- update the path passed to setup to point to your system or virtual env python binary
  end
}

