-- LuaCheck `.luacheckrc` file
-- BUG: DOES NOT WORK - This file isn't being picked up by NeoVim's linting process

-- LuaCheck tries to load configuration from `.luacheckrc` file in the current directory.
-- If not found, it will look for it in the parent directory and so on,
-- going up until it reaches file system root. - https://luacheck.readthedocs.io/en/stable/config.html


-- The `std` option allows setting a custom standard set of globals using a table.
-- This table can have two fields: `globals` and `read_globals`.
-- Both of them should contain a field definition map defining some globals.
-- The simplest way to define globals is to list their names:
std = {
   globals = {  },                 -- these globals can be set and accessed
   read_globals = { "vim", }       -- these globals can only be accessed
}

-- suppress complaints about line length unless greater than 300
max_code_line_length = 300

-- filtering warnings using pattern matching on warning codes, variable names, or both
ignore = {  }


