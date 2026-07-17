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
  'cmake',
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
  'ocaml',
  'zig',
  'toml',
  'html',
  'css'
}

require('nvim-treesitter').install(languages)

vim.api.nvim_create_autocmd('FileType', {
  callback = function(args)
    local ft = vim.bo[args.buf].filetype
    local lang = vim.treesitter.language.get_lang(ft) or ft

    if not vim.tbl_contains(languages, lang) then
      return
    end

    -- Highlighting
    local ok = pcall(vim.treesitter.start, args.buf)

    if not ok then return end

    -- Folding
    vim.wo[0][0].foldmethod = "expr"
    vim.wo[0][0].foldexpr = "v:lua.vim.treesitter.foldexpr()"

    -- Keep folds open by default
    vim.wo[0][0].foldlevel = 99

    -- Treesitter indentation
    vim.bo[args.buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
  end,
})

-- Folding keymaps
vim.keymap.set("n", "<leader>za", "za", { desc = "Toggle fold" })
vim.keymap.set("n", "<leader>zo", "zo", { desc = "Open fold" })
vim.keymap.set("n", "<leader>zc", "zc", { desc = "Close fold" })
vim.keymap.set("n", "<leader>zR", "zR", { desc = "Open all folds" })
vim.keymap.set("n", "<leader>zM", "zM", { desc = "Close all folds" })
vim.keymap.set("n", "<leader>zr", "zr", { desc = "Open one fold level" })
vim.keymap.set("n", "<leader>zm", "zm", { desc = "Close one fold level" })
vim.keymap.set("n", "<leader>zj", "zj", { desc = "Next fold" })
vim.keymap.set("n", "<leader>zk", "zk", { desc = "Previous fold" })
