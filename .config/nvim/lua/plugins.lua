---@diagnostic disable: undefined-global
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable", -- latest stable release
		lazypath,
	})
end
vim.opt.rtp:prepend(lazypath)

local status_ok, lazy = pcall(require, "lazy")
if not status_ok then
	print("lazy just installed, please restart neovim")
	return
end

lazy.setup({
	-- -----------------------
	-- NOTE: WITHOUT CONFIG
	-- -----------------------
	--
	{ "nvim-lua/plenary.nvim" }, -- common utilities
	{ "kkharji/sqlite.lua" },    -- sqlite for other plugins
	{ "tribela/vim-transparent" }, -- transparent background
	{ "farmergreg/vim-lastplace" }, -- last position in files
	{ "tpope/vim-surround" },    -- surround ("' [ { }]')  	--> ysiw' | cs'" | ds",
	{ "tpope/vim-repeat" },      -- repeat for surround
	{ "sindrets/diffview.nvim" }, -- :Diffview
	{ "dhruvasagar/vim-zoom" },  -- ZOOM (leader shift z)
	{ "wellle/targets.vim" },    -- next for textobjects in( an( {["'
	{ "tpope/vim-fugitive" },    -- Neogit
	{ "jinh0/eyeliner.nvim" },   -- fast F motion and highlight uniq chars
	{ "chaoren/vim-wordmotion" }, -- word motion extra (split on parts)
	{
		"NeogitOrg/neogit",      -- leader G
		config = true
	},



	-- -----------------------
	-- NOTE: WITH CONFIG
	-- -----------------------
	--
	require("plugins.asterisk"),             -- * # highlight without next obj
	require("plugins.marks"),                -- marks manipulation
	require("plugins.twilight"),             -- highlight in Zoom mode
	require("plugins.markdown-preview"),     -- markdown preview :MarkdownPreview
	require("plugins.mini_bufremove"),       -- buffer delete :bd bdelete
	require("plugins.my_theme"),             -- themes
	require("plugins.indent"),               -- indent (отступы)

	require("plugins.rnvimr"),               -- ranger
	require("plugins.neotree"),              -- neotree

	require("plugins.vim_smooth_scroll"),    -- scrolling
	require("plugins.bufferline"),           -- buffers on top
	require("plugins.lualine"),              -- line on bottom
	require("plugins.treesitter"),           -- highlight syntax
	require("plugins.sessions"),             -- session
	require("plugins.telescope"),            -- telescope
	require("plugins.vim_auto_save"),        -- auto-save files
	require("plugins.easymotion"),           -- fast motion
	require("plugins.indent_blankline"),     -- indent blanklin for func
	require("plugins.rainbow_delimiters"),   -- rainbow brackets and operators
	require("plugins.nvim_autopairs"),       -- autopairs for brackets
	require("plugins.comment"),              -- commentary for
	require("plugins.todo_comments"),        -- TODO: WARNING: FIX: XXX: BUG: NOTE:
	require("plugins.neogen"),               -- DOC for C
	require("plugins.zen_mode"),             -- zen mode
	require("plugins.vim_visual_multi"),     -- multi cursor
	require("plugins.gitsigns"),             -- right sign inline
	require("plugins.lazygit"),              -- leader+l+g
	require("plugins.wilder"),               -- menu vim
	require("plugins.nvim-treesitter-context"), -- context (leader t c)
	require("plugins.tagbar"),               -- tagbar F8
	require("plugins.codeium"),              -- Codeium AI
	require("plugins.coc"),                  -- LSP
	require("plugins.ale"),                  -- linters
	require("plugins.trouble"),              -- quickfix, bug-list and other
	require("plugins.dap"),                  -- debugger
	require("plugins.dap_ui"),               -- debugger ui
	require("plugins.neotest"),              -- tests ui
	require("plugins.nvim-scrollview"),      -- scroll bar on right
	require("plugins.telekasten"),           -- notes in markdown
	require("plugins.hlslens"),              -- for navigate in search mode
	require("plugins.spectre"),              -- search and replace
	require("plugins.smart-splits"),         -- navigate for tmux and resize (ctrl -> navigate, alt -> resize)
	require("plugins.vim-matchup"),          -- % match

	-- ----------------------------
	-- NOTE: dependencies
	-- ----------------------------
	require("plugins.nvim-window-picker"), -- window picker for file_browser
	require("plugins.nvim_web_devicons"), -- for other plugins, extend with icons

	-- ----------------------------
	-- NOTE: ARCHIVE
	-- ----------------------------
	--
	-- { "mgedmin/python-imports.vim" },
	-- tag for import
	-- {
	-- 	"ludovicchabant/vim-gutentags",
	-- 	config = function()
	-- 		require("plugins.gutentags")
	-- 	end,
	-- },
	-- require("plugins.dap_python"),
	-- require("plugins.tmux"),
	-- require("plugins.telescope-coc"),
	-- require("plugins.glance"),
	-- require("plugins.ide"),
	-- { "christoomey/vim-tmux-navigator" }, -- tmux navigation for CTRL
	-- { "simeji/winresizer" }, -- resize windows CTRL+e
})
