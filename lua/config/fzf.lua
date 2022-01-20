local ignore_dirs = {"node_modules", "target", ".git", "bin", "obj", "out-tsc", ".angular", "db"}

vim.env.FZF_DEFAULT_OPTS =
  "--bind ctrl-a:select-all,ctrl-d:deselect-all,up:preview-half-page-up,down:preview-half-page-down"

vim.env.FZF_DEFAULT_COMMAND =
  "find . -type d \\( -name " .. table.concat(ignore_dirs, " -o -name ") .. " \\) -prune -o -print"

local M = {}

function M.find_files(dir)
  if dir == nil then
    vim.fn["fzf#vim#files"](require("utils").git_root(), vim.fn["fzf#vim#with_preview"]())
  else
    vim.fn["fzf#vim#files"](dir, vim.fn["fzf#vim#with_preview"]())
  end
end

function M.grep_files(dir)
  if dir == nil then
    dir = require("utils").git_root()
  end

  vim.fn["fzf#vim#grep"](
    "ag --skip-vcs-ignores --hidden --nogroup --column --color --ignore-dir={" ..
      table.concat(ignore_dirs, ",") .. "} -- '^(?=.)'",
    false,
    vim.fn["fzf#vim#with_preview"]({dir = dir})
  )
end

return M
