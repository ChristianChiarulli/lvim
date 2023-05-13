local status_ok, todo_comments = pcall(require, "todo-comments")
if not status_ok then
  return
end

todo_comments.setup {
  signs = false, -- show icons in the signs column
  highlight = {
    after = "empty", -- "fg" or "bg" or empty
  },
}
