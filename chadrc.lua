---@type ChadrcConfig
local M = {}

-- Path to overriding theme and highlights files
local highlights = require "custom.highlights"

M.ui = {
  theme = "bearded-arc",
  theme_toggle = { "bearded-arc", "one_light" },
  extended_integrations = {
    "notify",
  },
  nvdash = {
    load_on_startup = true,
  },
  hl_override = highlights.override,
  hl_add = highlights.add,
  cmp = {
    style = "atom",
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
