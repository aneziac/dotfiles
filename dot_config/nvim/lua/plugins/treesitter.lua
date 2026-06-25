vim.pack.add({
  { src = 'https://github.com/nvim-treesitter/nvim-treesitter' },
})

local languages = {
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
  'solidity',
  'haskell',
}

require('nvim-treesitter').install(languages)
