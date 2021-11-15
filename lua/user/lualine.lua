local M = {}

local function clock()
  return " " .. os.date "%H:%M"
end

local function lsp_progress()
  local messages = vim.lsp.util.get_progress_messages()
  if #messages == 0 then
    return ""
  end
  local status = {}
  for _, msg in pairs(messages) do
    table.insert(status, (msg.percentage or 0) .. "%% " .. (msg.title or ""))
  end
  local spinners = { "⠋", "⠙", "⠹", "⠸", "⠼", "⠴", "⠦", "⠧", "⠇", "⠏" }
  local ms = vim.loop.hrtime() / 1000000
  local frame = math.floor(ms / 120) % #spinners
  return table.concat(status, " | ") .. " " .. spinners[frame + 1]
end

vim.cmd [[autocmd User LspProgressUpdate let &ro = &ro]]

local function diff_source()
  local gitsigns = vim.b.gitsigns_status_dict
  if gitsigns then
    return {
      added = gitsigns.added,
      modified = gitsigns.changed,
      removed = gitsigns.removed,
    }
  end
end

local function testing()
  if vim.g.testing_status == "running" then
    return " "
  end
  if vim.g.testing_status == "fail" then
    return ""
  end
  if vim.g.testing_status == "pass" then
    return " "
  end
  return nil
end
local function using_session()
  return (vim.g.using_persistence ~= nil)
end

local mode = function()
  local mod = vim.fn.mode()
  if mod == "n" or mod == "no" or mod == "nov" then
    -- return "  "
    -- return "▊ "
    return "-- Normal --"
  elseif mod == "i" or mod == "ic" or mod == "ix" then
    -- return "  "
    -- return "▊ "
    return "-- Insert --"
  elseif mod == "V" or mod == "v" or mod == "vs" or mod == "Vs" or mod == "cv" then
    -- return "  "
    -- return "▊ "
    return "-- Visual --"
  elseif mod == "c" or mod == "ce" then
    -- return " ﴣ "
    -- return "▊ "
    return "-- Commmand --"
  elseif mod == "r" or mod == "rm" or mod == "r?" then
    -- return "  "
    -- return "▊ "
    return "-- Normal --"
  elseif mod == "R" or mod == "Rc" or mod == "Rv" or mod == "Rv" then
    -- return "  "
    -- return "▊ "
    return "-- Replace --"
  end
  -- return "  "
  -- return "▊ "
  return "-- Normal --"
end
local file_icons = {
  Brown = { "" },
  Aqua = { "" },
  LightBlue = { "", "" },
  Blue = { "", "", "", "", "", "", "", "", "", "", "", "", "" },
  Darkblue = { "", "" },
  Purple = { "", "", "", "", "" },
  Red = { "", "", "", "", "", "" },
  Beige = { "", "", "" },
  Yellow = { "", "", "λ", "", "" },
  Orange = { "", "" },
  Darkorange = { "", "", "", "", "" },
  Pink = { "", "" },
  Salmon = { "" },
  Green = { "", "", "", "", "", "" },
  Lightgreen = { "", "", "", "﵂" },
  White = { "", "", "", "", "", "" },
}

local file_icon_colors = {
  Brown = "#905532",
  Aqua = "#3AFFDB",
  Blue = "#689FB6",
  Darkblue = "#44788E",
  Purple = "#834F79",
  Red = "#AE403F",
  Beige = "#F5C06F",
  Yellow = "#F09F17",
  Orange = "#D4843E",
  Darkorange = "#F16529",
  Pink = "#CB6F6F",
  Salmon = "#EE6E73",
  Green = "#8FAA54",
  Lightgreen = "#31B53E",
  White = "#FFFFFF",
  LightBlue = "#5fd7ff",
}

local function get_file_info()
  return vim.fn.expand "%:t", vim.fn.expand "%:e"
end

local function get_file_icon()
  local icon
  local ok, devicons = pcall(require, "nvim-web-devicons")
  if not ok then
    print "No icon plugin found. Please install 'kyazdani42/nvim-web-devicons'"
    return ""
  end
  local f_name, f_extension = get_file_info()
  icon = devicons.get_icon(f_name, f_extension)
  if icon == nil then
    icon = ""
  end
  return icon
end

local function get_file_icon_color()
  local f_name, f_ext = get_file_info()
  local has_devicons, devicons = pcall(require, "nvim-web-devicons")
  if has_devicons then
    local icon, iconhl = devicons.get_icon(f_name, f_ext)
    if icon ~= nil then
      return vim.fn.synIDattr(vim.fn.hlID(iconhl), "fg")
    end
  end

  local icon = get_file_icon():match "%S+"
  for k, _ in pairs(file_icons) do
    if vim.fn.index(file_icons[k], icon) ~= -1 then
      return file_icon_colors[k]
    end
  end
