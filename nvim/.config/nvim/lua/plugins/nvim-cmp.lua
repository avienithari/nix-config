return {
  "hrsh7th/nvim-cmp",
  event = "InsertEnter",
  dependencies = {
    "hrsh7th/cmp-buffer",
    "hrsh7th/cmp-path",
    "onsails/lspkind.nvim",
    "L3MON4D3/LuaSnip",
    "saadparwaiz1/cmp_luasnip",
    "rafamadriz/friendly-snippets",
    "kristijanhusak/vim-dadbod-completion",
  },

  config = function()
    local cmp_config = require("cmp")
    local luasnip_config = require("luasnip")
    local lspkind_config = require("lspkind")

    require("luasnip.loaders.from_vscode").lazy_load()

    cmp_config.setup({
      completion = {
        completeopt = "menu,menuone,preview,noselect",
      },
      snippet = {
        expand = function(args)
          luasnip_config.lsp_expand(args.body)
        end,
      },
      mapping = cmp_config.mapping.preset.insert({
        ["<C-k>"] = cmp_config.mapping.select_prev_item(),
        ["<C-j>"] = cmp_config.mapping.select_next_item(),
        ["<C-b>"] = cmp_config.mapping.scroll_docs(-4),
        ["<C-f>"] = cmp_config.mapping.scroll_docs(4),
        ["<C-Space>"] = cmp_config.mapping.complete(),
        ["<C-e>"] = cmp_config.mapping.abort(),
        ["<CR>"] = cmp_config.mapping.confirm({ select = false }),
      }),
      sources = cmp_config.config.sources({
        { name = "nvim_lsp" },
        { name = "luasnip" },
        { name = "buffer" },
        { name = "path" },
      }),
      formatting = {
        format = lspkind_config.cmp_format({
          maxwidth = 50,
          ellipsis_char = "...",
        }),
      },
    })
  end,
  require("cmp").setup.filetype({ "sql", "mysql", "plsql" }, {
    sources = {
      { name = "vim-dadbod-completion" },
      { name = "buffer" },
    },
  }),
}
