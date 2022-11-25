require("fzf-lua").setup(
  {
    fzf_opts = {
      ["--layout"] = "default"
    },
    keymap = {
      builtin = {
        ["<C-d>"] = "preview-page-down",
        ["<C-u>"] = "preview-page-up"
      },
      fzf = {
        ["ctrl-a"] = "toggle-all"
      }
    },
    grep = {
        rg_opts = "--hidden --column --line-number --no-heading --color=always --smart-case --max-columns=512"
    }
  }
)
