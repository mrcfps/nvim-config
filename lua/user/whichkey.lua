local status_ok, which_key = pcall(require, "which-key")
if not status_ok then
  return
end

which_key.setup {
  plugins = {
    marks = true,
    registers = true,
    spelling = {
      enabled = true,
      suggestions = 20,
    },
    presets = {
      operators = false,
      motions = true,
      text_objects = true,
      windows = true,
      nav = true,
      z = true,
      g = true,
    },
  },
  icons = {
    breadcrumb = ">",
    separator = "->",
    group = "+",
  },
  keys = {
    scroll_down = "<c-d>",
    scroll_up = "<c-u>",
  },
  layout = {
    width = { min = 20, max = 50 },
    spacing = 3,
  },
  show_help = true,
  triggers = {
    { "<auto>", mode = "nxso" },
  },
}

local telescope = require "user.telescope_helpers"

local mappings = {
  { "<leader>a", "<cmd>Alpha<cr>", desc = "Alpha" },
  {
    "<leader>b",
    telescope.buffers,
    desc = "Buffers",
  },
  { "<leader>e", "<cmd>NvimTreeToggle<cr>", desc = "Explorer" },
  { "<leader>w", "<cmd>w!<CR>", desc = "Save" },
  { "<leader>c", "<cmd>Bdelete!<CR>", desc = "Close Buffer" },
  {
    "<leader>f",
    telescope.find_files,
    desc = "Find files",
  },
  { "<leader>o", "<cmd>SymbolsOutline<cr>", desc = "Outline" },
  { "<leader>F", telescope.live_grep, desc = "Find Text" },
  {
    "<leader>P",
    function()
      require("telescope").extensions.projects.projects()
    end,
    desc = "Projects",
  },

  { "<leader>p", group = "Plugins" },
  { "<leader>pc", "<cmd>Lazy clean<cr>", desc = "Clean" },
  { "<leader>pi", "<cmd>Lazy install<cr>", desc = "Install" },
  { "<leader>ps", "<cmd>Lazy sync<cr>", desc = "Sync" },
  { "<leader>pS", "<cmd>Lazy<cr>", desc = "Status" },
  { "<leader>pu", "<cmd>Lazy update<cr>", desc = "Update" },

  { "<leader>g", group = "Git" },
  { "<leader>gg", _LAZYGIT_TOGGLE, desc = "Lazygit" },
  {
    "<leader>gj",
    function()
      require("gitsigns").next_hunk()
    end,
    desc = "Next Hunk",
  },
  {
    "<leader>gk",
    function()
      require("gitsigns").prev_hunk()
    end,
    desc = "Prev Hunk",
  },
  {
    "<leader>gl",
    function()
      require("gitsigns").blame_line()
    end,
    desc = "Blame",
  },
  {
    "<leader>gp",
    function()
      require("gitsigns").preview_hunk()
    end,
    desc = "Preview Hunk",
  },
  {
    "<leader>gr",
    function()
      require("gitsigns").reset_hunk()
    end,
    desc = "Reset Hunk",
  },
  {
    "<leader>gR",
    function()
      require("gitsigns").reset_buffer()
    end,
    desc = "Reset Buffer",
  },
  {
    "<leader>gs",
    function()
      require("gitsigns").stage_hunk()
    end,
    desc = "Stage Hunk",
  },
  {
    "<leader>gu",
    function()
      require("gitsigns").undo_stage_hunk()
    end,
    desc = "Undo Stage Hunk",
  },
  { "<leader>go", "<cmd>Telescope git_status<cr>", desc = "Open changed file" },
  { "<leader>gb", "<cmd>Telescope git_branches<cr>", desc = "Checkout branch" },
  { "<leader>gc", "<cmd>Telescope git_commits<cr>", desc = "Checkout commit" },
  { "<leader>gd", "<cmd>Gitsigns diffthis HEAD<cr>", desc = "Diff" },

  { "<leader>l", group = "LSP" },
  { "<leader>la", vim.lsp.buf.code_action, desc = "Code Action" },
  { "<leader>ld", "<cmd>Telescope diagnostics bufnr=0<cr>", desc = "Document Diagnostics" },
  { "<leader>lw", "<cmd>Telescope diagnostics<cr>", desc = "Workspace Diagnostics" },
  { "<leader>li", "<cmd>LspInfo<cr>", desc = "Info" },
  { "<leader>lI", "<cmd>Mason<cr>", desc = "Installer Info" },
  {
    "<leader>lj",
    function()
      vim.diagnostic.jump { count = 1 }
    end,
    desc = "Next Diagnostic",
  },
  {
    "<leader>lk",
    function()
      vim.diagnostic.jump { count = -1 }
    end,
    desc = "Prev Diagnostic",
  },
  { "<leader>ll", vim.lsp.codelens.run, desc = "CodeLens Action" },
  { "<leader>lq", vim.diagnostic.setloclist, desc = "Quickfix" },
  { "<leader>lr", vim.lsp.buf.rename, desc = "Rename" },
  { "<leader>ls", "<cmd>Telescope lsp_document_symbols<cr>", desc = "Document Symbols" },
  { "<leader>lS", "<cmd>Telescope lsp_dynamic_workspace_symbols<cr>", desc = "Workspace Symbols" },

  { "<leader>s", group = "Search" },
  { "<leader>sb", "<cmd>Telescope git_branches<cr>", desc = "Checkout branch" },
  { "<leader>sc", "<cmd>Telescope colorscheme<cr>", desc = "Colorscheme" },
  { "<leader>sh", "<cmd>Telescope help_tags<cr>", desc = "Find Help" },
  { "<leader>sM", "<cmd>Telescope man_pages<cr>", desc = "Man Pages" },
  { "<leader>sr", "<cmd>Telescope oldfiles<cr>", desc = "Open Recent File" },
  { "<leader>sR", "<cmd>Telescope registers<cr>", desc = "Registers" },
  { "<leader>sk", "<cmd>Telescope keymaps<cr>", desc = "Keymaps" },
  { "<leader>sC", "<cmd>Telescope commands<cr>", desc = "Commands" },
  { "<leader>ss", "<cmd>Telescope lsp_dynamic_workspace_symbols<cr>", desc = "Symbols" },

  { "<leader>x", group = "Trouble" },
  { "<leader>xx", "<cmd>Trouble diagnostics toggle<cr>", desc = "Toggle trouble" },
  { "<leader>xw", "<cmd>Trouble diagnostics toggle<cr>", desc = "Open workspace diagnostics" },
  { "<leader>xd", "<cmd>Trouble diagnostics toggle focus=true filter.buf=0<cr>", desc = "Open document diagnostics" },
  { "<leader>xq", "<cmd>Trouble qflist toggle<cr>", desc = "Open quickfix" },
  { "<leader>xl", "<cmd>Trouble loclist toggle<cr>", desc = "Open loclist" },

  { "<leader>t", group = "Terminal" },
  { "<leader>tl", _LAZYGIT_TOGGLE, desc = "LazyGit" },
  { "<leader>tn", _NODE_TOGGLE, desc = "Node" },
  { "<leader>tu", _NCDU_TOGGLE, desc = "NCDU" },
  { "<leader>tt", _HTOP_TOGGLE, desc = "Htop" },
  { "<leader>tp", _PYTHON_TOGGLE, desc = "Python" },
  { "<leader>tf", "<cmd>ToggleTerm direction=float<cr>", desc = "Float" },
  { "<leader>th", "<cmd>ToggleTerm direction=horizontal<cr>", desc = "Horizontal" },
  { "<leader>tv", "<cmd>ToggleTerm direction=vertical<cr>", desc = "Vertical" },

  { "<leader>u", group = "Test" },
  {
    "<leader>ua",
    function()
      require("neotest").run.attach()
    end,
    desc = "Attach to the process",
  },
  {
    "<leader>un",
    function()
      require("neotest").run.run()
    end,
    desc = "Run nearest test",
  },
  {
    "<leader>uo",
    function()
      require("neotest").output_panel.toggle()
    end,
    desc = "Show the output of the nearest test",
  },
  {
    "<leader>uu",
    function()
      require("neotest").run.run(vim.fn.expand "%")
    end,
    desc = "Run all tests in the current file",
  },
  {
    "<leader>us",
    function()
      require("neotest").summary.toggle()
    end,
    desc = "Toggle the test summary window",
  },
  {
    "<leader>uS",
    function()
      require("neotest").run.stop()
    end,
    desc = "Stop running test",
  },
}

for _, mapping in ipairs(mappings) do
  if mapping[2] ~= nil then
    vim.keymap.set("n", mapping[1], mapping[2], {
      silent = true,
      noremap = true,
      nowait = true,
      desc = mapping.desc,
    })
  end
end

which_key.add(mappings, {
  mode = "n",
})
