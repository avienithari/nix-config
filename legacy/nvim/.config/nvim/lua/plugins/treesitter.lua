return {
  {
    "avienithari/nvim-treesitter",
    event = "BufReadPre",
    branch = "main",
    dependencies = {
      { "nvim-treesitter/nvim-treesitter-textobjects", branch = "main" },
      "windwp/nvim-ts-autotag",
    },

    init = function()
      vim.api.nvim_create_autocmd("FileType", {
        callback = function()
          pcall(vim.treesitter.start)
          vim.bo.indentexpr = "v:lua.require('nvim-treesitter').indentexpr()"
        end,
      })

      local ensure_installed = {
        "bash",
        "c",
        "csv",
        "dockerfile",
        "gitcommit",
        "go",
        "javascript",
        "lua",
        "nix",
        "ocaml",
        "python",
        "rust",
        "typescript",
        "vim",
        "yaml",
        "zig",
      }

      local installed = require("nvim-treesitter.config").get_installed()
      local to_install = vim
        .iter(ensure_installed)
        :filter(function(parser)
          return not vim.tbl_contains(installed, parser)
        end)
        :totable()

      require("nvim-treesitter").install(to_install)
    end,
  },
}
