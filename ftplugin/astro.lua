vim.opt_local.shiftwidth = 2
vim.opt_local.tabstop = 2

vim.list_extend(lvim.lsp.automatic_configuration.skipped_servers, { "emmet-ls" })

local lsp_manager = require "lvim.lsp.manager"
lsp_manager.setup("emmet_ls", {
  filetypes = { "astro", "html" },
  -- cmd = { "/Users/chris/Library/Caches/fnm_multishells/65657_1672759387689/bin/ls_emmet", "--stdio" },
  on_init = require("lvim.lsp").common_on_init,
  capabilities = require("lvim.lsp").common_capabilities(),
})

-- lsp_manager.setup("tailwindcss", {
--   filetypes = { "astro", "html" },
--   -- cmd = { "/Users/chris/Library/Caches/fnm_multishells/65657_1672759387689/bin/ls_emmet", "--stdio" },
--   on_init = require("lvim.lsp").common_on_init,
--   capabilities = require("lvim.lsp").common_capabilities(),
-- })
