vim.g.mapleader = " "

local keymap = vim.keymap

keymap.set("n", "x", '"_x')

keymap.set("c", "W", "w<CR>")

keymap.set("n", "<C-d>", "<C-d>zz")
keymap.set("n", "<C-u>", "<C-u>zz")

keymap.set("v", "K", ":m '<-2<CR>gv=gv")
keymap.set("v", "J", ":m '>+1<CR>gv=gv")

keymap.set("x", "<leader>p", '"_dP')

keymap.set("n", "<leader>to", ":tabnew<CR>")
keymap.set("n", "<leader>tx", ":tabclose<CR>")
keymap.set("n", "<left>", "gT")
keymap.set("n", "<right>", "gt")

keymap.set("n", "<leader>X", "<cmd>!chmod +x %<CR>", { silent = true })
keymap.set("n", "<leader><leader>x", "<cmd>source %<CR>")

keymap.set("n", "<CR>", function()
  if vim.opt.hlsearch:get() then
    vim.cmd.nohlsearch()
  else
    return "<CR>"
  end
end)

vim.keymap.set("n", "<leader>tt", function()
  vim.cmd.new()
  vim.cmd.wincmd("J")
  vim.api.nvim_win_set_height(0, 12)
  vim.wo.winfixheight = true
  vim.cmd.term()
end)

vim.keymap.set("t", "<esc><esc>", "<c-\\><c-n>")

keymap.set("n", "<leader>L", "<cmd>Lazy<CR>", { noremap = true, silent = true })
keymap.set("n", "<leader>M", "<cmd>Mason<CR>", { silent = true })
keymap.set("n", "<leader>G", "<cmd>Git<CR>", { noremap = true, silent = true })
keymap.set("n", "<leader>U", ":UndotreeToggle<CR>")
keymap.set("n", "<leader>n", ":ScribeToggle<CR>", { silent = true })
keymap.set("n", "-", "<CMD>Oil<CR>", { desc = "Open parent directory" })
keymap.set("n", "<leader>T", ":Trouble diagnostics toggle focus=true<CR>", { silent = true })
keymap.set("n", "<leader>D", function()
  vim.cmd("tabnew")
  vim.cmd("DBUI")
end, { silent = true })

keymap.set("n", "<leader>sm", ":MaximizerToggle<CR>")
keymap.set("n", "<leader>ff", "<cmd>Telescope find_files<cr>")
keymap.set("n", "<leader>fs", "<cmd>Telescope live_grep<cr>")
keymap.set("n", "<leader>fc", "<cmd>Telescope grep_string<cr>")
keymap.set("n", "<leader>fb", "<cmd>Telescope buffers<cr>")
keymap.set("n", "<leader>fh", "<cmd>Telescope help_tags<cr>")
keymap.set("v", "<leader>a", ":ScribeRange<CR>")
keymap.set("n", "<leader>gp", ":Gitsigns preview_hunk<CR>", { silent = true })
keymap.set("n", "<leader>gt", ":Gitsigns toggle_current_line_blame<CR>", { silent = true })
keymap.set("n", "<leader>p", ":NoNeckPain<CR>", { silent = true })

-- plugin dev keymaps
-- keymap.set("n", ",r", ":lua R('scribe')<CR>", { silent = true }) -- reload scribe
-- keymap.set("n", ",t", ":PlenaryBustedFile %<CR>") -- test single file with with plenary
-- keymap.set("n", ",b", ":buffers<CR>", { silent = true }) -- list buffers
