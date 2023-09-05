local M = {}

M.treesitter = {
  ensure_installed = {
    "lua",
    "html",
    "css",
    "javascript",
    "typescript",
    "tsx",
    "go",
    "markdown",
    "markdown_inline",
  },
  autotag = {
    enable = true,
  },
  indent = {
    enable = true,
  },
  context_commentstring = { enable = true, enable_autocmd = false },
  matchup = { enable = true },
  textobjects = {
    select = {
      enable = true,
      keymaps = {
        ["af"] = "@function.outer",
        ["if"] = "@function.inner",
        ["ac"] = "@class.outer",
        ["ic"] = "@class.inner",
      },
    },
    move = {
      enable = true,
      set_jumps = true, -- whether to set jumps in the jumplist
      goto_next_start = {
        ["]["] = "@function.outer",
        ["]m"] = "@class.outer",
      },
      goto_next_end = {
        ["]]"] = "@function.outer",
        ["]M"] = "@class.outer",
      },
      goto_previous_start = {
        ["[["] = "@function.outer",
        ["[m"] = "@class.outer",
      },
      goto_previous_end = {
        ["[]"] = "@function.outer",
        ["[M"] = "@class.outer",
      },
    },
  },
}

M.mason = {
  ensure_installed = {
    -- lua stuff
    "lua-language-server",
    -- "stylua",
    -- "buf-language-server",
    -- "prettierd",

    -- web dev stuff
    "css-lsp",
    "html-lsp",
    "typescript-language-server",
    "unocss-language-server",
    -- "tailwindcss-language-server",
    "eslint-lsp",
    -- "gopls",
    "marksman",
  },
}

-- git support in nvimtree
M.nvimtree = {
  git = {
    enable = true,
    ignore = true,
  },

  filters = {
    dotfiles = false,
    custom = { ".DS_Store", "^\\.git$" },
    exclude = {},
  },

  view = {
    width = 35,
  },

  renderer = {
    highlight_git = true,
    icons = {
      show = {
        git = true,
      },
      git_placement = "after",
    },
  },
  on_attach = function(bufnr)
    local api = require "nvim-tree.api"
    local openfile = require "nvim-tree.actions.node.open-file"

    local actions = require "telescope.actions"
    local action_state = require "telescope.actions.state"

    api.config.mappings.default_on_attach(bufnr)

    vim.keymap.del("n", "s", { buffer = bufnr })

    local function opts(desc)
      return { desc = "NvimTree: " .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
    end

    local function edit_or_open()
      local node = api.tree.get_node_under_cursor()

      if node.nodes ~= nil then
        -- expand or collapse folder
        api.node.open.edit()
      else
        -- open file
        api.node.open.edit()
      end
    end

    local view_selection = function(prompt_bufnr, map)
      actions.select_default:replace(function()
        actions.close(prompt_bufnr)
        local selection = action_state.get_selected_entry()
        local filename = selection.filename
        if filename == nil then
          filename = selection[1]
        end
        openfile.fn("preview", filename)
      end)
      return true
    end

    local function launch_telescope(func_name, opts)
      local telescope_status_ok, _ = pcall(require, "telescope")
      if not telescope_status_ok then
        return
      end
      local node = api.tree.get_node_under_cursor()
      local is_folder = node.fs_stat and node.fs_stat.type == "directory" or false
      local basedir = is_folder and node.absolute_path or vim.fn.fnamemodify(node.absolute_path, ":h")
      if node.name == ".." and TreeExplorer ~= nil then
        basedir = TreeExplorer.cwd
      end
      opts = opts or {}
      opts.cwd = basedir
      opts.search_dirs = { basedir }
      opts.attach_mappings = view_selection
      return require("telescope.builtin")[func_name](opts)
    end

    local function launch_live_grep(opts)
      return launch_telescope("live_grep", opts)
    end

    vim.keymap.set("n", "l", edit_or_open, opts "Edit Or Open")
    vim.keymap.set("n", "A", api.tree.collapse_all, opts "Collapse All")
    vim.keymap.set("n", "<c-f>", launch_live_grep, opts "Launch Live Grep")
  end,
}

return M
