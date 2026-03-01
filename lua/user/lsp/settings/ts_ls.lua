local util = require "lspconfig.util"

return {
  root_dir = util.root_pattern("package.json", "tsconfig.json", "jsconfig.json", ".git"),
  single_file_support = false,
  on_attach = function(client, bufnr)
    client.server_capabilities.documentFormattingProvider = false
    client.server_capabilities.documentRangeFormattingProvider = false
    require("user.lsp.handlers").on_attach(client, bufnr)
  end,
}
