local cmp = require("cmp")
cmp.setup(
  {
    completion = {completeopt = "menuone,noinsert"},
    mapping = {
      ["<CR>"] = cmp.mapping.confirm(
        {
          behavior = cmp.ConfirmBehavior.Replace,
          select = false
        }
      )
    },
    snippet = {
      expand = function(args)
        require("luasnip").lsp_expand(args.body)
      end
    },
    sources = cmp.config.sources(
      {
        {name = "buffer"},
        {name = "path"},
        {name = "calc"},
        {name = "nvim_lsp"}
      }
    )
  }
)
