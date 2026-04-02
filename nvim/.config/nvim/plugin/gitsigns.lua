vim.pack.add({
  'https://github.com/lewis6991/gitsigns.nvim',
})

require('gitsigns').setup({
  current_line_blame = true,
  current_line_blame_opts = {
    delay = 300,
  },
  current_line_blame_formatter = '    <author>, <author_time:%R>, <abbrev_sha> - <summary>',
  current_line_blame_formatter_nc = '    You, <author_time:%R>, Not commited yet',
})

vim.api.nvim_set_hl(0, 'GitSignsCurrentLineBlame', { fg = '#928374' })

local map = vim.keymap.set
map('n', ']h', ':Gitsigns next_hunk<CR>', { desc = 'Next Git hunk' })
map('n', '[h', ':Gitsigns prev_hunk<CR>', { desc = 'Previous Git hunk' })
map('n', '<leader>Gh', ':Gitsigns preview_hunk<CR>', { desc = 'Preview Git hunk' })
map('n', '<leader>Gd', ':Gitsigns diffthis<CR>', { desc = 'Diff this hunk' })
map('n', '<leader>Gb', ':Gitsigns blame_line<CR>', { desc = 'Git blame line' })
map('n', '<leader>Gs', ':Gitsigns stage_hunk<CR>', { desc = 'Stage Git hunk' })
map('n', '<leader>Gu', ':Gitsigns undo_stage_hunk<CR>', { desc = 'Unstage Git hunk' })
