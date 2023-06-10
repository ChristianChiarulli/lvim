vim.diagnostic.config { virtual_text = false }

vim.list_extend(lvim.lsp.automatic_configuration.skipped_servers, { "jdtls" })

vim.list_extend(lvim.lsp.automatic_configuration.skipped_servers, { "tsserver" })

local capabilities = require("lvim.lsp").common_capabilities()

require("typescript").setup {
  -- disable_commands = false, -- prevent the plugin from creating Vim commands
  debug = false, -- enable debug logging for commands
  go_to_source_definition = {
    fallback = true, -- fall back to standard LSP definition on failure
  },
  sources = {
    require "typescript.extensions.null-ls.code-actions",
  },
  server = {
    -- pass options to lspconfig's setup method
    on_attach = require("lvim.lsp").common_on_attach,
    on_init = require("lvim.lsp").common_on_init,
    capabilities = capabilities,
    settings = {
      typescript = {
        inlayHints = {
          includeInlayEnumMemberValueHints = false,
          includeInlayFunctionLikeReturnTypeHints = false,
          includeInlayFunctionParameterTypeHints = false,
          includeInlayParameterNameHints = "none", -- 'none' | 'literals' | 'all';
          includeInlayParameterNameHintsWhenArgumentMatchesName = false,
          includeInlayPropertyDeclarationTypeHints = false,
          includeInlayVariableTypeHints = false,
        },
      },
    },
  },
}

local formatters = require "lvim.lsp.null-ls.formatters"
formatters.setup {
  { command = "stylua", filetypes = { "lua" } },
  { command = "shfmt", filetypes = { "sh", "zsh" } },
  { command = "prettier", filetypes = { "css", "javascript", "javascriptreact", "typescript", "typescriptreact" } },
}

-- lvim.lsp.on_attach_callback = function(client, bufnr)
-- end

-- local linters = require "lvim.lsp.null-ls.linters"
-- linters.setup {
--   { command = "eslint_d", filetypes = { "javascript" } },
-- }
