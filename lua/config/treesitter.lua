vim.g.OmniSharp_highlighting = 0

require("nvim-treesitter.configs").setup(
  {
    highlight = {
      enable = true,
      disable = {"typescript"},
      custom_captures = {}
    }
  }
)
