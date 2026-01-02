vim.pack.add({
  { src = 'https://github.com/stevearc/conform.nvim' },
})

require('conform').setup({
  formatters_by_ft = {
    lua = { 'stylua' },
    python = { 'ruff_format' },
    rust = { 'rustfmt' },
    typescript = { 'prettier' },
    javascript = { 'prettier' },
    go = { 'gofmt' },
    typst = { 'typstyle' },
    c = { 'clang-format' },
  },
  format_on_save = {
    timeout_ms = 500,
    lsp_fallback = true,
  },
})

vim.keymap.set('n', '<leader>lf', function()
  require('conform').format()
end, { desc = 'Format buffer' })
