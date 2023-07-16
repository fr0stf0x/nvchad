return {
  ---@type NvPluginSpec
  {
    "lewis6991/gitsigns.nvim",
    dependencies = {
      {
        "sindrets/diffview.nvim",
        cmd = { "DiffviewOpen", "DiffviewClose" },
      },
    },
  },
  {
    "tpope/vim-fugitive",
    enabled = false,
    cmd = { "Git", "GBrowse" },
  },
}
