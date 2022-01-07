local lualine = require('lualine')
local gps = require("nvim-gps")

-- Color table for highlights
-- stylua: ignore
local colors = {
  bg       = '#202328',
  fg       = '#bbc2cf',
  yellow   = '#ECBE7B',
  cyan     = '#008080',
  darkblue = '#081633',
  green    = '#98be65',
  orange   = '#FF8800',
  violet   = '#a9a1e1',
  magenta  = '#c678dd',
  blue     = '#51afef',
  red      = '#ec5f67',
}

local conditions = {
  buffer_not_empty = function()
    return vim.fn.empty(vim.fn.expand('%:t')) ~= 1
  end,
  hide_in_width = function()
    return vim.fn.winwidth(0) > 80
  end,
  check_git_workspace = function()
    local filepath = vim.fn.expand('%:p:h')
    local gitdir = vim.fn.finddir('.git', filepath .. ';')
    return gitdir and #gitdir > 0 and #gitdir < #filepath
  end,
}

-- Config
local config = {
  options = {
    -- Disable sections and component separators
    component_separators = '',
    section_separators = '',
    theme = "tokyonight",
    icons_enabled = true,
  },
  sections = {
    -- these are to remove the defaults
    lualine_a = {},
    lualine_b = {},
    lualine_y = {},
    lualine_z = {},
    -- These will be filled later
    lualine_c = {},
    lualine_x = {},
  },
  inactive_sections = {
    -- these are to remove the defaults
    lualine_a = {},
    lualine_b = {},
    lualine_y = {},
    lualine_z = {},
    lualine_c = {},
    lualine_x = {},
  },
}

-- Inserts a component in lualine_c at left section
local function ins_left(component)
  table.insert(config.sections.lualine_c, component)
end

-- Inserts a component in lualine_x ot right section
local function ins_right(component)
  table.insert(config.sections.lualine_x, component)
end

 ins_left({
   -- mode component
   function()
     -- auto change color according to neovims mode
     local mode_color = {
       n = colors.red,
       i = colors.green,
       v = colors.blue,
       [''] = colors.blue,
       V = colors.blue,
       c = colors.magenta,
       no = colors.red,
       s = colors.orange,
       S = colors.orange,
       [''] = colors.orange,
       ic = colors.yellow,
       R = colors.violet,
       Rv = colors.violet,
       cv = colors.red,
       ce = colors.red,
       r = colors.cyan,
       rm = colors.cyan,
       ['r?'] = colors.cyan,
       ['!'] = colors.red,
       t = colors.red,
     }
     vim.api.nvim_command('hi! LualineMode guifg=' .. mode_color[vim.fn.mode()] .. ' guibg=' .. colors.bg)
     return '▊'
   end,
   color = 'LualineMode',
   padding = { right = 1 },
 })

 ins_left("mode")

ins_left({
  'diagnostics',
  sources = { 'nvim_diagnostic' },
  symbols = { error = ' ', warn = ' ', info = ' ' },
  diagnostics_color = {
    color_error = { fg = colors.red },
    color_warn = { fg = colors.yellow },
    color_info = { fg = colors.cyan },
  },
})

ins_left({
  'filename',
  cond = conditions.buffer_not_empty,
  color = { fg = colors.magenta, gui = 'bold' },
  path = 1,
  gps.get_location, cond = gps.is_available ,
})

ins_right({
  'branch',
  icon = '',
  color = { fg = colors.violet, gui = 'bold' },
})

ins_right({
  'diff',
  -- Is it me or the symbol for modified us really weird
  symbols = { added = ' ', modified = '柳 ', removed = ' ' },
  diff_color = {
    added = { fg = colors.green },
    modified = { fg = colors.orange },
    removed = { fg = colors.red },
  },
  cond = conditions.hide_in_width,
})


ins_right("progress")

-- Now don't forget to initialize lualine
lualine.setup(config)

-- local function clock()
--   return " " .. os.date("%H:%M")
-- end
-- 
-- local function lsp_progress(self, is_active)
--   if not is_active then
--     return
--   end
--   local messages = vim.lsp.util.get_progress_messages()
--   if #messages == 0 then
--     return ""
--   end
--   local status = {}
--   for _, msg in pairs(messages) do
--     table.insert(status, (msg.percentage or 0) .. "%% " .. (msg.title or ""))
--   end
--   local spinners = { "⠋", "⠙", "⠹", "⠸", "⠼", "⠴", "⠦", "⠧", "⠇", "⠏" }
--   local ms = vim.loop.hrtime() / 1000000
--   local frame = math.floor(ms / 120) % #spinners
--   return table.concat(status, " | ") .. " " .. spinners[frame + 1]
-- end
-- 
-- vim.cmd([[autocmd User LspProgressUpdate let &ro = &ro]])
-- 
-- local gps = require("nvim-gps")
-- 
-- local config = {
--   options = {
--     theme = "onedark",
--     section_separators = { left = "", right = "" },
--     component_separators = { left = "", right = "" },
--     -- section_separators = { "", "" },
--     -- component_separators = { "", "" },
--     icons_enabled = true,
--   },
--   sections = {
--     lualine_a = { "mode" },
--     lualine_b = { "branch" },
--     lualine_c = {
--       { "filename", path = 1 },
--       { gps.get_location, cond = gps.is_available },
--     },
--     lualine_x = {
--       { "diagnostics", sources = { "nvim_diagnostic" } },
--     },
--     lualine_y = { "filetype", lsp_progress },
--     lualine_z = { "progress" },
--   },
--   inactive_sections = {
--     lualine_a = {},
--     lualine_b = {},
--     lualine_c = {},
--     lualine_x = {},
--     lualine_y = {},
--     lualine_z = {},
--   },
--   extensions = { "nvim-tree" },
-- }
-- 
-- -- try to load matching lualine theme
-- 
-- local M = {}
-- 
-- function M.load()
--   local name = vim.g.colors_name or ""
--   local ok, _ = pcall(require, "lualine.themes." .. name)
--   if ok then
--     config.options.theme = name
--   end
--   require("lualine").setup(config)
-- end
-- 
-- M.load()
-- 
-- -- vim.api.nvim_exec([[
-- --   autocmd ColorScheme * lua require("config.lualine").load();
-- -- ]], false)
-- 
-- return M
