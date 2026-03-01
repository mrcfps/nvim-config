if vim.lsp and vim.lsp.get_clients then
  vim.lsp.buf_get_clients = function(bufnr)
    local current_bufnr = vim.api.nvim_get_current_buf()
    local target_bufnr = (bufnr == nil or bufnr == 0) and current_bufnr or bufnr
    return vim.lsp.get_clients({ bufnr = target_bufnr })
  end
end

require "user.lsp.configs"
require("user.lsp.handlers").setup()
require "user.lsp.null-ls"

require("go").setup()
