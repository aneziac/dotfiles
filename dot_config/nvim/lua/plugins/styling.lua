vim.pack.add({
  { src = 'https://github.com/ellisonleao/gruvbox.nvim' },
  { src = 'https://github.com/nvim-lualine/lualine.nvim' },
  { src = 'https://github.com/nvim-tree/nvim-web-devicons' },
  { src = 'https://github.com/goolord/alpha-nvim' },
  { src = 'https://github.com/folke/todo-comments.nvim' },
  { src = 'https://github.com/nvim-lua/plenary.nvim' },
})

-- Colorscheme
require('gruvbox').setup({})
vim.cmd.colorscheme('gruvbox')
vim.api.nvim_set_hl(0, 'NormalFloat', { bg = 'none' })
vim.api.nvim_set_hl(0, 'FloatBorder', { bg = 'none', fg = 'none' })

-- Statusline
require('lualine').setup({
  options = { theme = 'gruvbox_dark' },
})

-- Dashboard
local alpha = require('alpha')
local dashboard = require('alpha.themes.dashboard')

dashboard.section.buttons.val = {
  dashboard.button('e', '  New file', ':ene <BAR> startinsert<CR>'),
  dashboard.button('-', '  File browser', ':Oil<CR>'),
  dashboard.button('f', '  Find file', ':FzfLua files<CR>'),
  dashboard.button('g', '  Grep text', ':FzfLua live_grep<CR>'),
  dashboard.button('r', '  Recent files', ':FzfLua oldfiles<CR>'),
  dashboard.button('q', '  Quit', ':qa<CR>'),
}

alpha.setup(dashboard.config)

-- Todo comments (TODO, FIXME, NOTE, etc)
require('todo-comments').setup({ signs = false })
