vim.pack.add({
  'https://github.com/folke/flash.nvim',
})

require('flash').setup({
  modes = {
    char = {
      highlight = { backdrop = false },
    },
  },
})

vim.keymap.set('n', '<leader>j', function() require('flash').jump() end, { desc = 'Flash Jump' })
