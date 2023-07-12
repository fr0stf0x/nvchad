---@type ChadrcConfig
local M = {}

-- Path to overriding theme and highlights files
local highlights = require "custom.highlights"

M.ui = {
  theme = "kanagawa",
  theme_toggle = { "kanagawa", "one_light" },
  extended_integrations = {
    "notify",
  },
  nvdash = {
    load_on_startup = true,
  },
  hl_override = highlights.override,
  hl_add = highlights.add,
  cmp = {
    style = "default",
  },
}

M.plugins = "custom.plugins"

-- check core.mappings for table structure
M.mappings = require "custom.mappings"

return M
