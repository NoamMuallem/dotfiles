local icons = require('cosmic.theme.icons')
local g = vim.g

g.dashboard_custom_header = {
  '',
  '',
  '',
  '',
  '',
  '',
  ' ██████╗ ██████╗ ███████╗███╗   ███╗██╗ ██████╗███╗   ██╗██╗   ██╗██╗███╗   ███╗',
  '██╔════╝██╔═══██╗██╔════╝████╗ ████║██║██╔════╝████╗  ██║██║   ██║██║████╗ ████║',
  '██║     ██║   ██║███████╗██╔████╔██║██║██║     ██╔██╗ ██║██║   ██║██║██╔████╔██║',
  '██║     ██║   ██║╚════██║██║╚██╔╝██║██║██║     ██║╚██╗██║╚██╗ ██╔╝██║██║╚██╔╝██║',
  '╚██████╗╚██████╔╝███████║██║ ╚═╝ ██║██║╚██████╗██║ ╚████║ ╚████╔╝ ██║██║ ╚═╝ ██║',
  ' ╚═════╝ ╚═════╝ ╚══════╝╚═╝     ╚═╝╚═╝ ╚═════╝╚═╝  ╚═══╝  ╚═══╝  ╚═╝╚═╝     ╚═╝',
  '',
  '',
  '',
}

g.dashboard_default_executive = 'telescope'

g.dashboard_custom_section = {
  find_file = {
    description = { icons.file1 .. ' Find File           <leader><leader>' },
    command = 'Telescope find_files',
  },
  file_explorer = {
    description = { icons.file2 .. ' File Manager        <C-n>     ' },
    command = 'NvimTreeToggle',
  },
  find_string = {
    description = { icons.word .. ' Grep String         <leader>fs' },
    command = 'Telescope grep_string',
  },
}

g.dashboard_custom_footer = { 'Noam Muallem' }
