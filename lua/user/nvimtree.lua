local function my_on_attach(bufnr)
  local api = require "nvim-tree.api"

  local function opts(desc)
    return { desc = "nvim-tree: " .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
  end

  api.config.mappings.default_on_attach(bufnr)

  vim.keymap.set("n", "l", api.node.open.edit, opts "Open")
  vim.keymap.set("n", "h", api.node.navigate.parent_close, opts "Close Directory")
  vim.keymap.set("n", "v", api.node.open.vertical, opts "Open: Vertical Split")
  vim.keymap.del("n", "<C-k>", { buffer = bufnr })
  vim.keymap.set("n", "<S-k>", api.node.open.preview, opts "Open Preview")
end

-- lvim.builtin.lir.icon = ""

lvim.builtin.nvimtree.setup.on_attach = my_on_attach
lvim.builtin.nvimtree.setup.view.centralize_selection = true
lvim.builtin.nvimtree.setup.renderer.icons.glyphs.folder.arrow_open = ""
lvim.builtin.nvimtree.setup.renderer.icons.glyphs.folder.arrow_closed = ""
-- lvim.builtin.nvimtree.setup.renderer.icons.glyphs.folder.open = ""
-- lvim.builtin.nvimtree.setup.renderer.icons.glyphs.folder.default = ""
-- lvim.builtin.nvimtree.setup.renderer.icons.glyphs.folder.empty = ""
-- lvim.builtin.nvimtree.setup.renderer.icons.glyphs.folder.symlink = ""
lvim.builtin.nvimtree.setup.view.centralize_selection = true
-- lvim.builtin.nvimtree.setup.view.cursor = false

-- vim.api.nvim_create_autocmd({ 'WinEnter', 'BufWinEnter' }, {
--   pattern = 'NvimTree*',
--   callback = function()
--     local def = vim.api.nvim_get_hl_by_name('Cursor', true)
--     vim.api.nvim_set_hl(0, 'Cursor', vim.tbl_extend('force', def, { blend = 100 }))
--     vim.opt.guicursor:append('a:Cursor/lCursor')
--   end,
-- })

-- vim.api.nvim_create_autocmd({ 'BufLeave', 'WinClosed' }, {
--   pattern = 'NvimTree*',
--   callback = function()
--     local def = vim.api.nvim_get_hl_by_name('Cursor', true)
--     vim.api.nvim_set_hl(0, 'Cursor', vim.tbl_extend('force', def, { blend = 0 }))
--     vim.opt.guicursor = 'n-v-c-sm:block,i-ci-ve:ver25,r-cr-o:hor20'
--   end,
-- })
