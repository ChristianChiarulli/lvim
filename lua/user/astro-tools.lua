M = {}

M.run_astro_sync = function()
  local output = vim.fn.system "astro sync"
  vim.notify(output, "info", { title = "Astro Sync" })
  vim.cmd "LspRestart"

  -- local command = "astro sync"
  -- local handle = io.popen(command)

  -- if handle == nil then
  --   vim.api.nvim_err_writeln "Error running astro sync"
  --   return
  -- end

  -- local output = handle:read "*a"
  -- handle:close()

  -- if vim.v.job_info[handle].status ~= 0 then
  --   vim.api.nvim_err_writeln "Error running astro sync:"
  --   vim.api.nvim_err_writeln(output)
  -- else
  --   print "Astro sync completed successfully!"
  -- end
end

-- function RunAstroSync()
--   local command = "astro sync"
--   local handle = io.popen(command)
--   local output = handle:read "*a"
--   handle:close()

--   if vim.v.job_info[handle].status ~= 0 then
--     vim.api.nvim_err_writeln "Error running astro sync:"
--     vim.api.nvim_err_writeln(output)
--   else
--     print "Astro sync completed successfully!"
--     vim.cmd "LspRestart"
--   end
-- end

vim.cmd [[command! AstroSync lua require("user.astro-tools").run_astro_sync()]]

return M
