-- NOTE: edge
--
return {
	"sainnhe/edge",
	lazy = false,
	priority = 1000,
	config = function()
		vim.cmd([[colorscheme edge]])
        vim.g.edge_better_performance = 1
	end,
}

-- NOTE: tokyonight
--
-- return {
-- 	"folke/tokyonight.nvim",
-- 	lazy = false,
-- 	priority = 1000,
-- 	config = function()
-- 		vim.cmd([[colorscheme tokyonight]])
-- 	end,
-- }

-- NOTE: catppuccin
--
-- return {
-- 	"catppuccin/nvim",
-- 	lazy = false,
-- 	priority = 1000,
-- 	config = function()
-- 		vim.cmd([[colorscheme catppuccin-frappe]])
-- 	end,
-- }
