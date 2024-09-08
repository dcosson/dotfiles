return {
	"folke/trouble.nvim",
	dependencies = { "nvim-tree/nvim-web-devicons", "folke/todo-comments.nvim" },
	opts = {
		focus = true,
	},
	cmd = "Trouble",
	keys = {
		{ "<leader>td", "<cmd>Trouble [D]iagnostics toggle<CR>", desc = "Open trouble workspace diagnostics" },
		{
			"<leader>tD",
			"<cmd>Trouble [D]iagnostics toggle current buffer<CR>",
			desc = "Open trouble document diagnostics",
		},
		{ "<leader>tq", "<cmd>Trouble [Q]uickfix toggle<CR>", desc = "Open trouble quickfix list" },
		{ "<leader>tl", "<cmd>Trouble [L]oclist toggle<CR>", desc = "Open trouble location list" },
		{ "<leader>tt", "<cmd>Trouble [T]oDo toggle<CR>", desc = "Open todos in trouble" },
	},
}
