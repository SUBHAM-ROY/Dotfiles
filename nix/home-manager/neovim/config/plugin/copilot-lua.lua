vim.pack.add({
  'https://github.com/zbirenbaum/copilot.lua',
})

require('copilot').setup({
  server = {
    type = 'binary',
    -- nixpkgs `copilot-language-server` on PATH, no auto-download
    custom_server_filepath = 'copilot-language-server',
  },
  filetypes = {
    markdown = true,
    yaml = true,
  },
  suggestion = {
    auto_trigger = false,
    keymap = {
      accept = '<C-l>',
      accept_word = '<C-]>',
      accept_line = '<C-\\>',
      dismiss = false,
    },
  },
})

vim.keymap.set('n', '<leader>gc', '<cmd>Copilot toggle<cr>', { desc = 'Toggle Copilot' })
