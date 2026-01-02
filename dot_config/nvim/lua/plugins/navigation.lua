vim.pack.add({
  { src = 'https://github.com/stevearc/oil.nvim' },
  { src = 'https://github.com/nvim-neo-tree/neo-tree.nvim' },
  { src = 'https://github.com/nvim-lua/plenary.nvim' },
  { src = 'https://github.com/MunifTanjim/nui.nvim' },
  { src = 'https://github.com/nvim-tree/nvim-web-devicons' },
  { src = 'https://github.com/stevearc/aerial.nvim' },
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

-- Neo-tree
require('neo-tree').setup({
  filesystem = {
    window = {
      mappings = { ['\\'] = 'close_window' },
    },
    filtered_items = {
      visible = true,
      hide_dotfiles = false,
      hide_hidden = false,
      never_show = { '.git' },
    },
  },
})
vim.keymap.set('n', '\\', ':Neotree reveal<CR>', { desc = 'NeoTree reveal', silent = true })
vim.keymap.set('n', '<F1>', ':Neotree toggle<CR>', { desc = 'NeoTree toggle', silent = true })

-- Aerial
require('aerial').setup({
  backends = { 'treesitter', 'lsp', 'markdown', 'man' },
  layout = {
    max_width = { 40, 0.2 },
    min_width = 10,
    placement = 'window',
  },
})
vim.keymap.set('n', '<F12>', function()
  vim.cmd('Neotree close')
  require('aerial').toggle()
end, { desc = 'Aerial toggle' })

-- Recall
require('recall').setup({})
vim.keymap.set('n', '<leader>mm', require('recall').toggle, { desc = 'Toggle mark' })
vim.keymap.set('n', '<leader>mn', require('recall').goto_next, { desc = 'Next mark' })
vim.keymap.set('n', '<leader>mp', require('recall').goto_prev, { desc = 'Prev mark' })
vim.keymap.set('n', '<leader>mc', require('recall').clear, { desc = 'Clear marks' })
vim.keymap.set('n', '<leader>ml', ':Telescope recall<CR>', { desc = 'List marks' })

-- Tmux navigator (no setup needed, just keymaps)
vim.keymap.set('n', '<C-h>', '<cmd>TmuxNavigateLeft<CR>')
vim.keymap.set('n', '<C-j>', '<cmd>TmuxNavigateDown<CR>')
vim.keymap.set('n', '<C-k>', '<cmd>TmuxNavigateUp<CR>')
vim.keymap.set('n', '<C-l>', '<cmd>TmuxNavigateRight<CR>')
vim.keymap.set('n', '<C-\\>', '<cmd>TmuxNavigatePrevious<CR>')
