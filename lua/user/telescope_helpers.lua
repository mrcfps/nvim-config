local M = {}

function M.find_files()
  local has_builtin, builtin = pcall(require, "telescope.builtin")
  if not has_builtin then
    return
  end

  local has_themes, themes = pcall(require, "telescope.themes")
  if has_themes then
    builtin.find_files(themes.get_dropdown { previewer = false })
    return
  end

  builtin.find_files()
end

function M.live_grep()
  local has_builtin, builtin = pcall(require, "telescope.builtin")
  if not has_builtin then
    return
  end

  local has_themes, themes = pcall(require, "telescope.themes")
  if has_themes then
    builtin.live_grep(themes.get_ivy())
    return
  end

  builtin.live_grep()
end

function M.buffers()
  local has_builtin, builtin = pcall(require, "telescope.builtin")
  if not has_builtin then
    return
  end

  local has_themes, themes = pcall(require, "telescope.themes")
  if has_themes then
    builtin.buffers(themes.get_dropdown { previewer = false })
    return
  end

  builtin.buffers()
end

return M
