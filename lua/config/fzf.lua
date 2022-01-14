local git_root_or_default = require("utils").git_root_or_default

vim.env.FZF_DEFAULT_OPTS =
  "--bind ctrl-a:select-all,ctrl-d:deselect-all,up:preview-half-page-up,down:preview-half-page-down"

local ignore_dirs = {"node_modules", "target", ".git", "bin", "obj", "out-tsc", ".angular"}

vim.env.FZF_DEFAULT_COMMAND =
  "find . -type d \\( -name " .. table.concat(ignore_dirs, " -o -name ") .. " \\) -prune -o -print"

local M = {}

function M.find_files(dir)
  vim.fn["fzf#vim#files"](git_root_or_default(dir), vim.fn["fzf#vim#with_preview"]())
end

function M.grep_files(dir)
  print(git_root_or_default(dir))
  vim.fn["fzf#vim#grep"](
    "ag --skip-vcs-ignores --hidden --nogroup --column --color --ignore-dir={" ..
      table.concat(ignore_dirs, ",") .. "} -- '^(?=.)'",
    false,
    vim.fn["fzf#vim#with_preview"]({dir = git_root_or_default(dir)})
  )
end

return M
