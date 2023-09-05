-- local autocmd = vim.api.nvim_create_autocmd

-- Auto resize panes when resizing nvim window
-- autocmd("VimResized", {
--   pattern = "*",
--   command = "tabdo wincmd =",
-- })

-- https://github.com/neovim/neovim/issues/21749#issuecomment-1378720864
-- Fix loading of json5
table.insert(vim._so_trails, "/?.dylib")

-- vim.cmd.source "~/.vimrc"

local autocmd = vim.api.nvim_create_autocmd
local augroup = vim.api.nvim_create_augroup

vim.opt.relativenumber = true
vim.opt.cmdheight = 0
vim.opt.scrolloff = 8
vim.g.swapfile = false

vim.filetype.add {
  extension = {
    mdx = "mdx",
  },
}

vim.treesitter.language.register("markdown", "mdx")

vim.g.markdown_fenced_languages = {
  "ts=typescript",
  "tsx=typescriptreact",
  "javascript",
  "typescript",
  "typescriptreact",
  "bash",
  "lua",
  "go",
  "rust",
}

vim.cmd [[
  nnoremap <Leader>L "ayiwoconsole.log('<C-R>a:', <C-R>a);<Esc>

  xnoremap <Leader>L "ayoconsole.log('<C-R>a:', <C-R>a);<Esc>
]]

vim.api.nvim_create_user_command("CloseAllFloatingWindows", function()
  local closed_windows = {}
  for _, win in ipairs(vim.api.nvim_list_wins()) do
    local config = vim.api.nvim_win_get_config(win)
    if config.relative ~= "" then -- is_floating_window?
      vim.api.nvim_win_close(win, false) -- do not force
      table.insert(closed_windows, win)
    end
  end
  print(string.format("Closed %d windows: %s", #closed_windows, vim.inspect(closed_windows)))
end, {})

autocmd("TextYankPost", {
  desc = "Highlight yanked text",
  group = augroup("highlightyank", { clear = true }),
  pattern = "*",
  callback = function()
    vim.highlight.on_yank()
  end,
})
