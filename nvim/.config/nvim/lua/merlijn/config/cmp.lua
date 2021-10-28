local cmp = require 'cmp'

local press = function(key)
  vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes(key, true, true, true), 'n', true)
end

cmp.setup({
  mapping = {
    ['<C-e>'] = cmp.mapping.close(),
    ['<C-k>'] = cmp.mapping.confirm {
      behavior = cmp.ConfirmBehavior.Insert,
      select = true,
    },
    ['<C-l>'] = cmp.mapping(
      function(fallback)
        if vim.fn['UltiSnips#CanJumpForwards']() == 1 then
          press('<ESC>:call UltiSnips#JumpForwards()<CR>')
        else
          fallback() -- The fallback function is treated as original mapped key.
        end
      end,
      { 'i', 's' }
    ),
    ['<C-j>'] = cmp.mapping(
      function(fallback)
        if vim.fn['UltiSnips#CanJumpBackwards']() == 1 then
          press('<ESC>:call UltiSnips#JumpBackwards()<CR>')
        else
          fallback() -- The fallback function is treated as original mapped key.
        end
      end,
      { 'i', 's' }
    ),
    ['<c-space>'] = cmp.mapping.complete(),
  },
  sources = {
    -- The order of the sources matter, it determines priority in what to suggest
    { name = 'nvim_lua' }, -- only enabled in lua files
    { name = 'nvim_lsp' },
    { name = 'path' },
    { name = 'ultisnips' },
    { name = 'buffer', keyword_length = 4 },
  },
  snippet = {
    expand = function(args)
      vim.fn['UltiSnips#Anon'](args.body)
    end,
  },
  experimental = {
    ghost_text = true,
  }
})
