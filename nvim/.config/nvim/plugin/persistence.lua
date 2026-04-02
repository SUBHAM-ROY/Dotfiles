vim.pack.add({
  'https://github.com/folke/persistence.nvim',
})

require('persistence').setup({})

local map = vim.keymap.set
map('n', '<leader>pl', function() require('persistence').load() end, { desc = 'Load Session' })
map('n', '<leader>pq', function() require('persistence').stop() end, { desc = 'Quit Without Saving Session' })
map('n', '<leader>ps', function() require('persistence').select() end, { desc = 'Select Session' })
