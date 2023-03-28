vim.cmd [[
try
  colorscheme dogrun
catch /^Vim\%((\a\+)\)\=:E185/
  colorscheme default
  set background=dark
endtry
]]
