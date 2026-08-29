vim.pack.add({
  'https://github.com/folke/sidekick.nvim',
})

local tools = {}

-- linux: opencode sandbox via podman
local opencode_compose = vim.fn.expand('~/Codes/agent-sandbox/compose.yaml')
if vim.fn.filereadable(opencode_compose) == 1 then
  tools.opencode_sandbox = {
    cmd = {
      'podman',
      'compose',
      '-f',
      opencode_compose,
      'run',
      '--rm',
      'opencode',
    },
  }
end

-- resolves the main repo's .git dir (differs from PWD/.git when PWD is a linked worktree)
-- so it can be bind-mounted alongside PWD, letting the worktree's gitdir pointer resolve in-container
local git_common_dir_cmd =
  'GIT_COMMON_DIR="$(git rev-parse --path-format=absolute --git-common-dir 2>/dev/null || echo "$PWD/.git")"'

-- mac: claude sandbox via docker
local claude_compose = vim.fn.expand('~/Desktop/Codes/agent-sandbox/compose.claude.yaml')
if vim.fn.filereadable(claude_compose) == 1 then
  tools.claude_sandbox = {
    cmd = {
      'sh',
      '-c',
      'touch -a "$PWD/.env"; '
        .. git_common_dir_cmd
        .. ' exec docker compose -f "'
        .. claude_compose
        .. '" run --rm agent-sandbox',
    },
  }
end

-- mac: cursor sandbox via docker
local cursor_compose = vim.fn.expand('~/Desktop/Codes/agent-sandbox/compose.cursor.yaml')
if vim.fn.filereadable(cursor_compose) == 1 then
  tools.cursor_sandbox = {
    cmd = {
      'sh',
      '-c',
      'touch -a "$PWD/.env"; '
        .. git_common_dir_cmd
        .. ' exec docker compose -f "'
        .. cursor_compose
        .. '" run --rm cursor-sandbox',
    },
  }
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
