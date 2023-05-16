local M = {}

local sqlite = require "sqlite"
local tbl = require "sqlite.tbl" --- for constructing sql tables
local uri = os.getenv "HOME" .. "/test_db"

local projects = tbl("projects", {
  id = true,
  path = { "text", required = true },
})

local bookmarks = tbl("bookmarks", {
  id = true,
  project_id = { "integer", references = "projects.id" },
  file_path = { "text", required = true },
  line_numbers = { "text", required = true },
})

local db = sqlite {
  uri = uri,
  projects = projects,
  bookmarks = bookmarks,
  opts = {},
}

local function get_project_id(path)
  local project = projects:where { path = path }
  if project then
    return project.id
  else
    return projects:insert { path = path }
  end
end

M.add_bookmark = function(file_path, line_numbers)
  local project_id = get_project_id(vim.fn.getcwd())
  bookmarks:insert { project_id = project_id, file_path = file_path, line_numbers = line_numbers }
end

M.get_bookmarks = function()
  local project_id = get_project_id(vim.fn.getcwd())
  local all = bookmarks:where({ project_id = project_id })

  --   :map(function(row)
  --   return { row.id, row.project_id, row.file_path, row.line_numbers }
  -- end)
  print(vim.inspect(all))
  -- return all
end

lvim.builtin.which_key.mappings["."] = {
  '<cmd>lua require("user.sqtest2").add_bookmark("/Users/chris/.config/lvim/config.lua", "3,4")<CR>',
  "Comment",
}

lvim.builtin.which_key.mappings["a"] = {
  '<cmd>lua require("user.sqtest2").get_bookmarks()<CR>',
  "Comment",
}

vim.api.nvim_command "autocmd VimLeave * lua db:close()"

return M

-- function update_bookmark(id, url, title)
--   db:update("bookmarks", { where = { id = id }, set = { url = url, title = title } })
-- end

-- update_bookmark(1, "https://www.newurl.com", "New Title")

-- function delete_bookmark(id)
--   db:delete("bookmarks", { id = id })
-- end

-- delete_bookmark(1)
