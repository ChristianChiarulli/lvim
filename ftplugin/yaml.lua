vim.list_extend(lvim.lsp.automatic_configuration.skipped_servers, { "yamlls" })

-- print(vim.api.nvim_buf_get_name(0))
local path = vim.api.nvim_buf_get_name(0)
local parts = vim.split(path, "/")
local filename = parts[#parts]
-- print(filename)

-- check if ansidble is in file extension
if string.find(filename, "ansible") then
  require("lvim.lsp.manager").setup("ansiblels", {})
else
  require("lvim.lsp.manager").setup("yamlls", {})
end
