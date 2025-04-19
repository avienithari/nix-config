vim.api.nvim_create_autocmd("TextYankPost", {
  callback = function()
    vim.highlight.on_yank()
  end,
  desc = "Briefly highlight yanked text",
})

vim.api.nvim_create_autocmd("LspAttach", {
  callback = function(ev)
    local opts = { buffer = ev.buf }

    vim.keymap.set("n", "K", function()
      vim.lsp.buf.hover()
    end, opts)
    vim.keymap.set("n", "gd", function()
      vim.lsp.buf.definition()
    end, opts)
    vim.keymap.set("n", "<leader>rn", function()
      vim.lsp.buf.rename()
    end, opts)
    vim.keymap.set("n", "<leader>rf", function()
      vim.lsp.buf.references()
    end, opts)
    vim.keymap.set("n", "<leader>ca", function()
      vim.lsp.buf.code_action()
    end, opts)
    vim.keymap.set("n", "<leader>ws", function()
      vim.lsp.buf.workspace_symbol()
    end, opts)
    vim.keymap.set("n", "<leader>vd", function()
      vim.diagnostic.open_float()
    end, opts)
    vim.keymap.set("n", "[d", function()
      vim.diagnostic.goto_prev()
    end, opts)
    vim.keymap.set("n", "]d", function()
      vim.diagnostic.goto_next()
    end, opts)
    vim.keymap.set("i", "<C-h>", function()
      vim.lsp.buf.signature_help()
    end, opts)
  end,
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
