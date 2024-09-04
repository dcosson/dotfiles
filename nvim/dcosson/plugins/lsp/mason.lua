return {
  "williamboman/mason.nvim",
  dependencies = {
    "williamboman/mason-lspconfig.nvim",
    "WhoIsSethDaniel/mason-tool-installer.nvim",

  },
  opts = {
    ui = {
      icons = {
        package_installed = "✓",
        package_pending = "➜",
        package_uninstalled = "✗",
      }
    }

  },
  config = function(_, opts)
    local mason = require("mason")
    local mason_lspconfig = require("mason-lspconfig")
    local mason_tool_installer = require("mason-tool-installer")

    mason.setup(opts)

    mason_lspconfig.setup({
      -- list of LSP servers for mason to install
      ensure_installed = {
        "tsserver",
        "html",
        "cssls",
        "tailwindcss",
        -- "svelte",
        "lua_ls",
        "graphql",
        -- "emmet_ls",
        -- "prismals",
        "pyright",
      }
    })

    mason_tool_installer.setup({
      -- list of non-lsp formatters and linters to install
      ensure_installed = {
        "prettier",
        "stylua",
        "isort",
        "black",
        "pylint",
        "eslint_d",
      },
    })
  end

}
