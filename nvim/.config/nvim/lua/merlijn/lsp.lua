local lspconfig = require("lspconfig")

local function set_lsp_config(client)
  vim.cmd [[nnoremap <buffer><silent> ]g :lua vim.lsp.diagnostic.goto_next()<CR>]]
  vim.cmd [[nnoremap <buffer><silent> [g :lua vim.lsp.diagnostic.goto_prev()<CR>]]

  vim.cmd [[setlocal omnifunc=v:lua.vim.lsp.omnifunc]]

  if client.resolved_capabilities.hover then
    vim.cmd [[nnoremap <buffer><silent> K :lua vim.lsp.buf.hover()<CR>]]
  end

  if client.resolved_capabilities.goto_definition then
    vim.cmd [[nnoremap <buffer><silent> gd :lua require"lsp_utils".definition_sync()<CR>]]
    vim.cmd [[nnoremap <buffer><silent> gp :lua require"lsp_utils".peek_definition()<CR>]]
  end

  if client.resolved_capabilities.type_definition then
    vim.cmd [[nnoremap <buffer><silent> gt :lua vim.lsp.buf.type_definition()<CR>]]
  end

  if client.resolved_capabilities.find_references then
    vim.cmd [[command! -buffer References lua vim.lsp.buf.references()]]
  end

  if client.resolved_capabilities.rename then
    vim.cmd [[nnoremap <buffer><silent> <leader>rn :lua vim.lsp.buf.rename()<CR>]]
  end

  if client.resolved_capabilities.code_action then
    vim.cmd [[nnoremap <buffer><silent> <leader>ca :lua vim.lsp.buf.code_action()<CR>]]
  end

  if client.resolved_capabilities.signature_help then
    vim.cmd [[inoremap <buffer><silent> <leader>sh :lua vim.lsp.buf.signature_help()<CR>]]
  end

  if client.name == "tsserver" then
    vim.cmd [[nnoremap <silent> <leader>oi :lua require'tsserver_utils'.organize_imports()<CR>]]

    vim.cmd [[augroup LspImportAfterCompletion]]
    vim.cmd [[  au!]]
    vim.cmd [[  autocmd CompleteDone <buffer> lua require"lsp_utils".import_after_completion()]]
    vim.cmd [[augroup END]]
  end
end

local eslint = {
  lintCommand = "eslint_d -f unix --stdin --stdin-filename ${INPUT}",
  lintStdin = true,
  lintFormats = { "%f:%l:%c: %m" },
  lintIgnoreExitCode = true,
  formatCommand = "eslint_d --fix-to-stdout --stdin --stdin-filename=${INPUT}",
  formatStdin = true,
}

lspconfig.tsserver.setup {
  on_attach = function(client)
    set_lsp_config(client)
  end
}

lspconfig.efm.setup({
  init_options = { documentFormatting = true },
  root_dir = function(fname)
    return lspconfig.util.find_git_ancestor(fname) or vim.loop.os_homedir()
  end,
  on_attach = function(client)
    set_lsp_config(client)
  end,
  settings = {
    rootMarkers = { ".git/", "package.json" },
    languages = {
      javascript = { eslint },
      javascriptreact = { eslint },
      typescript = { eslint },
      typescriptreact = { eslint },
    },
  },
  filetypes = {
    "javascript",
    "javascriptreact",
    "javascript.jsx",
    "typescript",
    "typescript.tsx",
    "typescriptreact"
  },
})
