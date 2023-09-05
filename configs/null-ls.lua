local present, null_ls = pcall(require, "null-ls")

if not present then
  return
end

local b = null_ls.builtins

local has_prettier_support = function(utils)
  return utils.root_has_file_matches(".prettierrc", ".prettierrc.*", "prettier.config.*")
end

local sources = {

  -- webdev stuff
  -- b.formatting.deno_fmt, -- choosed deno for ts/js files cuz its very fast!

  b.formatting.prettierd.with {
    filetypes = {
      "javascript",
      "javascriptreact",
      "typescript",
      "typescriptreact",
      "vue",
      "json",
      "jsonc",
      "markdown",
      "markdown.mdx",
    },
    condition = has_prettier_support,
  },

  require "typescript.extensions.null-ls.code-actions",

  -- go
  -- b.formatting.gofmt,
  -- b.formatting.goimports,
  -- b.formatting.gofumpt,
  b.formatting.goimports_reviser,
  b.formatting.golines,

  b.diagnostics.golangci_lint,

  -- Lua
  b.formatting.stylua,
}

local augroup = vim.api.nvim_create_augroup("LspFormatting", {})

null_ls.setup {
  debug = true,
  sources = sources,
  -- you can reuse a shared lspconfig on_attach callback here
  on_attach = function(client, bufnr)
    if client.supports_method "textDocument/formatting" then
      vim.api.nvim_clear_autocmds { group = augroup, buffer = bufnr }
      vim.api.nvim_create_autocmd("BufWritePre", {
        group = augroup,
        buffer = bufnr,
        callback = function()
          vim.lsp.buf.format {
            bufnr = bufnr,
            filter = function(client)
              return client.name == "null-ls"
            end,
          }
        end,
      })
    end
  end,
}
