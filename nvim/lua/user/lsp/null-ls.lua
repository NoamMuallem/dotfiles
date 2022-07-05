local null_ls_status_ok, null_ls = pcall(require, "null-ls")
if not null_ls_status_ok then
  return
end

-- https://github.com/jose-elias-alvarez/null-ls.nvim/tree/main/lua/null-ls/builtins/formatting
local formatting = null_ls.builtins.formatting

null_ls.setup({
  debug = false,
  sources = {
    formatting.prettierd,
    formatting.eslint_d,
  },
  on_attach = function(client)
    if client.resolved_capabilities.document_formatting then
      -- do not change formatting_sync to formatting (async)
      -- will done formatting after save and will require another save
      vim.cmd("autocmd BufWritePre <buffer> lua vim.lsp.buf.formatting_sync()")
    end
  end,
})
