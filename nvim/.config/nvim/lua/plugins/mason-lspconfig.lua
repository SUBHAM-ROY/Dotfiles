return {
  'mason-org/mason-lspconfig.nvim',
  lazy = false,
  opts = {
    ensure_installed = {
      'pyright',
    },
  },
  dependencies = {
    { 'mason-org/mason.nvim', opts = {} },
    'neovim/nvim-lspconfig',
  },
  keys = {
    { '<leader>M', '<cmd>Mason<cr>', desc = 'Mason' },
  },
  init = function()
    local icons = {
      [vim.diagnostic.severity.ERROR] = '',
      [vim.diagnostic.severity.WARN] = '',
      [vim.diagnostic.severity.INFO] = '',
      [vim.diagnostic.severity.HINT] = '󰌶',
    }
    vim.diagnostic.config({
      virtual_text = {
        prefix = function(diagnostic, _, _)
          return icons[diagnostic.severity] .. ' '
        end,
      },
      signs = {
        text = icons,
      },
    })
  end,
}
