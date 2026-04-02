vim.api.nvim_create_autocmd('PackChanged', {
  callback = function(ev)
    if ev.data.spec.name == 'markdown-preview.nvim' and (ev.data.kind == 'install' or ev.data.kind == 'update') then
      vim.system({ 'yarn', 'install' }, { cwd = ev.data.path .. '/app' })
    end
  end,
})

vim.pack.add({
  'https://github.com/iamcco/markdown-preview.nvim',
})

vim.g.mkdp_filetypes = { 'markdown' }
