vim.pack.add({
  'https://github.com/folke/sidekick.nvim',
})

require('sidekick').setup({
  cli = {
    mux = {
      backend = 'tmux',
      enabled = true,
    },
  },
})

local map = vim.keymap.set

map('n', '<tab>', function()
  if not require('sidekick').nes_jump_or_apply() then return '<Tab>' end
end, { expr = true, desc = 'Goto/Apply Next Edit Suggestion' })

map('n', '<leader>aa', function() require('sidekick.cli').toggle() end, { desc = 'Sidekick Toggle CLI' })
map(
  'n',
  '<leader>as',
  function() require('sidekick.cli').select({ filter = { installed = true } }) end,
  { desc = 'Select CLI' }
)
map({ 'x', 'n' }, '<leader>at', function() require('sidekick.cli').send({ msg = '{this}' }) end, { desc = 'Send This' })
map('n', '<leader>af', function() require('sidekick.cli').send({ msg = '{file}' }) end, { desc = 'Send File' })
map(
  'x',
  '<leader>av',
  function() require('sidekick.cli').send({ msg = '{selection}' }) end,
  { desc = 'Send Visual Selection' }
)
map({ 'n', 'x' }, '<leader>ap', function() require('sidekick.cli').prompt() end, { desc = 'Sidekick Select Prompt' })
map(
  { 'n', 'x' },
  '<leader>ad',
  function() require('sidekick.cli').send({ msg = '{diagnostics}' }) end,
  { desc = 'Send Diagnostic' }
)
