-- keymappings
lvim.leader = "space"

lvim.keys.normal_mode["<esc><esc>"] = "<cmd>nohlsearch<cr>"
lvim.keys.visual_mode["p"] = [["_dP]]
lvim.keys.normal_mode["Q"] = "<cmd>BufferClose!<CR>"
lvim.keys.normal_mode["<F1>"] = "<nop>"
lvim.keys.normal_mode["<F1>"] = "<cmd>Telescope commands<CR>"
lvim.keys.normal_mode["<F11>"] = "<cmd>lua vim.lsp.buf.references()<CR>"
lvim.keys.normal_mode["<F12>"] = "<cmd>lua vim.lsp.buf.definition()<CR>"
lvim.keys.normal_mode["<F3>"] = '<cmd>lua require("user.bookmark").toggle_bookmark()<CR>'
lvim.keys.normal_mode["<F4>"] = '<cmd>lua require("user.bookmark").remove_bookmark()<CR>'
lvim.keys.normal_mode["<F4>"] = "<cmd>Telescope resume<cr>"
lvim.keys.normal_mode["<F5>"] = ":e ~/Notes/<cr>"
lvim.keys.normal_mode["<TAB>"] = "<cmd>lua vim.lsp.buf.signature_help()<CR>"
lvim.keys.normal_mode["mm"] = "<cmd>BookmarkToggle<cr>"
lvim.keys.normal_mode["mj"] = "<cmd>BookmarkNext<cr>"
lvim.keys.normal_mode["mk"] = "<cmd>BookmarkPrev<cr>"
lvim.keys.normal_mode["ms"] = "<cmd>Telescope vim_bookmarks all<cr>"
lvim.keys.normal_mode["mc"] = "<cmd>BookmarkClear<cr>"
lvim.keys.normal_mode["mx"] = "<cmd>BookmarkClearAll<cr>"

-- for finding syntax ids for non TS enabled languages
vim.cmd [[
map <F6> :echo "hi<" . synIDattr(synID(line("."),col("."),1),"name") . '> trans<' . synIDattr(synID(line("."),col("."),0),"name") . "> lo<" . synIDattr(synIDtrans(synID(line("."),col("."),1)),"name") . ">" . " FG:" . synIDattr(synIDtrans(synID(line("."),col("."),1)),"fg#")<CR>
]]
lvim.keys.normal_mode["<F7>"] = "<cmd>TSHighlightCapturesUnderCursor<cr>"
lvim.keys.normal_mode["<F8>"] = "<cmd>TSPlaygroundToggle<cr>"

-- Whichkey
lvim.builtin.which_key.mappings.l.d = { "<cmd>TroubleToggle<cr>", "Diagnostics" }
lvim.builtin.which_key.mappings.l.R = { "<cmd>TroubleToggle lsp_references<cr>", "References" }
lvim.builtin.which_key.mappings.l.o = { "<cmd>SymbolsOutline<cr>", "Outline" }
lvim.builtin.which_key.mappings.T.h = { "<cmd>TSHighlightCapturesUnderCursor<cr>", "Highlight" }
lvim.builtin.which_key.mappings.T.p = { "<cmd>TSPlaygroundToggle<cr>", "Playground" }
lvim.builtin.which_key.mappings.s.l = { "<cmd>Telescope resume<cr>", "Last Search" }
lvim.builtin.which_key.mappings.g.l = { "<cmd>GitBlameToggle<cr>", "Blame" }

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
lvim.builtin.which_key.mappings["m"] = {
  name = "Replace",
  a = { "<cmd>BookmarkAnnotate<cr>", "Annotate" },
  b = { "<cmd>Telescope vim_bookmarks current_file<cr>", "Show Buffer" },
  c = { "<cmd>BookmarkClear<cr>", "Clear" },
  h = { '<cmd>lua require("harpoon.mark").add_file()<cr>', "Harpoon Mark" },
  u = { '<cmd>lua require("harpoon.ui").toggle_quick_menu()<cr>', "Harpoon Menu" },
  m = { "<cmd>BookmarkToggle<cr>", "Toggle" },
  j = { "<cmd>BookmarkNext<cr>", "Next" },
  k = { "<cmd>BookmarkPrev<cr>", "Prev" },
  -- q = { "<cmd>BookmarkShowAll<cr>", "Show QF" },
  s = { "<cmd>Telescope vim_bookmarks all<cr>", "Show All" },
  x = { "<cmd>BookmarkClearAll<cr>", "Clear All" },
}
-- lvim.builtin.which_key.mappings.f = { "<cmd>lua require('lir.float').toggle()<cr>", "Files" }
lvim.builtin.which_key.mappings["P"] = { "<cmd>Telescope projects<cr>", "Projects" }
lvim.builtin.which_key.mappings["R"] = { '<cmd>lua require("renamer").rename()<cr>', "Projects" }

-- Telescope
lvim.builtin.telescope.on_config_done = function()
  local actions = require "telescope.actions"
  lvim.builtin.telescope.defaults.mappings.i["<C-j>"] = actions.move_selection_next
  lvim.builtin.telescope.defaults.mappings.i["<C-k>"] = actions.move_selection_previous
  lvim.builtin.telescope.defaults.mappings.i["<C-n>"] = actions.cycle_history_next
  lvim.builtin.telescope.defaults.mappings.i["<C-p>"] = actions.cycle_history_prev
end
