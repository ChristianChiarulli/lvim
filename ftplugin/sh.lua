local formatters = require "lvim.lsp.null-ls.formatters"
formatters.setup {
  {
    exe = "shfmt",
    filetypes = { "sh" },
  },
}

vim.cmd[[setlocal shiftwidth=4]]
vim.cmd[[setlocal tabstop=4]]
