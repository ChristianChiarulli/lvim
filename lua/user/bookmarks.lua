local M = {}

local bookmarks = {}
local sign_lookup = {}

vim.cmd [[
    command! BookmarkToggle lua require'user.bookmarks'.toggle_bookmark()
    command! BookmarkNext lua require'user.bookmarks'.next_bookmark()
    command! BookmarkPrev lua require'user.bookmarks'.previous_bookmark()
]]

-- Define a sign
vim.fn.sign_define("BookmarkSign", { text = "", texthl = "Function" })

-- Place the sign
local function add_sign(line, sign_name)
  return vim.fn.sign_place(0, "Bookmarks", sign_name, vim.api.nvim_buf_get_name(0), { lnum = line })
end

local function get_current_line()
  return vim.api.nvim_win_get_cursor(0)[1]
end

-- Toggle Bookmark
function M.toggle_bookmark()
  local current_file = vim.api.nvim_buf_get_name(0)
  local current_line = get_current_line()

  if not bookmarks[current_file] then
    bookmarks[current_file] = {}
  end

  if not sign_lookup[current_file] then
    sign_lookup[current_file] = {}
  end

  -- check if the line is already bookmarked
  for i, line in ipairs(bookmarks[current_file]) do
    if line == current_line then
      -- remove the sign
      -- vim.fn.sign_unplace("BookmarkSign", { buffer = "%", 3 })
      vim.fn.sign_unplace(
        "Bookmarks",
        { buffer = vim.api.nvim_buf_get_name(0), id = sign_lookup[current_file][current_line], name = "BookmarkSign" }
      )
      -- remove the line from the bookmarks
      table.remove(bookmarks[current_file], i)
      -- print("Bookmark removed for file " .. current_file .. " at line " .. current_line)
      return
    end
  end

  -- insert the line into the bookmarks
  local sign_id = add_sign(current_line, "BookmarkSign")

  if not sign_lookup[current_file][current_line] then
    sign_lookup[current_file][current_line] = {}
  end

  sign_lookup[current_file][current_line] = sign_id
  table.insert(bookmarks[current_file], current_line)
  table.sort(bookmarks[current_file])

  print("Bookmark set for file " .. current_file .. " at line " .. current_line)
end

local function next_largest(num, list)
  local next_largest_num = nil

  for _, v in ipairs(list) do
    if v > num then
      if next_largest_num == nil or v < next_largest_num then
        next_largest_num = v
      end
    end
  end

  return next_largest_num
end

-- write function for next smallest
local function next_smallest(num, list)
  local next_smallest_num = nil
  for _, v in ipairs(list) do
    if v < num then
      if next_smallest_num == nil or v > next_smallest_num then
        next_smallest_num = v
      end
    end
  end
  return next_smallest_num
end

function M.next_bookmark()
  local current_file = vim.api.nvim_buf_get_name(0)

  if bookmarks[current_file] == nil then
    print "No bookmarks"
    return
  end

  if current_file and #bookmarks[current_file] > 0 then
    local next_line = next_largest(get_current_line(), bookmarks[current_file])
    if next_line == nil then
      next_line = bookmarks[current_file][1]
    end
    vim.api.nvim_win_set_cursor(0, { next_line, 0 })
    vim.api.nvim_command "normal! zz"
  else
    print "No bookmarks"
  end
end

function M.previous_bookmark()
  local current_file = vim.api.nvim_buf_get_name(0)

  if bookmarks[current_file] == nil then
    print "No bookmarks"
    return
  end

  if current_file and #bookmarks[current_file] > 0 then
    local next_line = next_smallest(get_current_line(), bookmarks[current_file])
    if next_line == nil then
      next_line = bookmarks[current_file][#bookmarks[current_file]]
    end
    vim.api.nvim_win_set_cursor(0, { next_line, 0 })
    vim.api.nvim_command "normal! zz"
  else
    print "No bookmarks"
  end
end

return M
