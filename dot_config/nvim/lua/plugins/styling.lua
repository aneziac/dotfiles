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


vim.api.nvim_exec_autocmds('ColorScheme', {})
vim.api.nvim_create_autocmd('ColorScheme', {
  callback = function()
    local normal_bg = vim.api.nvim_get_hl(0, { name = 'Normal' }).bg

    -- vim.api.nvim_set_hl(0, 'SidekickNormal', { bg = normal_bg })
    -- vim.api.nvim_set_hl(0, 'SidekickBorder', { bg = normal_bg })

    vim.api.nvim_set_hl(0, 'SnacksNormal', { bg = normal_bg })
    vim.api.nvim_set_hl(0, 'SnacksBorder', { bg = normal_bg })

    vim.api.nvim_set_hl(0, 'TroubleNormal', { bg = normal_bg })
    vim.api.nvim_set_hl(0, 'TroubleBorder', { bg = normal_bg })
  end,
})

-- Statusline
require('lualine').setup({
  options = { theme = 'gruvbox_dark' },
  tabline = {
    lualine_a = {
      {
        "tabs",
        mode = 1,
        max_length = vim.o.columns,
      }
    }
  }
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
