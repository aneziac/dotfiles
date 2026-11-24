-- plugins/lint.lua
vim.pack.add({
  { src = 'https://github.com/mfussenegger/nvim-lint' },
})

local lint = require('lint')

lint.linters_by_ft = {
  markdown = { 'markdownlint' },
  python = { 'ruff' },
}

-- Only run linters whose executable is actually installed
local function is_available(name)
  local linter = lint.linters[name]
  if type(linter) == 'function' then
    linter = linter()
  end
  local cmd = linter and linter.cmd
  if type(cmd) == 'function' then
    cmd = cmd()
  end
  return type(cmd) == 'string' and vim.fn.executable(cmd) == 1
end

vim.api.nvim_create_autocmd({ 'BufEnter', 'BufWritePost', 'InsertLeave' }, {
  group = vim.api.nvim_create_augroup('lint', { clear = true }),
  callback = function()
    if not vim.opt_local.modifiable:get() then
      return
    end
    local names = vim.tbl_filter(is_available, lint.linters_by_ft[vim.bo.filetype] or {})
    if #names > 0 then
      lint.try_lint(names)
    end
  end,
})
