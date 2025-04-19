return {
  {
    "nvim-treesitter/nvim-treesitter",
    event = "BufReadPre",
    dependencies = {
      "nvim-treesitter/nvim-treesitter-textobjects",
      "windwp/nvim-ts-autotag",
    },
    config = function()
      local treesitter_config = require("nvim-treesitter.configs")

      treesitter_config.setup({
        sync_install = false,

        auto_install = true,

        highlight = {
          enable = true,
        },

        indent = {
          enable = true,
        },

        autoapairs = {
          enable = true,
        },

        autotag = {
          enable = true,
        },

        ensure_installed = {
          "bash",
          "c",
          "dockerfile",
          "go",
          "javascript",
          "lua",
          "ocaml",
          "python",
          "rust",
          "typescript",
          "vim",
          "zig",
        },
      })

      local parser_config = require("nvim-treesitter.parsers").get_parser_configs()
      parser_config.blade = {
        install_info = {
          url = "https://github.com/EmranMR/tree-sitter-blade",
          files = { "src/parser.c" },
          branch = "main",
        },
        filetype = "blade",
      }
    end,
  },
}
