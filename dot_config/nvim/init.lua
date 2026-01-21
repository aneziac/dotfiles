-- Leaders
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- UI
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.cursorline = true
vim.opt.scrolloff = 15
vim.opt.signcolumn = 'yes'
vim.opt.splitright = true
vim.opt.splitbelow = true
vim.wo.wrap = false
vim.g.have_nerd_font = true
vim.opt.showmode = false

-- Whitespace
vim.opt.list = true
vim.opt.listchars = {
  tab = '» ',
  trail = '·',
  nbsp = '␣',
  eol = '⏎',
}

-- Behavior
vim.opt.breakindent = true
vim.opt.spell = true
vim.opt.spelllang = 'en_us'
vim.opt.ignorecase = true -- Case insensitive search unless \C or capital letters in search term
vim.opt.smartcase = true
vim.opt.undofile = true
vim.opt.autoread = true

-- Sync clipboard
vim.schedule(function() vim.opt.clipboard = 'unnamedplus' end)

-- Keymaps
vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')

vim.keymap.set('n', '<C-Up>', '<Cmd>resize +2<CR>')
vim.keymap.set('n', '<C-Down>', '<Cmd>resize -2<CR>')
vim.keymap.set('n', '<C-Left>', '<Cmd>vertical resize -2<CR>')
vim.keymap.set('n', '<C-Right>', '<Cmd>vertical resize +2<CR>')

vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostic Quickfix list' })
vim.keymap.set('n', '<leader>tw', function() vim.wo.wrap = not vim.wo.wrap end, { desc = 'Toggle Wrap' })
vim.keymap.set('n', '<leader>e', '<cmd>edit<CR>', { desc = 'Reload current file' })

vim.keymap.set('n', '<leader>so', function()
  vim.fn.system('chezmoi apply')
  vim.cmd('source $MYVIMRC')
  for _, client in pairs(vim.lsp.get_clients()) do client:stop() end
  vim.cmd('edit')
  print('Config reloaded!')
end, { desc = 'Reload config' })

-- Treesitter
vim.api.nvim_create_autocmd('FileType', {
  callback = function()
    pcall(vim.treesitter.start)
  end,
})

-- Autocommands
vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking text',
  group = vim.api.nvim_create_augroup('highlight-yank', { clear = true }),
  callback = function() vim.highlight.on_yank() end,
})

vim.api.nvim_create_autocmd("BufWritePre", {
  desc = 'Remove trailing whitespace',
  pattern = "*",
  callback = function()
    local save_cursor = vim.fn.getpos('.')
    vim.cmd([[%s/\s\+$//e]])
    vim.fn.setpos(".", save_cursor)
  end,
})

require 'plugins.debug'
require 'plugins.editing'
require 'plugins.editing'
require 'plugins.fzf'
require 'plugins.git'
require 'plugins.keybinds'
require 'plugins.lint'
require 'plugins.lsp'
require 'plugins.navigation'
require 'plugins.preview'
require 'plugins.styling'
