vim.api.nvim_create_autocmd('PackChanged', {
  callback = function(ev)
    local name, kind = ev.data.spec.name, ev.data.kind
    if name == 'markdown-preview.nvim' and (kind == 'install' or kind == 'update') then
      vim.system({ 'npm', 'install' }, { cwd = ev.data.path .. '/app' })
    end
  end,
})

vim.pack.add({
  { src = 'https://github.com/chomosuke/typst-preview.nvim', version = 'v1.0.0' },
  { src = 'https://github.com/iamcco/markdown-preview.nvim' },
})

require('typst-preview').setup({})
vim.g.mkdp_filetypes = { 'markdown' }

vim.keymap.set('n', '<leader>p', function()
  local ft = vim.bo.filetype
  if ft == 'markdown' then
    vim.cmd('MarkdownPreviewToggle')
  elseif ft == 'typst' then
    vim.cmd('TypstPreviewToggle')
  else
    vim.notify('Preview not supported for filetype: ' .. ft, vim.log.levels.WARN)
  end
end, { desc = 'Toggle preview' })
