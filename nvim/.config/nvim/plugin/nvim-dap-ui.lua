vim.pack.add({
  'https://github.com/mfussenegger/nvim-dap',
  'https://github.com/nvim-neotest/nvim-nio',
  'https://github.com/rcarriga/nvim-dap-ui',
  'https://github.com/mfussenegger/nvim-dap-python',
})

require('dap-python').setup('~/.local/share/nvim/mason/packages/debugpy/venv/bin/python3')

local dap, dapui = require('dap'), require('dapui')
dapui.setup()

dap.listeners.before.attach.dapui_config = function() dapui.open() end
dap.listeners.before.launch.dapui_config = function() dapui.open() end
dap.listeners.before.event_terminated.dapui_config = function() dapui.close() end
dap.listeners.before.event_exited.dapui_config = function() dapui.close() end

local map = vim.keymap.set
map('n', 'gb', function() require('dap').toggle_breakpoint() end, { desc = 'Toggle Breakpoint' })
map('n', '<F5>', function() require('dap').continue() end, { desc = 'Dap Continue' })
map('n', '<F10>', function() require('dap').step_over() end, { desc = 'Dap Step Over' })
map('n', '<F11>', function() require('dap').step_into() end, { desc = 'Dap Step Into' })
map('n', '<F12>', function() require('dap').step_out() end, { desc = 'Dap Step Out' })
map('n', '<leader>de', function() require('dapui').eval() end, { desc = 'Dap Eval' })
