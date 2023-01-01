lvim.colorscheme = "darkplus"
lvim.log.level = "warn"
lvim.builtin.alpha.active = true
lvim.lsp.diagnostics.float.focusable = true
lvim.reload_config_on_save = false
lvim.builtin.illuminate.active = false
lvim.builtin.bufferline.active = false
lvim.builtin.alpha.mode = "dashboard"
lvim.builtin.terminal.active = true
lvim.builtin.nvimtree.setup.view.side = "left"
lvim.builtin.nvimtree.setup.renderer.icons.show.git = false
lvim.builtin.nvimtree.setup.view.mappings.custom_only = true
lvim.builtin.breadcrumbs.active = true
lvim.builtin.treesitter.highlight.enabled = true
lvim.builtin.dap.active = true
lvim.keys.term_mode = { ["<C-l>"] = false }
lvim.builtin.cmp.cmdline.enable = false
-- lvim.builtin.cmp.window.documentation = false
lvim.builtin.cmp.window.documentation = {
  border = "rounded",
  winhighlight = "NormalFloat:Pmenu,NormalFloat:Pmenu,CursorLine:PmenuSel,Search:None",
}
lvim.builtin.cmp.window.completion = {
  border = "rounded",
  winhighlight = "NormalFloat:Pmenu,NormalFloat:Pmenu,CursorLine:PmenuSel,Search:None",
}
lvim.builtin.cmp.formatting.source_names = {
  nvim_lsp = "",
  emoji = "",
  path = "",
  calc = "",
  cmp_tabnine = "",
  vsnip = "",
  luasnip = "",
  buffer = "",
  tmux = "",
  copilot = "",
  treesitter = "",
}
-- lvim.builtin.autopairs.active = false
-- vim.g.netrw_browse_split = 0
-- vim.g.netrw_banner = 0
-- vim.g.netrw_winsize = 25
vim.opt.showtabline = 0

local options = {
  backup = false, -- creates a backup file
  clipboard = "unnamedplus", -- allows neovim to access the system clipboard
  cmdheight = 1, -- more space in the neovim command line for displaying messages
  completeopt = { "menuone", "noselect" }, -- mostly just for cmp
  conceallevel = 0, -- so that `` is visible in markdown files
  fileencoding = "utf-8", -- the encoding written to a file
  hlsearch = true, -- highlight all matches on previous search pattern
  ignorecase = true, -- ignore case in search patterns
  mouse = "a", -- allow the mouse to be used in neovim
  pumheight = 10, -- pop up menu height
  showmode = false, -- we don't need to see things like -- INSERT -- anymore
  showtabline = 0, -- always show tabs
  smartcase = true, -- smart case
  smartindent = true, -- make indenting smarter again
  splitbelow = true, -- force all horizontal splits to go below current window
  splitright = true, -- force all vertical splits to go to the right of current window
  swapfile = false, -- creates a swapfile
  termguicolors = true, -- set term gui colors (most terminals support this)
  timeoutlen = 1000, -- time to wait for a mapped sequence to complete (in milliseconds)
  undofile = true, -- enable persistent undo
  updatetime = 100, -- faster completion (4000ms default)
  writebackup = false, -- if a file is being edited by another program (or was written to file while editing with another program), it is not allowed to be edited
  expandtab = true, -- convert tabs to spaces
  shiftwidth = 2, -- the number of spaces inserted for each indentation
  tabstop = 2, -- insert 2 spaces for a tab
  cursorline = true, -- highlight the current line
  number = true, -- set numbered lines
  laststatus = 3,
  showcmd = false,
  ruler = false,
  relativenumber = true, -- set relative numbered lines
  numberwidth = 4, -- set number column width to 2 {default 4}
  signcolumn = "yes", -- always show the sign column, otherwise it would shift the text each time
  wrap = false, -- display lines as one long line
  scrolloff = 0,
  sidescrolloff = 8,
  guifont = "monospace:h17", -- the font used in graphical neovim applications
  title = true,
  -- colorcolumn = "80",
  -- colorcolumn = "120",
}
-- vim.g.loaded_netrw = 1
-- vim.g.loaded_netrwPlugin = 1
-- vim.opt.fillchars.eob = " "
-- vim.opt.fillchars = vim.opt.fillchars + "vertleft: "
-- vim.opt.fillchars = vim.opt.fillchars + "vertright: "
vim.opt.fillchars = vim.opt.fillchars + "eob: "
vim.opt.fillchars:append {
  stl = " ",
}

vim.opt.shortmess:append "c"

for k, v in pairs(options) do
  vim.opt[k] = v
end

vim.cmd "set whichwrap+=<,>,[,],h,l"
vim.cmd [[set iskeyword+=-]]
vim.cmd [[set formatoptions-=cro]] -- TODO: this doesn't seem to work

vim.filetype.add {
  extension = {
    conf = "dosini",
  },
}

local Api = require "nvim-tree.api"

