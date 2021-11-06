-- general
lvim.colorscheme = "darkplus"
lvim.format_on_save = false
lvim.transparent_window = false
vim.opt.wrap = false
lvim.debug = false

-- vim.g.loaded_netrw = 1
-- vim.g.loaded_netrwPlugin = 1

-- keymappings
lvim.leader = "space"

lvim.keys.normal_mode["<esc><esc>"] = "<cmd>nohlsearch<cr>"
-- lvim.keys.normal_mode["Y"] = "y$"
lvim.keys.visual_mode["p"] = [["_dP]]
lvim.keys.normal_mode["Q"] = "<cmd>BufferClose!<CR>"
lvim.keys.normal_mode["X"] = "<cmd>BufferClose!<CR>"

-- for finding syntax ids for non TS enabled languages
vim.cmd [[
map <F3> :echo "hi<" . synIDattr(synID(line("."),col("."),1),"name") . '> trans<' . synIDattr(synID(line("."),col("."),0),"name") . "> lo<" . synIDattr(synIDtrans(synID(line("."),col("."),1)),"name") . ">" . " FG:" . synIDattr(synIDtrans(synID(line("."),col("."),1)),"fg#")<CR>
]]

-- LSP
lvim.lsp.diagnostics.virtual_text = false
lvim.lsp.override = { "java" }
-- require("user.json_schemas").setup()

-- Builtins
lvim.builtin.dashboard.active = true
lvim.builtin.terminal.active = true
lvim.builtin.dap.active = true
lvim.builtin.bufferline.active = true
lvim.builtin.cmp.experimental.ghost_text = false
-- lvim.builtin.cmp.sources = {}

lvim.builtin.fancy_statusline = { active = true } -- enable/disable fancy statusline
if lvim.builtin.fancy_statusline.active then
  require("user.lualine").config()
end

-- Whichkey
lvim.builtin.which_key.mappings.l.d = { "<cmd>TroubleToggle<cr>", "Diagnostics" }
lvim.builtin.which_key.mappings.l.R = { "<cmd>TroubleToggle lsp_references<cr>", "References" }
lvim.builtin.which_key.mappings.l.o = { "<cmd>SymbolsOutline<cr>", "Outline" }
lvim.builtin.which_key.mappings.T.h = { "<cmd>TSHighlightCapturesUnderCursor<cr>", "Highlight" }
lvim.builtin.which_key.mappings.T.p = { "<cmd>TSPlaygroundToggle<cr>", "Playground" }

lvim.builtin.which_key.mappings.g["G"] = {
  name = "Gist",
  a = { "<cmd>Gist -b -a<cr>", "Create Anon" },
  d = { "<cmd>Gist -d<cr>", "Delete" },
  f = { "<cmd>Gist -f<cr>", "Fork" },
  g = { "<cmd>Gist -b<cr>", "Create" },
  l = { "<cmd>Gist -l<cr>", "List" },
  p = { "<cmd>Gist -b -p<cr>", "Create Private" },
}
lvim.builtin.which_key.mappings["z"] = { "<cmd>ZenMode<cr>", "Zen" }
lvim.builtin.which_key.mappings["r"] = {
  name = "Replace",
  r = { "<cmd>lua require('spectre').open()<cr>", "Replace" },
  w = { "<cmd>lua require('spectre').open_visual({select_word=true})<cr>", "Replace Word" },
  f = { "<cmd>lua require('spectre').open_file_search()<cr>", "Replace Buffer" },
}
-- lvim.builtin.which_key.mappings.f = { "<cmd>lua require('lir.float').toggle()<cr>", "Files" }

-- Treesitter
lvim.builtin.treesitter.ensure_installed = "maintained"
lvim.builtin.treesitter.autotag.enable = true
lvim.builtin.treesitter.playground.enable = true
lvim.builtin.treesitter.indent.disable = { "python" }

-- local actions = require "telescope.actions"
-- lvim.builtin.telescope.defaults.mappings.i["<C-j>"] = actions.move_selection_next

-- Telescope
lvim.builtin.telescope.on_config_done = function()
  local actions = require "telescope.actions"
  lvim.builtin.telescope.defaults.mappings.i["<C-j>"] = actions.move_selection_next
  lvim.builtin.telescope.defaults.mappings.i["<C-k>"] = actions.move_selection_previous
  lvim.builtin.telescope.defaults.mappings.i["<C-n>"] = actions.cycle_history_next
  lvim.builtin.telescope.defaults.mappings.i["<C-p>"] = actions.cycle_history_prev
end

-- Additional Plugins
lvim.plugins = {
  { "lunarvim/colorschemes" },
  -- { "folke/tokyonight.nvim" },
  { "mfussenegger/nvim-jdtls" },
  { "ChristianChiarulli/vim-solidity" },
  -- {
  --   "abecodes/tabout.nvim",
  --   config = function()
  --     require("user.tabout").config()
  --   end,
  --   wants = { "nvim-treesitter" }, -- or require if not used so far
  --   after = { "nvim-cmp", "LuaSnip" }, -- if a completion plugin is using tabs load it before
  -- },
  {
    "pwntester/octo.nvim",
    event = "BufRead",
    config = function()
      require("user.octo").config()
    end,
  },
  -- {
  --   "ray-x/lsp_signature.nvim",
  --   event = "InsertEnter",
  --   config = function()
  --     require("user.lsp_signature").config()
  --   end,
  -- },
  {
    "unblevable/quick-scope",
    config = function()
      require "user.quickscope"
    end,
  },
  {
    "kevinhwang91/rnvimr",
    config = function()
      require "user.rnvimr"
    end,
  },
  {
    "lukas-reineke/indent-blankline.nvim",
    -- event = "BufReadPre",
    config = function()
      require "user.blankline"
    end,
  },
  {
    "ruifm/gitlinker.nvim",
    event = "BufRead",
    config = function()
      require("user.gitlinker").config()
    end,
  },
  {
    "phaazon/hop.nvim",
    event = "BufRead",
    config = function()
      require("user.hop").config()
    end,
  },
  {
    -- Note for this to work you need to create a pat and put it in `~/.gist-vim` as <token XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX>
    -- You will also need to set github username like:
    --
    -- [user]
    --	 email = chris.machine@pm.me
    --   name = Christian Chiarulli
    -- [github]
    --   user = ChristianChiarulli
    --	 email = chris.machine@pm.me
    "mattn/vim-gist",
    requires = "mattn/webapi-vim",
    config = function()
      vim.g.gist_open_browser_after_post = 1
    end,
  },
  {
    "tamago324/lir.nvim",
    config = function()
      require "user.lir"
    end,
  },
  {
    "andymass/vim-matchup",
    event = "CursorMoved",
    config = function()
      require "user.matchup"
    end,
  },
  {
    "nacro90/numb.nvim",
    event = "BufRead",
    config = function()
      require("user.numb").config()
    end,
  },
  {
    "monaqa/dial.nvim",
    event = "BufRead",
    config = function()
      require("user.dial").config()
    end,
  },
  {
    "norcalli/nvim-colorizer.lua",
    config = function()
      require("user.colorizer").config()
    end,
  },
  -- {
  --   "nvim-telescope/telescope-project.nvim",
  --   event = "BufWinEnter",
  --   setup = function()
  --     vim.cmd [[packadd telescope.nvim]]
  --   end,
  -- },
  {
    "windwp/nvim-spectre",
    event = "BufRead",
    config = function()
      require("user.spectre").config()
    end,
  },
  {
    "folke/zen-mode.nvim",
    config = function()
      require("user.zen").config()
    end,
  },
  {
    "karb94/neoscroll.nvim",
    config = function()
      require("user.neoscroll").config()
    end,
  },
  -- {
  --   "vuki656/package-info.nvim",
  --   config = function()
  --     require "user.package-info"
  --   end,
  --   ft = "json",
  -- },
  -- {
  --   "rcarriga/nvim-notify",
  --   event = "BufRead",
  --   config = function()
  --     require("user.notify").config()
  --   end,
  -- },
  {
    "simrat39/symbols-outline.nvim",
    -- cmd = "SymbolsOutline",
    config = function()
      require("user.outline").config()
    end,
  },
  -- TODO: maybe oneday
  -- { "gelguy/wilder.nvim",
  --   config = function ()
  --     vim.cmd("source $HOME/.config/lvim/lua/user/wilder.vim")
  --   end
  -- },
  -- {
  --   "folke/twilight.nvim",
  --   config = function()
  --     require("user.twilight").config()
  --   end,
  --   -- cmd = "ZenMode",
  -- },
  --

  {
    "tzachar/cmp-tabnine",
    config = function()
      local tabnine = require "cmp_tabnine.config"
      tabnine:setup {
        max_lines = 1000,
        max_num_results = 20,
        sort = true,
      }
    end,

    run = "./install.sh",
    requires = "hrsh7th/nvim-cmp",
  },
  -- {
  --   "tzachar/compe-tabnine",
  --   run = "./install.sh",
  --   requires = "hrsh7th/nvim-compe",
  --   event = "InsertEnter",
  --   disable = not lvim.builtin.tabnine.active,
  -- },
  {
    "dccsillag/magma-nvim",
  },
  {
    "metakirby5/codi.vim",
    cmd = "Codi",
  },
  {
    "folke/trouble.nvim",
    cmd = "TroubleToggle",
  },
  {
    "kevinhwang91/nvim-bqf",
    event = "BufRead",
  },
  {
    "iamcco/markdown-preview.nvim",
    run = "cd app && npm install",
    ft = "markdown",
  },
  {
    "nvim-treesitter/playground",
    event = "BufRead",
  },
  {
    "windwp/nvim-ts-autotag",
    event = "InsertEnter",
  },
  {
    "sindrets/diffview.nvim",
    event = "BufRead",
  },
}

vim.cmd [[ au CmdWinEnter * quit ]]
-- TODO: q quits in spectr_panel ft
-- Autocommands (https://neovim.io/doc/user/autocmd.html)
-- O.user_autocommands = {{ "BufWinEnter", "*", "echo \"hi again\""}}

-- way to get os name
-- print(vim.loop.os_uname().sysname)

-- *Must* be *S*olidity not solidity
require("nvim-treesitter.parsers").get_parser_configs().solidity = {
  install_info = {
    url = "https://github.com/JoranHonig/tree-sitter-solidity",
    files = { "src/parser.c" },
    requires_generate_from_grammar = true,
  },
  filetype = "solidity",
}
