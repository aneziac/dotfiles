vim.pack.add({
  { src = 'https://github.com/neovim/nvim-lspconfig' },
  { src = 'https://github.com/j-hui/fidget.nvim' },
  { src = 'https://github.com/tpope/vim-sleuth' },
})

require('fidget').setup({})

-- LSP keymaps on attach
vim.api.nvim_create_autocmd('LspAttach', {
  callback = function(event)
    local map = function(keys, func, desc, mode)
      vim.keymap.set(mode or 'n', keys, func, { buffer = event.buf, desc = desc })
    end

    map('gd', vim.lsp.buf.definition, 'Goto Definition')
    map('gr', vim.lsp.buf.references, 'Goto References')
    map('gI', vim.lsp.buf.implementation, 'Goto Implementation')
    map('gD', vim.lsp.buf.declaration, 'Goto Declaration')
    map('K', vim.lsp.buf.hover, 'Hover')
    map('<leader>rn', vim.lsp.buf.rename, 'Rename')
    map('<leader>ca', vim.lsp.buf.code_action, 'Code Action', { 'n', 'x' })
    map('<leader>th', function()
      vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled({ bufnr = event.buf }))
    end, 'Toggle Inlay Hints')
  end,
})

vim.lsp.config('lua_ls', {
  settings = {
    Lua = {
      diagnostics = { globals = { 'vim' } },
    },
  },
})

vim.lsp.config('tinymist', {
  settings = {
    formatterMode = 'typstyle',
    exportPdf = 'onType',
    semanticTokens = 'disable',
  },
})

vim.lsp.config('pyright', {})
vim.lsp.config('rust_analyzer', {})
vim.lsp.config('ts_ls', {})
vim.lsp.config('clangd', {})
vim.lsp.config('gopls', {})

vim.lsp.enable({
  'lua_ls',
  'tinymist',
  'pyright',
  'rust_analyzer',
  'ts_ls',
  'clangd',
  'gopls'
})
