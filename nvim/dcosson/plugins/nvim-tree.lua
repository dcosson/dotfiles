return {
	"nvim-tree/nvim-tree.lua",
	dependencies = "nvim-tree/nvim-web-devicons",
	opts = {
		diagnostics = {
			enable = true,
			show_on_dirs = true,
			icons = {
				hint = "",
				info = "",
				warning = "",
				error = "",
			},
		},
		view = {
			width = 35,
			relativenumber = true,
		},
		-- show indent levels folder & better arrow icons
		renderer = {
			indent_markers = {
				enable = true,
			},
			icons = {
				glyphs = {
					folder = {
						arrow_closed = "", -- arrow when folder is closed
						arrow_open = "", -- arrow when folder is open
					},
				},
			},
		},
		-- enable the window picker when there's a split open
		actions = {
			open_file = {
				window_picker = {
					enable = true,
				},
			},
		},
		-- ignore certain files
		filters = {
			custom = { ".DS_Store", ".git" },
		},
		git = {
			enable = true,
			ignore = true,
			timeout = 500,
		},
		on_attach = function(bufnr)
			local api = require("nvim-tree.api")

			local function attach_opts(desc)
				return { desc = "nvim-tree: " .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
			end

			-- default mappings within nvim-tree window
			api.config.mappings.default_on_attach(bufnr)

			-- custom mappings within nvim-tree window
			-- I want the window picker available but I don't use it that often so Enter
			-- should skip it, explicitly trigger it with "p" default mapping
			vim.keymap.set("n", "<CR>", api.node.open.no_window_picker, attach_opts("Open"))
			vim.keymap.set("n", "<C-P>", api.node.open.edit, attach_opts("Open with Window [P]icker"))
			vim.keymap.set("n", "?", api.tree.toggle_help, attach_opts("Help"))
		end,
	},
	config = function(_, opts)
		require("nvim-tree").setup(opts)

		-- Setup keymaps
		vim.keymap.set(
			"n",
			"<leader>W",
			"<cmd>NvimTreeFindFileToggle<CR>",
			{ desc = "Toggle NvimTree explorer to current file" }
		)
		vim.keymap.set(
			"n",
			"<leader>ef",
			"<cmd>NvimTreeFindFileToggle<CR>",
			{ desc = "Toggle file explorer on current file" }
		) -- toggle file explorer on current file
		vim.keymap.set("n", "<leader>ec", "<cmd>NvimTreeCollapse<CR>", { desc = "Collapse file explorer" }) -- collapse file explorer
		vim.keymap.set("n", "<leader>er", "<cmd>NvimTreeRefresh<CR>", { desc = "Refresh file explorer." }) -- refresh file explorer,
	end,
}
