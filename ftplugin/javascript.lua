-- lvim.lang.javascript.formatters = {
--   {
--     exe = "prettier",
--   },
-- }

-- lvim.lang.javascript.linters = {
--   {
--     exe = "eslint_d",
--   },
-- }

local formatters = require "lvim.lsp.null-ls.formatters"
formatters.setup({{exe = "prettier", filetypes = {"javascript"} }})
