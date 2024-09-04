return {
  "akinsho/bufferline.nvim",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  version = "*",
  opts = {
    options = {
      mode = "buffers",
      separator_style = "slant",
      diagnostics = "nvim_lsp",
    }
  },
  config = function(_, opts)
    require("bufferline").setup(opts)

    vim.keymap.set("n", "<leader>b", "<cmd>BufferLineCycleNext<CR>", { desc = "Select next [b]uffer in bufferline" })
    vim.keymap.set("n", "<leader>B", "<cmd>BufferLineCyclePrev<CR>", { desc = "Select previous [B]uffer in bufferline" })
  end
}
