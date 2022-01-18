local ignore_dirs = {"node_modules", "target", ".git", "bin", "obj", "out-tsc", ".angular"}

require("fzf-lua").setup(
  {
    files = {
      find_opts = "\\( -name " .. table.concat(ignore_dirs, " -o -name ") .. " \\) -prune -o -print",
      rg_opts = "--color=never --files --hidden --follow -g '!{**/" .. table.concat(ignore_dirs, "/*,**/") .. "/*}'"
    },
    fzf_opts = {
      ["--layout"] = "default"
    }
  }
)
