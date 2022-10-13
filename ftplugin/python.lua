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
    name = "Python",
    t = { "<cmd>lua require('dap-python').test_method()<cr>", "Test Method" },
    T = { "<cmd>lua require('dap-python').test_class()<cr>", "Test Class" },
    d = { "<cmd>lua require('dap-python').debug_selection()<cr>", "Debug Selection" },
  },
}

which_key.register(mappings, opts)
