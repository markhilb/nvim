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

local config = require("lspconfig")

-- npm i -g pyright
config.pyright.setup({})

-- npm i -g typescript typescript-language-server
config.tsserver.setup({})

-- npm i -g vscode-langservers-extracted
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true
config.cssls.setup({capabilities = capabilities})
config.html.setup({capabilities = capabilities})
config.eslint.setup({})
config.jsonls.setup(
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
config.clangd.setup({})

-- curl -L https://github.com/OmniSharp/omnisharp-roslyn/releases/latest/download/omnisharp-linux-x64.tar.gz > ~/omnisharp.tar.gz && tar xzf ~/omnisharp.tar.gz -C ~/.omnisharp/ && rm ~/omnisharp.tar.gz
config.omnisharp.setup(
  {
    cmd = {"/home/markus/.omnisharp/run", "--languageserver", "--hostPID", tostring(pid)}
  }
)