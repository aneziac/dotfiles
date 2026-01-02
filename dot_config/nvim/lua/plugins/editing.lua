vim.pack.add({
  { src = 'https://github.com/NickvanDyke/opencode.nvim' },
  { src = 'https://github.com/folke/snacks.nvim' },
  { src = 'https://github.com/saghen/blink.cmp' },
  { src = 'https://github.com/windwp/nvim-autopairs' },
  { src = 'https://github.com/kylechui/nvim-surround' },
})

-- Nvim surround
require('nvim-surround').setup({})

-- Autopairs
local npairs = require('nvim-autopairs')
local Rule = require('nvim-autopairs.rule')

npairs.setup({})
npairs.add_rule(Rule('$', '$', { 'typst', 'tex', 'latex', 'markdown' }))

-- Blink
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

-- Snacks
local Snacks = require('snacks')
Snacks.setup({
  input = { enabled = true },
  explorer = { enabled = true },
  lazygit = { enabled = true },
  words = { enabled = true },
  indent = { enabled = true },
  quickfile = { enabled = true },
})
vim.keymap.set('n', '\\', function() Snacks.explorer() end, { desc = 'Explorer' })
vim.keymap.set('n', '<F1>', function() Snacks.explorer() end, { desc = 'Explorer' })
vim.keymap.set('n', '<leader>lg', function() Snacks.lazygit() end, { desc = 'Lazygit' })

-- Opencode
vim.keymap.set('n', '<leader>oA', function() require('opencode').ask() end,
  { desc = 'Ask opencode' })
vim.keymap.set('n', '<leader>oa', function() require('opencode').ask('@cursor: ') end,
  { desc = 'Ask opencode about this' })
vim.keymap.set('v', '<leader>oa', function() require('opencode').ask('@selection: ') end,
  { desc = 'Ask opencode about selection' })
vim.keymap.set('n', '<leader>oy', function() require('opencode').command('messages_copy') end,
  { desc = 'Copy last opencode response' })
vim.keymap.set({ 'n', 'v' }, '<leader>os', function() require('opencode').select() end,
  { desc = 'Select opencode prompt' })
