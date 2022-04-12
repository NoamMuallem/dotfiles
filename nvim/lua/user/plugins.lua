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
  use({
    "kyazdani42/nvim-tree.lua",
    cmd = { "NvimTreeToggle", "NvimTreeClose" },
    config = function()
      require("user.nvim-tree")
    end,
  }) --project tree plugin
  use({
    "nvim-lualine/lualine.nvim",
    event = "VimEnter",
    config = [[require('user.lualine')]],
    wants = "nvim-web-devicons"
  }) -- status line
  use "lewis6991/impatient.nvim" -- faster startup time
    use({
    "lukas-reineke/indent-blankline.nvim",
    event = "BufReadPre",
    config = function()
      require("user.indentline")
    end,
  }) -- ident lines
  use "goolord/alpha-nvim" -- startup menu
  use "antoinemadec/FixCursorHold.nvim" -- This is needed to fix lsp doc highlight
  use "folke/which-key.nvim" -- shows available commands durring input
  use({
    "petertriho/nvim-scrollbar",
    event = "BufReadPre",
    config = function()
        require("scrollbar").setup({
        handle = {
        color = "#2c2c2c",
    },
      })
    end
  }) -- scrollbar with diagnostics
  use {
  "narutoxy/dim.lua",
  requires = { "nvim-treesitter/nvim-treesitter", "neovim/nvim-lspconfig" },
  config = function()
    require('dim').setup({})
  end} -- dim out variables and functions that are unused

  use({ "stevearc/dressing.nvim", event = "BufReadPre" }) -- ui components

  use { 'alvarosevilla95/luatab.nvim',
    requires='kyazdani42/nvim-web-devicons',
    event = "BufReadPre",
    wants = "nvim-web-devicons",
    config = function()
      require('luatab').setup{}
    end} -- tabline

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
      vim.cmd("hi HopNextKey guifg=#ff9900")
      vim.cmd("hi HopNextKey1 guifg=#ff9900")
      vim.cmd("hi HopNextKey2 guifg=#ff9900")
    end,
  }) -- move to any word on the buffer (quick navigation)

  -- use({
  --   "SmiteshP/nvim-gps",
  --   requires = "nvim-treesitter/nvim-treesitter",
  --   wants = "nvim-treesitter",
  --   module = "nvim-gps",
  --   config = function()
  --     require("nvim-gps").setup({ separator = " " })
  --   end,
  -- }) -- gives the rout of the buffer

  -- Colorschemes
  -- use "lunarvim/colorschemes" -- A bunch of colorschemes you can try out
  use "lunarvim/darkplus.nvim"
  use 'folke/tokyonight.nvim'

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
    opt = true,
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


  -- Telescope
  use({
    "nvim-telescope/telescope.nvim",
    config = function()
      require("user.telescope")
    end,
  })

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

