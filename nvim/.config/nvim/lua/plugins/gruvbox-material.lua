return {
  'sainnhe/gruvbox-material',
  lazy = false,
  priority = 1000,
  config = function()
    vim.g.gruvbox_material_enable_italic = true
    vim.g.gruvbox_material_foreground = 'mix'
    vim.g.gruvbox_material_diagnostic_virtual_text = 'colored'
    vim.g.gruvbox_material_transparent_background = 1
    vim.cmd.colorscheme('gruvbox-material')
    vim.api.nvim_set_hl(0, 'LineNr', { fg = '#665c54', bg = '#1d2021' })
    vim.api.nvim_set_hl(0, 'DiffAdd', { bg = '#4a7c4a' })
    vim.api.nvim_set_hl(0, 'DiffChange', { bg = '#7c7c4a' })
    vim.api.nvim_set_hl(0, 'DiffDelete', { bg = '#7c4a4a' })
  end,
}
