vim.schedule(function()
  if vim.opt.filetype:get() == "yaml" then
    require("lvim.lsp.manager").setup("yamlls", {})
  end
end)
