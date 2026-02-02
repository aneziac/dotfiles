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
  { src = 'https://github.com/benlubas/molten-nvim' }
})

require('typst-preview').setup({})
vim.g.mkdp_filetypes = { 'markdown' }

local otter = require('otter')
otter.setup({
  lsp = {
    hover = { border = "rounded" },
  }
})
require('quarto').setup{
  debug = false,
  closePreviewOnExit = true,
  lspFeatures = {
    enabled = true,
    chunks = "all",
    languages = { "r", "python", "julia", "bash", "html", "typst", "=typst" },
    diagnostics = {
      enabled = true,
      triggers = { "BufWritePost" },
    },
    completion = {
      enabled = true,
    },
  },
  codeRunner = {
    enabled = true,
    default_method = "molten",
    ft_runners = {},
    never_run = { 'yaml' },
  },
}

vim.g.molten_image_provider = "none"
vim.g.molten_output_win_max_height = 12
vim.g.molten_wrap_output = true
vim.g.molten_virt_text_output = true
vim.g.molten_virt_lines_off_by_1 = true
vim.g.molten_auto_open_output = true
vim.g.molten_output_show_more = true

vim.keymap.set("n", "<localleader>mi", ":MoltenInit<CR>",
    { silent = true, desc = "Initialize kernel" })
vim.keymap.set("n", "<localleader>rc", ":QuartoSend<CR>",
    { silent = true, desc = "Run code cell" })
vim.keymap.set("n", "<localleader>rr", ":MoltenReevaluateCell<CR>",
    { silent = true, desc = "Re-run cell" })

-- Quarto-specific: run current code cell
vim.keymap.set("n", "<localleader>rc", function()
  vim.cmd('QuartoSend')
end, { silent = true, desc = "run code cell" })

vim.api.nvim_create_autocmd("FileType", {
  pattern = { "quarto", "markdown" },
  callback = function(ev)
    local buf = ev.buf
    if vim.b[buf].otter_activated then
      return
    end
    vim.b[buf].otter_activated = true
    vim.treesitter.start()
    otter.activate({ "python", "rust", "javascript", "typst", "=typst" }, true, true, nil)
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
