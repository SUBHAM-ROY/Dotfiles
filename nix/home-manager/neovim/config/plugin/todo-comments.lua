vim.pack.add({
  'https://github.com/folke/todo-comments.nvim',
  'https://github.com/nvim-lua/plenary.nvim',
})

require('todo-comments').setup({})

vim.keymap.set('n', '<leader>xt', '<cmd>TodoTrouble<cr>', { desc = 'Todo Trouble' })
vim.keymap.set('n', '<leader>st', function() Snacks.picker.todo_comments() end, { desc = 'Todo Comments' })
