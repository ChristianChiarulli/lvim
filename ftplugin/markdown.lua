local formatters = require "lvim.lsp.null-ls.formatters"
formatters.setup {
  {
    exe = "prettier",
    filetypes = { "markdown" },
  },
}

vim.cmd[[setlocal nospell]]
