local M = {}

local sqlite = require "sqlite"
local db = sqlite.new(os.getenv "HOME" .. "/test_db")

local bookmarks = db:tbl("bookmarks", {
  id = { type = "integer", primary = true },
  url = "text",
  title = "text",
})

print(vim.inspect(bookmarks))

M.add_bookmark = function(url, title)
  bookmarks:insert { url = url, title = title }
end

M.get_bookmarks = function()
  local all = bookmarks:map(function(row)
    return { row.id, row.url, row.title }
  end)
  print(vim.inspect(all))
  return all
end

lvim.builtin.which_key.mappings["."] = {
  '<cmd>lua require("user.sqtest2").add_bookmark("https://www.example.com", "Example Website")<CR>',
  "Comment",
}

lvim.builtin.which_key.mappings["a"] = {
  '<cmd>lua require("user.sqtest2").get_bookmarks("https://www.example.com", "Example Website")<CR>',
  "Comment",
}

return M

-- function update_bookmark(id, url, title)
--   db:update("bookmarks", { where = { id = id }, set = { url = url, title = title } })
-- end

-- update_bookmark(1, "https://www.newurl.com", "New Title")

-- function delete_bookmark(id)
--   db:delete("bookmarks", { id = id })
-- end

-- delete_bookmark(1)
