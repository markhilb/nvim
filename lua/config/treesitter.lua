require("nvim-treesitter.configs").setup(
  {
    ensure_installed = {
      "c",
      "c_sharp",
      "comment",
      "dockerfile",
      "javascript",
      "typescript",
      "tsx",
      "html",
      "css",
      "scss",
      "json",
      "markdown",
      "lua",
      "python",
      "rust"
    },
    highlight = {
      enable = true,
      disable = {"typescript", "tsx", "bash", "html", "css", "scss", "rust"}
    },
    autotag = {enable = true}
  }
)
