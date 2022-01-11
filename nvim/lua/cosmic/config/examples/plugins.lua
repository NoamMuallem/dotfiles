-- Add additional plugins as well as disable some core plugins

local plugins = {
  add = {
    'ggandor/lightspeed.nvim',
    {
      'romgrk/barbar.nvim',
      requires = { 'kyazdani42/nvim-web-devicons' },
    },
  },
  disable = { -- disabling some core plugins may mean you'll have to remap some keybindings
    [[
    'terminal',
    ]]
  },
}

return plugins
