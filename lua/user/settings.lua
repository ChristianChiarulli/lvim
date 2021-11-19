lvim.transparent_window = false
vim.opt.wrap = false
lvim.debug = false
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1
vim.cmd [[set iskeyword+=-]]
vim.cmd [[set formatoptions-=cro]] -- TODO: this doesn't seem to work
pcall(require, "profile")
