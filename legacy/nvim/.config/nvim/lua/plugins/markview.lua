return {
  {
    "OXY2DEV/markview.nvim",
    lazy = false,
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
      "nvim-tree/nvim-web-devicons",
    },
    config = function()
      local presets = require("markview.presets")

      require("markview").setup({
        markdown = {
          headings = presets.headings.glow,
          horizontal_rules = presets.horizontal_rules.thick,
          tables = presets.tables.single,

          list_items = {
            shift_width = 0,
            indent_size = 2,
            marker_minus = { add_padding = false },
            marker_plus = { add_padding = false },
            marker_star = { add_padding = false },
          },
        },

        markdown_inline = {
          tags = {
            enable = false,
          },
        },
      })
    end,
  },
}
