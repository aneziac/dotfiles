return {
  'nvim-neo-tree/neo-tree.nvim',
  version = '*',
  dependencies = {
    'nvim-lua/plenary.nvim',
    'nvim-tree/nvim-web-devicons',
    'MunifTanjim/nui.nvim',
  },
  cmd = 'Neotree',
  keys = {
    { '\\', ':Neotree reveal<CR>', desc = 'NeoTree reveal', silent = true },
    {
      '<F1>',
      function()
        require('neo-tree.command').execute({ toggle = true })
      end,
      desc = 'NeoTree toggle',
    },
  },
  opts = {
    filesystem = {
      window = {
        mappings = {
          ['\\'] = 'close_window',
        },
      },
      filtered_items = {
        visible = true,           -- show hidden files
        hide_dotfiles = false,    -- show dotfiles (e.g. .env, .config)
        hide_hidden = false,      -- show Unix hidden files
        never_show = { '.git' },  -- always hide .git
      },
    },
  },
}

