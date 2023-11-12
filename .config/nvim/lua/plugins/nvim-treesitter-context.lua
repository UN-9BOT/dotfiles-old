local M = {
    "nvim-treesitter/nvim-treesitter-context"
}

M.config = function()
    local b = vim.keymap.set
    b("n", "<leader>tc", "<cmd>TSContextToggle<cr>")
end

return M
