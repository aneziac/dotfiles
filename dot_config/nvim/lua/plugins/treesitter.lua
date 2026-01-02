-- Install parsers
local parsers = { 'bash', 'c', 'diff', 'html', 'lua', 'luadoc', 'markdown', 'markdown_inline', 'query', 'vim', 'vimdoc' }
for _, lang in ipairs(parsers) do
  vim.treesitter.language.add(lang)
end

-- Enable treesitter highlighting for all filetypes
vim.api.nvim_create_autocmd('FileType', {
  callback = function()
    pcall(vim.treesitter.start)
  end,
})
