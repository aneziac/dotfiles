-- Install parsers
local parsers = { 'bash', 'c', 'diff', 'html', 'lua', 'luadoc', 'markdown', 'markdown_inline', 'query', 'vim', 'vimdoc' }
for _, lang in ipairs(parsers) do
  vim.treesitter.language.add(lang)
end

-- Enable treesitter highlighting for all filetypes
vim.api.nvim_create_autocmd('FileType', {
  callback = function()
    pcall(vim.treesitter.start)
  end,
})

-- Leaders
vim.g.mapleader = " "
vim.g.maplocalleader = " "
vim.g.have_nerd_font = true

-- UI
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.cursorline = true
vim.opt.scrolloff = 15
vim.opt.signcolumn = 'yes'
vim.opt.splitright = true
vim.opt.splitbelow = true
vim.wo.wrap = false

-- Whitespace
vim.opt.list = true
vim.opt.listchars = {
  tab = '» ',
  trail = '·',
  nbsp = '␣',
  -- eol = '⏎',
}

-- Behavior
vim.opt.breakindent = true
vim.opt.spell = true
vim.opt.spelllang = 'en_us'
vim.opt.ignorecase = true  -- Case insensitive search unless \C or capital letters in search term
vim.opt.smartcase = true
vim.opt.undofile = true

-- Sync clipboard
vim.schedule(function() vim.opt.clipboard = 'unnamedplus' end)

-- Keymaps
vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostic [Q]uickfix list' })

vim.keymap.set('n', '<C-h>', '<C-w><C-h>')
vim.keymap.set('n', '<C-l>', '<C-w><C-l>')
vim.keymap.set('n', '<C-j>', '<C-w><C-j>')
vim.keymap.set('n', '<C-k>', '<C-w><C-k>')

vim.keymap.set('n', '<C-Up>',    '<Cmd>resize +2<CR>')
vim.keymap.set('n', '<C-Down>',  '<Cmd>resize -2<CR>')
vim.keymap.set('n', '<C-Left>',  '<Cmd>vertical resize -2<CR>')
vim.keymap.set('n', '<C-Right>', '<Cmd>vertical resize +2<CR>')

vim.keymap.set('n', '<leader>tw', function() vim.wo.wrap = not vim.wo.wrap end, { desc = '[T]oggle [W]rap' })
vim.keymap.set('n', '<leader>e', '<cmd>edit<CR>', { desc = 'R[e]load current file' })

vim.keymap.set('n', '<leader>so', function()
  vim.fn.system('chezmoi apply')
  vim.cmd('source $MYVIMRC')
  for _, client in pairs(vim.lsp.get_clients()) do client:stop() end
  vim.cmd('edit')
  print('Config reloaded!')
end, { desc = 'Reload config' })

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

local lazypath = vim.fn.stdpath 'data' .. '/lazy/lazy.nvim'
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = 'https://github.com/folke/lazy.nvim.git'
  local out = vim.fn.system { 'git', 'clone', '--filter=blob:none', '--branch=stable', lazyrepo, lazypath }
  if vim.v.shell_error ~= 0 then
    error('Error cloning lazy.nvim:\n' .. out)
  end
end ---@diagnostic disable-next-line: undefined-field
vim.opt.rtp:prepend(lazypath)

require('lazy').setup {
  require 'plugins.ai',
  require 'plugins.autocomplete',
  require 'plugins.autopairs',
  require 'plugins.debug',
  require 'plugins.git',
  require 'plugins.indent_line',
  require 'plugins.keybinds',
  require 'plugins.lint',
  require 'plugins.lsp',
  require 'plugins.mini',
  require 'plugins.navigation',
  require 'plugins.preview',
  require 'plugins.styling',
  require 'plugins.telescope',
}

-- Fix visual bug when using floating window
vim.api.nvim_set_hl(0, "NormalFloat", { link = "Pmenu" })
