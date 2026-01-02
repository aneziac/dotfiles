vim.pack.add({
  { src = 'https://github.com/ibhagwan/fzf-lua' },
  { src = 'https://github.com/nvim-tree/nvim-web-devicons' },
})

require('fzf-lua').setup({})

vim.keymap.set('n', '<leader>sf', require('fzf-lua').files, { desc = 'Search Files' })
vim.keymap.set('n', '<leader>sg', require('fzf-lua').live_grep, { desc = 'Search Grep' })
vim.keymap.set('n', '<leader>sh', require('fzf-lua').helptags, { desc = 'Search Help' })
vim.keymap.set('n', '<leader>sk', require('fzf-lua').keymaps, { desc = 'Search Keymaps' })
vim.keymap.set('n', '<leader>sd', require('fzf-lua').diagnostics_document, { desc = 'Search Diagnostics' })
vim.keymap.set('n', '<leader>sr', require('fzf-lua').resume, { desc = 'Search Resume' })
vim.keymap.set('n', '<leader>s.', require('fzf-lua').oldfiles, { desc = 'Search Recent Files' })
vim.keymap.set('n', '<leader><leader>', require('fzf-lua').buffers, { desc = 'Find Buffers' })
vim.keymap.set('n', '<leader>/', require('fzf-lua').lgrep_curbuf, { desc = 'Search in Buffer' })
vim.keymap.set('n', '<leader>sn', function()
  require('fzf-lua').files({ cwd = vim.fn.stdpath('config') })
end, { desc = 'Search Neovim Config' })

