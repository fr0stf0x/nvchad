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
  -- {
  --   "pmizio/typescript-tools.nvim",
  --   dependencies = { "nvim-lua/plenary.nvim", "neovim/nvim-lspconfig" },
  --   ft = {
  --     "typescript",
  --     "javascript",
  --     "typescriptreact",
  --   },
  --   opts = {
  --     on_attach,
  --   },
  -- },
  {
    "olexsmir/gopher.nvim",
    event = "LspAttach",
    ft = "go",
    config = function(_, opts)
      require("gopher").setup(opts)
    end,
    -- build = function()
    --   vim.cmd [[silent! GoInstallDeps]]
    -- end,
  },
  {
    "simrat39/rust-tools.nvim",
    ft = "rust",
    dependencies = "neovim/nvim-lspconfig",
    opts = function()
      return require "custom.configs.rust-tools"
    end,
    config = function(_, opts)
      require("rust-tools").setup(opts)
    end,
  },
  {
    "saecki/crates.nvim",
    ft = { "rust", "toml" },
    dependencies = "hrsh7th/nvim-cmp",
    config = function(_, opts)
      local crates = require "crates"
      crates.setup(opts)
      -- require("cmp").setup.buffer {
      --   sources = { { name = "crates" } },
      -- }
      crates.show()
      -- require("core.utils").load_mappings "crates"
    end,
  },
  {
    "rust-lang/rust.vim",
    ft = "rust",
    init = function()
      vim.g.rustfmt_autosave = 1
    end,
  },

  {
    "nvim-neotest/neotest",
    dependencies = {
      "nvim-neotest/neotest-go",
      "nvim-lua/plenary.nvim",
      "nvim-treesitter/nvim-treesitter",
      "antoinemadec/FixCursorHold.nvim",
    },
    ft = {
      "go",
    },
    config = function()
      -- get neotest namespace (api call creates or returns namespace)
      local neotest_ns = vim.api.nvim_create_namespace "neotest"
      vim.diagnostic.config({
        virtual_text = {
          format = function(diagnostic)
            local message = diagnostic.message:gsub("\n", " "):gsub("\t", " "):gsub("%s+", " "):gsub("^%s+", "")
            return message
          end,
        },
      }, neotest_ns)
      require("neotest").setup {
        -- your neotest config here
        adapters = {
          require "neotest-go",
        },
      }
    end,
  },
}
