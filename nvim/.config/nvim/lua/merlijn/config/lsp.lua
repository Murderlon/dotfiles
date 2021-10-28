local nvim_lsp = require 'lspconfig'
local dlsconfig = require 'diagnosticls-configs'
local eslint_d = require 'diagnosticls-configs.linters.eslint_d'
local eslint_fix = require 'diagnosticls-configs.formatters.eslint_d_fmt'
local prettier = require 'diagnosticls-configs.formatters.prettier'

local capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities())
local servers = { 'tsserver', 'tailwindcss', 'cssls', 'html' }
local eslint_and_prettier = {
  linter = eslint_d,
  formatter = { prettier, eslint_fix }
}

local on_attach = function(client, bufnr)
  local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
  local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end
  local opts = { noremap=true, silent=true }

  buf_set_keymap('n', '<space>pp', '<cmd>lua vim.lsp.buf.formatting()<CR>', opts)
  buf_set_keymap('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>', opts)
  buf_set_keymap('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
  buf_set_keymap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
  buf_set_keymap('n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
  buf_set_keymap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
  buf_set_keymap('n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
  buf_set_keymap('n', '<space>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
  buf_set_keymap('n', '<space>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
  buf_set_keymap('n', '<space>e', '<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>', opts)
  buf_set_keymap('n', '[g', '<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>', opts)
  buf_set_keymap('n', ']g', '<cmd>lua vim.lsp.diagnostic.goto_next()<CR>', opts)
end

for _, lsp in ipairs(servers) do
  nvim_lsp[lsp].setup {
    on_attach = function(client, bufnr)
      if lsp == 'tsserver' then
        client.resolved_capabilities.document_formatting = false
      end
      on_attach(client, bufnr)
    end,
    capabilities = capabilities
  }
end

dlsconfig.init {
  on_attach = on_attach,
  capabilities = capabilities
}

dlsconfig.setup {
  ['javascript'] = eslint_and_prettier,
  ['javascriptreact'] = eslint_and_prettier,
  ['typescript'] = eslint_and_prettier,
  ['typescriptreact'] = eslint_and_prettier,
  ['markdown'] = eslint_and_prettier
}
