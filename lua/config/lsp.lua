vim.lsp.handlers["textDocument/publishDiagnostics"] =
  vim.lsp.with(
  vim.lsp.diagnostic.on_publish_diagnostics,
  {
    virtual_text = {spacing = 4, prefix = "●"},
    signs = true,
    update_in_insert = false,
    loclist = true
  }
)

-- npm i -g pyright
require("lspconfig").pyright.setup({})

-- npm i -g typesript typescript-language-server
require("lspconfig").tsserver.setup({})

-- npm i -g vscode-langservers-extracted
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true
require("lspconfig").cssls.setup({capabilities = capabilities})
require("lspconfig").html.setup({capabilities = capabilities})
require("lspconfig").eslint.setup({})
require("lspconfig").jsonls.setup(
  {
    capabilities = capabilities,
    commands = {
      Format = {
        function()
          vim.lsp.buf.range_formatting({}, {0, 0}, {vim.fn.line("$"), 0})
        end
      }
    }
  }
)

-- sudo pacman -S clang (https://clangd.llvm.org/installation.html)
require("lspconfig").clangd.setup({})
