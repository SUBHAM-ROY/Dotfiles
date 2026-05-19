vim.pack.add({
  'https://github.com/OXY2DEV/markview.nvim',
})

vim.api.nvim_create_autocmd('ColorScheme', {
  callback = function()
    local src = vim.api.nvim_get_hl(0, { name = 'Type' })
    local cur = vim.api.nvim_get_hl(0, { name = 'Italic' })
    cur.fg = src.fg
    vim.api.nvim_set_hl(0, 'Italic', cur)
  end,
})
