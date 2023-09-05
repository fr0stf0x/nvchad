return {
  {
    "rainbowhxch/accelerated-jk.nvim",
    event = "BufRead",
    opts = {
      mode = "time_driven",
      enable_deceleration = false,
      acceleration_motions = {},
      acceleration_limit = 150,
      acceleration_table = { 7, 12, 17, 21, 24, 26, 28, 30 },
      -- when 'enable_deceleration = true', 'deceleration_table = { {200, 3}, {300, 7}, {450, 11}, {600, 15}, {750, 21}, {900, 9999} }'
      deceleration_table = { { 150, 9999 } },
    },
    config = function(_, opts)
      require("accelerated-jk").setup(opts)

      vim.api.nvim_set_keymap("n", "j", "<Plug>(accelerated_jk_gj)", {})
      vim.api.nvim_set_keymap("n", "k", "<Plug>(accelerated_jk_gk)", {})
    end,
  },
  {
    "ray-x/lsp_signature.nvim",
    event = "BufRead",
    config = function()
      require("lsp_signature").setup {
        hint_enable = false,
      }
    end,
  },
  {
    "kevinhwang91/nvim-bqf",
    event = "BufWinEnter",
    opts = {},
  },
  {
    "rhysd/clever-f.vim",
    event = { "BufReadPost", "BufAdd", "BufNewFile" },
    config = function()
      vim.api.nvim_set_hl(
        0,
        "CleverChar",
        { underline = true, bold = true, fg = "Orange", bg = "NONE", ctermfg = "Red", ctermbg = "NONE" }
      )
      vim.g.clever_f_mark_char_color = "CleverChar"
      vim.g.clever_f_mark_direct_color = "CleverChar"
      vim.g.clever_f_mark_direct = true
      vim.g.clever_f_timeout_ms = 1500
    end,
  },
  {
    "andymass/vim-matchup",
    event = "BufReadPost",
    config = function()
      vim.g.matchup_matchparen_offscreen = { method = "popup" }
    end,
  },
  {
    "simeji/winresizer",
    cmd = "WinResizerStartResize",
    keys = { "<C-e>" },
    config = function(_, _)
      vim.g.winresizer_finish_with_escape = 1
    end,
  },
  {
    "mbbill/undotree",
    keys = { { "<leader>u", "<Cmd>UndotreeToggle<CR>" } },
    config = function()
      vim.g.undotree_SetFocusWhenToggle = 1
      vim.g.undotree_WindowLayout = 2
      vim.g.undotree_ShortIndicators = 1
      vim.g.undotree_DiffpanelHeight = 15
    end,
  },
  {
    "petertriho/nvim-scrollbar",
    enabled = false,
    event = "BufReadPre",
    opts = { marks = { GitChange = { text = "│" } } },
    config = function(_, otps)
      require("scrollbar").setup(otps)
    end,
  },
  {
    "luukvbaal/statuscol.nvim",
    enabled = true,
    event = "VeryLazy",
    config = function()
      local builtin = require "statuscol.builtin"
      require("statuscol").setup {
        relculright = true,
        segments = {
          { text = { "%s" }, click = "v:lua.ScSa" },
          { text = { builtin.lnumfunc }, click = "v:lua.ScLa" },
          { text = { " ", builtin.foldfunc, " " }, click = "v:lua.ScFa" },
        },
      }
    end,
  },
  {
    "echasnovski/mini.move",
    keys = {
      { "<A-S-h>", mode = "n", desc = "Move line left" },
      { "<A-S-j>", mode = "n", desc = "Move line down" },
      { "<A-S-k>", mode = "n", desc = "Move line up" },
      { "<A-S-l>", mode = "n", desc = "Move line right" },
      { "<A-S-h>", mode = "v", desc = "Move selection left" },
      { "<A-S-j>", mode = "v", desc = "Move selection down" },
      { "<A-S-k>", mode = "v", desc = "Move selection up" },
      { "<A-S-l>", mode = "v", desc = "Move selection right" },
    },
    opts = {
      mappings = {
        left = "<A-S-h>",
        right = "<A-S-l>",
        down = "<A-S-j>",
        up = "<A-S-k>",
        line_left = "<A-S-h>",
        line_right = "<A-S-l>",
        line_down = "<A-S-j>",
        line_up = "<A-S-k>",
      },
    },
  },
  {
    "folke/flash.nvim",
    event = "VeryLazy",
    ---@type Flash.Config
    opts = {},
    keys = {
      {
        "s",
        mode = { "n", "x", "o" },
        function()
          require("flash").jump()
        end,
        desc = "Flash",
      },
      {
        "S",
        mode = { "n", "o", "x" },
        function()
          require("flash").treesitter()
        end,
        desc = "Flash Treesitter",
      },
      {
        "R",
        mode = { "o", "x" },
        function()
          require("flash").treesitter_search()
        end,
        desc = "Flash Treesitter Search",
      },
      {
        "<A-s>",
        mode = { "c" },
        function()
          require("flash").toggle()
        end,
        desc = "Toggle Flash Search",
      },
    },
  },
  {
    "ThePrimeagen/harpoon",
    event = "VeryLazy",
    keys = {
      { "<C-m>", '<Cmd>lua require("harpoon.mark").add_file()<CR>' },
      { "<A-m>", '<Cmd>lua require("harpoon.mark").rm_file()<CR>' },

      { "<leader>j", '<Cmd>lua require("harpoon.ui").nav_next()<CR>' },
      { "<leader>k", '<Cmd>lua require("harpoon.ui").nav_prev()<CR>' },

      -- { "<leader>h", '<Cmd>lua require("harpoon.ui").toggle_quick_menu()<CR>' },
      { "<leader>fh", "<Cmd>Telescope harpoon marks<CR>" },
    },
    opts = {
      menu = {
        width = vim.api.nvim_win_get_width(0) - 4,
      },
    },
    config = true,
  },
  -- {
  --   "iamcco/markdown-preview.nvim",
  --   build = "cd app && yarn install",
  --   -- init = function()
  --   --   vim.g.mkdp_filetypes = { "markdown" }
  --   -- end,
  --   config = function()
  --     vim.g.mkdp_auto_close = true
  --     vim.g.mkdp_open_to_the_world = false
  --     vim.g.mkdp_open_ip = "127.0.0.1"
  --     vim.g.mkdp_port = "8888"
  --     vim.g.mkdp_browser = ""
  --     vim.g.mkdp_echo_preview_url = true
  --     vim.g.mkdp_page_title = "${name}"
  --   end,
  --   ft = { "markdown" },
  -- },
}
