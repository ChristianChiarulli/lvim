-- Setup lsp.

-- Set a formatter.
-- local formatters = require "lvim.lsp.null-ls.formatters"
-- formatters.setup {
--   { command = "prettier", filetypes = { "javascript", "typescript", "javascriptreact", "typescriptreact", "css" } },
-- }

-- local mason_path = vim.fn.glob(vim.fn.stdpath "data" .. "/mason/")
-- require("dap-vscode-js").setup {
--   -- node_path = "node", -- Path of node executable. Defaults to $NODE_PATH, and then "node"
--   debugger_path = mason_path .. "packages/js-debug-adapter", -- Path to vscode-js-debug installation.
--   -- debugger_cmd = { "js-debug-adapter" }, -- Command to use to launch the debug server. Takes precedence over `node_path` and `debugger_path`.
--   adapters = { "pwa-node", "pwa-chrome", "pwa-msedge", "node-terminal", "pwa-extensionHost" }, -- which adapters to register in nvim-dap
-- }

-- for _, language in ipairs { "typescript", "javascript" } do
--   require("dap").configurations[language] = {
--     {
--       type = "pwa-node",
--       request = "launch",
--       name = "Debug Jest Tests",
--       -- trace = true, -- include debugger info
--       runtimeExecutable = "node",
--       runtimeArgs = {
--         "./node_modules/jest/bin/jest.js",
--         "--runInBand",
--       },
--       rootPath = "${workspaceFolder}",
--       cwd = "${workspaceFolder}",
--       console = "integratedTerminal",
--       internalConsoleOptions = "neverOpen",
--     },
--   }
-- end

-- Set a linter.
-- local linters = require("lvim.lsp.null-ls.linters")
-- linters.setup({
--   { command = "eslint", filetypes = { "javascript", "typescript" } },
-- })



local status_ok, which_key = pcall(require, "which-key")
if not status_ok then
  return
end

local opts = {
  mode = "n", -- NORMAL mode
  prefix = "<leader>",
  buffer = nil, -- Global mappings. Specify a buffer number for buffer local mappings
  silent = true, -- use `silent` when creating keymaps
  noremap = true, -- use `noremap` when creating keymaps
  nowait = true, -- use `nowait` when creating keymaps
}

local mappings = {
  C = {
    name = "Typescript",
    i = { "<cmd>TypescriptAddMissingImports<Cr>", "AddMissingImports" },
    o = { "<cmd>TypescriptOrganizeImports<cr>", "OrganizeImports" },
    u = { "<cmd>TypescriptRemoveUnused<Cr>", "RemoveUnused" },
    r = { "<cmd>TypescriptRenameFile<Cr>", "RenameFile" },
    f = { "<cmd>TypescriptFixAll<Cr>", "FixAll" },
    g = { "<cmd>TypescriptGoToSourceDefinition<Cr>", "GoToSourceDefinition" },
  },
}

which_key.register(mappings, opts)


