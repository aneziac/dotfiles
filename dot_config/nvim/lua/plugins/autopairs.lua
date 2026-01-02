vim.pack.add({
  { src = 'https://github.com/windwp/nvim-autopairs' },
})

local npairs = require('nvim-autopairs')
local Rule = require('nvim-autopairs.rule')

npairs.setup({})

npairs.add_rule(Rule('$', '$', { 'typst', 'tex', 'latex', 'markdown' }))
