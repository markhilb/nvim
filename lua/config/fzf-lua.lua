require("fzf-lua").setup(
  {
    fzf_opts = {
      ["--layout"] = "default"
    },
    keymap = {
      builtin = {
        ["<C-d>"] = "preview-page-down",
        ["<C-u>"] = "preview-page-up"
      }
    }
  }
)
