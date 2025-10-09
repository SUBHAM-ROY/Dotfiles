return {
  'rcarriga/nvim-dap-ui',
  dependencies = {
    'mfussenegger/nvim-dap',
    'nvim-neotest/nvim-nio',
    'mfussenegger/nvim-dap-python',
  },
  init = function()
    require('dap-python').setup(
      '~/.local/share/nvim/mason/packages/debugpy/venv/bin/python3'
    )
    local dap, dapui = require('dap'), require('dapui')
    require('dapui').setup()
    dap.listeners.before.attach.dapui_config = function()
      dapui.open()
    end
    dap.listeners.before.launch.dapui_config = function()
      dapui.open()
    end
    dap.listeners.before.event_terminated.dapui_config = function()
      dapui.close()
    end
    dap.listeners.before.event_exited.dapui_config = function()
      dapui.close()
    end
  end,
  keys = {
    {
      'gb',
      function()
        require('dap').toggle_breakpoint()
      end,
      desc = 'Toggle Breakpoint',
    },
    {
      '<F5>',
      function()
        require('dap').continue()
      end,
      desc = 'Dap Continue',
    },
    {
      '<F10>',
      function()
        require('dap').step_over()
      end,
      desc = 'Dap Step Over',
    },
    {
      '<F11>',
      function()
        require('dap').step_into()
      end,
      desc = 'Dap Step Into',
    },
    {
      '<F12>',
      function()
        require('dap').step_out()
      end,
      desc = 'Dap Step Out',
    },
    {
      '<leader>de',
      function()
        require('dapui').eval()
      end,
      desc = 'Dap Eval',
    },
  },
}
