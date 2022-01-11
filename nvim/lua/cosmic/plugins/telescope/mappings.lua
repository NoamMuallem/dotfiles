local map = require('cosmic.utils').map
local M = {}

M.project_files = function()
  local opts = {} -- define here if you want to define something
  local ok = pcall(require('telescope.builtin').git_files, opts)
  if not ok then
    require('telescope.builtin').find_files(opts)
  end
end

M.init = function()
  -- navigation
  map('n', '<leader><leader>', '<cmd>lua require("cosmic.plugins.telescope.mappings").project_files()<cr>')
  map('n', '<leader>b', ':Telescope buffers<cr>')
  map('n', '<leader>/', ':Telescope live_grep<cr>')

  -- git navigation
  map('n', '<leader>ggc', ':Telescope git_commits<cr>')
  map('n', '<leader>ggs', ':Telescope git_status<cr>')
end

return M
