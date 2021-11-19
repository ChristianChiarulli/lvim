local status, jdtls = pcall(require, "jdtls")
if not status then
	return
end
local home = os.getenv("HOME")
-- find_root looks for parent directories relative to the current buffer containing one of the given arguments.
if vim.fn.has("mac") == 1 then
	WORKSPACE_PATH = home .. "/workspace/"
elseif vim.fn.has("unix") == 1 then
	WORKSPACE_PATH = home .. "/workspace/"
else
	print("Unsupported system")
end

local root_markers = { ".gitmodules", ".git/" }
local root_dir = require("jdtls.setup").find_root(root_markers)
if root_dir == "" then
	return
end
local extendedClientCapabilities = jdtls.extendedClientCapabilities
extendedClientCapabilities.resolveAdditionalTextEditsSupport = true
JAVA_LS_EXECUTABLE = home .. "/.local/share/lunarvim/lvim/utils/bin/jdtls"

-- local JAR_FOLDER = "/dev/jdtls"
-- local jar_patterns = {
-- 	JAR_FOLDER .. "/java-debug/com.microsoft.java.debug.plugin/target/com.microsoft.java.debug.plugin-*.jar",
-- 	JAR_FOLDER .. "/vscode-java-decompiler/server/*.jar",
-- 	JAR_FOLDER .. "/vscode-java-test/server/*.jar",
-- }
-- local bundles = {}
-- for _, jar_pattern in ipairs(jar_patterns) do
-- 	for _, bundle in ipairs(vim.split(vim.fn.glob(home .. jar_pattern), "\n")) do
-- 		if not vim.endswith(bundle, "com.microsoft.java.test.runner.jar") then
-- 			table.insert(bundles, bundle)
-- 		end
-- 	end
-- end
lvim.lsp.code_lens_refresh = false
jdtls.start_or_attach({
    on_attach = require("lvim.lsp").common_on_attach,
	-- init_options = {
	-- 	bundles = bundles,
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
		java = {
			signatureHelp = { enabled = true },
			contentProvider = { preferred = "fernflower" },
			codeGeneration = {
				toString = {
					template = "${object.className}{${member.name()}=${member.value}, ${otherMembers}}",
				},
			},
		},
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
})

vim.cmd("command! -buffer JdtCompile lua require('jdtls').compile()")
vim.cmd("command! -buffer JdtUpdateConfig lua require('jdtls').update_project_config()")
-- vim.cmd "command! -buffer JdtJol lua require('jdtls').jol()"
vim.cmd("command! -buffer JdtBytecode lua require('jdtls').javap()")
-- vim.cmd "command! -buffer JdtJshell lua require('jdtls').jshell()"
vim.cmd[[setlocal shiftwidth=4]]
vim.cmd[[setlocal tabstop=4]]
