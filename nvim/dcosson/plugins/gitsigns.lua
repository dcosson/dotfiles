return {
	"lewis6991/gitsigns.nvim",
	opts = {
		current_line_blame = false,
	},
	keys = {
		{ "<leader>gp", "<cmd>Gitsigns preview_hunk<CR>", desc = "Git [P]review hunk" },
		{ "<leader>gs", "<cmd>Gitsigns stage_hunk<CR>", desc = "Git [S]tage hunk" },
		{ "<leader>gr", "<cmd>Gitsigns reset_hunk<CR>", desc = "Git [R]eset hunk" },
		{ "<leader>gu", "<cmd>Gitsigns undo_stage_hunk<CR>", desc = "Git [U]ndo stage hunk" },
		{ "<leader>gl", "<cmd>Gitsigns toggle_current_line_blame<CR>", desc = "Git [L]ine blame toggle" },
		{ "]h", "<cmd>Gitsigns next_hunk<CR>", desc = "Next git hunk" },
		{ "[h", "<cmd>Gitsigns prev_hunk<CR>", desc = "Previous git hunk" },
	},
}
