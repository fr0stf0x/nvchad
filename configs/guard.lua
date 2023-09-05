return function()
  local ft = require "guard.filetype"

  ft("typescript,javascript,typescriptreact"):fmt "prettierd"
  ft("go"):fmt("goimports"):append("golines"):lint "golangci"
  ft("lua"):fmt "stylua"

  -- Call setup() LAST!
  require("guard").setup {
    -- the only options for the setup function
    fmt_on_save = true,
    -- Use lsp if no formatter was defined for this filetype
    lsp_as_default_formatter = false,
  }
end
