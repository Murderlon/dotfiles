return {
  {
    "saghen/blink.cmp",
    opts = {
      sources = {
        providers = {
          lsp = {
            transform_items = function(_, items)
              local kind = require("blink.cmp.types").CompletionItemKind
              return vim.tbl_filter(function(item)
                return item.kind ~= kind.File and item.kind ~= kind.Folder
              end, items)
            end,
          },
          snippets = {
            should_show_items = function(ctx)
              local before = ctx.line:sub(1, ctx.cursor[2])
              local before_keyword = before:gsub("[%w_]*$", "")
              if before_keyword:sub(-1) == "." then
                return false
              end
              local path_regex = require("blink.cmp.sources.path.regex").PATH
              if path_regex:match_str(before) then
                return false
              end
              return true
            end,
          },
        },
      },
    },
  },
}
