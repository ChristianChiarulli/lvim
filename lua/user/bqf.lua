local opts = {
	auto_enable = true,
	magic_window = true,
	auto_resize_height = false,
	preview = {
		auto_preview = false,
		show_title = true,
		delay_syntax = 50,
		wrap = false,
	},
	func_map = {
		split = "s",
		vsplit = "v",
		stoggleup = "M",
		stoggledown = "m",
		stogglevm = "m",
		filterr = "f",
		filter = "F",
	},
}
-- open	open the item under the cursor in quickfix window	<CR>
-- openc	open the item, and close quickfix window	o
-- drop	use drop to open the item, and close quickfix window	O
-- tabdrop	use tab drop to open the item, and close quickfix window
-- tab	open the item in a new tab	t
-- tabb	open the item in a new tab, but stay at quickfix window	T
-- tabc	open the item in a new tab, and close quickfix window	<C-t>

-- split	open the item in vertical split	<C-x>
-- vsplit	open the item in horizontal split	<C-v>

-- prevfile	go to previous file under the cursor in quickfix window	<C-p>
-- nextfile	go to next file under the cursor in quickfix window	<C-n>
-- prevhist	go to previous quickfix list in quickfix window	<
-- nexthist	go to next quickfix list in quickfix window	>
-- lastleave	go to last leaving position in quickfix window	'"
-- stoggleup	toggle sign and move cursor up	<S-Tab>
-- stoggledown	toggle sign and move cursor down	<Tab>
-- stogglevm	toggle multiple signs in visual mode	<Tab>
-- stogglebuf	toggle signs for same buffers under the cursor	'<Tab>
-- sclear	clear the signs in current quickfix list	z<Tab>
-- pscrollup	scroll up half-page in preview window	<C-b>
-- pscrolldown	scroll down half-page in preview window	<C-f>
-- pscrollorig	scroll back to original position in preview window	zo
-- ptogglemode	toggle preview window between normal and max size	zp
-- ptoggleitem	toggle preview for an item of quickfix list	p
-- ptoggleauto	toggle auto preview when cursor moved	P
-- fzffilter	enter fzf mode	zf

require("bqf").setup(opts)
