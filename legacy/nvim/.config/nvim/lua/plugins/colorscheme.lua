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

      vim.api.nvim_create_autocmd("FileType", {
        pattern = "markdown",
        callback = function()
          local hl_groups = {
            "markdownItalic",
            "@markup.italic",
            "@markup.italic.markdown_inline",
          }

          for _, group in ipairs(hl_groups) do
            local hl = vim.api.nvim_get_hl(0, { name = group })

            hl.italic = true

            vim.api.nvim_set_hl(0, group, hl)
          end
        end,
      })
    end,
  },
}
