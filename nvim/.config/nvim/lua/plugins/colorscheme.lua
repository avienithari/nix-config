return {
  {
    "rose-pine/neovim",
    lazy = false,
    priority = 1000,
    config = function()
      local rose_pine_config = require("rose-pine")

      rose_pine_config.setup({
        styles = {
          bold = true,
          italic = false,
          transparency = false,
        },
      })
      vim.cmd([[colorscheme rose-pine]])
    end,
  },
}
