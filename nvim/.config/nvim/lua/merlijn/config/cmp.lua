local cmp = require 'cmp'
local ls = require 'luasnip'

cmp.setup({
  mapping = {
    ['<C-e>'] = cmp.mapping.close(),
    ['<C-k>'] = cmp.mapping.confirm {
      behavior = cmp.ConfirmBehavior.Insert,
      select = true,
    },
    ['<C-l>'] = cmp.mapping(
      function(fallback)
        if ls.expand_or_jumpable() then
          ls.expand_or_jump()
        else
          fallback() -- The fallback function is treated as original mapped key.
        end
      end,
      { 'i', 's' }
    ),
    ['<C-j>'] = cmp.mapping(
      function(fallback)
        if ls.jumpable(-1) then
          ls.jump(-1)
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
    { name = 'luasnip' },
    { name = 'nvim_lsp' },
    { name = 'path' },
    { name = 'buffer', keyword_length = 4 },
  },
  snippet = {
    expand = function(args)
      ls.lsp_expand(args.body)
    end
  },
  experimental = {
    ghost_text = true,
  }
})
