-- general
lvim.format_on_save = true
lvim.colorscheme = "darkplus"

vim.opt.wrap = false

-- keymappings
lvim.leader = "space"
vim.cmd [[
nnoremap Y y$

" paste on cursor
"nnoremap gP i<CR><Esc>PkJxJx

"nnoremap gp a<CR><Esc>PkJxJx

" delete without yanking
"nnoremap <leader>d "_d
"vnoremap <leader>d "_d

" replace currently selected text with default register
" without yanking it
vnoremap p "_dP
]]

-- LSP
lvim.lsp.diagnostics.virtual_text = false
lvim.lsp.override = { "java" }

-- Builtins
lvim.builtin.dashboard.active = true
lvim.builtin.terminal.active = true

-- lvim.builtin.nvimtree.auto_open = 0
-- vim.g.nvim_tree_disable_netrw = 0
-- vim.g.nvim_tree_hijack_netrw = 0

-- Treesitter
lvim.builtin.treesitter.autotag.enable = true
lvim.builtin.treesitter.playground.enable = true

-- Additional Plugins
lvim.plugins = {
  { "lunarvim/colorschemes" },
  { "mfussenegger/nvim-jdtls" },
  {
    "ray-x/lsp_signature.nvim",
    event = "InsertEnter",
    config = function()
      require("user.lsp_signature").config()
    end,
  },
  {
    "unblevable/quick-scope",
    config = function()
      require "user.quickscope"
    end,
  },
  {
    "kevinhwang91/rnvimr",
    cmd = "Rnvimr",
    config = function()
      require "user.rnvimr"
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
    "mattn/vim-gist",
    event = "BufRead",
    requires = "mattn/webapi-vim",
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

-- Autocommands (https://neovim.io/doc/user/autocmd.html)
-- O.user_autocommands = {{ "BufWinEnter", "*", "echo \"hi again\""}}
