return {
	"folke/tokyonight.nvim",
	lazy = false,
	priority = 1000,
	opts = {
		style = "storm",
		on_colors = function(colors)
			-- Set various faded text to a blue-ish gray color with 20% saturation but make
			-- them a little brighter for readability, defaults are too dark on dark bg.
			colors.fg_gutter = "#52597a" -- 40% luminance
			colors.terminal_black = "#52597a" -- 40% luminance
			colors.comment = "#5c638a" -- 45% luminance

			-- Uncomment to try out making any other changes to full list of colors:
			-- colors.bg = "#24283b"
			-- colors.bg_dark = "#1f2335"
			-- colors.bg_float = "#1f2335"
			-- colors.bg_highlight = "#292e42"
			-- colors.bg_popup = "#1f2335"
			-- colors.bg_search = "#3d59a1"
			-- colors.bg_sidebar = "#1f2335"
			-- colors.bg_statusline = "#1f2335"
			-- colors.bg_visual = "#2e3c64"
			-- colors.black = "#1d202f"
			-- colors.blue = "#7aa2f7"
			-- colors.blue0 = "#3d59a1"
			-- colors.blue1 = "#2ac3de"
			-- colors.blue2 = "#0db9d7"
			-- colors.blue5 = "#89ddff"
			-- colors.blue6 = "#b4f9f8"
			-- colors.blue7 = "#394b70"
			-- colors.border = "#1d202f"
			-- colors.border_highlight = "#29a4bd"
			-- colors.comment = "#565f89"
			-- colors.cyan = "#7dcfff"
			-- colors.dark3 = "#545c7e"
			-- colors.dark5 = "#737aa2"
			-- colors.diff = {
			-- 	 add = "#283b4d",
			-- 	 change = "#272d43",
			-- 	 delete = "#3f2d3d",
			-- 	 text = "#394b70",
			-- }
			-- colors.error = "#db4b4b"
			-- colors.fg = "#c0caf5"
			-- colors.fg_dark = "#a9b1d6"
			-- colors.fg_float = "#c0caf5"
			-- colors.fg_gutter = "#3b4261"
			-- colors.fg_sidebar = "#a9b1d6"
			-- colors.git = {
			-- 	 add = "#449dab",
			-- 	 change = "#6183bb",
			-- 	 delete = "#914c54",
			-- 	 ignore = "#545c7e",
			-- }
			-- colors.green = "#9ece6a"
			-- colors.green1 = "#73daca"
			-- colors.green2 = "#41a6b5"
			-- colors.hint = "#1abc9c"
			-- colors.info = "#0db9d7"
			-- colors.magenta = "#bb9af7"
			-- colors.magenta2 = "#ff007c"
			-- colors.none = "NONE"
			-- colors.orange = "#ff9e64"
			-- colors.purple = "#9d7cd8"
			-- colors.rainbow = {
			--   "#7aa2f7",
			--   "#e0af68",
			--   "#9ece6a",
			--   "#1abc9c",
			--   "#bb9af7",
			--   "#9d7cd8",
			-- }
			-- colors.red = "#f7768e"
			-- colors.red1 = "#db4b4b"
			-- colors.teal = "#1abc9c"
			-- colors.terminal_black = "#414868"
			-- colors.todo = "#7aa2f7"
			-- colors.warning = "#e0af68"
			-- colors.yellow = "#e0af68"
		end,
	},
	config = function(_, opts)
		require("tokyonight").setup(opts)
		vim.cmd([[colorscheme tokyonight]])
	end,
}
