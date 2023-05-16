M = {}

local db = require "sqlite.db" --- for constructing sql databases
local tbl = require "sqlite.tbl" --- for constructing sql tables
local uri = "/home/chris/.config/lvim/test_db" -- defined here to be deleted later

local julianday = db.lib.julianday
local strftime = db.lib.strftime

local entries = tbl("entries", {
  id = true,
  filepath = { "text", required = true },
  linenumbers = { "text", required = true },
})

local bookmark_db = db {
  uri = uri,
  entries = entries,
  opts = {},
}

function entries:add(row)
  local id = entries:insert(row)
  return id
end

function entries:get()
  -- local rows = todos:map(function(row)
  --   row.somekey = ""
  --   row.f = callfunction(row)
  --   return row
  -- end, {
  --   where = { status = "pending" },
  --   contains = { title = "fix*" },
  -- })
  --- This works too.
  -- local titles = todos:map({ where = { ... } }, function(row)
  --   return row.title
  -- end)
  --- no query, no problem :D
  local all = entries:map(function(row)
    return row.filepath
  end)

  return all

  -- return entries
end

local test = {
  { filepath = "/home/chris/.config/lvim/config.lua", linenumbers = "3,7" },
  { filepath = "/home/chris/.config/lvim/lua/user/bqf.lua.lua", linenumbers = "1,4" },
  { filepath = "/home/chris/.config/lvim/lua/user/git.lua", linenumbers = "2,5" },
  { filepath = "/home/chris/.config/lvim/lua/user/dial.lua", linenumbers = "6,9" },
}

function entries:seed()
  for _, row in ipairs(test) do
    entries:add(row)
  end
end

if entries:count() == 0 then
  entries:seed()
end

M.get_bookmarks = function()
  print(vim.inspect(entries:get()))
end

return M
