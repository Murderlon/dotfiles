-- gopls and golangci_lint are run inside Neovim's native LSP
-- so we disable them inside this plugin.
vim.g.go_diagnostics_enabled = 0
vim.g.go_metalinter_enabled = 0
vim.g.go_code_completion_enabled = 0
