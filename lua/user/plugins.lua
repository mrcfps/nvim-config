local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
local uv = vim.uv

if not uv.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable",
    lazypath,
  })
end

vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
  "nvim-lua/popup.nvim",
  "nvim-lua/plenary.nvim",
  "windwp/nvim-autopairs",
  "numToStr/Comment.nvim",
  "ethanholz/nvim-lastplace",
  "gelguy/wilder.nvim",
  "editorconfig/editorconfig-vim",
  "nvim-tree/nvim-web-devicons",
  "nvim-tree/nvim-tree.lua",
  "akinsho/bufferline.nvim",
  "moll/vim-bbye",
  "tpope/vim-surround",
  "nvim-lualine/lualine.nvim",
  "akinsho/toggleterm.nvim",
  "karb94/neoscroll.nvim",
  "ahmedkhalf/project.nvim",
  "lewis6991/impatient.nvim",
  "lukas-reineke/indent-blankline.nvim",
  "goolord/alpha-nvim",
  "antoinemadec/FixCursorHold.nvim",
  "folke/which-key.nvim",
  "echasnovski/mini.icons",

  "rafi/awesome-vim-colorschemes",
  "ayu-theme/ayu-vim",
  "catppuccin/nvim",
  "folke/tokyonight.nvim",
  "lunarvim/darkplus.nvim",

  "ray-x/go.nvim",

  "hrsh7th/nvim-cmp",
  "hrsh7th/cmp-buffer",
  "hrsh7th/cmp-path",
  "hrsh7th/cmp-cmdline",
  "saadparwaiz1/cmp_luasnip",
  "hrsh7th/cmp-nvim-lsp",

  "L3MON4D3/LuaSnip",
  "rafamadriz/friendly-snippets",

  "neovim/nvim-lspconfig",
  "williamboman/mason.nvim",
  "williamboman/mason-lspconfig.nvim",
  "tamago324/nlsp-settings.nvim",
  "ray-x/lsp_signature.nvim",

  "simrat39/symbols-outline.nvim",

  "nvim-telescope/telescope.nvim",

  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
  },
  "nvim-treesitter/nvim-treesitter-textobjects",
  "JoosepAlviste/nvim-ts-context-commentstring",

  "lewis6991/gitsigns.nvim",

  {
    "jakewvincent/mkdnflow.nvim",
    ft = { "markdown", "rmd" },
    config = function()
      require("mkdnflow").setup({
        mappings = {
          MkdnFollowLink = { "n", "gd" },
        },
      })
    end,
  },

  {
    "folke/trouble.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
  },

  "vim-test/vim-test",
  {
    "nvim-neotest/neotest",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-neotest/nvim-nio",
      "nvim-neotest/neotest-go",
      "nvim-treesitter/nvim-treesitter",
      "antoinemadec/FixCursorHold.nvim",
    },
    config = function()
      local neotest_ns = vim.api.nvim_create_namespace("neotest")
      vim.diagnostic.config({
        virtual_text = {
          format = function(diagnostic)
            local message =
              diagnostic.message:gsub("\n", " "):gsub("\t", " "):gsub("%s+", " "):gsub("^%s+", "")
            return message
          end,
        },
      }, neotest_ns)
      require("neotest").setup({
        adapters = {
          require("neotest-go"),
        },
      })
    end,
  },
}, {
  install = { missing = true },
  checker = { enabled = false },
})
