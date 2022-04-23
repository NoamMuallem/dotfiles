vim.cmd [[
augroup last_cursor_position
    autocmd!
    autocmd BufReadPost *
      \ if line("'\"") > 1 && line("'\"") <= line("$") && &ft !~# 'commit' | execute "normal! g`\"zvzz" | endif
  augroup END
]]

vim.api.nvim_create_autocmd('FocusLost', { pattern = '*', command = 'silent! wa' })
