return {
	"nvim-lualine/lualine.nvim",
	dependencies = { "nvim-tree/nvim-web-devicons" },
	opts = {
		options = {
			icons_enabled = true,
			theme = "auto",
			component_separators = { left = "", right = "" },
			section_separators = { left = "", right = "" },
			disabled_filetypes = {
				statusline = {},
				winbar = {},
			},
			ignore_focus = {},
			always_divide_middle = true,
			globalstatus = false,
			refresh = {
				statusline = 1000,
				tabline = 1000,
				winbar = 1000,
			},
		},
		sections = {
			lualine_a = { "mode" },
			lualine_b = { "branch", "diff", "diagnostics" },
			lualine_c = {
				{
					"filename",
					path = 1, -- 1 == relative path
				},
			},
			lualine_x = { "encoding", "fileformat", "filetype" },
			lualine_y = { "progress" },
			lualine_z = { "location" },
		},
		inactive_sections = {
			lualine_a = {},
			lualine_b = { "diagnostics" },
			lualine_c = { { "filename", path = 1 } },
			lualine_x = { "location" },
			lualine_y = {},
			lualine_z = {},
		},
		tabline = {},
		winbar = {},
		inactive_winbar = {},
		extensions = {},
		-- Experimenting with a top tabline for buffers
		-- tabline = {
		-- 	lualine_a = {},
		-- 	lualine_b = {},
		-- 	lualine_c = {
		-- 		{
		-- 			"buffers",
		-- 			show_filename_only = true,
		-- 			show_modified_status = true,
		-- 			mode = 4, -- 4 == buffer number and name
		-- 			max_length = vim.o.columns * 2 / 3,
		-- 			filetype_names = {
		-- 				NvimTree = "Nvim Tree",
		-- 				TelescopePrompt = "Telescope",
		-- 				dashboard = "Dashboard",
		-- 				packer = "Packer",
		-- 				fzf = "FZF",
		-- 				alpha = "Alpha",
		-- 			},
		-- 		},
		-- 	},
		-- 	lualine_x = {},
		-- 	lualine_y = {},
		-- 	lualine_z = {},
		-- },
	},
	config = function(_, opts)
		require("lualine").setup(opts)
	end,
}
