vim.g.OmniSharp_highlighting = 0

require("nvim-treesitter.configs").setup(
  {
    ensure_installed = {
      "c",
      "c_sharp",
      "comment",
      "dockerfile",
      "javascript",
      "json",
      "lua",
      "python"
    },
    highlight = {
      enable = true,
      disable = {"typescript", "bash", "html", "css", "scss"},
      custom_captures = {}
    }
  }
)
