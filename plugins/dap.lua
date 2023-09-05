return {
  {
    "mfussenegger/nvim-dap",
    enabled = vim.fn.has "win32" == 0,
    dependencies = {
      {
        "jay-babu/mason-nvim-dap.nvim",
        dependencies = { "nvim-dap" },
        cmd = { "DapInstall", "DapUninstall" },
        opts = { ensure_installed = { "js" } },
      },
      {
        "rcarriga/nvim-dap-ui",
        opts = { floating = { border = "rounded" } },
        config = require("custom.configs.nvim-dap").dapui,
      },
    },
  },
  {
    "Joakker/lua-json5",
    enabled = false,
    build = "./install.sh",
  },
  {
    "mxsdev/nvim-dap-vscode-js",
    ft = { "typescript", "typescriptreact", "javascript", "javascriptreact" },
    dependencies = {
      {
        "microsoft/vscode-js-debug",
        commit = "bf9c6e625a799518ace4ce6adc7653174c81d3fa",
        opt = true,
        build = "npm install --legacy-peer-deps && npx gulp vsDebugServerBundle && mv dist out",
      },
    },
    config = require("custom.configs.nvim-dap")["dap-js"],
  },
}
