---@type MappingsTable
local M = {}

local function diagnostic_goto(next, severity)
  return function()
    severity = severity and vim.diagnostic.severity[severity] or nil

    if next == true then
      vim.diagnostic.goto_next { severity = severity }
    else
      vim.diagnostic.goto_prev { severity = severity }
    end
  end
end

M.disabled = {
  n = {
    ["[c"] = "",
    ["]c"] = "",
    ["[d"] = "",
    ["]d"] = "",
    ["<leader>fm"] = "",

    ["<leader>b"] = "",
    ["<leader>f"] = "",
    ["<leader>v"] = "",
    ["<leader>h"] = "",

    ["<A-v>"] = "",
    ["<A-h>"] = "",
    ["<A-i>"] = "",
  },

  t = {
    ["<A-v>"] = "",
    ["<A-h>"] = "",
    ["<A-i>"] = "",
  },
}

M.general = {
  n = {
    ["c"] = { '"_c' },
    ["C"] = { '"_C' },
    ["x"] = { '"_x' },
    ["X"] = { '"_X' },
    ["K"] = {
      function()
        vim.lsp.buf.hover()
      end,
    },
    -- [";"] = { ":", "enter command mode", opts = { nowait = true } },
    ["<leader>q"] = {
      "<cmd>confirm q<cr>",
      "quit",
    },
    ["[w"] = {
      diagnostic_goto(false, "WARNING"),
      "Go to previous warning",
    },
    ["]w"] = {
      diagnostic_goto(true, "WARNING"),
      "Go to previous warning",
    },
    ["[e"] = {
      diagnostic_goto(false, "ERROR"),
      "Go to previous error",
    },
    ["]e"] = {
      diagnostic_goto(true, "ERROR"),
      "Go to next error",
    },
    ["[c"] = {
      function()
        require("treesitter-context").go_to_context()
      end,
      "Jump to context",
    },
    ["<C-w>f"] = {
      "<cmd>CloseAllFloatingWindows<cr>",
      "Close all floating windows",
    },
  },
}

M.dap = {
  n = {
    ["<leader>U"] = {
      function()
        require("dapui").toggle()
      end,
      "Toggle Dap UI",
    },
    ["<leader>b"] = {
      function()
        require("dap").toggle_breakpoint()
      end,
      "Toggle breakpoint",
    },
    ["<leader>B"] = {
      function()
        require("dap").set_breakpoint(vim.fn.input "Breakpoint condition: ")
      end,
      "Set conditional breakpoint",
    },
    ["<F5>"] = {
      function()
        require("dap").continue()
      end,
      "Continue breakpoint",
    },
    ["<F10>"] = {
      function()
        require("dap").step_over()
      end,
      "Step over breakpoint",
    },
    ["<F11>"] = {
      function()
        require("dap").step_info()
      end,
      "Step into breakpoint",
    },
    ["<F12>"] = {
      function()
        require("dap").step_out()
      end,
      "Step out breakpoint",
    },
  },
}

M.gitsigns = {
  n = {
    ["<leader>G"] = {
      "<cmd>Git<cr>",
      "Open :Git",
    },
    ["]g"] = {
      function()
        vim.schedule(function()
          require("gitsigns").next_hunk()
        end)
        return "<Ignore>"
      end,
      "Jump to next hunk",
      opts = { expr = true },
    },
    ["[g"] = {
      function()
        vim.schedule(function()
          require("gitsigns").prev_hunk()
        end)
        return "<Ignore>"
      end,
      "Jump to prev hunk",
      opts = { expr = true },
    },
    ["<leader>gh"] = {
      function()
        require("gitsigns").reset_hunk()
      end,
      "Reset hunk",
    },
    ["<leader>gr"] = {
      function()
        require("gitsigns").reset_buffer()
      end,
      "Reset buffer",
    },
    ["<leader>gs"] = {
      function()
        require("gitsigns").stage_hunk()
      end,
      "Stage hunk",
    },
    ["<leader>gS"] = {
      function()
        require("gitsigns").stage_buffer()
      end,
      "Stage buffer",
    },
    ["<leader>gp"] = {
      function()
        require("gitsigns").preview_hunk()
      end,
      "Preview hunk",
    },
    ["<leader>gl"] = {
      function()
        package.loaded.gitsigns.blame_line()
      end,
      "Blame line",
    },
    ["<leader>gL"] = {
      function()
        package.loaded.gitsigns.blame_line { full = true }
      end,
      "Blame full line",
    },
    ["<leader>gd"] = {
      function()
        package.loaded.gitsigns.diffthis()
      end,
      "Diff this",
    },
  },
}

M.tabufline = {
  n = {
    ["<leader>n"] = { "<cmd> enew <CR>", "New buffer" },
    ["<leader>bc"] = {
      function()
        require("nvchad.tabufline").closeOtherBufs()
      end,
      "Close other buffers",
    },
    ["<leader>bC"] = {
      function()
        require("nvchad.tabufline").closeAllBufs()
      end,
      desc = "Close all buffers",
    },
  },
}

M.telescope = {
  n = {
    ["<leader>f<CR>"] = { "<cmd>Telescope resume<cr>", "find: Resume" },
    ["<leader>fs"] = { "<cmd>Telescope grep_string<cr>", "find: Current word" },
    ["<leader>gc"] = { "<cmd>Telescope git_commits<cr>", "find: Commits" },
    ["<leader>gC"] = { "<cmd>Telescope git_commits<cr>", "find: Buffer commits" },
    ["<leader>gb"] = { "<cmd>Telescope git_branches<cr>", "find: Branches" },
    ["gr"] = { "<cmd>Telescope lsp_references<cr>", "find: Lsp references" },
    ["gd"] = {
      "<cmd> Telescope lsp_definitions<cr>",
      "find: Lsp definitions",
    },
  },
}

M.lsp = {
  n = {
    ["<leader>ld"] = {
      function()
        vim.diagnostic.open_float()
      end,
      "Lsp hover diagnostics",
    },
  },
}

M.diffview = {
  n = {
    ["<leader>D"] = { "<Cmd>DiffviewOpen<CR>", "Diffview: Open" },
    ["<leader><leader>D"] = { "<Cmd>DiffviewClose<CR>", "Diffview: Close" },
  },
}

-- M.hop = {
--   n = {
--     ["<A-w>"] = { "<Cmd>HopWord<CR>", "jump: Goto word" },
--     ["<A-j>"] = { "<Cmd>HopLine<CR>", "jump: Goto line" },
--     ["<A-k>"] = { "<Cmd>HopLine<CR>", "jump: Goto line" },
--   },
-- }

M.typescript = {
  n = {
    ["<A-O>"] = {
      function()
        local ts = require("typescript").actions
        ts.addMissingImports { sync = true }
        ts.organizeImports()
        ts.removeUnused()
      end,
      "add missing imports and organize imports",
    },
  },
}

return M
