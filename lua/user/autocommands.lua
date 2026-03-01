local api = vim.api

local general_group = api.nvim_create_augroup("_general_settings", { clear = true })
api.nvim_create_autocmd("FileType", {
  group = general_group,
  pattern = { "qf", "help", "man", "lspinfo" },
  callback = function(args)
    vim.keymap.set("n", "q", "<cmd>close<CR>", { buffer = args.buf, silent = true })
  end,
})

api.nvim_create_autocmd("TextYankPost", {
  group = general_group,
  callback = function()
    pcall(vim.highlight.on_yank, { higroup = "Visual", timeout = 200 })
  end,
})

api.nvim_create_autocmd("BufWinEnter", {
  group = general_group,
  callback = function()
    vim.opt_local.formatoptions:remove { "c", "r", "o" }
  end,
})

api.nvim_create_autocmd("FileType", {
  group = general_group,
  pattern = "qf",
  callback = function()
    vim.opt_local.buflisted = false
  end,
})

api.nvim_create_autocmd({ "FocusGained", "BufEnter" }, {
  group = general_group,
  command = "checktime",
})

local git_group = api.nvim_create_augroup("_git", { clear = true })
api.nvim_create_autocmd("FileType", {
  group = git_group,
  pattern = "gitcommit",
  callback = function()
    vim.opt_local.wrap = true
    vim.opt_local.spell = true
  end,
})

local markdown_group = api.nvim_create_augroup("_markdown", { clear = true })
api.nvim_create_autocmd("FileType", {
  group = markdown_group,
  pattern = "markdown",
  callback = function()
    vim.opt_local.wrap = true
    vim.opt_local.spell = true
  end,
})

local auto_resize_group = api.nvim_create_augroup("_auto_resize", { clear = true })
api.nvim_create_autocmd("VimResized", {
  group = auto_resize_group,
  command = "tabdo wincmd =",
})

local alpha_group = api.nvim_create_augroup("_alpha", { clear = true })
api.nvim_create_autocmd("User", {
  group = alpha_group,
  pattern = "AlphaReady",
  callback = function(args)
    vim.opt.showtabline = 0
    api.nvim_create_autocmd("BufUnload", {
      group = alpha_group,
      buffer = args.buf,
      once = true,
      callback = function()
        vim.opt.showtabline = 2
      end,
    })
  end,
})

local quickfix_group = api.nvim_create_augroup("_quickfix", { clear = true })
api.nvim_create_autocmd("FileType", {
  group = quickfix_group,
  pattern = "qf",
  callback = function(args)
    vim.keymap.set("n", "<CR>", "<CR><cmd>cclose<CR>", { buffer = args.buf, silent = true })
  end,
})

-- Autoformat
-- local lsp_group = api.nvim_create_augroup("_lsp", { clear = true })
-- api.nvim_create_autocmd("BufWritePre", {
--   group = lsp_group,
--   callback = function()
--     vim.lsp.buf.format({ async = false })
--   end,
-- })
