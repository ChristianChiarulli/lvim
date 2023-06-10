require("modicator").setup {
  -- Show warning if any required option is missing
  show_warnings = true,
  highlights = {
    -- Default options for bold/italic
    defaults = {
      bold = true,
      italic = false,
    },
  },
}

vim.api.nvim_create_autocmd({ "Colorscheme" }, {
  callback = function()
    vim.api.nvim_set_hl(0, "CursorLineNr", { fg = "#388bfd", bg = "NONE" })
  end,
})
