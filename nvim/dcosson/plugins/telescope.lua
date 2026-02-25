return {
	"nvim-telescope/telescope.nvim",
	dependencies = {
		"nvim-lua/plenary.nvim",
		{ "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
		"nvim-tree/nvim-web-devicons",
	},
	opts = {
		defaults = {
			path_display = { "smart" },
		},
		pickers = {
			find_files = {
				follow = true,
			},
		},
	},
	config = function(_, opts)
		local telescope = require("telescope")
		telescope.setup(opts)
		telescope.load_extension("fzf")

		vim.keymap.set("n", "<C-p>", "<cmd>Telescope find_files<CR>", { desc = "Telescope: Fuzzy file [p]icker" })
		vim.keymap.set(
			"n",
			"<leader>f",
			"<cmd>Telescope live_grep<CR>",
			{ desc = "Telescope: [F]ind within all files, and then use <C-space> to fuzzy filter" }
		)
	end,
}
