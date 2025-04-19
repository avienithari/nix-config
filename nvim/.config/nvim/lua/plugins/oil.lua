return {
  "stevearc/oil.nvim",
  opts = {},
  dependencies = { "nvim-tree/nvim-web-devicons" },

  config = function()
    local oil_config = require("oil")

    oil_config.setup({
      view_options = {
        show_hidden = true,
      },
    })
  end,
}
