return {
  {
    'NickvanDyke/opencode.nvim',
    config = function()
      vim.opt.autoread = true

      vim.keymap.set('n', '<leader>oA', function() require('opencode').ask() end, { desc = 'Ask opencode' })
      vim.keymap.set('n', '<leader>oa', function() require('opencode').ask('@cursor: ') end, { desc = 'Ask opencode about this' })
      vim.keymap.set('v', '<leader>oa', function() require('opencode').ask('@selection: ') end, { desc = 'Ask opencode about selection' })
      vim.keymap.set('n', '<leader>oy', function() require('opencode').command('messages_copy') end, { desc = 'Copy last opencode response' })
      vim.keymap.set({ 'n', 'v' }, '<leader>os', function() require('opencode').select() end, { desc = 'Select opencode prompt' })
    end,
  }
}
