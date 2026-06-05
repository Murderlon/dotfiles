-- ┌─────────────────────────┐
-- │ Plugins outside of MINI │
-- └─────────────────────────┘
--
-- This file contains installation and configuration of plugins outside of MINI.
-- They significantly improve user experience in a way not yet possible with MINI.
-- These are mostly plugins that provide programming language specific behavior.
--
-- Use this file to install and configure other such plugins.

-- Make concise helpers for installing/adding plugins in two stages
local add = vim.pack.add
local now_if_args, later = Config.now_if_args, Config.later

-- Appearance =================================================================

-- Load immediately: this should apply the correct light/dark variant during
-- startup (after the colorscheme is set) and keep it in sync with the OS.
Config.now(function()
  add({ 'https://github.com/f-person/auto-dark-mode.nvim' })

  require('auto-dark-mode').setup()
end)

-- Tree-sitter ================================================================

-- Tree-sitter is a tool for fast incremental parsing. It converts text into
-- a hierarchical structure (called tree) that can be used to implement advanced
-- and/or more precise actions: syntax highlighting, textobjects, indent, etc.
--
-- Tree-sitter support is built into Neovim (see `:h treesitter`). However, it
-- requires two extra pieces that don't come with Neovim directly:
-- - Language parsers: programs that convert text into trees. Some are built-in
--   (like for Lua), 'nvim-treesitter' provides many others.
--   NOTE: It requires third party software to build and install parsers.
--   See the link for more info in "Requirements" section of the MiniMax README.
-- - Query files: definitions of how to extract information from trees in
--   a useful manner (see `:h treesitter-query`). 'nvim-treesitter' also provides
--   these, while 'nvim-treesitter-textobjects' provides the ones for Neovim
--   textobjects (see `:h text-objects`, `:h MiniAi.gen_spec.treesitter()`).
--
-- Add these plugins now if file (and not 'mini.starter') is shown after startup.
--
-- Troubleshooting:
-- - Run `:checkhealth vim.treesitter nvim-treesitter` to see potential issues.
-- - In case of errors related to queries for Neovim bundled parsers (like `lua`,
--   `vimdoc`, `markdown`, etc.), manually install them via 'nvim-treesitter'
--   with `:TSInstall <language>`. Be sure to have necessary system dependencies
--   (see MiniMax README section for software requirements).
now_if_args(function()
  -- Define hook to update tree-sitter parsers after plugin is updated
  local ts_update = function() vim.cmd('TSUpdate') end
  Config.on_packchanged('nvim-treesitter', { 'update' }, ts_update, ':TSUpdate')

  add({
    'https://github.com/nvim-treesitter/nvim-treesitter',
    'https://github.com/nvim-treesitter/nvim-treesitter-textobjects',
  })

  -- Define languages which will have parsers installed and auto enabled.
  -- After changing this, restart Neovim once to install necessary parsers. Wait
  -- for the installation to finish before opening a file for added language(s).
  local languages = {
    -- Neovim / Lua config
    'lua',
    'luadoc',
    'query',
    'vim',
    'vimdoc',

    -- Full-stack TypeScript / web development
    'javascript',
    'typescript',
    'tsx',
    'html',
    'svelte',
    'astro',
    'vue',
    'css',
    'scss',
    'json',
    'yaml',
    'regex',

    -- Common project and ops files
    'bash',
    'dockerfile',
    'git_config',
    'git_rebase',
    'gitcommit',
    'markdown',
    'markdown_inline',
    'sql',
    'toml',

    -- Go
    'go',
    'gomod',

    -- Rust
    'rust',
  }
  local isnt_installed = function(lang)
    return #vim.api.nvim_get_runtime_file('parser/' .. lang .. '.*', false) == 0
  end
  local to_install = vim.tbl_filter(isnt_installed, languages)
  if #to_install > 0 then require('nvim-treesitter').install(to_install) end

  -- Enable tree-sitter after opening a file for a target language
  local filetypes = {}
  for _, lang in ipairs(languages) do
    for _, ft in ipairs(vim.treesitter.language.get_filetypes(lang)) do
      table.insert(filetypes, ft)
    end
  end
  local ts_start = function(ev) vim.treesitter.start(ev.buf) end
  Config.new_autocmd('FileType', filetypes, ts_start, 'Start tree-sitter')
end)

-- Language servers ===========================================================

