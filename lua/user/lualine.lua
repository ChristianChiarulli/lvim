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

