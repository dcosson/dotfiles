-- for nvim-tree: disable netrw at the very start of your init.lua
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

local opt = vim.opt

-- set how linenumbers show up
opt.relativenumber = true
opt.number = true

-- tabs & indentation
opt.tabstop = 2 -- number of spaces that a tab character takes up
opt.shiftwidth = 0 -- number of spaces to insert instead of a tab, 0 means same as tabstop value
opt.expandtab = true -- expand tabs to spaces
opt.autoindent = true -- copy indent from previous line when starting a new line

-- Enable mouse mode, can be useful for resizing splits for example!
vim.opt.mouse = "a"

-- Don't show the mode, since it's already in the status line
vim.opt.showmode = false

-- line wrap
opt.wrap = true
opt.breakindent = true -- if using wrap, can set this true to match wrap to indent level

-- backspace
opt.backspace = "indent,eol,start"

-- Sets how neovim will display certain whitespace characters in the editor.
opt.list = false
opt.listchars = { tab = "» ", trail = "·", nbsp = "␣", eol = "$" }

-- Preview substitutions live, as you type!
opt.inccommand = "split"

-- Show which line your cursor is on
opt.cursorline = true

-- Save undo history
opt.undofile = true

-- Decrease update time
opt.updatetime = 250

-- Decrease mapped sequence wait time
-- Displays which-key popup sooner
vim.opt.timeout = true
vim.opt.timeoutlen = 500

-- colors
opt.termguicolors = true
opt.background = "dark"
opt.signcolumn = "yes" -- always show sign column so text doesn't shift

-- Set highlight on search, but clear on pressing <Esc> in normal mode
vim.opt.hlsearch = true

-- Case-insensitive searching UNLESS \C or one or more capital letters in the search term
opt.ignorecase = true
opt.smartcase = true

-- Minimal number of screen lines to keep above and below the cursor.
opt.scrolloff = 10

-- Configure how new splits should be opened
opt.splitright = true
opt.splitbelow = true
