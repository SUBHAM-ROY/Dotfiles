return {
  'folke/persistence.nvim',
  event = 'BufReadPre', -- this will only start session saving when an actual file was opened
  opts = {},
  keys = {
    {
      '<leader>pl',
      function()
        require('persistence').load()
      end,
      desc = 'Load Session',
    },
    {
      '<leader>pq',
      function()
        require('persistence').stop()
      end,
      desc = 'Quit Without Saving Session',
    },
    {
      '<leader>ps',
      function()
        require('persistence').select()
      end,
      desc = 'Select Session',
    },
  },
}
