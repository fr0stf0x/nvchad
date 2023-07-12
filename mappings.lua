---@type MappingsTable
local M = {}

local function diagnostic_goto(next, severity)
  return function()
    severity = severity and vim.diagnostic.severity[severity] or nil

    if next then
      vim.diagnostic.goto_next { severity = severity }
    else
      vim.diagnostic:goto_prev { severity = severity }
    end
  end
end

M.disabled = {
  n = {
    ["[c"] = "",
    ["]c"] = "",
    ["[d"] = "",
    ["]d"] = "",
  },
}

M.general = {
  n = {
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
      "Go to previous error",
    },
    ["<C-w>f"] = {
      "<cmd>CloseAllFloatingWindows<cr>",
      "Close all floating windows",
    },
  },
}

M.tabufline = {
  n = {
    ["<leader>bc"] = {
      function()
        require("nvchad_ui.tabufline").closeOtherBufs()
      end,
      "Close other buffers",
    },
    ["<leader>bC"] = {
      function()
        require("nvchad_ui.tabufline").closeAllBufs()
      end,
      desc = "Close all buffers",
    },
  },
}

M.telescope = {
  n = {
    ["<leader>fs"] = { "<cmd>Telescope grep_string<cr>", "find: Current word" },
    ["<leader>gc"] = { "<cmd>Telescope git_commits<cr>", "find: Commits" },
    ["<leader>gbc"] = { "<cmd>Telescope git_bcommits<cr>", "find: Buffer commits" },
    ["gr"] = { "<cmd>Telescope lsp_references<cr>", "find: Lsp references" },
    ["gd"] = {
      "<cmd> Telescope lsp_definitions<cr>",
      "find: Lsp definitions",
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

-- M.lspsaga = {
--   n = {
--     ["<leader>o"] = { "<cmd>Lspsaga outline<CR>" },
--     ["gr"] = { "<cmd>Lspsaga lsp_finder<CR>" },
--     ["gd"] = { "<cmd>Lspsaga goto_definition<CR>", "Lspsaga goto_definition" },
--     ["<leader>ca"] = { "<cmd>Lspsaga code_action<CR>", "Lspsaga code_action" },
--     ["<leader>db"] = { "<cmd>Lspsaga show_buf_diagnostics<CR>", "Lspsaga show_buf_diagnostics" },
--     ["<leader>dw"] = { "<cmd>Lspsaga show_workspace_diagnostics<CR>", "Lspsaga show_workspace_diagnostics" },
--     ["K"] = { "<cmd>Lspsaga hover_doc<CR>", "Lspsaga hover_doc" },
--     ["[e"] = {
--       diagnostic_goto(false, "ERROR"),
--       "Go to previous error",
--     },
--     ["]e"] = {
--       diagnostic_goto(true, "ERROR"),
--       "Go to previous error",
--     },
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
