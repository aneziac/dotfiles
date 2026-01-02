vim.pack.add({
  { src = 'https://github.com/saghen/blink.cmp', version = 'main' },
})

require('blink.cmp').setup({
  keymap = {
    ['<C-n>'] = { 'select_next', 'fallback' },
    ['<C-p>'] = { 'select_prev', 'fallback' },
    ['<C-y>'] = { 'accept', 'fallback' },
    ['<C-space>'] = { 'show', 'fallback' },
  },
  sources = {
    default = { 'lsp', 'path', 'buffer' },
  },
})
