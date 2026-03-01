if vim.lsp and vim.lsp.get_clients then
  vim.lsp.buf_get_clients = function(bufnr)
    local target_bufnr = bufnr
    if target_bufnr == nil or target_bufnr == 0 then
      target_bufnr = vim.api.nvim_get_current_buf()
    end

    return vim.lsp.get_clients({ bufnr = target_bufnr })
  end
end