-- Language Server Protocol (LSP) is a set of conventions that power creation of
-- language specific tools. It requires two parts:
-- - Server - program that performs language specific computations.
-- - Client - program that asks server for computations and shows results.
--
-- Here Neovim itself is a client (see `:h vim.lsp`). Language servers need to
-- be installed separately based on your OS, CLI tools, and preferences.
-- See note about 'mason.nvim' at the bottom of the file.
--
-- Neovim's team collects commonly used configurations for most language servers
-- inside 'neovim/nvim-lspconfig' plugin.
--
-- Add it now if file (and not 'mini.starter') is shown after startup.
--
-- Troubleshooting:
-- - Run `:checkhealth vim.lsp` to see potential issues.
now_if_args(function()
  add({
    'https://github.com/mason-org/mason.nvim',
    'https://github.com/neovim/nvim-lspconfig',
    'https://github.com/mason-org/mason-lspconfig.nvim',
  })

  require('mason').setup()

  -- Bridge Mason-installed servers with nvim-lspconfig. By default this will
  -- automatically enable installed Mason LSP servers via `vim.lsp.enable()`.
  require('mason-lspconfig').setup()

  -- Use `:h vim.lsp.config()` or 'after/lsp/' directory to configure servers.
end)

-- Formatting =================================================================

-- Programs dedicated to text formatting (a.k.a. formatters) are very useful.
-- Neovim has built-in tools for text formatting (see `:h gq` and `:h 'formatprg'`).
-- They can be used to configure external programs, but it might become tedious.
--
-- The 'stevearc/conform.nvim' plugin is a good and maintained solution for easier
-- formatting setup.
later(function()
  add({ 'https://github.com/stevearc/conform.nvim' })

  -- See also:
  -- - `:h Conform`
  -- - `:h conform-options`
  -- - `:h conform-formatters`
  local oxfmt_configs = {
    '.oxfmtrc.json',
    '.oxfmtrc.jsonc',
    '.oxfmtrc.js',
    '.oxfmtrc.mjs',
    '.oxfmtrc.cjs',
    '.oxfmtrc.ts',
    '.oxfmtrc.mts',
    '.oxfmtrc.cts',
    'oxfmt.config.js',
    'oxfmt.config.mjs',
    'oxfmt.config.cjs',
    'oxfmt.config.ts',
    'oxfmt.config.mts',
    'oxfmt.config.cts',
  }
  local biome_configs = { 'biome.json', 'biome.jsonc' }

  -- Keep Biome in sync with LazyVim's TypeScript Biome extra. Oxfmt supports
  -- more web-adjacent languages than LazyVim's current OXC extra lists.
  local oxfmt_filetypes = {
    'javascript',
    'javascriptreact',
    'typescript',
    'typescriptreact',
    'json',
    'jsonc',
    'json5',
    'yaml',
    'toml',
    'html',
    'htmlangular',
    'vue',
    'svelte',
    'astro',
    'css',
    'scss',
    'less',
    'markdown',
    'markdown.mdx',
    'graphql',
    'glimmer',
    'handlebars',
    'hbs',
  }

  -- https://biomejs.dev/internals/language-support/
  local biome_filetypes = {
    'astro',
    'css',
    'scss',
    'graphql',
    -- 'html',
    'javascript',
    'javascriptreact',
    'json',
    'jsonc',
    -- 'markdown',
    'svelte',
    'typescript',
    'typescriptreact',
    'vue',
    -- 'yaml',
  }

  local formatters_by_ft = {}
  for _, ft in ipairs(oxfmt_filetypes) do
    formatters_by_ft[ft] = formatters_by_ft[ft] or {}
    table.insert(formatters_by_ft[ft], 'oxfmt')
  end
  for _, ft in ipairs(biome_filetypes) do
    formatters_by_ft[ft] = formatters_by_ft[ft] or {}
    table.insert(formatters_by_ft[ft], 'biome-check')
  end

  require('conform').setup({
    default_format_opts = {
      -- Allow formatting from LSP server if no dedicated formatter is available
      lsp_format = 'fallback',
    },
    format_on_save = {
      timeout_ms = 3000,
      lsp_format = 'fallback',
    },
    -- Conform does not automatically use every Mason-installed formatter. It
    -- needs filetype mappings; `require_cwd` keeps formatters project-local.
    formatters_by_ft = formatters_by_ft,
    formatters = {
      oxfmt = {
        command = 'oxfmt',
        args = { '--stdin-filepath', '$FILENAME' },
        stdin = true,
        cwd = require('conform.util').root_file(oxfmt_configs),
        require_cwd = true,
      },
      ['biome-check'] = {
        command = 'biome',
        args = { 'check', '--write', '--stdin-file-path', '$FILENAME' },
        stdin = true,
        cwd = require('conform.util').root_file(biome_configs),
        require_cwd = true,
      },
    },
  })
end)

-- Snippets ===================================================================

-- Although 'mini.snippets' provides functionality to manage snippet files, it
-- deliberately doesn't come with those.
--
-- The 'rafamadriz/friendly-snippets' is currently the largest collection of
-- snippet files. They are organized in 'snippets/' directory (mostly) per language.
-- 'mini.snippets' is designed to work with it as seamlessly as possible.
-- See `:h MiniSnippets.gen_loader.from_lang()`.
later(function() add({ 'https://github.com/rafamadriz/friendly-snippets' }) end)
