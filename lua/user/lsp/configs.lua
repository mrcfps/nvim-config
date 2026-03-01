local handler = require "user.lsp.handlers"
local has_mason, mason = pcall(require, "mason")
local has_mason_lspconfig, mason_lspconfig = pcall(require, "mason-lspconfig")

local servers = { "jsonls", "lua_ls", "bashls", "rust_analyzer", "ts_ls" }

if has_mason then
  mason.setup()
end

if has_mason_lspconfig then
  mason_lspconfig.setup({
    ensure_installed = servers,
  })
end

for _, server in pairs(servers) do
  local opts = {
    on_attach = handler.on_attach,
    capabilities = handler.capabilities,
    flag = handler.flag,
  }
  local has_custom_opts, server_custom_opts = pcall(require, "user.lsp.settings." .. server)
  if not has_custom_opts and server == "lua_ls" then
    has_custom_opts, server_custom_opts = pcall(require, "user.lsp.settings.sumneko_lua")
  end
  if has_custom_opts then
    opts = vim.tbl_deep_extend("force", opts, server_custom_opts)
  end
  vim.lsp.config(server, opts)
  vim.lsp.enable(server)
end
