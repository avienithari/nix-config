return {
  "neovim/nvim-lspconfig",
  dependencies = {
    "williamboman/mason.nvim",
    "williamboman/mason-lspconfig.nvim",
    "hrsh7th/cmp-nvim-lsp",
    "hrsh7th/cmp-buffer",
    "hrsh7th/cmp-path",
    "hrsh7th/cmp-cmdline",
    "hrsh7th/nvim-cmp",
    "j-hui/fidget.nvim",
    "folke/neodev.nvim",
    "stevearc/conform.nvim",
    "WhoIsSethDaniel/mason-tool-installer.nvim",
  },

  config = function()
    local capabilities = require("cmp_nvim_lsp").default_capabilities()

    require("fidget").setup({})
    require("mason").setup({})
    require("neodev").setup({
      library = { plugins = { "nvim-dap-ui" }, types = true },
    })
    require("mason-lspconfig").setup({
      ensure_installed = {
        "clangd",
        "lua_ls",
        "gopls",
        "golangci_lint_ls",
        "pyright",
        "rust_analyzer",
        "ts_ls",
        "vimls",
        "zls",
        "html",
        "templ",
        "cssls",
        "bashls",
        "dockerls",
        "docker_compose_language_service",
      },
      handlers = {
        function(server_name)
          require("lspconfig")[server_name].setup({
            capabilities = capabilities,
          })
        end,

        ["lua_ls"] = function()
          local lspconfig = require("lspconfig")
          lspconfig.lua_ls.setup({
            settings = {
              Lua = {
                diagnostics = {
                  globals = { "vim" },
                },
              },
            },
          })
        end,
      },
    })
    require("mason-tool-installer").setup({
      ensure_installed = {
        "golangci-lint",
        "htmlhint",
        "pylint",
        "gofumpt",
        "goimports",
        "stylua",
        "delve",
      },
    })
    require("conform").setup({
      formatters_by_ft = {
        lua = { "stylua" },
      },
    })
    vim.api.nvim_create_autocmd("BufWritePre", {
      callback = function(args)
        require("conform").format({
          bufnr = args.buf,
          lsp_fallback = true,
          quiet = true,
        })
      end,
    })
  end,
}
