local vim = vim
local opt = vim.opt

-- We want to use folds regularly, but don’t want folds to be applied when you open a file
vim.cmd [[set nofoldenable]]

opt.foldmethod = "indent"
opt.foldexpr = "nvim_treesitter#foldexpr()"
