return {
  'Exafunction/windsurf.nvim',
  enabled = false,
  event = 'VeryLazy',
  dependencies = {
    'nvim-lua/plenary.nvim',
  },
  config = function()
    require('codeium').setup({
      enable_cmp_source = false,
      virtual_text = {
        enabled = true,
        key_bindings = {
          accept = '<C-l>',
          accept_word = '<C-]>',
          accept_line = '<C-\\>',
          prev = '<M-[>',
          next = '<M-]>',
          clear = 'Esc',
        },
      },
    })
  end,
  init = function()
    -- Override Codeium highlight
    vim.api.nvim_create_autocmd('ColorScheme', {
      callback = function()
        vim.api.nvim_set_hl(0, 'CodeiumSuggestion', {
          fg = '#777777',
        })
      end,
    })
  end,
}