local DEFAULT_KEYMAPS = {
  {
    key = { "<CR>", "o", "<2-LeftMouse>" },
    callback = Api.node.open.edit,
    desc = "open a file or folder; root will cd to the above directory",
  },
  {
    key = "<C-e>",
    callback = Api.node.open.replace_tree_buffer,
    desc = "edit the file in place, effectively replacing the tree explorer",
  },
  {
    key = "O",
    callback = Api.node.open.no_window_picker,
    desc = "same as (edit) with no window picker",
  },
  {
    key = { "<C-]>", "<2-RightMouse>" },
    callback = Api.tree.change_root_to_node,
    desc = "cd in the directory under the cursor",
  },
  {
    key = "<C-v>",
    callback = Api.node.open.vertical,
    desc = "open the file in a vertical split",
  },
  {
    key = "<C-x>",
    callback = Api.node.open.horizontal,
    desc = "open the file in a horizontal split",
  },
  {
    key = "<C-t>",
    callback = Api.node.open.tab,
    desc = "open the file in a new tab",
  },
  {
    key = "<",
    callback = Api.node.navigate.sibling.prev,
    desc = "navigate to the previous sibling of current file/directory",
  },
  {
    key = ">",
    callback = Api.node.navigate.sibling.next,
    desc = "navigate to the next sibling of current file/directory",
  },
  {
    key = "P",
    callback = Api.node.navigate.parent,
    desc = "move cursor to the parent directory",
  },
  {
    key = "<BS>",
    callback = Api.node.navigate.parent_close,
    desc = "close current opened directory or parent",
  },
  {
    key = "<Tab>",
    callback = Api.node.open.preview,
    desc = "open the file as a preview (keeps the cursor in the tree)",
  },
  {
    key = "K",
    callback = Api.node.navigate.sibling.first,
    desc = "navigate to the first sibling of current file/directory",
  },
  {
    key = "J",
    callback = Api.node.navigate.sibling.last,
    desc = "navigate to the last sibling of current file/directory",
  },
  {
    key = "I",
    callback = Api.tree.toggle_gitignore_filter,
    desc = "toggle visibility of files/folders hidden via |git.ignore| option",
  },
  {
    key = "H",
    callback = Api.tree.toggle_hidden_filter,
    desc = "toggle visibility of dotfiles via |filters.dotfiles| option",
  },
  {
    key = "U",
    callback = Api.tree.toggle_custom_filter,
    desc = "toggle visibility of files/folders hidden via |filters.custom| option",
  },
  {
    key = "R",
    callback = Api.tree.reload,
    desc = "refresh the tree",
  },
  {
    key = "a",
    callback = Api.fs.create,
    desc = "add a file; leaving a trailing `/` will add a directory",
  },
  {
    key = "d",
    callback = Api.fs.remove,
    desc = "delete a file (will prompt for confirmation)",
  },
  {
    key = "D",
    callback = Api.fs.trash,
    desc = "trash a file via |trash| option",
  },
  {
    key = "r",
    callback = Api.fs.rename,
    desc = "rename a file",
  },
  {
    key = "<C-r>",
    callback = Api.fs.rename_sub,
    desc = "rename a file and omit the filename on input",
  },
  {
    key = "x",
    callback = Api.fs.cut,
    desc = "add/remove file/directory to cut clipboard",
  },
  {
    key = "c",
    callback = Api.fs.copy.node,
    desc = "add/remove file/directory to copy clipboard",
  },
  {
    key = "p",
    callback = Api.fs.paste,
    desc = "paste from clipboard; cut clipboard has precedence over copy; will prompt for confirmation",
  },
  {
    key = "y",
    callback = Api.fs.copy.filename,
    desc = "copy name to system clipboard",
  },
  {
    key = "Y",
    callback = Api.fs.copy.relative_path,
    desc = "copy relative path to system clipboard",
  },
  {
    key = "gy",
    callback = Api.fs.copy.absolute_path,
    desc = "copy absolute path to system clipboard",
  },
  {
    key = "]e",
    callback = Api.node.navigate.diagnostics.next,
    desc = "go to next diagnostic item",
  },
  {
    key = "]c",
    callback = Api.node.navigate.git.next,
    desc = "go to next git item",
  },
  {
    key = "[e",
    callback = Api.node.navigate.diagnostics.prev,
    desc = "go to prev diagnostic item",
  },
  {
    key = "[c",
    callback = Api.node.navigate.git.prev,
    desc = "go to prev git item",
  },
  {
    key = "-",
    callback = Api.tree.change_root_to_parent,
    desc = "navigate up to the parent directory of the current file/directory",
  },
  {
    key = "s",
    callback = Api.node.run.system,
    desc = "open a file with default system application or a folder with default file manager, using |system_open| option",
  },
  {
    key = "f",
    callback = Api.live_filter.start,
    desc = "live filter nodes dynamically based on regex matching.",
  },
  {
    key = "F",
    callback = Api.live_filter.clear,
    desc = "clear live filter",
  },
  {
    key = "q",
    callback = Api.tree.close,
    desc = "close tree window",
  },
  {
    key = "W",
    callback = Api.tree.collapse_all,
    desc = "collapse the whole tree",
  },
  {
    key = "E",
    callback = Api.tree.expand_all,
    desc = "expand the whole tree, stopping after expanding |callbacks.expand_all.max_folder_discovery| folders; this might hang neovim for a while if running on a big folder",
  },
  {
    key = "S",
    callback = Api.tree.search_node,
    desc = "prompt the user to enter a path and then expands the tree to match the path",
  },
  {
    key = ".",
    callback = Api.node.run.cmd,
    desc = "enter vim command mode with the file the cursor is on",
  },
  {
    key = "g?",
    callback = Api.tree.toggle_help,
    desc = "toggle help",
  },
  {
    key = "m",
    callback = Api.marks.toggle,
    desc = "Toggle node in bookmarks",
  },
  {
    key = "bmv",
    callback = Api.marks.bulk.move,
    desc = "Move all bookmarked nodes into specified location",
  },
  { key = { "l", "<CR>", "o" }, action = "edit", mode = "n" },
  { key = "h", action = "close_node" },
  { key = "v", action = "vsplit" },
  { key = "C", action = "cd" },
}

lvim.builtin.nvimtree.setup.view.mappings.list = DEFAULT_KEYMAPS
