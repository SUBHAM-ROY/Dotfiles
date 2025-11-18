return {
  'OXY2DEV/markview.nvim',
  lazy = false,
  -- For `nvim-treesitter` users.
  priority = 49,
  init = function()
    vim.api.nvim_create_autocmd('ColorScheme', {
      callback = function()
        local src = vim.api.nvim_get_hl(0, { name = 'Type' })
        local cur = vim.api.nvim_get_hl(0, { name = 'Italic' })
        cur.fg = src.fg
        vim.api.nvim_set_hl(0, 'Italic', cur)
      end,
    })
  end,
  dependencies = {
    'saghen/blink.cmp',
  },
}
