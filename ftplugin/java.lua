local status, jdtls = pcall(require, "jdtls")
if not status then
  return
end
local home = os.getenv "HOME"
-- find_root looks for parent directories relative to the current buffer containing one of the given arguments.
if vim.fn.has "mac" == 1 then
  WORKSPACE_PATH = home .. "/workspace/"
elseif vim.fn.has "unix" == 1 then
  WORKSPACE_PATH = home .. "/workspace/"
else
  print "Unsupported system"
end

local root_markers = { ".gitmodules", ".git/" }
local root_dir = require("jdtls.setup").find_root(root_markers)
if root_dir == "" then
  return
end
local extendedClientCapabilities = jdtls.extendedClientCapabilities
extendedClientCapabilities.resolveAdditionalTextEditsSupport = true
JAVA_LS_EXECUTABLE = home .. "/.local/share/lunarvim/lvim/utils/bin/jdtls"

local bundles = {
    vim.fn.glob(home .. "/.config/lvim/java/java-debug/com.microsoft.java.debug.plugin/target/com.microsoft.java.debug.plugin-*.jar")
};

-- This is the new part
vim.list_extend(bundles, vim.split(vim.fn.glob(home .. "/.config/lvim/java/vscode-java-test/server/*.jar"), "\n"))

lvim.lsp.code_lens_refresh = false
jdtls.start_or_attach {
  on_attach = require("lvim.lsp").common_on_attach,
  -- on_attach = function(client, bufnr)
  --   -- With `hotcodereplace = 'auto' the debug adapter will try to apply code changes
  --   -- you make during a debug session immediately.
  --   -- Remove the option if you do not want that.
  --   require("jdtls").setup_dap { hotcodereplace = "auto" }
  -- end,
  -- init_options = {
  --   bundles = bundles,
  -- },
  flags = {
    allow_incremental_sync = true,
  },
  root_dir = root_dir,
  cmd = { JAVA_LS_EXECUTABLE, WORKSPACE_PATH .. vim.fn.fnamemodify(root_dir, ":p:h:t") },
  settings = {
    extendedClientCapabilities = extendedClientCapabilities,
    sources = {
      organizeImports = {
        starThreshold = 9999,
        staticStarThreshold = 9999,
      },
    },
    codeGeneration = {
      toString = {
        template = "${object.className}{${member.name()}=${member.value}, ${otherMembers}}",
      },
      useBlocks = true,
    },
    -- java = {
    -- 	signatureHelp = { enabled = true },
    -- 	contentProvider = { preferred = "fernflower" },
    -- 	codeGeneration = {
    -- 		toString = {
    -- 			template = "${object.className}{${member.name()}=${member.value}, ${otherMembers}}",
    -- 		},
    -- 	},
    -- },
    -- 	configuration = {
    -- 		runtimes = {
    -- 			{
    -- 				name = "JavaSE-11",
    -- 				path = "/usr/lib/jvm/java-11-openjdk/",
    -- 			},
    -- 			{
    -- 				name = "JavaSE-15",
    -- 				path = "/usr/lib/jvm/java-15-openjdk/",
    -- 			},
    -- 		},
    -- 	},
  },
}
local finders = require "telescope.finders"
local sorters = require "telescope.sorters"
local actions = require "telescope.actions"
local pickers = require "telescope.pickers"
local action_state = require "telescope.actions.state"

require("jdtls.ui").pick_one_async = function(items, prompt, label_fn, cb)
  local opts = {
    winblend = 15,
    layout_config = {
      prompt_position = "top",
      width = 80,
      height = 12,
    },
  }
  pickers.new(opts, {
    prompt_title = prompt,
    finder = finders.new_table {
      results = items,
      entry_maker = function(entry)
        return {
          value = entry,
          display = label_fn(entry),
          ordinal = label_fn(entry),
        }
      end,
    },
    sorter = sorters.get_generic_fuzzy_sorter(),
    attach_mappings = function(prompt_bufnr)
      actions.select_default:replace(function()
        local selection = action_state.get_selected_entry(prompt_bufnr)

        actions.close(prompt_bufnr)

        cb(selection.value)
      end)

      return true
    end,
  }):find()
end
require('jdtls').setup_dap()

vim.api.nvim_set_keymap("n", "<leader>la", ":lua require('jdtls').code_action()<CR>", {
  noremap = true,
  silent = true,
})

vim.cmd "command! -buffer JdtCompile lua require('jdtls').compile()"
vim.cmd "command! -buffer JdtUpdateConfig lua require('jdtls').update_project_config()"
-- vim.cmd "command! -buffer JdtJol lua require('jdtls').jol()"
vim.cmd "command! -buffer JdtBytecode lua require('jdtls').javap()"
-- vim.cmd "command! -buffer JdtJshell lua require('jdtls').jshell()"
vim.cmd [[setlocal shiftwidth=4]]
vim.cmd [[setlocal tabstop=4]]
