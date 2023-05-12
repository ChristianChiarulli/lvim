local M = {}

function M.setup(opts)
  local plugin_opts = {
    option1 = opts.option1 or "default_value1",
    option2 = opts.option2 or "default_value2",
  }
  return plugin_opts
end

function M.my_command()
  print "MyPlugin command executed!"
end

vim.api.nvim_set_keymap("n", "<c-a>", '<cmd>lua require("nostr").my_command()<cr>', { noremap = true })

return M
