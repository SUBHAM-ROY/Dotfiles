return {
  'EdenEast/nightfox.nvim',
  event = 'VeryLazy',
  priority = 1000,
  config = function()
    vim.cmd.colorscheme('nordfox')
  end,
}
