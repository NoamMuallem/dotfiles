local fn = vim.fn

-- Automatically install packer
local install_path = fn.stdpath "data" .. "/site/pack/packer/start/packer.nvim"
if fn.empty(fn.glob(install_path)) > 0 then
  PACKER_BOOTSTRAP = fn.system {
    "git",
    "clone",
    "--depth",
    "1",
    "https://github.com/wbthomason/packer.nvim",
    install_path,
  }
  print "Installing packer close and reopen Neovim..."
  vim.cmd [[packadd packer.nvim]]
end

-- Autocommand that reloads neovim whenever you save the plugins.lua file
vim.cmd [[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerSync
  augroup end
]]

-- Use a protected call so we don't error out on first use
local status_ok, packer = pcall(require, "packer")
if not status_ok then
  return
end

-- Have packer use a popup window
packer.init {
  display = {
    open_fn = function()
      return require("packer.util").float { border = "rounded" }
    end,
  },
}

-- Install your plugins here
return packer.startup(function(use)
  -- My plugins here
  use "wbthomason/packer.nvim" -- Have packer manage itself
  use "nvim-lua/popup.nvim" -- An implementation of the Popup API from vim in Neovim
  use "nvim-lua/plenary.nvim" -- Useful lua functions used ny lots of plugins
  use "kyazdani42/nvim-web-devicons"
  use "lewis6991/impatient.nvim" -- faster startup time
  use "goolord/alpha-nvim" -- startup menu
  use "antoinemadec/FixCursorHold.nvim" -- This is needed to fix lsp doc highlight
  use "folke/which-key.nvim" -- shows available commands durring input
  -- Telescope
  use({
    "nvim-telescope/telescope.nvim",
    config = function()
      require("user.telescope")
    end,
    requires = {
      "nvim-telescope/telescope-z.nvim",
      "nvim-telescope/telescope-project.nvim",
      "nvim-telescope/telescope-symbols.nvim",
      "nvim-telescope/telescope-fzy-native.nvim",
      -- { "nvim-telescope/telescope-frecency.nvim", requires = "tami5/sql.nvim" }
    },
  })
  use({
    "folke/trouble.nvim",
    wants = "nvim-web-devicons",
    config = function()
      require("trouble").setup({
        auto_open = false,
        use_diagnostic_signs = true, -- en
      })
    end,
  }) -- cool and usefull diagnostics manu
  use({
    "kyazdani42/nvim-tree.lua",
    cmd = { "NvimTreeToggle", "NvimTreeClose" },
    config = function()
      require("user.nvim-tree")
    end,
  }) --project tree plugin
  use {
    'glepnir/galaxyline.nvim',
    branch = 'main',
    -- your statusline
    config = function() require 'user.galaxyline' end,
    -- some optional icons
    requires = { 'kyazdani42/nvim-web-devicons', opt = true }
  } -- status line
  use({
    "lukas-reineke/indent-blankline.nvim",
    event = "BufReadPre",
    config = function()
      require("user.indentline")
    end,
  }) -- ident lines
  use({
    "petertriho/nvim-scrollbar",
    event = "BufReadPre",
    config = function()
      require("scrollbar").setup({
        handle = {
          color = "#33373E",
        },
        marks = {
          Search = { color = "#d19a66" },
          Error = { color = "#e06c75" },
          Warn = { color = "#e5c07b" },
          Info = { color = "#56b6c2" },
          Misc = { color = "#c678dd" },
        }
      })
    end
  }) -- scrollbar with diagnostics
  use {
    "narutoxy/dim.lua",
    event = "BufReadPre",
    requires = { "nvim-treesitter/nvim-treesitter", "neovim/nvim-lspconfig" },
    config = function()
      require('dim').setup({})
    end } -- dim out variables and functions that are unused

  use({ "stevearc/dressing.nvim", event = "BufReadPre" }) -- ui components
  use {
    "ray-x/lsp_signature.nvim",
  } -- show function signeture in popup

  use { 'alvarosevilla95/luatab.nvim',
    requires = 'kyazdani42/nvim-web-devicons',
    event = "BufReadPre",
    wants = "nvim-web-devicons",
    config = function()
      require('luatab').setup {}
    end } -- tabline


  use({
    "andymass/vim-matchup",
    event = "CursorMoved",
  }) -- shows openning/ closing scope line instead of the statuse line when cursore holds on closing/ openning of scope

  use({
    "phaazon/hop.nvim",
    keys = { "gh" },
    cmd = "HopWord",
    config = function()
      require("hop").setup({})
      -- changed the color on hints:
      vim.cmd("hi HopNextKey guibg=#ff9900")
      vim.cmd("hi HopNextKey guifg=#000000")
      vim.cmd("hi HopNextKey1 guibg=#ff9900")
      vim.cmd("hi HopNextKey1 guifg=#000000")
      vim.cmd("hi HopNextKey2 guibg=#ff9900")
      vim.cmd("hi HopNextKey2 guifg=#000000")
    end,
  }) -- move to any word on the buffer (quick navigation)

  use({ 'p00f/nvim-ts-rainbow', event = "BufReadPre" }) -- color same brackets with same color

  -- Colorschemes
  use {
    'folke/tokyonight.nvim',
    config = function()
      require("user.colorscheme")
    end
  }

  use({
    "hrsh7th/nvim-cmp",
    event = "InsertEnter",
    opt = true,
    config = function()
      require("user.cmp")
    end,
    wants = { "LuaSnip" },
    requires = {
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path",
      "saadparwaiz1/cmp_luasnip",
      "hrsh7th/cmp-cmdline",
      {
        "L3MON4D3/LuaSnip",
        wants = "friendly-snippets",
      },
      "rafamadriz/friendly-snippets",
      {
        module = "nvim-autopairs",
        "windwp/nvim-autopairs",
        config = function()
          require("user.autopairs")
        end,
      },
    },
  }) -- completion + snippets + autopairs (closing automatically '(' and '{' etc...)

  use({
    "neovim/nvim-lspconfig",
    event = "BufReadPre",
    wants = {
      "null-ls.nvim",
      "cmp-nvim-lsp",
      "nvim-lsp-installer",
    },
    config = function()
      require("user.lsp.init")
    end,
    requires = {
      "tamago324/nlsp-settings.nvim",
      "jose-elias-alvarez/null-ls.nvim",
      "williamboman/nvim-lsp-installer",
    },
  }) -- lsp

  -- Treesitter
  use({
    "nvim-treesitter/nvim-treesitter",
    run = ":TSUpdate",
    opt = true,
    event = "BufRead",
    config = function()
      require("user.treesitter")
    end,
  })

  -- Git
  use({
    "lewis6991/gitsigns.nvim",
    event = "BufReadPre",
    wants = "plenary.nvim",
    requires = { "nvim-lua/plenary.nvim" },
    config = function()
      require("user.gitsigns")
    end,
  }) -- shows on the left in line hase beed deleted/ modified or added

  use({
    "TimUntersberger/neogit",
    module = "neogit",
    cmd = "Neogit",
    config = function()
      require("user.neogit")
    end,
  }) -- a tool to execute git actions

  use({
    "sindrets/diffview.nvim",
    cmd = { "DiffviewOpen", "DiffviewClose", "DiffviewToggleFiles", "DiffviewFocusFiles" },
    config = function()
      require("diffview").setup({})
    end,
  }) -- a tool to show the diff of the current priject state to the last commit

  -- Css colors:
  use({
    "norcalli/nvim-colorizer.lua",
    event = "BufReadPre",
    config = function()
      require("user.colorizer")
    end,
  })

  -- Automatically set up your configuration after cloning packer.nvim
  -- Put this at the end after all plugins
  if PACKER_BOOTSTRAP then
    require("packer").sync()
  end

end)
