local cmp = require("cmp")
local types = require("cmp.types")

cmp.setup(
  {
    sources = {
      {name = "luasnip"},
      {name = "nvim_lsp"},
      {name = "buffer"},
      {name = "path"},
      {name = "calc"},
      {name = "crates"}
    },
    snippet = {
      expand = function(args)
        require("luasnip").lsp_expand(args.body)
      end
    },
    mapping = {
      ["<CR>"] = cmp.mapping.confirm(
        {
          behavior = cmp.ConfirmBehavior.Replace,
          select = false
        }
      ),
      ["<C-d>"] = cmp.mapping(cmp.mapping.scroll_docs(4), {"i", "c"}),
      ["<C-u>"] = cmp.mapping(cmp.mapping.scroll_docs(-4), {"i", "c"}),
      ["<C-y>"] = cmp.mapping(
        cmp.mapping.confirm(
          {
            behavior = cmp.ConfirmBehavior.Replace,
            select = true
          }
        ),
        {"i", "c"}
      ),
      ["<C-n>"] = cmp.mapping(
        function()
          if not cmp.visible() then
            cmp.complete()
          else
            cmp.select_next_item({behavior = types.cmp.SelectBehavior.Insert})
          end
        end
      ),
      ["<C-p>"] = cmp.mapping(
        function()
          if not cmp.visible() then
            cmp.complete()
          else
            cmp.select_prev_item({behavior = types.cmp.SelectBehavior.Insert})
          end
        end
      )
    },
    completion = {completeopt = "menuone,noinsert"}
  }
)
