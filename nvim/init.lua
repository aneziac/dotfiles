local vim = vim
local Plug = vim.fn['plug#']

vim.call('plug#begin')
Plug 'numToStr/Comment.nvim'
Plug 'morhetz/gruvbox'
-- Plug 'norcalli/nvim-colorizer.lua'
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'
Plug 'nvim-lualine/lualine.nvim'
Plug 'nvim-tree/nvim-web-devicons'
Plug 'nvim-tree/nvim-tree.lua'

Plug 'neovim/nvim-lspconfig'
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/cmp-buffer'
Plug 'hrsh7th/cmp-path'
Plug 'hrsh7th/cmp-cmdline'
Plug 'hrsh7th/nvim-cmp'

Plug 'akinsho/bufferline.nvim'

vim.call('plug#end')

vim.cmd([[colorscheme gruvbox]])

vim.cmd([[
    lua require("Comment").setup()
]])

-- Set up globals {{{
do
  local nixvim_globals = {["mapleader"] = " ",["typst_pdf_viewer"] = "zathura",["vimtex_callback_progpath"] = "nvim",["vimtex_enabled"] = true,["vimtex_view_method"] = "zathura"}

  for k,v in pairs(nixvim_globals) do
    vim.g[k] = v
  end
end
-- }}}
-- Set up options {{{
do
  local nixvim_options = {["autoindent"] = true,["errorbells"] = false,["expandtab"] = true,["list"] = true,["listchars"] = "eol:↵,trail:~,tab:>-,nbsp:␣",["number"] = true,["scrolloff"] = 7,["shiftwidth"] = 4,["signcolumn"] = "number",["softtabstop"] = 0,["swapfile"] = false,["syntax"] = "on",["tabstop"] = 4,["wildmenu"] = true,["wildmode"] = "list:longest",["wrap"] = true}

  for k,v in pairs(nixvim_options) do
    vim.opt[k] = v
  end
end
-- }}}

vim.loader.disable()
--[[
require("colorizer").setup({
  filetypes = nil,
  user_default_options = nil,
  buftypes = nil,
})
--]]

do
  local __telescopeExtensions = {}

  require('telescope').setup({})

  for i, extension in ipairs(__telescopeExtensions) do
    require('telescope').load_extension(extension)
  end
end

require("lualine").setup({["options"] = {["globalstatus"] = true,["icons_enabled"] = true}})
-- LSP {{{
do
  

  local __lspServers = {{["name"] = "typst_lsp"},{["name"] = "tsserver"},{["name"] = "rust_analyzer"},{["name"] = "pyright"},{["name"] = "nil_ls"},{["extraOptions"] = {["settings"] = {["Lua"] = {["diagnostics"] = {["globals"] = {"vim"}},["runtime"] = {["version"] = "LuaJIT"},["telemetry"] = {["enable"] = false},["workspace"] = {["checkThirdParty"] = false,["library"] = {vim.api.nvim_get_runtime_file('', true)}}}}},["name"] = "lua_ls"},{["extraOptions"] = {["cmd"] = {"/nix/store/p2hfkkzvar5mdjw1gchvd32sr7j5avh0-vscode-langservers-extracted-4.8.0/bin/vscode-html-language-server","--stdio"}},["name"] = "html"},{["name"] = "clangd"}}
  local __lspOnAttach = function(client, bufnr)
    
  end
  local __lspCapabilities = function()
    capabilities = vim.lsp.protocol.make_client_capabilities()

    capabilities = require('cmp_nvim_lsp').default_capabilities()


    return capabilities
  end

  local __setup = {
            on_attach = __lspOnAttach,
            capabilities = __lspCapabilities()
          }

  for i,server in ipairs(__lspServers) do
    if type(server) == "string" then
      require('lspconfig')[server].setup(__setup)
    else
      local options = server.extraOptions

      if options == nil then
        options = __setup
      else
        options = vim.tbl_extend("keep", options, __setup)
      end

      require('lspconfig')[server.name].setup(options)
    end
  end

  
end
-- }}}


