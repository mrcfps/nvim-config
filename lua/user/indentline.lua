local status_ok, ibl = pcall(require, "ibl")
if not status_ok then
  return
end

vim.opt.list = true

ibl.setup({
  indent = {
    char = "▏",
    tab_char = "│",
  },
  exclude = {
    buftypes = { "terminal", "nofile" },
    filetypes = {
      "help",
      "startify",
      "dashboard",
      "packer",
      "neogitstatus",
      "NvimTree",
      "Trouble",
    },
  },
  scope = {
    enabled = true,
    show_start = true,
  },
})
