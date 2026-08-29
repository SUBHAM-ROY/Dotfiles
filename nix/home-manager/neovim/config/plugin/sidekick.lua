vim.pack.add({
  'https://github.com/folke/sidekick.nvim',
})

local tools = {}

local run_sandbox = nil
for _, p in ipairs({
  vim.fn.expand('~/Codes/agent-sandbox/run-container.sh'),
  vim.fn.expand('~/Desktop/Codes/agent-sandbox/run-container.sh'),
}) do
  if vim.fn.filereadable(p) == 1 then
    run_sandbox = p
    break
  end
end
if run_sandbox then
  if vim.fn.has('mac') == 0 then
    tools.pi_sandbox = { cmd = { run_sandbox, 'pi' } }
    tools.opencode_sandbox = { cmd = { run_sandbox, 'opencode' } }
  else
    tools.claude_sandbox = { cmd = { run_sandbox, 'claude' } }
    tools.cursor_sandbox = { cmd = { run_sandbox, 'cursor' } }
  end
end

require('sidekick').setup({
  cli = {
    mux = {
      backend = 'tmux',
      enabled = true,
    },
    tools = tools,
    win = {
      split = {
        width = 0.45,
      },
    },
  },
})

local map = vim.keymap.set

map('n', '<tab>', function()
  if not require('sidekick').nes_jump_or_apply() then return '<Tab>' end
end, { expr = true, desc = 'Goto/Apply Next Edit Suggestion' })

map(
  'n',
  '<leader>aa',
  function() require('sidekick.cli').toggle({ filter = { installed = true } }) end,
  { desc = 'Sidekick Toggle CLI' }
)
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
