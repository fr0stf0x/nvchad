return {
  {
    "rcarriga/nvim-notify",
    event = "VeryLazy",
    opts = {
      timeout = 3000,
      max_height = function()
        return math.floor(vim.o.lines * 0.75)
      end,
      max_width = function()
        return math.floor(vim.o.columns * 0.75)
      end,
    },
    config = function(_, opts)
      require("notify").setup(opts)
      vim.notify = require "notify"
    end,
  },
  -- {
  --   "folke/tokyonight.nvim",
  --   priority = 1000,
  --   -- lazy = false,
  --   opts = {
  --     style = "moon",
  --     on_highlights = function(hl, c)
  --       local prompt = "#2d3149"
  --       hl.TelescopeNormal = {
  --         bg = c.bg_dark,
  --         fg = c.fg_dark,
  --       }
  --       hl.TelescopeBorder = {
  --         bg = c.bg_dark,
  --         fg = c.bg_dark,
  --       }
  --       hl.TelescopePromptNormal = {
  --         bg = prompt,
  --       }
  --       hl.TelescopePromptBorder = {
  --         bg = prompt,
  --         fg = prompt,
  --       }
  --       hl.TelescopePromptTitle = {
  --         bg = prompt,
  --         fg = prompt,
  --       }
  --       hl.TelescopePreviewTitle = {
  --         bg = c.bg_dark,
  --         fg = c.bg_dark,
  --       }
  --       hl.TelescopeResultsTitle = {
  --         bg = c.bg_dark,
  --         fg = c.bg_dark,
  --       }
  --     end,
  --   },
  -- },
}
