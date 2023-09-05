-- To find any highlight groups: "<cmd> Telescope highlights"
-- Each highlight group can take a table with variables fg, bg, bold, italic, etc
-- base30 variable names can also be used as colors

local M = {}

---@type Base46HLGroupsList
M.override = {
  Comment = {
    italic = true,
  },
  FoldColumn = {
    bg = "black",
    fg = "grey_fg",
  },
  DiffAdd = {
    bg = "#2c3d30",
    fg = "NONE",
  },
  DiffChange = {
    fg = "NONE",
  },
  DiffText = {
    bg = "#384a66",
    fg = "NONE",
  },
  DiffModified = {
    bg = "blue",
    fg = "NONE",
  },
}

---@type HLTable
M.add = {
  -- NvimTreeOpenedFolderName = { fg = "green", bold = true },
}

return M
