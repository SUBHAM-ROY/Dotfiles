vim.pack.add({
  'https://github.com/sindrets/diffview.nvim',
})

require('diffview').setup({
  file_panel = {
    win_config = {
      position = 'right',
    },
  },
})

local map = vim.keymap.set
map('n', '<leader>do', ':DiffviewOpen<CR>', { desc = 'Open Diffview' })
map('n', '<leader>dm', ':DiffviewOpen master...HEAD<CR>', { desc = 'Diffview master..HEAD' })
map('n', '<leader>dc', ':DiffviewClose<CR>', { desc = 'Close Diffview' })
