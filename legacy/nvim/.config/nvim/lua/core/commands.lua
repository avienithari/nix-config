vim.api.nvim_create_autocmd("TextYankPost", {
  callback = function()
    vim.highlight.on_yank()
  end,
  desc = "Briefly highlight yanked text",
})

vim.api.nvim_create_autocmd({ "BufWritePre" }, {
  command = [[%s/\s\+$//e]],
  desc = "Autoremove trailing whitespaces",
})

vim.api.nvim_create_autocmd("TermOpen", {
  group = vim.api.nvim_create_augroup("term-open-custom", {}),
  callback = function()
    vim.opt_local.number = false
    vim.opt_local.relativenumber = false
    vim.opt_local.scrolloff = 0

    vim.bo.filetype = "terminal"
  end,
})

local function set_filetype(pattern, filetype)
  vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
    pattern = pattern,
    command = "set filetype=" .. filetype,
  })
end

set_filetype({ "docker-compose.yml" }, "yaml.docker-compose")
