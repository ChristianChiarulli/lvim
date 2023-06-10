-- if lvim.colorscheme == "darkplus" then
--   lvim.builtin.treesitter.rainbow = {
--     enable = true,
--     extended_mode = false,
--     colors = {
--       "DodgerBlue",
--       "Orchid",
--       "Gold",
--     },
--     disable = { "html" },
--   }
-- end

lvim.builtin.treesitter.ensure_installed = {
  "java",
  "python",
  "javascript",
}

lvim.builtin.treesitter.rainbow = {
  enable = true,
  query = {
    "rainbow-parens",
  },
  strategy = require("ts-rainbow").strategy.global,
  hlgroups = {
    -- "TSRainbowRed",
    "TSRainbowBlue",
    -- "TSRainbowOrange",
    -- "TSRainbowCoral",
    -- "TSRainbowPink",
    "TSRainbowYellow",
    -- "TSRainbowViolet",
    "TSRainbowGreen",
  },
}

lvim.builtin.treesitter.autotag.enable = true
lvim.builtin.treesitter.auto_install = false

-- lvim.builtin.treesitter.ignore_install = { "markdown" }

lvim.builtin.treesitter.textobjects = {
  select = {
    enable = true,
    -- Automatically jump forward to textobj, similar to targets.vim
    lookahead = true,
    keymaps = {
      -- You can use the capture groups defined in textobjects.scm
      ["af"] = "@function.outer",
      ["if"] = "@function.inner",
      ["at"] = "@class.outer",
      ["it"] = "@class.inner",
      ["ac"] = "@call.outer",
      ["ic"] = "@call.inner",
      ["aa"] = "@parameter.outer",
      ["ia"] = "@parameter.inner",
      ["al"] = "@loop.outer",
      ["il"] = "@loop.inner",
      ["ai"] = "@conditional.outer",
      ["ii"] = "@conditional.inner",
      ["a/"] = "@comment.outer",
      ["i/"] = "@comment.inner",
      ["ab"] = "@block.outer",
      ["ib"] = "@block.inner",
      ["as"] = "@statement.outer",
      ["is"] = "@scopename.inner",
      ["aA"] = "@attribute.outer",
      ["iA"] = "@attribute.inner",
      ["aF"] = "@frame.outer",
      ["iF"] = "@frame.inner",
    },
  },
}
