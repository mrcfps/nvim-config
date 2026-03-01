local status_ok, trouble = pcall(require, "trouble")
if not status_ok then
  return
end

trouble.setup {
  auto_open = false,
  auto_close = false,
  auto_preview = true,
  focus = false,
  follow = true,
  win = {
    type = "split",
    position = "bottom",
    size = 10,
  },
  preview = {
    type = "main",
  },
}
