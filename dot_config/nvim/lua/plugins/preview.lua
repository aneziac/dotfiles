local function toggle_preview()
  local filetype = vim.bo.filetype
  if filetype == "markdown" then
    vim.cmd("MarkdownPreviewToggle")
  elseif filetype == "typst" then
    vim.cmd("TypstPreviewToggle")
  else
    vim.notify("Preview not supported for filetype: " .. filetype, vim.log.levels.WARN)
  end
end

vim.keymap.set('n', '<leader>p', toggle_preview, { desc = "Toggle preview" })

return {
  {
    'chomosuke/typst-preview.nvim',
    lazy = false, -- or ft = 'typst'
    version = '1.*',
    opts = {}, -- lazy.nvim will implicitly calls `setup {}`
  },
  {
    "iamcco/markdown-preview.nvim",
    cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
    build = "cd app && npm install",
    init = function()
      vim.g.mkdp_filetypes = { "markdown" }
    end,
    ft = { "markdown" },
  },
}
