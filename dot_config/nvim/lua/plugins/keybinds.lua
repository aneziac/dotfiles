vim.pack.add({
  { src = 'https://github.com/folke/which-key.nvim' },
})

require('which-key').setup({
  delay = 0,
  icons = { mappings = true },
  spec = {
    { '<leader>c', group = 'Code',     mode = { 'n', 'x' } },
    { '<leader>d', group = 'Document' },
    { '<leader>r', group = 'Rename' },
    { '<leader>s', group = 'Search' },
    { '<leader>w', group = 'Workspace' },
    { '<leader>t', group = 'Toggle' },
    { '<leader>h', group = 'Git Hunk', mode = { 'n', 'v' } },
    { '<leader>m', group = 'Marks' },
    { '<leader>a', group = 'AI' },
  },
})
