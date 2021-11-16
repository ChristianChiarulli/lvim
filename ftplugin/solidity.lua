-- https://github.com/prettier-solidity/prettier-plugin-solidity
-- npm install --save-dev prettier prettier-plugin-solidity
-- lvim.lang.solidity.formatters = {
--   {
--     exe = "prettier",
--   },
-- }
local formatters = require "lvim.lsp.null-ls.formatters"
formatters.setup({{exe = "prettier", filetypes = {"solidity"} }})

vim.cmd[[setlocal shiftwidth=4]]
vim.cmd[[setlocal tabstop=4]]
