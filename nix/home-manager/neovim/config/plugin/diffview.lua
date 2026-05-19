vim.pack.add({
  'https://github.com/sindrets/diffview.nvim',
})

require('diffview').setup({
  file_panel = {
    win_config = {
      position = 'right',
    },
  },
  hooks = {
    diff_buf_win_enter = function() vim.opt_local.foldenable = false end,
  },
})

local map = vim.keymap.set
map('n', '<leader>do', ':DiffviewOpen<CR>', { desc = 'Open Diffview' })
map('n', '<leader>dm', ':DiffviewOpen master...HEAD<CR>', { desc = 'Diffview master..HEAD' })
map('n', '<leader>dc', ':DiffviewClose<CR>', { desc = 'Close Diffview' })
