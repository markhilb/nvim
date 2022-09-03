vim.diagnostic.config(
  {
    virtual_text = {spacing = 4, prefix = "●"},
    float = {border = "rounded", source = "if_many"},
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

-- Must be installed per project
-- npm i -D @angular/language-server
config.angularls.setup({filetypes = {"html"}})

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

-- sudo pacman -S --noconfirm lua-language-server
config.sumneko_lua.setup({})

-- sudo pacman -S clang (https://clangd.llvm.org/installation.html)
config.clangd.setup({})

-- curl -L https://github.com/OmniSharp/omnisharp-roslyn/releases/latest/download/omnisharp-linux-x64.tar.gz > ~/omnisharp.tar.gz && tar xzf ~/omnisharp.tar.gz -C ~/.omnisharp/ && rm ~/omnisharp.tar.gz
config.omnisharp.setup(
  {
    cmd = {"/home/markus/.omnisharp/OmniSharp", "--languageserver", "--hostPID", tostring(pid)}
  }
)

-- curl -L https://github.com/rust-analyzer/rust-analyzer/releases/latest/download/rust-analyzer-x86_64-unknown-linux-gnu.gz | gunzip -c - > ~/.local/bin/rust-analyzer && chmod +x ~/.local/bin/rust-analyzer
config.rust_analyzer.setup(
  {
    settings = {
      ["rust-analyzer"] = {
        checkOnSave = {
          allFeatures = true,
          overrideCommand = {
            "cargo",
            "clippy",
            "--workspace",
            "--message-format=json",
            "--all-targets",
            "--all-features"
          }
        }
      }
    }
  }
)
