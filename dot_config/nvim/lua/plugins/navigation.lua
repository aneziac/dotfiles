return {
  {
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
          require('aerial').close()
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
  },
  {
    'stevearc/oil.nvim',
    ---@module 'oil'
    ---@type oil.SetupOpts
    opts = {
      view_options = {
        show_hidden = true
      },
      keymaps = {
        ["<C-h>"] = false, -- disable default Oil behavior for <C-h>
        ["<C-l>"] = false,
      },
    },
    -- Optional dependencies
    -- dependencies = { { 'echasnovski/mini.icons', opts = {} } },
    dependencies = { "nvim-tree/nvim-web-devicons" }, -- use if you prefer nvim-web-devicons
    -- Lazy loading is not recommended because it is very tricky to make it work correctly in all situations.
    lazy = false,
    config = function(_, opts)
      require("oil").setup(opts)
      vim.keymap.set('n', '-', require("oil").open, { desc = "Open Oil" })
    end,
  },
  {
    'stevearc/aerial.nvim',
    opts = {
      backends = { "treesitter", "lsp", "markdown", "man" },
      layout = {
        max_width = { 40, 0.2 },
        width = nil,
        min_width = 10,
        placement = "window",
      },
    },
    dependencies = {
       "nvim-treesitter/nvim-treesitter",
       "nvim-tree/nvim-web-devicons"
    },
    keys = {
      {
        '<F2>',
        function()
          -- Close neotree if open
          vim.cmd('Neotree close')
          -- Toggle aerial
          require('aerial').toggle()
        end,
        desc = 'Aerial toggle',
      },
    },
  },
  {
    "folke/flash.nvim",
    event = "VeryLazy",
    ---@type Flash.Config
    opts = {},
    -- stylua: ignore
    keys = {
      { "s", mode = { "n", "x", "o" }, function() require("flash").jump() end, desc = "Flash" },
      { "S", mode = { "n", "x", "o" }, function() require("flash").treesitter() end, desc = "Flash Treesitter" },
      { "r", mode = "o", function() require("flash").remote() end, desc = "Remote Flash" },
      { "R", mode = { "o", "x" }, function() require("flash").treesitter_search() end, desc = "Treesitter Search" },
      { "<c-s>", mode = { "c" }, function() require("flash").toggle() end, desc = "Toggle Flash Search" },
    },
  },
  {
    "fnune/recall.nvim",
    version = "*",
    config = function()
      local recall = require("recall")

      recall.setup({})
      vim.keymap.set("n", "<leader>mm", recall.toggle, { noremap = true, silent = true, desc = "Toggle recall marks" })
      vim.keymap.set("n", "<leader>mn", recall.goto_next, { noremap = true, silent = true, desc = "Go to next recall mark" })
      vim.keymap.set("n", "<leader>mp", recall.goto_prev, { noremap = true, silent = true, desc = "Go to previous recall mark" })
      vim.keymap.set("n", "<leader>mc", recall.clear, { noremap = true, silent = true, desc = "Clear recall marks" })
      vim.keymap.set("n", "<leader>ml", ":Telescope recall<CR>", { noremap = true, silent = true })
    end
  },
  {
    "fasterius/simple-zoom.nvim",
    opts = {
        hide_tabline = true
    },
  },
  {
    "christoomey/vim-tmux-navigator",
    cmd = {
      "TmuxNavigateLeft",
      "TmuxNavigateDown",
      "TmuxNavigateUp",
      "TmuxNavigateRight",
      "TmuxNavigatePrevious",
      "TmuxNavigatorProcessList",
    },
    keys = {
      { "<c-h>", "<cmd><C-U>TmuxNavigateLeft<cr>" },
      { "<c-j>", "<cmd><C-U>TmuxNavigateDown<cr>" },
      { "<c-k>", "<cmd><C-U>TmuxNavigateUp<cr>" },
      { "<c-l>", "<cmd><C-U>TmuxNavigateRight<cr>" },
      { "<c-\\>", "<cmd><C-U>TmuxNavigatePrevious<cr>" },
    },
  },
}
