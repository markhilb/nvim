local execute = vim.api.nvim_command
local install_path = vim.fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
  execute("!git clone https://github.com/wbthomason/packer.nvim " .. install_path)
  execute("packadd packer.nvim")
end
vim.cmd("packadd packer.nvim")

return require("packer").startup(
  function()
    use "wbthomason/packer.nvim"

    use "ap/vim-css-color"
    use "windwp/nvim-ts-autotag"

    use "wellle/targets.vim"
    use "bronson/vim-trailing-whitespace"
    use {"tpope/vim-commentary", config = "require('config/vim-commentary')"}

    use {"APZelos/blamer.nvim", config = "require('config/blamer')"}

    use {"phaazon/hop.nvim", branch = "v1", config = "require('config/hop')"}

    use {"mhartington/formatter.nvim", config = "require('config/formatter')"}

    use {
      "nvim-treesitter/nvim-treesitter",
      run = ":TSUpdate",
      config = "require('config/treesitter')",
      requires = {
        {"nvim-treesitter/playground"}
      }
    }

    use {"windwp/nvim-autopairs", config = "require('nvim-autopairs').setup({})"}

    use {"nvim-lua/plenary.nvim"}

    use {"ibhagwan/fzf-lua", config = "require('config/fzf-lua')"}
    use {
      "junegunn/fzf",
      config = "require('config/fzf')",
      requires = {
        {"junegunn/fzf.vim"}
      }
    }

    use {
      "neovim/nvim-lspconfig",
      config = "require('config/lsp')"
    }

    use {"j-hui/fidget.nvim", config = "require('fidget').setup({})"}

    use {
      "hrsh7th/nvim-cmp",
      config = "require('config/cmp')",
      requires = {
        {"hrsh7th/cmp-nvim-lsp"},
        {"hrsh7th/cmp-buffer"},
        {"hrsh7th/cmp-path"},
        {"hrsh7th/cmp-calc"},
        {"hrsh7th/cmp-nvim-lsp-signature-help"},
        {"L3MON4D3/LuaSnip"}
      }
    }
  end
)
