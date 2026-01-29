vim.api.nvim_create_autocmd('PackChanged', {
  callback = function(ev)
    local name, kind = ev.data.spec.name, ev.data.kind
    if name == 'markdown-preview.nvim' and (kind == 'install' or kind == 'update') then
      vim.system({ 'npm', 'install' }, { cwd = ev.data.path .. '/app' })
    end
  end,
})

vim.pack.add({
  { src = 'https://github.com/chomosuke/typst-preview.nvim' },
  { src = 'https://github.com/iamcco/markdown-preview.nvim' },
  { src = 'https://github.com/jmbuhr/otter.nvim' },
  { src = 'https://github.com/quarto-dev/quarto-nvim' },
})

require('typst-preview').setup({})
vim.g.mkdp_filetypes = { 'markdown' }

local otter = require('otter')
otter.setup({
  lsp = {
    hover = { border = "rounded" },
  }
})
require('quarto').setup({})

vim.api.nvim_create_autocmd("FileType", {
  pattern = { "quarto", "markdown" },
  callback = function(ev)
    local buf = ev.buf
    if vim.b[buf].otter_activated then
      return
    end
    vim.b[buf].otter_activated = true
    vim.treesitter.start()
    otter.activate({ "python", "rust", "javascript", "typst" }, true, true, nil)
  end,
})

vim.keymap.set('n', '<leader>p', function()
  local ft = vim.bo.filetype
  if ft == 'markdown' then
    vim.cmd('MarkdownPreview')
  elseif ft == 'typst' then
    vim.cmd('TypstPreview')
  elseif ft == 'quarto' then
    vim.cmd('QuartoPreview')
  else
    vim.notify('Preview not supported for filetype: ' .. ft, vim.log.levels.WARN)
  end
end, { desc = 'Toggle preview' })
