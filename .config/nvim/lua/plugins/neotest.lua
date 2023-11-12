local M = {
	"nvim-neotest/neotest",
	dependencies = {

		"nvim-neotest/neotest-python",
	}
}

M.config = function()
	require("neotest").setup({
		adapters = {
			require("neotest-python")({
				-- Extra arguments for nvim-dap configuration
				-- See https://github.com/microsoft/debugpy/wiki/Debug-configuration-settings for values
				dap = { justMyCode = true },
				-- Command line arguments for runner
				-- Can also be a function to return dynamic values
				args = { "-vv" },
				-- Runner to use. Will use pytest if available by default.
				-- Can be a function to return dynamic value.
				runner = "pytest",
				-- Custom python path for the runner.
				-- Can be a string or a list of strings.
				-- Can also be a function to return dynamic value.
				-- If not provided, the path will be inferred by checking for
				-- virtual envs in the local directory and for Pipenev/Poetry configs
				python = ".venv/bin/python",
				-- Returns if a given file path is a test file.
				-- NB: This function is called a lot so don't perform any heavy tasks within it.
			}),
		},
	})

	---@diagnostic disable-next-line: undefined-global
	local b = vim.keymap.set
	local opts = { noremap = true, silent = true }

	-- b("n", "<leader>dtm", "<cmd>lua require('neotest').run.run({strategy='dap'})<CR>", opts)
	b("n", "<leader>dtm", "<cmd>lua require('neotest').run.run()<CR>", opts)
	b("n", "<leader>dtl", "<cmd>lua require('neotest').run.run_last()<CR>", opts)
	b("n", "<leader>dto", "<cmd>lua require('neotest').output.open({enter=true})<CR>", opts)
	b("n", "<leader>dts", "<cmd>lua require('neotest').run.stop()<CR>", opts)
	b("n", "<leader>dtf", "<cmd>lua require('neotest').run.run({vim.fn.expand('%')})<CR>", opts)
	b("n", "<leader>dti", "<cmd>lua require('neotest').summary.toggle()<CR>", opts)

	b("n", "<leader>dtd", "<ESC>:lua require('dap-python').debug_selection()<CR>", opts)
end
return M
