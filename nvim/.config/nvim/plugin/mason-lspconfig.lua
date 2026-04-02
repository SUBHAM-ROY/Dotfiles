vim.pack.add({
  'https://github.com/mason-org/mason.nvim',
  'https://github.com/neovim/nvim-lspconfig',
  'https://github.com/mason-org/mason-lspconfig.nvim',
})

require('mason').setup({})
require('mason-lspconfig').setup({
  ensure_installed = {
    'pyright',
    'markdown_oxide',
  },
})

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

vim.keymap.set('n', '<leader>M', '<cmd>Mason<cr>', { desc = 'Mason' })
