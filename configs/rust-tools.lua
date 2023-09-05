local capabilities = require("plugins.configs.lspconfig").capabilities
local on_attach = require("plugins.configs.lspconfig").on_attach

local options = {
  server = {
    on_attach = on_attach,
    capabilities = capabilities,
  },
}

return options
