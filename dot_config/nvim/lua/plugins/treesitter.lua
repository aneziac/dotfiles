vim.pack.add({
  { src = 'https://github.com/nvim-treesitter/nvim-treesitter' },
})

local ts = require('nvim-treesitter')

local pkgs = {
  'python',
  'rust',
  'javascript',
  'typescript',
  'go',
  'cpp',
  'c',
  'bash',
  'zsh',
  'typst',
  'markdown',
  'markdown_inline',
  'svelte',
  'vue',
  'tmux',
  'lua',
  'nix',
  'cuda',
  'yaml',
}

ts.setup({})
ts.install(pkgs)

vim.api.nvim_create_autocmd('FileType', {
  callback = function(args)
    pcall(vim.treesitter.start, args.buf)
  end,
})
