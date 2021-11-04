--json
-- lvim.lang.json.formatters = {
--   {
--     exe = "prettier",
--   },
-- }

local formatters = require "lvim.lsp.null-ls.formatters"
formatters.setup({{exe = "prettier", filetypes = {"json"} }})
