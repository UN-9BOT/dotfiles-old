local M = {
	"rcarriga/nvim-dap-ui",
}
M.config = function()
	require("dapui").setup()

	---@diagnostic disable-next-line: undefined-global
	local b = vim.keymap.set
	local opts = { noremap = true, silent = true }

	b("n", "<leader>du", "<cmd>lua require('dapui').toggle()<CR>", opts)

    -- automatically open/close the DAP UI when starting/stopping the debugger
    local listener = require("dap").listeners
    listener.after.event_initialized["dapui_config"] = function() require("dapui").open() end
    listener.before.event_terminated["dapui_config"] = function () require("dapui").close() end
    listener.before.event_exited["dapui_config"] = function() require("dapui").close() end
end

return M
