local status_ok, lsp_installer = pcall(require, "nvim-lsp-installer")
if not status_ok then
  return
end

local lspconfig = require "lspconfig"
local handler = require "user.lsp.handlers"

local servers = { "jsonls", "lua_ls", "gopls", "bashls", "rust_analyzer" }

lsp_installer.setup {
  ensure_installed = servers,
}

for _, server in pairs(servers) do
  local opts = {
    on_attach = handler.on_attach,
    capabilities = handler.capabilities,
    flag = handler.flag,
  }
  local has_custom_opts, server_custom_opts = pcall(require, "user.lsp.settings." .. server)
  if has_custom_opts then
    opts = vim.tbl_deep_extend("force", server_custom_opts, opts)
  end
  lspconfig[server].setup(opts)
end
