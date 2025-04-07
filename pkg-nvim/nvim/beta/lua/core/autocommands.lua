-- luacheck: globals vim
-- luacheck: max line length 400

--[[   Automatic Backup of lazy-lock.json File

  Description:
    describe what this module or plugin does

    Backups of the 'lazy-lock.json' file are stored in the directory
    :lua print(vim.fn.stdpath('data') .. '/plugin-snapshot') give you
    '/home/jeff/.local/share/nvim/lua/experimental/plugin-snapshot'.

    If something goes wrong I use the command ':BrowseSnapshots' to search for the latest working lockfile.
    Grab the commit of the plugin that broke your configuration, and copy it to the current lockfile.
    After that, I use the restore command with the name of the plugin.

  Definitions:
    definitions of phrases when it could be helpful

  Usage:
    list the most significant commandline and keymap operations

    Commandline
      :BrowseSnapshots              - search for the latest lockfile, grab the commit of the plugin that broke configuration, then copy it to the current lockfile, after that, use the restore command with the name of the plugin

      :Lazy restore <plugin-name>   - this will revert the plugin <plugin-name> to the state reflected in the 'lazy-lock.json' lockfile
      :Lazy restore                 - this will revert all the plugins to the state reflected in the 'lazy-lock.json' lockfile

    Keymapped Commands
      none that I'm using or aware of or ...
      <leader>sp               - toggle spell checking

  Alternatives:
      any similar modules or plugins

  Sources:
    See `:help lua-guide-autocommands`
    [Lazy.nvim: how to revert a plugin back to a previous version](https://dev.to/vonheikemen/lazynvim-how-to-revert-a-plugin-back-to-a-previous-version-1pdp)
]]


-- ------------------ Automatic Backup of lazy-lock.json File ------------------
local lazy_cmds = vim.api.nvim_create_augroup('lazy_cmds', {clear = true})
local snapshot_dir = vim.fn.stdpath('data') .. '/plugin-snapshot'
local lockfile = vim.fn.stdpath('config') .. '/lazy-lock.json'

-- do auto-backup of lazy-lock.json when it is updated
vim.api.nvim_create_autocmd('User', {
  group = lazy_cmds,
  pattern = 'LazyUpdatePre',
  desc = "Backup lazy.nvim lockfile 'lazy-lock.json'",

  -- pupup buffer contain list of backup files that you can pick from
  callback = function(event)
    vim.fn.mkdir(snapshot_dir, 'p')
    local snapshot = snapshot_dir .. os.date('/lazy-lock-%Y-%m-%dT%H:%M:%S.json')
    vim.loop.fs_copyfile(lockfile, snapshot)
  end,
})

-- pupup buffer contain list of backup files that you can pick from
vim.api.nvim_create_user_command(
  'BrowseSnapshots',
  'edit ' .. snapshot_dir,
  {}
)


-- ----------------- Highlight When Yanking (aka Copying) Text -----------------
-- highlight when yanking (aka copying) text
vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking (copying) text',
  group = vim.api.nvim_create_augroup('highlight-yank', { clear = true }),
  callback = function()
    vim.highlight.on_yank()
  end,
})

