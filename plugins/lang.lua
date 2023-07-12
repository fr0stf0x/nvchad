local capabilities = require("plugins.configs.lspconfig").capabilities
local on_attach = require("plugins.configs.lspconfig").on_attach
local nvim_lsp = require "lspconfig"

return {
  {
    "jose-elias-alvarez/typescript.nvim",
    dependencies = "neovim/nvim-lspconfig",
    event = "LspAttach",
    config = function()
      require("typescript").setup {
        server = {
          capabilities,
          root_dir = nvim_lsp.util.root_pattern "package.json",
          on_attach,
          single_file_support = false,
        },
      }
    end,
  },
  {
    "olexsmir/gopher.nvim",
    event = "LspAttach",
    ft = "go",
    config = function(_, opts)
      require("gopher").setup(opts)
    end,
    build = function()
      vim.cmd [[silent! GoInstallDeps]]
    end,
  },
}
