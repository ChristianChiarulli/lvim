-- lvim.lang.lua.formatters = {
--   {
--     exe = "stylua",
--   },
-- }
local formatters = require "lvim.lsp.null-ls.formatters"
formatters.setup { { exe = "stylua", filetypes = { "lua" } } }

-- local linters = require "lvim.lsp.null-ls.linters"
-- linters.setup { { exe = "luacheck", filetypes = { "lua" } } }
