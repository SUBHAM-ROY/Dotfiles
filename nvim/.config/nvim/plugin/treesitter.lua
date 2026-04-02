vim.api.nvim_create_autocmd('PackChanged', {
  callback = function(ev)
    if ev.data.spec.name == 'nvim-treesitter' and (ev.data.kind == 'install' or ev.data.kind == 'update') then
      if not ev.data.active then vim.cmd.packadd('nvim-treesitter') end
      vim.cmd('TSUpdate')
    end
  end,
})

vim.pack.add({
  'https://github.com/nvim-treesitter/nvim-treesitter',
})

require('nvim-treesitter').install({
  'lua',
  'typescript',
  'tsx',
  'markdown',
  'python',
})

vim.api.nvim_create_autocmd('FileType', {
  callback = function()
    if pcall(vim.treesitter.start) then vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()" end
  end,
})

vim.keymap.set('n', '<leader><TAB>', 'van', { remap = true, desc = 'Start Treesitter Selection' })
vim.keymap.set('x', '<TAB>', 'an', { remap = true, desc = 'Expand Selection' })
vim.keymap.set('x', '<BS>', 'in', { remap = true, desc = 'Shrink Selection' })
