local components = require "lvim.core.lualine.components"

if lvim.colorscheme == "darkplus" then
  local normal_hl = vim.api.nvim_get_hl_by_name("Normal", true)
  vim.api.nvim_create_autocmd({ "Colorscheme" }, {
    callback = function()
      vim.api.nvim_set_hl(0, "SLGitIconDark", { fg = "#E8AB53", bg = "#333333" })
      vim.api.nvim_set_hl(0, "SLBranchNameDark", { fg = normal_hl.foreground, bg = "#333333" })
    end,
  })

  local branch_icon = "%#SLGitIconDark#" .. lvim.icons.git.Branch .. "%*" .. "%#SLBranchNameDark#"

  local branch = {
    "b:gitsigns_head",
    icon = branch_icon,
    color = { gui = "bold" },
  }

  lvim.builtin.lualine.sections.lualine_b = { branch }
end

if lvim.colorscheme == "onedark" then

  lvim.builtin.lualine.options.theme = "onedark_gray"

  local diagnostics = {
    "diagnostics",

    sources = { "nvim_diagnostic" },
    sections = { "error", "warn" },

    diagnostics_color = {
      error = "Statusline",
      warn = "Statusline",
      info = "Statusline",
      hint = "Statusline",
    },
    symbols = { error = lvim.icons.diagnostics.Error .. " ", warn = lvim.icons.diagnostics.Warning .. " ", info = "I", hint = "H" },
    colored = false, -- Displays diagnostics status in color if set to true.
    update_in_insert = false, -- Update diagnostics in insert mode.
    always_visible = true, -- Show diagnostics even if there are none.
  }

  local filetype = function()
    return vim.bo.filetype
  end
  lvim.builtin.lualine.sections.lualine_a = {
    components.branch
  }
  lvim.builtin.lualine.sections.lualine_b = {
  }

  lvim.builtin.lualine.sections.lualine_c = {
    diagnostics,
  }

  lvim.builtin.lualine.sections.lualine_c = {
    diagnostics,
  }

  lvim.builtin.lualine.sections.lualine_x = {
    -- components.diagnostics,
    -- components.lsp,
    components.spaces,
    filetype,
  }
end
