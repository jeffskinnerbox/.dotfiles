-- luacheck: globals vim
-- luacheck: max line length 300

--[[
    luacheck tries to load configuration from `.luacheckrc` file in the current directory.
    If not found, it will look for it in the parent directory and so on,
    going up until it reaches file system root. Path to config can be set using `fig option`,
    in which case it will be used during recursive loading.
    Paths within config are interpreted relatively to the directory from which it was loaded.

    If neither of `--config`, `--no-config`, and `--no-default-config` options are used,
    luacheck will attempt to load configuration from value of `--default-config` option,
    or `$XDG_CONFIG_HOME/luacheck/.luacheckrc` or `~/.config/luacheck/.luacheckrc` on Linux systems.

    Sources:
        LuaCheck Documentation
          Configuration File - https://luacheck.readthedocs.io/en/stable/config.html
          List of warnings - https://luacheck.readthedocs.io/en/stable/warnings.html
]]

max_line_length = 300

std = "max"

local ignore = {
  "612", -- A line contains trailing whitespace
  "631", -- line is too long
}

include_files = {
    "*.lua",
    "**/*.lua",
}

globals = {"vim", }                       -- these globals can be set and accessed

read_globals = { }                          -- these globals can only be accessed
