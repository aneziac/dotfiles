vim.pack.add({
  { src = 'https://github.com/folke/sidekick.nvim' },
  { src = 'https://github.com/folke/snacks.nvim' },
  { src = 'https://github.com/saghen/blink.cmp' },
  { src = 'https://github.com/windwp/nvim-autopairs' },
  { src = 'https://github.com/kylechui/nvim-surround' },
  { src = 'https://github.com/nvim-mini/mini.nvim' },
})

-- Nvim surround
require('nvim-surround').setup({})

-- Autopairs
local npairs = require('nvim-autopairs')
local Rule = require('nvim-autopairs.rule')

npairs.setup({})
npairs.add_rule(Rule('$', '$', { 'typst', 'tex', 'latex', 'markdown' })
  :with_move(function(opts) return opts.char == '$' end))

-- Mini
require('mini.ai').setup({
  n_lines = 500,
  custom_textobjects = {
    ['$'] = { '%$().-()%$' },
  },
})

-- Sidekick
vim.lsp.config('copilot', {})
vim.lsp.enable('copilot')
require('sidekick').setup({
  cli = {
    mux = {
      backend = "tmux",
      enabled = true,
    },
  },
})

vim.keymap.set('n', '<leader>aa', function() require('sidekick.cli').toggle() end, { desc = 'Sidekick Toggle' })
vim.keymap.set('n', '<leader>as', function() require('sidekick.cli').select() end, { desc = 'Select CLI Tool' })
vim.keymap.set({'n', 'x'}, '<leader>at', function() require('sidekick.cli').send({ msg = '{this}' }) end, { desc = 'Send This' })
vim.keymap.set('x', '<leader>av', function() require('sidekick.cli').send({ msg = '{selection}' }) end, { desc = 'Send Selection' })
vim.keymap.set('n', '<leader>af', function() require('sidekick.cli').send({ msg = '{file}' }) end, { desc = 'Send File' })

-- Blink
require('blink.cmp').setup({
  fuzzy = {
    implementation = "lua"
  },
  keymap = {
    ['<C-n>'] = { 'select_next', 'fallback' },
    ['<C-p>'] = { 'select_prev', 'fallback' },
    ['<C-y>'] = { 'accept', 'fallback' },
    ['<C-space>'] = { 'show', 'fallback' },
    ["<Tab>"] = {
      "snippet_forward",
      function() return require("sidekick").nes_jump_or_apply() end,
      function() return vim.lsp.inline_completion.get() end,
      "fallback",
    },
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
