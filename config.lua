reload "user.plugins"
reload "user.options"
reload "user.keymaps"
reload "user.lsp"
reload "user.smoothie"
reload "user.harpoon"
reload "user.autocommands"
reload "user.webdev-icons"
reload "user.cybu"
reload "user.neotest"
reload "user.surround"
reload "user.bookmark"
reload "user.todo-comments"
reload "user.jaq"
reload "user.fidget"
reload "user.lab"
reload "user.git"
reload "user.zen-mode"
reload "user.inlay-hints"
reload "user.telescope"
reload "user.bqf"
reload "user.dial"
reload "user.numb"
reload "user.treesitter"
reload "user.neogit"
reload "user.colorizer"
reload "user.lualine"
reload "user.tabnine"
reload "user.copilot"
reload "user.chatgpt"
reload "user.whichkey"
reload "user.neoai"
reload "user.cmp"
reload "user.nvimtree"
reload "nostr"
reload "user.astro-tools"

function RunAstroSync()
  local command = 'astro sync'
  local handle = io.popen(command)
  local output = handle:read('*a')
  handle:close()

  if vim.v.job_info[handle].status ~= 0 then
    vim.api.nvim_err_writeln('Error running astro sync:')
    vim.api.nvim_err_writeln(output)
  else
    print('Astro sync completed successfully!')
  end
end
