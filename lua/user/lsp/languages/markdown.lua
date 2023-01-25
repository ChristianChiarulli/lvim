vim.list_extend(lvim.lsp.automatic_configuration.skipped_servers, { "zk" })

local lsp_manager = require 'lvim.lsp.manager'
lsp_manager.setup('zk', {
  filetypes = { "markdown", "telekasten" },
  on_init = require("lvim.lsp").common_on_init,
  capabilities = require("lvim.lsp").common_capabilities()
})
