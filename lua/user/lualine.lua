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

if lvim.colorscheme == "primer_dark" then
  lvim.builtin.lualine.options.theme = "primer_dark"

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
    symbols = {
      error = lvim.icons.diagnostics.Error .. " ",
      warn = lvim.icons.diagnostics.Warning .. " ",
      info = "I",
      hint = "H",
    },
    colored = false, -- Displays diagnostics status in color if set to true.
    update_in_insert = false, -- Update diagnostics in insert mode.
    always_visible = true, -- Show diagnostics even if there are none.
  }
  local copilot = function()
    local buf_clients = vim.lsp.get_active_clients { bufnr = 0 }
    if #buf_clients == 0 then
      return "LSP Inactive"
    end

    local buf_ft = vim.bo.filetype
    local buf_client_names = {}
    local copilot_active = false

    -- add client
    for _, client in pairs(buf_clients) do
      if client.name ~= "null-ls" and client.name ~= "copilot" then
        table.insert(buf_client_names, client.name)
      end

      if client.name == "copilot" then
        copilot_active = true
      end
    end

    if copilot_active then
      return lvim.icons.git.Octoface
    end
    return ""
  end

  local filetype = function()
    return vim.bo.filetype
  end

  lvim.builtin.lualine.sections.lualine_a = {
    components.branch,
  }
  lvim.builtin.lualine.sections.lualine_b = {}

  lvim.builtin.lualine.sections.lualine_c = {
    diagnostics,
    components.python_env,
  }

  lvim.builtin.lualine.sections.lualine_c = {
    diagnostics,
  }

  local function location()
    local line = vim.fn.line "."
    local col = vim.fn.virtcol "."
    return string.format("Ln %d,Col %d", line, col)
  end

  lvim.builtin.lualine.sections.lualine_x = {
    location,
  }
  lvim.builtin.lualine.sections.lualine_y = {
    components.spaces,
    copilot,
    filetype,
  }

  lvim.builtin.lualine.sections.lualine_z = {
    components.progress,
  }
end
