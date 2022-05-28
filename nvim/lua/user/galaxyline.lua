local gl = require('galaxyline')
local gps = require('nvim-gps')
local gls = gl.section
local extension = require('galaxyline.provider_extensions')

gl.short_line_list = {
  'LuaTree',
  'NvimTree',
  'vista',
  'dbui',
  'startify',
  'term',
  'nerdtree',
  'fugitive',
  'fugitiveblame',
  'plug',
  'plugins'
}

VistaPlugin = extension.vista_nearest

local ProgFileTypes = { 'lua', 'python', 'typescript', 'typescriptreact', 'react', 'javascript', 'javascriptreact', 'rust', 'go', 'html' }

-- for checking value in table
local function has_value(tab, val)
  for index, value in ipairs(tab) do
    if value == val then
      return true
    end
  end

  return false
end

local function get_color()
  if vim.o.background == 'light' then
    return "#fff"
  end
  return "#353644"
end

local function get_color_bg()
  if vim.o.background == 'light' then
    return "#fff"
  end
  return "#282c34"
end

-- then change in colors line_bg = get_color_bg

local colors = {
  bg        = "#33373E",
  line_bg   = "#3D4147",
  fg        = "#abb2bf",
  red       = "#e06c75",
  orange    = "#d19a66",
  yellow    = "#e5c07b",
  green     = "#98c379",
  cyan      = "#56b6c2",
  blue      = "#61afef",
  purple    = "#c678dd",
  white     = "#abb2bf",
  black     = "#282c34",
  gray      = "#5c6370",
  highlight = "#e2be7d",
}


local function file_readonly(readonly_icon)
  if vim.bo.filetype == 'help' then
    return ''
  end
  local icon = readonly_icon or ''
  if vim.bo.readonly == true then
    return " " .. icon .. " "
  end
  return ''
end

-- get current file name
local function get_current_file_name()
  -- local file = vim.fn.expand('%:t')
  -- local file = vim.fn.expand('%:f')
  local file = string.gsub(vim.api.nvim_buf_get_name(0), vim.loop.cwd(), '')
  if vim.fn.empty(file) == 1 then return '' end
  if string.len(file_readonly(readonly_icon)) ~= 0 then
    return file .. file_readonly(readonly_icon)
  end
  local icon = modified_icon or ''
  if vim.bo.modifiable then
    if vim.bo.modified then
      return file .. ' ' .. icon .. '  '
    end
  end
  return file .. ' '
end

local function lsp_status(status)
  shorter_stat = ''
  for match in string.gmatch(status, "[^%s]+") do
    err_warn = string.find(match, "^[WE]%d+", 0)
    if not err_warn then
      shorter_stat = shorter_stat .. ' ' .. match
    end
  end
  return shorter_stat
end

local function get_coc_lsp()
  local status = vim.fn['coc#status']()
  if not status or status == '' then
    return ''
  end
  return lsp_status(status)
end

function get_diagnostic_info()
  if vim.fn.exists('*coc#rpc#start_server') == 1 then
    return get_coc_lsp()
  end
  return ''
end

local function get_current_func()
  local has_func, func_name = pcall(vim.api.nvim_buf_get_var, 0, 'coc_current_function')
  if not has_func then return end
  return func_name
end

function get_function_info()
  if vim.fn.exists('*coc#rpc#start_server') == 1 then
    return get_current_func()
  end
  return ''
end

local function trailing_whitespace()
  local trail = vim.fn.search("\\s$", "nw")
  if trail ~= 0 then
    return ' '
  else
    return nil
  end
end

-- current_func_status with treesitter
local function get_current_func_from_treesitter()
  local opts = {
    indicator_size = 100,
    type_patterns = { 'class', 'function', 'method', },
    transform_fn = function(line) return line:gsub('%s*[%[%(%{]*%s*$', '') end,
    separator = '  ',
  }
  local status = vim.fn['nvim_treesitter#statusline'](opts)
  if not status or status == '' then
    return ''
  end
  return status
