local M = {
	"mfussenegger/nvim-dap-python",
}
M.keys = {
	{
		"<leader>dPt",
		function()
			require("dap-python").test_method()
		end,
		desc = "Debug Method",
	},
	{
		"<leader>dPc",
		function()
			require("dap-python").test_class()
		end,
		desc = "Debug Class",
	},
}
M.config = function()
	local path = require("mason-registry").get_package("debugpy"):get_install_path()
	-- local pythonPath = function()
	-- 	if vim.env.VIRTUAL_ENV then
	-- 		return vim.env.VIRTUAL_ENV .. "/bin/python"
	-- 	end
	-- 	-- debugpy supports launching an application with a different interpreter then the one used to launch debugpy itself.
	-- 	-- The code below looks for a `venv` or `.venv` folder in the current directly and uses the python within.
	-- 	-- You could adapt this - to for example use the `VIRTUAL_ENV` environment variable.
	-- 	local cwd = vim.fn.getcwd()
	-- 	if vim.fn.executable(cwd .. "/venv/bin/python") == 1 then
	-- 		return cwd .. "/venv/bin/python"
	-- 	elseif vim.fn.executable(cwd .. "/.venv/bin/python") == 1 then
	-- 		return cwd .. "/.venv/bin/python"
	-- 	else
	-- 		return "/usr/bin/python"
	-- 	end
	-- end
	require("dap-python").setup(path)
	require("dap-python").test_runner = "pytest"
end

return M
