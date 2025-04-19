return {
  "nvim-lualine/lualine.nvim",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  config = function()
    local lualine_config = require("lualine")
    local lazy_status_config = require("lazy.status")

    lualine_config.setup({
      sections = {
        lualine_x = {
          {
            lazy_status_config.updates,
            cond = lazy_status_config.has_updates,
            color = {
              fg = "#ff9e64",
            },
          },
          { "encoding" },
          { "fileformat" },
          { "filetype" },
        },
      },
    })
  end,
}
