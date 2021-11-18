local formatters = require "lvim.lsp.null-ls.formatters"
formatters.setup {
  {
    exe = "prettier",
    filetypes = { "typescriptreact" },
    args = { "--no-semi", "--single-quote", "--jsx-single-quote" },
  },
}

-- local linters = require "lvim.lsp.null-ls.linters"
-- linters.setup({{exe = "eslint_d", filetypes = {"typescriptreact"} }})

-- {
--   "semi": true,
--   "tabWidth": 2,
--   "printWidth": 100,
--   "singleQuote": true,
--   "trailingComma": "none",
--   "jsxBracketSameLine": true
-- }