end

local default_colors = {
  -- bg = "#252525",
  -- bg_alt = "#252525",
  -- bg = "#68217a",
  -- bg_alt = "#68217a",
  -- bg = "#327ac6",
  -- bg_alt = "#327ac6",
  bg = "#007acc",
  bg_alt = "#007acc",
  fg = "#d4d4d4",
  yellow = "#dcdcaa",
  yellow_orange = "#d7ba7d",
  cyan = "#4ec9b0",
  light_blue = "#9cdcfe",
  green = "#6a9955",
  orange = "#ce9178",
  violet = "#c586c0",
  magenta = "#d16d9e",
  blue = "#569cd6",
  red = "#d16969",
  git = { change = "#0c7d9d", add = "#587c0c", delete = "#94151b", conflict = "#bb7a61" },
}

M.config = function()
  local colors
  colors = default_colors
  -- Color table for highlights
  local mode_color = {
    n = colors.fg,
    i = colors.fg,
    v = colors.fg,
    [""] = colors.fg,
    V = colors.fg,
    c = colors.fg,
    no = colors.fg,
    s = colors.fg,
    S = colors.fg,
    [""] = colors.fg,
    ic = colors.fg,
    R = colors.fg,
    Rv = colors.fg,
    cv = colors.fg,
    ce = colors.fg,
    r = colors.fg,
    rm = colors.fg,
    ["r?"] = colors.fg,
    ["!"] = colors.fg,
    t = colors.fg,
  }
  local conditions = {
    buffer_not_empty = function()
      return vim.fn.empty(vim.fn.expand "%:t") ~= 1
    end,
    hide_in_width = function()
      return vim.fn.winwidth(0) > 80
    end,
    hide_in_width_lsp = function()
      return vim.fn.winwidth(0) > 60
    end,
    hide_small = function()
      return vim.fn.winwidth(0) > 150
    end,
    check_git_workspace = function()
      local filepath = vim.fn.expand "%:p:h"
      local gitdir = vim.fn.finddir(".git", filepath .. ";")
      return gitdir and #gitdir > 0 and #gitdir < #filepath
    end,
  }

  -- Config
  local config = {
    options = {
      icons_enabled = false,
      -- Disable sections and component separators
      component_separators = { left = "", right = "" },
      section_separators = { left = "", right = "" },
      theme = {
        -- We are going to use lualine_c an lualine_x as left and
        -- right section. Both are highlighted by c theme .  So we
        -- are just setting default looks o statusline
        normal = { c = { fg = colors.fg, bg = colors.bg } },
        inactive = { c = { fg = colors.fg, bg = colors.bg_alt } },
      },
      disabled_filetypes = { "dashboard", "NvimTree", "Outline", "alpha" },
    },
    sections = {
      -- these are to remove the defaults
      lualine_a = {},

      lualine_b = {},
      lualine_y = {},
      lualine_z = {},
      -- These will be filled later
      lualine_c = {},
      lualine_x = {},
    },
    inactive_sections = {
      -- these are to remove the defaults
      lualine_a = {},
      lualine_v = {},
      lualine_y = {},
      lualine_z = {},
      lualine_c = {
        {
          function()
            vim.api.nvim_command(
              "hi! LualineModeInactive guifg=" .. mode_color[vim.fn.mode()] .. " guibg=" .. colors.bg_alt
            )
            -- return ""
            -- return "▊"
            return ""
            -- return mode()
          end,
          color = "LualineModeInactive",
          padding = { left = 0, right = 0 },
          -- left_padding = 1,
        },
        {
          "filename",
          cond = conditions.buffer_not_empty,
          color = { fg = colors.fg, gui = "bold" },
        },
      },
      lualine_x = {},
    },
  }

  -- Inserts a component in lualine_c at left section
  local function ins_left(component)
    table.insert(config.sections.lualine_c, component)
  end

  -- Inserts a component in lualine_x ot right section
  local function ins_right(component)
    table.insert(config.sections.lualine_x, component)
  end

  ins_left {
    function()
      return "  "
    end,
    cond = conditions.check_git_workspace,
    color = { fg = colors.fg }, -- Sets highlighting of component
    padding = 0,
  }
  ins_left {
    "b:gitsigns_head",
    -- color = "LualineBranchMode",
    cond = conditions.check_git_workspace,
    -- function()
    --   return "▊"
    -- end,
    -- -- color = "LualineMode",
    color = { fg = colors.fg }, -- Sets highlighting of component
    -- left_padding = 0, -- We don't need space before this
    padding = 0,
  }

  -- ins_left {
  --   function()
  --     local utils = require "lvim.core.lualine.utils"
  --     local filename = vim.fn.expand "%"
  --     local kube_env = os.getenv "KUBECONFIG"
  --     local kube_filename = "kubectl-edit"
  --     if (vim.bo.filetype == "yaml") and (string.sub(filename, 1, kube_filename:len()) == kube_filename) then
  --       return string.format("⎈  (%s)", utils.env_cleanup(kube_env))
  --     end
  --     return ""
  --   end,
  --   color = { fg = colors.cyan },
  --   cond = conditions.hide_in_width,
  -- }
  ins_left {
    function()
      return ""
    end,
    padding = 0,
  }
  -- ins_left {
  --   function()
  --     vim.api.nvim_command("hi! LualineFileIconColor guifg=" .. get_file_icon_color() .. " guibg=" .. colors.bg)
  --     return get_file_icon()
  --   end,
  --   padding = { left = 2, right = 0 },
  --   cond = conditions.buffer_not_empty,
  --   color = "LualineFileIconColor",
  --   gui = "bold",
  -- }
  -- ins_left {
  --   "filename",
  --   cond = conditions.buffer_not_empty,
  --   padding = { left = 1, right = 1 },
  --   color = { fg = colors.fg, gui = "bold" },
  -- }
  local ok, _ = pcall(require, "vim.diagnostic")
  if ok then
    ins_left {
      "diagnostics",
      sources = { "nvim" },
      symbols = { error = " ", warn = " ", info = " ", hint = " " },
      sections = { "error", "warn" },
      -- sections = {'error', 'warn', 'info', 'hint'},
      -- cond = conditions.hide_in_width,
      colored = false,
      always_visible = true,
      padding = { left = 2, right = 2 },
    }
  else
    ins_left {
      "diagnostics",
      sources = { "nvim_lsp" },
      sections = { "error", "warn" },
      -- sections = {'error', 'warn', 'info', 'hint'},
      symbols = { error = " ", warn = " ", info = " ", hint = " " },
      -- cond = conditions.hide_in_width,
      colored = false,
      always_visible = true,
      padding = { left = 2, right = 2 },
    }
  end
  ins_left {
    -- mode component
    function()
      -- auto change color according to neovims mode
      vim.api.nvim_command("hi! LualineMode guifg=" .. mode_color[vim.fn.mode()] .. " guibg=" .. colors.bg)
      return mode()
      -- return ""
    end,

    -- color = { fg = colors.red },
    color = "LualineMode",
    padding = { left = 0, right = 0 },
    -- left_padding = 1,
  }
  ins_left {
    function()
      local utils = require "lvim.core.lualine.utils"
      if vim.bo.filetype == "python" then
        local venv = os.getenv "CONDA_DEFAULT_ENV"
        if venv then
          return string.format("  (%s)", utils.env_cleanup(venv))
        end
        venv = os.getenv "VIRTUAL_ENV"
        if venv then
          return string.format("  (%s)", utils.env_cleanup(venv))
        end
        return ""
      end
      return ""
    end,
    color = { fg = colors.fg },
    cond = conditions.hide_in_width,
  }
  ins_left {
    provider = function()
      return testing()
    end,
    enabled = function()
      return testing() ~= nil
    end,
    hl = {
      fg = colors.fg,
    },
    left_sep = " ",
    right_sep = {
      str = " |",
      hl = { fg = colors.fg },
    },
  }
  ins_left {
    provider = function()
      if vim.g.using_persistence then
        return "  |"
      elseif vim.g.using_persistence == false then
        return "  |"
      end
    end,
    enabled = function()
      return using_session()
    end,
    hl = {
      fg = colors.fg,
    },
  }

  ins_left {
    lsp_progress,
    cond = conditions.hide_small,
  }

  -- Insert mid section. You can make any number of sections in neovim :)
  -- for lualine it's any number greater then 2
  ins_left {
    function()
      return "%="
    end,
  }

  ins_right {
    function()
      if not vim.bo.readonly or not vim.bo.modifiable then
        return ""
      end
      return "" -- """
    end,
    color = { fg = colors.fg },
  }

  ins_right {
    "diff",
    source = diff_source,
    symbols = { added = "  ", modified = "柳", removed = " " },
    diff_color = {
      added = { fg = colors.fg },
      modified = { fg = colors.fg },
      removed = { fg = colors.fg },
    },
    color = {},
    cond = conditions.hide_in_width,
    -- cond = nil,
  }
  -- ins_right {
  --   function()
  --     if next(vim.treesitter.highlighter.active) then
  --       return "  "
  --     end
  --     return ""
  --   end,
  --   padding = 0,
  --   -- left_padding = 0,
  --   -- right_padding = 0,
  --   color = { fg = colors.green },
  --   cond = conditions.hide_in_width,
  -- }
  ins_right {
    function(msg)
      msg = msg or "LS Inactive"
      local buf_clients = vim.lsp.buf_get_clients()
      if next(buf_clients) == nil then
        if type(msg) == "boolean" or #msg == 0 then
          return "LS Inactive"
        end
        return msg
      end
      local buf_ft = vim.bo.filetype
      local buf_client_names = {}
      local trim = vim.fn.winwidth(0) < 70

      -- add client
      -- local utils = require "lsp.utils"
      -- local active_client = utils.get_active_client_by_ft(buf_ft)
      for _, client in pairs(buf_clients) do
        if client.name ~= "null-ls" then
          local _added_client = client.name
          if trim then
            _added_client = string.sub(client.name, 1, 4)
          end
          table.insert(buf_client_names, _added_client)
        end
      end
      -- vim.list_extend(buf_client_names, active_client or {})

      -- add formatter
      local formatters = require "lvim.lsp.null-ls.formatters"
      local supported_formatters = {}
      for _, fmt in pairs(formatters.list_registered_providers(buf_ft)) do
        local _added_formatter = fmt
        if trim then
          _added_formatter = string.sub(fmt, 1, 4)
        end
        table.insert(supported_formatters, _added_formatter)
      end
      vim.list_extend(buf_client_names, supported_formatters)

      -- add linter
      local linters = require "lvim.lsp.null-ls.linters"
      local supported_linters = {}
      for _, lnt in pairs(linters.list_registered_providers(buf_ft)) do
        local _added_linter = lnt
        if trim then
          _added_linter = string.sub(lnt, 1, 4)
        end
        table.insert(supported_linters, _added_linter)
      end
      vim.list_extend(buf_client_names, supported_linters)

      return "[" .. table.concat(buf_client_names, ", ") .. "]"
    end,
    icon = " ",
    color = { fg = colors.fg },
    cond = conditions.hide_in_width_lsp,
  }

  ins_right {
    function()
      return "Spaces: " .. vim.api.nvim_buf_get_option(0, "shiftwidth") .. " "
    end,
    cond = conditions.hide_in_width,
    color = { fg = colors.fg, bg = colors.bg },
  }

  ins_right {
    "location",
    padding = 0,
    -- left_padding = 0,
    -- right_padding = 0,
    color = { fg = colors.fg },
  }
  -- Add components to right sections
  -- ins_right {
  --   -- filesize component
  --   function()
  --     local function format_file_size(file)
  --       local size = vim.fn.getfsize(file)
  --       if size <= 0 then
  --         return ""
  --       end
  --       local sufixes = { "b", "k", "m", "g" }
  --       local i = 1
  --       while size > 1024 do
  --         size = size / 1024
  --         i = i + 1
  --       end
  --       return string.format("%.1f%s", size, sufixes[i])
  --     end
  --     local file = vim.fn.expand "%:p"
  --     if string.len(file) == 0 then
  --       return ""
  --     end
  --     return format_file_size(file)
  --   end,
  --   cond = conditions.buffer_not_empty,
  -- }
  -- ins_right {
  --   "fileformat",
  --   -- upper = true,
  --   fmt = string.upper,
  --   icons_enabled = true, -- I think icons are cool but Eviline doesn't have them. sigh
  --   color = { fg = colors.green, gui = "bold" },
  --   cond = conditions.hide_in_width,
  -- }

  -- ins_right {
  --   clock,
  --   cond = conditions.hide_in_width,
  --   color = { fg = colors.blue, bg = colors.bg },
  -- }

  ins_right {
    "filetype",
    cond = conditions.hide_in_width,
    color = { fg = colors.fg, bg = colors.bg },
    icon = "",
  }

  ins_right {
    function()
      local current_line = vim.fn.line "."
      local total_lines = vim.fn.line "$"
      local chars = { "__", "▁▁", "▂▂", "▃▃", "▄▄", "▅▅", "▆▆", "▇▇", "██" }
      local line_ratio = current_line / total_lines
      local index = math.ceil(line_ratio * #chars)
      return chars[index]
    end,
    padding = 1,
    -- left_padding = 0,
    -- right_padding = 0,
    color = { fg = colors.fg, bg = colors.bg },
    cond = nil,
  }

  -- Now don't forget to initialize lualine
  lvim.builtin.lualine.options = config.options
  lvim.builtin.lualine.sections = config.sections
  lvim.builtin.lualine.inactive_sections = config.inactive_sections
end

return M
