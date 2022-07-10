-- Example config in Lua
vim.g.tokyonight_style = "night"
vim.g.tokyonight_italic_functions = true
vim.g.tokyonight_sidebars = { "qf", "vista_kind", "terminal", "packer" }

-- Load the colorscheme
vim.cmd[[colorscheme tokyonight]]
-- Change the "hint" color to the "orange" color, and make the "error" color bright red
vim.api.nvim_set_hl(0, "lineNr", { fg = "#4d5166", bg = "#1b1a26"})
