vim.pack.add({
  { src = 'https://github.com/sindrets/diffview.nvim' },
  { src = 'https://github.com/nvim-lua/plenary.nvim' },
  { src = 'https://github.com/lewis6991/gitsigns.nvim' },
})

-- Diffview
require('diffview').setup({
  enhanced_diff_hl = true,
  view = {
    default = { layout = 'diff2_horizontal' },
    merge_tool = { layout = 'diff3_horizontal' },
  },
})

vim.keymap.set('n', '<leader>hd', '<cmd>DiffviewOpen<cr>', { desc = 'Diff against index' })
vim.keymap.set('n', '<leader>hc', '<cmd>DiffviewClose<cr>', { desc = 'Close diffview' })
vim.keymap.set('n', '<leader>hh', '<cmd>DiffviewFileHistory %<cr>', { desc = 'File history' })
vim.keymap.set('n', '<leader>hH', '<cmd>DiffviewFileHistory<cr>', { desc = 'Project history' })

-- Gitsigns
require('gitsigns').setup({
  signs = {
    add          = { text = '+' },
    change       = { text = '~' },
    delete       = { text = '_' },
    topdelete    = { text = '‾' },
    changedelete = { text = '~' },
  },
  on_attach = function(bufnr)
    local gs = require('gitsigns')
    local function map(mode, l, r, opts)
      opts = opts or {}
      opts.buffer = bufnr
      vim.keymap.set(mode, l, r, opts)
    end

    -- Navigation
    map('n', ']c', function()
      if vim.wo.diff then
        vim.cmd.normal({ ']c', bang = true })
      else
        gs.nav_hunk('next')
      end
    end, { desc = 'Next hunk' })
    map('n', '[c', function()
      if vim.wo.diff then
        vim.cmd.normal({ '[c', bang = true })
      else
        gs.nav_hunk('prev')
      end
    end, { desc = 'Prev hunk' })

    -- Actions
    map('v', '<leader>hs', function() gs.stage_hunk({ vim.fn.line('.'), vim.fn.line('v') }) end, { desc = 'Stage hunk' })
    map('v', '<leader>hr', function() gs.reset_hunk({ vim.fn.line('.'), vim.fn.line('v') }) end, { desc = 'Reset hunk' })
    map('n', '<leader>hs', gs.stage_hunk, { desc = 'Stage hunk' })
    map('n', '<leader>hr', gs.reset_hunk, { desc = 'Reset hunk' })
    map('n', '<leader>hS', gs.stage_buffer, { desc = 'Stage buffer' })
    map('n', '<leader>hu', gs.undo_stage_hunk, { desc = 'Undo stage hunk' })
    map('n', '<leader>hR', gs.reset_buffer, { desc = 'Reset buffer' })
    map('n', '<leader>hp', gs.preview_hunk, { desc = 'Preview hunk' })
    map('n', '<leader>hb', gs.blame_line, { desc = 'Blame line' })
    map('n', '<leader>tb', gs.toggle_current_line_blame, { desc = 'Toggle blame' })
    map('n', '<leader>tD', gs.toggle_deleted, { desc = 'Toggle deleted' })
  end,
})
