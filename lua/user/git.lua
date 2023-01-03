vim.g.gitblame_enabled = 0
vim.g.gitblame_message_template = "<summary> • <date> • <author>"
vim.g.gitblame_highlight_group = "LineNr"

lvim.builtin.gitsigns.opts.attach_to_untracked = false

vim.g.gist_open_browser_after_post = 1

local status_ok, gitlinker = pcall(require, "gitlinker")
if not status_ok then
	return
end

gitlinker.setup({
	opts = {
		callbacks = {
			["git.comcast.com"] = require("gitlinker.hosts").get_github_type_url,
		},
		-- remote = 'github', -- force the use of a specific remote
		-- adds current line nr in the url for normal mode
		add_current_line_on_normal_mode = true,
		-- callback for what to do with the url
		action_callback = require("gitlinker.actions").open_in_browser,
		-- print the url after performing the action
		print_url = false,
		-- mapping to call url generation
		mappings = "<leader>gy",
	},
})
