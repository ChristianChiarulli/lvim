-- lvim.lang.lua.formatters = {
--   {
--     exe = "stylua",
--   },
-- }
local formatters = require "lvim.lsp.null-ls.formatters"
formatters.setup({{exe = "stylua", filetypes = {"lua"} }})
