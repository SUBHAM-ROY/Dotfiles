vim.pack.add({
  'https://github.com/zbirenbaum/copilot.lua',
})

require('copilot').setup({
  filetypes = {
    markdown = true,
    yaml = true,
  },
  suggestion = {
    auto_trigger = true,
    keymap = {
      accept = '<C-l>',
      accept_word = '<C-]>',
      accept_line = '<C-\\>',
      dismiss = false,
    },
  },
})

vim.keymap.set('n', '<leader>gc', '<cmd>Copilot toggle<cr>', { desc = 'Toggle Copilot' })
