-- luacheck: globals vim
-- luacheck: max line length 300
-- vim: ts=2 sts=2 sw=2 et                                                      -- this is called a 'modeline' - [Modeline magic](https://vim.fandom.com/wiki/Modeline_magic), [Tab settings in Vim](https://arisweedler.medium.com/tab-settings-in-vim-1ea0863c5990)

--[[ Module to perefrom basic health check operation for your NeoVim
kickstart2/lua/kickstart/health.lua

  Description:
    This file is not required for your own configuration,
    but helps people determine if their system is setup correctly.

    [CheckHealth in Neovim](http://vimcasts.org/episodes/neovim-checkhealth/)
    [Pi_health](https://neovim.io/doc/user/pi_health.html)
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
  for _, exe in ipairs { 'git', 'make', 'unzip', 'rg' } do
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

    check_version()
    check_external_reqs()
  end,
}

