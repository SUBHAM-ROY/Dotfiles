return {
  'EdenEast/nightfox.nvim',
  event = 'VeryLazy',
  priority = 1000,
  config = function()
    vim.cmd.colorscheme('nordfox')
    vim.api.nvim_set_hl(0, 'Visual', { bg = '#7686ad' })
  end,
}
