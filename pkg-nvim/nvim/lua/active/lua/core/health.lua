-- luacheck: globals vim
-- luacheck: max line length 300

--[[ Module to perefrom basic health check operation for your NeoVim configuration
kickstart2/lua/kickstart/health.lua

  Description:
    This file is not required for your own configuration,
    but helps people determine if their system is setup correctly.

  Sources:
    [CheckHealth in Neovim](http://vimcasts.org/episodes/neovim-checkhealth/)
    [Pi_health](https://neovim.io/doc/user/pi_health.html)
    [Vim 101: runtimepath](https://medium.com/usevim/vim-101-runtimepath-83194d411b0a)
    [What's The Vim Runtime? A Guide With Examples](https://thevaluable.dev/vim-runtime-guide-example/)
    [Where can I check my neovim lua 'runtimepath'?](https://stackoverflow.com/questions/73358168/where-can-i-check-my-neovim-lua-runtimepath)
]]


-- check the version of neovim that will be used
local check_version = function()
  local verstr = string.format('%s.%s.%s', vim.version().major, vim.version().minor, vim.version().patch)
  if not vim.version.cmp then
    vim.health.error(string.format("NeoVim out of date: '%s'. Upgrade to latest stable or nightly", verstr))
    return
  end

  if vim.version.cmp(vim.version(), { 0, 9, 4 }) >= 0 then
    vim.health.ok(string.format("NeoVim version is: '%s'\n", verstr))
  else
    vim.health.error(string.format("NeoVim out of date: '%s'. Upgrade to latest stable or nightly\n", verstr))
  end
end

-- check for the installation of basic utils like `git`, `make`, `unzip`, ...
local check_external_reqs = function()
  vim.health.ok(string.format("Checking for installation of required utilities:"))
  for _, exe in ipairs { 'git', 'make', 'unzip', 'rg', 'luarocks', 'nodejs', 'pip', 'ruby', 'gem', 'npm', 'yarn', 'fzf' } do
    local is_executable = vim.fn.executable(exe) == 1
    if is_executable then
      vim.health.ok(string.format("Found executable: '%s'", exe))
    else
      vim.health.warn(string.format("Could not find executable: '%s'", exe))
    end
  end
  return true
end

--------------------------------------------------------------------------------

return {
  check = function()
    vim.health.start 'kickstart.nvim'

    vim.health.info [[NOTE: Not every warning is a 'must-fix' in `:checkhealth`

      Fix only warnings for plugins and languages you intend to use.
      Mason will give warnings for languages that are not installed.
      You do not need to install, unless you want to use those languages!
      ]]

    local uv = vim.uv or vim.loop
    vim.health.info('NOTE: System Information: ' .. vim.inspect(uv.os_uname()) .. '\n')
    vim.health.info('NOTE: Spell File: ' .. tostring(vim.opt.spellfile) .. '\n')
    vim.health.info('NOTE: Undo Directory: ' .. vim.opt.undodir .. '\n')
    vim.health.info('NOTE: Swap Directory: ' .. vim.opt.directory .. '\n')
    vim.health.info('NOTE: Backup Directory: ' .. vim.opt.backupdir .. '\n')
    vim.health.info('NOTE: Command to Start Python: ' .. vim.g.python3_host_prog .. '\n')
    vim.health.info('NOTE: Runtime Path: ' .. vim.api.nvim_list_runtime_paths() .. '\n')   -- :lua print(vim.inspect(vim.api.nvim_list_runtime_paths())) NOTE: print runtimepath via commandline :echo &runtimepath'

    check_version()
    check_external_reqs()
  end,
}

