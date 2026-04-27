vim.pack.add({
  'https://github.com/neovim/nvim-lspconfig',
})

vim.lsp.enable('pyright')
vim.lsp.enable('markdown_oxide')
vim.lsp.enable('rust_analyzer')

local icons = {
  [vim.diagnostic.severity.ERROR] = '',
  [vim.diagnostic.severity.WARN] = '',
  [vim.diagnostic.severity.INFO] = '',
  [vim.diagnostic.severity.HINT] = '󰌶',
}
vim.diagnostic.config({
  virtual_text = {
    prefix = function(diagnostic, _, _) return icons[diagnostic.severity] .. ' ' end,
  },
  signs = {
    text = icons,
  },
})
