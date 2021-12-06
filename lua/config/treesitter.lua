vim.g.OmniSharp_highlighting = 0

require("nvim-treesitter.configs").setup(
  {
    ensure_installed = {
      "bash",
      "c",
      "c_sharp",
      "comment",
      "css",
      "dockerfile",
      "html",
      "javascript",
      "json",
      "lua",
      "python",
      "scss"
    },
    highlight = {
      enable = true,
      disable = {"typescript", "bash", "html", "css"},
      custom_captures = {}
    }
  }
)
