vim.pack.add({
  { src = 'https://github.com/tomtomjhj/coq-lsp.nvim' },
  { src = 'https://github.com/whonore/Coqtail' },
})

-- See https://github.com/tomtomjhj/coq-lsp.nvim for Coqtail config
vim.g.loaded_coqtail = 1     -- skip plugin/coqtail.vim (its commands + Python init)
vim.g.coqtail_supported = 1  -- correct var name; truthy avoids the "needs Python 3.6" warning
vim.g.coqtail_nomap = 1      -- don't install Coqtail's <leader>c mappings
vim.g.coqtail_tagfunc = 0    -- keep your coq.ctags <C-]>; don't let Coqtail override tagfunc

require("coq-lsp").setup({})

vim.api.nvim_create_autocmd("LspAttach", {
  callback = function(ev)
    local client = vim.lsp.get_client_by_id(ev.data.client_id)
    if not client or client.name ~= "coq_lsp" then return end
    local map = function(lhs, rhs, desc)
      vim.keymap.set("n", lhs, rhs, { buffer = ev.buf, desc = desc })
    end

    map("gd", "<C-]>", "Goto Definition (tags)")          -- coq-lsp has no LSP definition
    map("<leader>Cs", "<cmd>CoqLsp saveVo<cr>", "Coq: save .vo")
    map("<leader>Cp", '<cmd>CoqLsp open_info_panel<cr>', "Coq: reopen goals panel")
    map("<leader>Cr", function()                           -- coq-lsp can wedge on Qed/typeclass search
      client:stop(true)
      vim.defer_fn(vim.cmd.edit, 500)
    end, "Coq: restart server")
  end,
})