require('nvim-tree').setup({["git"] = {["enable"] = true},["hijack_netrw"] = true,["modified"] = {["enable"] = true,["show_on_dirs"] = true,["show_on_open_dirs"] = false},["renderer"] = {["add_trailing"] = true},["tab"] = {["sync"] = {["close"] = true,["open"] = true}},["update_focused_file"] = {["enable"] = true}})

do
  local cmp = require('cmp')
cmp.setup({["mapping"] = {["<C-Space>"] = cmp.mapping.complete(),["<C-d>"] = cmp.mapping.scroll_docs(-4),["<C-e>"] = cmp.mapping.close(),["<C-f>"] = cmp.mapping.scroll_docs(4),["<CR>"] = cmp.mapping.confirm({ select = true }),["<S-Tab>"] = cmp.mapping(cmp.mapping.select_prev_item(), {'i', 's'}),["<Tab>"] = cmp.mapping(cmp.mapping.select_next_item(), {'i', 's'})},["sources"] = {{["name"] = "nvim_lsp"},{["name"] = "buffer"},{["name"] = "path"}}})

end


require('bufferline').setup{["options"] = {["mode"] = "tabs",["numbers"] = "none",["show_buffer_close_icons"] = false,["show_buffer_icons"] = false,["show_close_icon"] = false}}

-- Set up keybinds {{{
do
  local __nixvim_binds = {{["action"] = require('telescope.builtin').help_tags,["key"] = "<leader>h",["mode"] = "n",["options"] = {["silent"] = false}},{["action"] = require('telescope.builtin').buffers,["key"] = "<leader>i",["mode"] = "n",["options"] = {["silent"] = false}},{["action"] = require('telescope.builtin').find_files,["key"] = "<leader>o",["mode"] = "n",["options"] = {["silent"] = false}},{["action"] = require('telescope.builtin').live_grep,["key"] = "<leader>p",["mode"] = "n",["options"] = {["silent"] = false}},{["action"] = ":TypstWatch<CR>",["key"] = "<leader>l",["mode"] = "n",["options"] = {["silent"] = true}},{["action"] = ":wincmd h<CR>",["key"] = "<C-h>",["mode"] = "",["options"] = {["silent"] = true}},{["action"] = ":wincmd j<CR>",["key"] = "<C-j>",["mode"] = "",["options"] = {["silent"] = true}},{["action"] = ":wincmd k<CR>",["key"] = "<C-k>",["mode"] = "",["options"] = {["silent"] = true}},{["action"] = ":wincmd l<CR>",["key"] = "<C-l>",["mode"] = "",["options"] = {["silent"] = true}},{["action"] = ":NvimTreeToggle<CR>",["key"] = "<leader>c",["mode"] = "",["options"] = {["silent"] = false}}}
  for i, map in ipairs(__nixvim_binds) do
    vim.keymap.set(map.mode, map.key, map.action, map.options)
  end
end
-- }}}

-- Set up autocommands {{
do
  local __nixvim_autocommands = {{["command"] = "if winnr('$') == 1 && bufname() == 'NvimTree_' . tabpagenr() | quit | endif",["event"] = "BufEnter",["nested"] = true},{["command"] = "if line(\"'\\\"\") > 1 && line(\"'\\\"\") <= line(\"$\") | exe \"normal! g'\\\"\" | endif",["event"] = {"BufReadPost"}}}

  for _, autocmd in ipairs(__nixvim_autocommands) do
    vim.api.nvim_create_autocmd(
      autocmd.event,
      {
        group     = autocmd.group,
        pattern   = autocmd.pattern,
        buffer    = autocmd.buffer,
        desc      = autocmd.desc,
        callback  = autocmd.callback,
        command   = autocmd.command,
        once      = autocmd.once,
        nested    = autocmd.nested
      }
    )
  end
end
-- }}

