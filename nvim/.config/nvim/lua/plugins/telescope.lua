return {
  "nvim-telescope/telescope.nvim",
  branch = "0.1.x",
  dependencies = {
    "nvim-lua/plenary.nvim",
    { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
    "nvim-tree/nvim-web-devicons",
  },

  config = function()
    local telescope_config = require("telescope")
    local actions_config = require("telescope.actions")

    telescope_config.setup({
      defaults = {
        file_ingnore_patterns = {
          "node%_modules/*",
          ".yarn/*",
          ".idea/*",
        },
        mappings = {
          i = {
            ["<C-k>"] = actions_config.move_selection_previous,
            ["<C-j>"] = actions_config.move_selection_next,
            ["<C-q>"] = actions_config.send_selected_to_qflist + actions_config.open_qflist,
          },
        },
      },
    })
    telescope_config.load_extension("fzf")
  end,
}