end

local function get_current_context()
  if vim.fn.exists('nvim_treesitter#statusline') == 1 then
    return get_current_func_from_treesitter()
  end
  return ''
end

CocStatus = get_diagnostic_info
CocFunc = get_current_func
TreesitterContext = get_current_func_from_treesitter
TrailingWhiteSpace = trailing_whitespace

function has_file_type()
  local f_type = vim.bo.filetype
  if not f_type or f_type == '' then
    return false
  end
  return true
end

function has_file_prog_filetype()
  local f_type = vim.bo.filetype
  if not f_type or f_type == '' then
    return false
  end
  if has_value(ProgFileTypes, f_type) then
    return true
  end
  return false
end

local buffer_not_empty = function()
  if vim.fn.empty(vim.fn.expand('%:t')) ~= 1 then
    return true
  end
  return false
end

gls.left[1] = {
  FirstElement = {
    provider = function() return ' ' end,
    highlight = { colors.blue, colors.line_bg }
  },
}
gls.left[3] = {
  FileIcon = {
    provider = 'FileIcon',
    condition = buffer_not_empty,
    highlight = { require('galaxyline.provider_fileinfo').get_file_icon_color, colors.line_bg },
  },
}
gls.left[4] = {
  FileName = {
    provider = { get_current_file_name },
    condition = buffer_not_empty,
    highlight = { colors.fg, colors.line_bg, 'bold' }
  }
}

gls.left[5] = {
  GitIcon = {
    provider = function() return '  ' end,
    condition = require('galaxyline.provider_vcs').check_git_workspace,
    highlight = { colors.blue, colors.line_bg },
  }
}
gls.left[6] = {
  GitBranch = {
    provider = 'GitBranch',
    condition = require('galaxyline.provider_vcs').check_git_workspace,
    highlight = { colors.blue, colors.line_bg, 'bold' },
  }
}

local checkwidth = function()
  local squeeze_width = vim.fn.winwidth(0) / 2
  if squeeze_width > 40 then
    return true
  end
  return false
end
gls.left[13] = {
  Space = {
    provider = function() return '' end
  }
}

gls.left[10] = {
  LeftEnd = {
    provider = function() return '' end,
    separator = '',
    separator_highlight = { colors.bg, colors.line_bg },
    highlight = { colors.line_bg, colors.line_bg }
  }
}

gls.left[11] = {
  TrailingWhiteSpace = {
    provider = TrailingWhiteSpace,
    icon = '   ',
    highlight = { colors.blue, colors.bg },
  }
}

gls.left[12] = {
  DiagnosticError = {
    provider = 'DiagnosticError',
    icon = '  ',
    highlight = { colors.red, colors.bg }
  }
}
gls.left[13] = {
  Space = {
    provider = function() return '' end
  }
}
gls.left[14] = {
  DiagnosticWarn = {
    provider = 'DiagnosticWarn',
    icon = '   ',
    highlight = { colors.yellow, colors.bg },
  }
}
gls.left[16] = {
  CocFunc = {
    provider = CocFunc,
    icon = ' ',
    highlight = { colors.blue, colors.bg },
  }
}

gls.left[17] = {
  TreesitterContext = {
    provider = TreesitterContext,
    condition = has_file_prog_filetype,
    icon = '  λ ',
    highlight = { colors.blue, colors.bg },
  }
}

gls.left[17] = {
  nvimGPS = {
    provider = function()
      return gps.get_location()
    end,
    condition = function()
      return gps.is_available()
    end,
    icon = '  ',
    highlight = { colors.blue, colors.bg },
  }
}

gls.short_line_right[1] = {
  BufferIcon = {
    provider = 'BufferIcon',
    separator = '',
    condition = has_file_type,
    separator_highlight = { colors.blue, colors.bg },
    highlight = { colors.fg, colors.blue }
  }
}

-- set global status line
vim.cmd [[
set laststatus=3
highlight WinSeparator guibg=none
]]