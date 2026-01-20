return {
  "neovim/nvim-lspconfig",
  event = { "BufReadPre", "BufNewFile" },

  dependencies = {
    "hrsh7th/nvim-cmp",
    "hrsh7th/cmp-nvim-lsp",
    "j-hui/fidget.nvim",
    "folke/neodev.nvim",
    "stevearc/conform.nvim",
  },

  config = function()
    local capabilities = require("cmp_nvim_lsp").default_capabilities()

    require("fidget").setup({})
    require("neodev").setup({})

    local servers = {
      bashls = {},
      clangd = {},
      cssls = {},
      docker_compose_language_service = {},
      dockerls = {},
      golangci_lint_ls = {},
      gopls = {},
      html = {},
      nixd = {},
      pyright = {},
      rust_analyzer = {},
      templ = {},
      ts_ls = {},
      vimls = {},
      zls = {},
    }

    local on_attach = function(_, bufnr)
      local opts = { buffer = bufnr }

      vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
      vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
      vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)
      vim.keymap.set("n", "<leader>rf", vim.lsp.buf.references, opts)
      vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, opts)
      vim.keymap.set("n", "<leader>ws", vim.lsp.buf.workspace_symbol, opts)

      vim.keymap.set("n", "<leader>vd", vim.diagnostic.open_float, opts)
      vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, opts)
      vim.keymap.set("n", "]d", vim.diagnostic.goto_next, opts)

      vim.keymap.set("i", "<C-h>", vim.lsp.buf.signature_help, opts)
    end

    for name, cfg in pairs(servers) do
      vim.lsp.config(name, {
        capabilities = capabilities,
        on_attach = on_attach,
        settings = cfg.settings,
      })
      vim.lsp.enable(name)
    end

    vim.lsp.config("lua_ls", {
      capabilities = capabilities,
      on_attach = on_attach,
      settings = {
        Lua = {
          diagnostics = { globals = { "vim" } },
          workspace = {
            library = vim.api.nvim_get_runtime_file("", true),
            checkThirdParty = false,
          },
          telemetry = { enable = false },
        },
      },
    })
    vim.lsp.enable("lua_ls")

    require("conform").setup({
      formatters_by_ft = {
        lua = { "stylua" },
        nix = { "nixpkgs_fmt" },
        go = { "gofumpt", "goimports" },
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
