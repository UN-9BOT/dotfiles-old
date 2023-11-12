---@diagnostic disable: undefined-global
local M = {
	"nvim-telescope/telescope.nvim",
	dependencies = {
		"kkharji/sqlite.lua",           -- for other dependencies
		"piersolenski/telescope-import.nvim", -- leader shift i = import
		{
			"prochri/telescope-all-recent.nvim", -- frecency sorting for Find files
			config = function()
				require("telescope-all-recent").setup({
					close_if_last_window = false, -- Close Neo-tree if it is the last window left in the tab
					pickers = {
						find_files = {
							disable = false,
							use_cwd = true,
							sorting = "frecency",
						},
					},
				})
			end,
		},
		{ "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
	},
}

M.config = function()
	local b = vim.keymap.set
	local opts = { noremap = true, silent = true }
	local actions = require("telescope.actions")
	local builtin = require("telescope.builtin")
	local previewers = require('telescope.previewers')
	local trouble = require("trouble.providers.telescope")
	local def_mapping = { i = { ["<esc>"] = actions.close } }
	local delta = previewers.new_termopen_previewer {
		get_command = function(entry)
			return { 'git', '-c', 'core.pager=delta', '-c', 'delta.side-by-side=false', 'blame', entry.value .. '^!',
				'--', entry.current_file }
		end
	}
	b({ "n", "v" }, ",c", builtin.git_bcommits_range, opts)
	b({ "n", "v" }, ",t", builtin.treesitter, opts)

	b("n", ",f", "<CMD>Telescope find_files<CR>", opts)
	b("n", ",g", builtin.live_grep, opts)
	b({ "n", "v" }, ",v", builtin.grep_string, opts)
	b({ "n", "v" }, ",r", builtin.registers, opts)
	-- b("n", "<c-f>", builtin.current_buffer_fuzzy_find, opts)
	b("n", "<c-f>", "<CMD>Spectre<CR>", opts)
	b("n", ",j", builtin.jumplist, opts)
	b("n", ",J", "<CMD> clearjumps<CR>", { noremap = true })
	M.my_git_bcommits = function(opts)
		opts = opts or {}
		opts.previewer = {
			delta,
			previewers.git_commit_message.new(opts),
			previewers.git_commit_diff_as_was.new(opts),
		}

		builtin.git_bcommits_range(opts)
	end
	b({ "n", "v" }, ",b", M.my_git_bcommits)

	local telescope = require("telescope").setup({
		defaults = {
			file_ignore_patterns = {
				"node_modules",
				"static",
				"assets/**",
				"assets/",
				"*/assets",
				".json",
				"site-packages",
				"site-packages/*",
				"site-packages/%",
				"docs/",
				"poetry.lock",
				"migrations",
				"%.class$",
				"%.dmg$",
				"%.pyc$",
				"%.pyi$",
				"%.tar",
				"%.zip$",
				"^.dart_tool/",
				"^.git/",
				"^.github/",
				"^.gradle/",
				"^.idea/",
				"^.settings/",
				"^.vscode/",
				"^.env/",
				"^__pycache__/",
				"^bin/",
				"^build/",
				"^env/",
				"^gradle/",
				"^node_modules/",
				"^obj/",
				"^target/",
				"^vendor/",
				"^zig%-cache/",
				"^zig%-out/",
				-- "tests/",
				"%.html"
			},
			mappings = {
				i = { ["<c-t>"] = trouble.open_with_trouble },
				n = { ["<c-t>"] = trouble.open_with_trouble },
			}
		},
		extensions = {
			media_files = {
				-- filetypes whitelist
				-- defaults to {"png", "jpg", "mp4", "webm", "pdf"}
				filetypes = { "png", "webp", "jpg", "jpeg", "webm", "pdf" },
				-- find command (defaults to `fd`)
				find_cmd = "rg",
			},
			fzf = {
				fuzzy = true,         -- false will only do exact matching
				override_generic_sorter = false, -- override the generic sorter
				override_file_sorter = false, -- override the file sorter
				case_mode = "smart_case", -- or "ignore_case" or "respect_case"
				-- the default case_mode is "smart_case"
			}
		},
		pickers = {
			find_files = {
				layout_config = { height = 0.4 },
				theme = "ivy",
				previewer = true,
				sorting = "frecency",
				mappings = def_mapping,
			},
			marks = {
				layout_config = { height = 0.4 },
				theme = "ivy",
				previewer = true,
				sorting = "frecency",
				mappings = def_mapping,
			},
			diagnostics = {
				layout_config = { height = 0.4 },
				theme = "ivy",
				previewer = true,
				sorting = "frecency",
				bufnr = 0,
				mappings = def_mapping,
			},
			live_grep = {
				layout_config = {
					anchor = "N",
					height = 0.50,
					mirror = true,
					width = 0.95,
				},
				theme = "dropdown",
				mappings = def_mapping,
			},
			git_bcommits_range = {
				layout_config = {
					anchor = "N",
					height = 0.30,
					mirror = true,
					width = 0.95,
				},
				theme = "dropdown",
				mappings = def_mapping,
			},
			treesitter = {
				layout_config = {
					anchor = "N",
					height = 0.30,
					mirror = true,
					width = 0.95,
				},
				theme = "dropdown",
				mappings = def_mapping,
			},
			grep_string = {
				layout_config = {
					anchor = "N",
					height = 0.30,
					mirror = true,
					width = 0.95,
				},
				theme = "dropdown",
				mappings = def_mapping,
			},
			registers = {
				theme = "dropdown",
				mappings = def_mapping,
			},
			current_buffer_fuzzy_find = {
				layout_config = {
					anchor = "N",
					height = 0.30,
					mirror = true,
					width = 0.95,
				},
				theme = "dropdown",
				mappings = def_mapping,
			},
			jumplist = {
				layout_config = {
					anchor = "N",
					height = 0.30,
					mirror = true,
					width = 0.95,
				},
				theme = "dropdown",
				mappings = {
					i = {
						["<esc>"] = actions.close,
						["<CR>"] = actions.select_default + actions.center
					},
				},

			}
		},
	})
	require("telescope").load_extension("fzf")
	require("telescope").load_extension("import")
	-- require("telescope").load_extension('media_files')
	-- require("telescope").load_extension("live_grep_args")
	-- require("telescope").load_extension("file_browser")
end


return M
