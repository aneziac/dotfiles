vim.g.mapleader = ' '
vim.g.maplocalleader = ' '
vim.g.have_nerd_font = true

-- Numbering different across different modes
vim.opt.number = true
vim.opt.relativenumber = true

vim.api.nvim_create_autocmd({"InsertEnter"}, {
  callback = function()
    vim.opt.relativenumber = false
  end
})

vim.api.nvim_create_autocmd({"InsertLeave"}, {
  callback = function()
    vim.opt.relativenumber = true
  end
})

-- Enable mouse mode
vim.opt.mouse = 'a'

-- Don't show the mode, since it's already in the status line
vim.opt.showmode = false

-- Sync clipboard between OS and Neovim.
vim.schedule(function()
  vim.opt.clipboard = 'unnamedplus'
end)

-- Enable break indent
vim.opt.breakindent = true

-- Save undo history
vim.opt.undofile = true

-- Case-insensitive searching UNLESS \C or one or more capital letters in the search term
vim.opt.ignorecase = true
vim.opt.smartcase = true

-- Keep signcolumn on by default
vim.opt.signcolumn = 'yes'

-- Decrease update time
vim.opt.updatetime = 250

-- Decrease mapped sequence wait time
vim.opt.timeoutlen = 300

-- Configure how new splits should be opened
vim.opt.splitright = true
vim.opt.splitbelow = true

-- Sets how neovim will display certain whitespace characters in the editor.
--  See `:help 'list'`
--  and `:help 'listchars'`
vim.opt.list = true
vim.opt.listchars = { 
  tab = '» ',
  trail = '·',
  nbsp = '␣',
  eol = '⏎',
}

-- Preview substitutions live, as you type!
vim.opt.inccommand = 'split'

-- Show which line your cursor is on
vim.opt.cursorline = true

-- Minimal number of screen lines to keep above and below the cursor.
vim.opt.scrolloff = 15

-- [[ Basic Keymaps ]]
--  See `:help vim.keymap.set()`

-- Clear highlights on search when pressing <Esc> in normal mode
--  See `:help hlsearch`
vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')

-- Diagnostic keymaps
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostic [Q]uickfix list' })

-- Disable arrow keys in normal mode
vim.keymap.set('n', '<left>', '<cmd>echo "Use h to move!!"<CR>')
vim.keymap.set('n', '<right>', '<cmd>echo "Use l to move!!"<CR>')
vim.keymap.set('n', '<up>', '<cmd>echo "Use k to move!!"<CR>')
vim.keymap.set('n', '<down>', '<cmd>echo "Use j to move!!"<CR>')

-- Keybinds to make split navigation easier
vim.keymap.set('n', '<C-h>', '<C-w><C-h>', { desc = 'Move focus to the left window' })
vim.keymap.set('n', '<C-l>', '<C-w><C-l>', { desc = 'Move focus to the right window' })
vim.keymap.set('n', '<C-j>', '<C-w><C-j>', { desc = 'Move focus to the lower window' })
vim.keymap.set('n', '<C-k>', '<C-w><C-k>', { desc = 'Move focus to the upper window' })

-- Resize splits with Ctrl + arrow keys
vim.keymap.set('n', '<C-Up>',    '<Cmd>resize +2<CR>', { desc = 'Increase window height' })
vim.keymap.set('n', '<C-Down>',  '<Cmd>resize -2<CR>', { desc = 'Decrease window height' })
vim.keymap.set('n', '<C-Left>',  '<Cmd>vertical resize -2<CR>', { desc = 'Decrease window width' })
vim.keymap.set('n', '<C-Right>', '<Cmd>vertical resize +2<CR>', { desc = 'Increase window width' })

-- Toggle wrap
vim.wo.wrap = false -- Off by default
vim.keymap.set('n', '<leader>tw', function()
  vim.wo.wrap = not vim.wo.wrap
end, { desc = '[T]oggle [W]rap' })

-- Auto-detect and activate Python virtualenv in project
vim.api.nvim_create_autocmd("VimEnter", {
  callback = function()
    local cwd = vim.loop.cwd()
    local venv_path = cwd .. "/venv/bin/python"

    if vim.fn.filereadable(venv_path) == 1 then
      vim.g.python3_host_prog = venv_path
    end
  end,
})

vim.keymap.set('n', '<leader>so', function()
  -- Reload init.lua
  vim.cmd('source $MYVIMRC')

  -- Restart all active LSP clients
  for _, client in pairs(vim.lsp.get_clients()) do
    client.stop()
  end
  vim.cmd('edit') -- reopen current buffer to trigger LspAttach
  print('Config reloaded and LSP servers restarted!')
end, { desc = 'Source init.lua and restart LSP' })

vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking (copying) text',
  group = vim.api.nvim_create_augroup('kickstart-highlight-yank', { clear = true }),
  callback = function()
    vim.highlight.on_yank()
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
  -- require 'plugins.format',
  require 'plugins.gitsigns',
  require 'plugins.indent_line',
  require 'plugins.keybinds',
  require 'plugins.lint',
  require 'plugins.lsp',
  require 'plugins.mini',
  require 'plugins.navigation',
  require 'plugins.preview',
  require 'plugins.styling',
  require 'plugins.telescope',
  require 'plugins.treesitter',
}

vim.api.nvim_set_hl(0, "NormalFloat", { link = "Pmenu" })  -- or use custom color
