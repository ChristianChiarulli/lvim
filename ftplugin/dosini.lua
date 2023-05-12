-- Define the comment string
local comment_string = "# %s"

-- Get the buffer number for the current buffer
local current_buffer = vim.api.nvim_get_current_buf()

-- Set the commentstring option for the buffer
vim.api.nvim_buf_set_option(current_buffer, "commentstring", comment_string)
