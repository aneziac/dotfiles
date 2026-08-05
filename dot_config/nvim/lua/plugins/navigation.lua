vim.pack.add({
  { src = 'https://github.com/stevearc/oil.nvim' },
  { src = 'https://github.com/folke/snacks.nvim' },
  { src = 'https://github.com/nvim-lua/plenary.nvim' },
  { src = 'https://github.com/MunifTanjim/nui.nvim' },
  { src = 'https://github.com/nvim-tree/nvim-web-devicons' },
  { src = 'https://github.com/folke/trouble.nvim' },
  { src = 'https://github.com/fnune/recall.nvim' },
  { src = 'https://github.com/christoomey/vim-tmux-navigator' },
})

-- Oil
require('oil').setup({
  view_options = { show_hidden = true },
  keymaps = {
    ['<C-h>'] = false,
    ['<C-l>'] = false,
  },
})
vim.keymap.set('n', '-', require('oil').open, { desc = 'Open Oil' })

-- Trouble
require('trouble').setup({})
vim.keymap.set('n', '<leader>d', '<cmd>Trouble diagnostics toggle<cr>', { desc = 'Diagnostics' })
vim.keymap.set('n', '<F12>', '<cmd>Trouble symbols toggle<cr>', { desc = 'Symbols' })

-- Recall
require('recall').setup({})
vim.keymap.set('n', '<leader>mm', require('recall').toggle, { desc = 'Toggle mark' })
vim.keymap.set('n', '<leader>mn', require('recall').goto_next, { desc = 'Next mark' })
vim.keymap.set('n', '<leader>mp', require('recall').goto_prev, { desc = 'Prev mark' })
vim.keymap.set('n', '<leader>mc', require('recall').clear, { desc = 'Clear marks' })
vim.keymap.set('n', '<leader>ml', ':Telescope recall<CR>', { desc = 'List marks' })

-- Tmux navigator (no setup needed, just keymaps)
vim.keymap.set('n', '<C-h>',  ':TmuxNavigateLeft<CR>')
vim.keymap.set('n', '<C-j>',  ':TmuxNavigateDown<CR>')
vim.keymap.set('n', '<C-k>',  ':TmuxNavigateUp<CR>')
vim.keymap.set('n', '<C-l>',  ':TmuxNavigateRight<CR>')
vim.keymap.set('n', '<C-\\>', ':TmuxNavigatePrevious<CR>')
