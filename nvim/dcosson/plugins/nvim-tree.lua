return {
  "nvim-tree/nvim-tree.lua",
  dependencies = "nvim-tree/nvim-web-devicons",
  opts = {
    view = {
      width = 55,
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
  },
  config = function(_, opts)
    require("nvim-tree").setup(opts)

    -- Setup keymaps
    vim.keymap.set("n", "<leader>W", "<cmd>NvimTreeToggle<CR>", { desc = "Toggle file explorer" }) -- toggle file explorer
    vim.keymap.set("n", "<leader>ee", "<cmd>NvimTreeToggle<CR>", { desc = "Toggle file explorer" }) -- toggle file explorer
    vim.keymap.set("n", "<leader>ef", "<cmd>NvimTreeFindFileToggle<CR>", { desc = "Toggle file explorer on current file" }) -- toggle file explorer on current file
    vim.keymap.set("n", "<leader>ec", "<cmd>NvimTreeCollapse<CR>", { desc = "Collapse file explorer" }) -- collapse file explorer
    vim.keymap.set("n", "<leader>er", "<cmd>NvimTreeRefresh<CR>", { desc = "Refresh file explorer." }) -- refresh file explorer, 
  end
}
