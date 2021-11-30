local fn = vim.fn
local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
if fn.empty(fn.glob(install_path)) > 0 then
  packer_bootstrap =
    fn.system({"git", "clone", "--depth", "1", "https://github.com/wbthomason/packer.nvim", install_path})
end

return require("packer").startup(
  function()
    use "wbthomason/packer.nvim"

    use "ap/vim-css-color"

    use "wellle/targets.vim"
    use "bronson/vim-trailing-whitespace"
    use {"tpope/vim-commentary", config = require("config/vim-commentary")}

    use {"APZelos/blamer.nvim", config = require("config/blamer")}

    use {"phaazon/hop.nvim", branch = "v1", config = require("config/hop")}

    use {"mhartington/formatter.nvim", config = require("config/formatter")}

    use {
      "nvim-treesitter/nvim-treesitter",
      run = ":TSUpdate",
      config = require("config/treesitter"),
      requires = {
        {"nvim-treesitter/playground"}
      }
    }

    use {"windwp/nvim-autopairs", config = require("nvim-autopairs").setup()}

    use {
      "junegunn/fzf",
      config = require("config/fzf"),
      run = "fzf#install()",
      requires = {
        {"junegunn/fzf.vim"},
        {"nvim-lua/plenary.nvim"}
      }
    }

    use "OmniSharp/omnisharp-vim"

    use {"neovim/nvim-lspconfig", config = require("config/lsp")}
    use {"weilbith/nvim-code-action-menu", config = require("config/nvim-code-action-menu")}
    use {"folke/trouble.nvim", config = require("config/trouble")}
    use {
      "hrsh7th/nvim-cmp",
      config = require("config/cmp"),
      requires = {
        {"hrsh7th/cmp-nvim-lsp"},
        {"hrsh7th/cmp-buffer"},
        {"hrsh7th/cmp-path"},
        {"hrsh7th/cmp-calc"},
        {"L3MON4D3/LuaSnip", config = require("config/luasnip")}
      }
    }

    -- Automatically set up your configuration after cloning packer.nvim
    -- Put this at the end after all plugins
    if packer_bootstrap then
      require("packer").sync()
    end
  end
)
