local status_ok, lualine = pcall(require, "lualine")
if not status_ok then
	return
end

local diagnostics = {
	"diagnostics",
	sources = { "nvim_diagnostic" },
	sections = { "error", "warn" },
	symbols = { error = " ", warn = " " },
	colored = false,
	update_in_insert = false,
	always_visible = true,
}

local LnCol = function()
  local r,c = unpack(vim.api.nvim_win_get_cursor(0))
  return "Ln " ..r.. ", Col " ..c
end

local branch = {
	"branch",
	icons_enabled = true,
	icon = "",
}

local spaces = function()
	return "Tab Size: " .. vim.api.nvim_buf_get_option(0, "shiftwidth")
end

lualine.setup({
	options = {
		icons_enabled = true,
		theme = "auto",
		component_separators = { left = "", right = "" },
		section_separators = { left = "", right = "" },
		disabled_filetypes = { "alpha", "dashboard", "NvimTree", "Outline" },
		always_divide_middle = true,
	},
	sections = {
		lualine_a = { branch },
		lualine_b = { diagnostics },
		lualine_c = { },
		lualine_x = { LnCol },
		-- lualine_x = { diff, spaces, "encoding", filetype },
		lualine_y = { spaces },
		lualine_z = { "encoding", "filetype" },
	},
	inactive_sections = {
		lualine_a = {},
		lualine_b = {},
		lualine_c = {},
		lualine_x = {},
		lualine_y = {},
		lualine_z = {},
	},
	tabline = {},
	extensions = {},
})
