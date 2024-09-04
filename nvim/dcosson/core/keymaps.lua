vim.g.mapleader = ","
vim.g.maplocalleader = ","

local keymap = vim.keymap

keymap.set("i", "jk", "<ESC>", { desc = "Exit insert mode with jk" })
-- maybe consider the less heavy-handed <leader>nh to clear highlights
keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>", { desc = "Clear search highlights by pressing <ESC> in normal mode" })
keymap.set("n", "\\c", [[<cmd>let @/=""<CR>]], { desc = "Clear the last search" })

-- Diagnostic keymaps
keymap.set("n", "<leader>ep", vim.diagnostic.goto_prev, { desc = "Go to [P]revious error message" })
keymap.set("n", "<leader>en", vim.diagnostic.goto_next, { desc = "Go to [N]ext error message" })
keymap.set("n", "<leader>ee", vim.diagnostic.open_float, { desc = "Show [E]rror message from current line" })
keymap.set("n", "<leader>eq", vim.diagnostic.setloclist, { desc = "Open diagnostic [Q]uickfix list" })

-- Navigate windows more easily
--  See `:help wincmd` for a list of all window commands
keymap.set("n", "<C-h>", "<C-w><C-h>", { desc = "Move focus to the left window" })
keymap.set("n", "<C-l>", "<C-w><C-l>", { desc = "Move focus to the right window" })
keymap.set("n", "<C-j>", "<C-w><C-j>", { desc = "Move focus to the lower window" })
keymap.set("n", "<C-k>", "<C-w><C-k>", { desc = "Move focus to the upper window" })

-- Highlight when yanking (copying) text
vim.api.nvim_create_autocmd("TextYankPost", {
	desc = "Highlight when yanking (copying) text",
	group = vim.api.nvim_create_augroup("dcosson-highlight-yank", { clear = true }),
	callback = function()
		vim.highlight.on_yank()
	end,
})
