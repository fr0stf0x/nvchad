---@type ChadrcConfig
local M = {}

-- Path to overriding theme and highlights files
local highlights = require "custom.highlights"

M.ui = {
  theme = "kanagawa",
  theme_toggle = { "kanagawa", "one_light" },
  extended_integrations = {},
  nvdash = {
    load_on_startup = true,
  },
  hl_override = highlights.override,
  hl_add = highlights.add,
  cmp = {
    style = "default",
  },
  lsp = {
    signature = {
      enabled = false,
    },
  },
  lsp_semantic_tokens = true,
  statusline = {
    theme = "minimal",
    overriden_modules = require "custom.configs.statusline",
  },
  tabufline = {
    enabled = true,
  },
}

M.plugins = "custom.plugins"

-- check core.mappings for table structure
M.mappings = require "custom.mappings"

return M
