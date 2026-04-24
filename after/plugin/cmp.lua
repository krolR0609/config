local cmp = require('cmp')

cmp.setup({
  snippet = {
    expand = function(args)
      require('luasnip').lsp_expand(args.body)
    end,
  },
  mapping = {
      ['<CR>'] = cmp.mapping.confirm({ select = true }), -- Confirm selection
      ['<C-c>'] = cmp.mapping.complete(),            -- Trigger completion
      ['<C-e>'] = cmp.mapping.abort(),
      ['<Tab>'] = cmp.mapping(function(fallback)
          if cmp.visible() then               -- меню открыто → выбрать «вниз»
              cmp.select_next_item()
          else                                -- иначе обычный Tab
              fallback()
          end
      end, { 'i', 's' }),
      ['<S-Tab>'] = cmp.mapping(function(fallback)
          if cmp.visible() then
              cmp.select_prev_item()
          else
              fallback()
          end
      end, { 'i', 's' }),
  },
  sources = {
    { name = 'nvim_lsp' },
    { name = 'luasnip' },
    { name = 'path' },
    { name = 'buffer' },
  },
  formatting = {
    fields = { "kind", "abbr", "menu" },
    format = require('lspkind').cmp_format({
      mode = 'symbol_text',  -- показывать пиктограммы и текст типа
      maxwidth = 50,
      ellipsis_char = '...',
    })
  },
})
