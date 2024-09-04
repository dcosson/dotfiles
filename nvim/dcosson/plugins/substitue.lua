return {
  "gbprod/substitute.nvim",
  opts = {},
  config = function(_, opts)
    local substitute = require('substitute')
    substitute.setup(opts)

    vim.keymap.set("n", "s", substitute.operator, { noremap = true })
    vim.keymap.set("n", "ss", substitute.line, { noremap = true })
    vim.keymap.set("n", "S", substitute.eol, { noremap = true })
    vim.keymap.set("x", "s", substitute.visual, { noremap = true })
  end
}
