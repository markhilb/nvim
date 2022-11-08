local ignore_dirs = {"node_modules/", "target/", ".git/", "bin/", "obj/", ".angular/", "db/"}

vim.env.FZF_DEFAULT_OPTS =
  [[
    --bind ctrl-a:select-all,ctrl-e:deselect-all,ctrl-u:preview-half-page-up,ctrl-d:preview-half-page-down
    --color fg:#e0e0e0,bg:#1c1c1c,hl:#ff0000
]]

vim.env.FZF_DEFAULT_COMMAND = "fd -HI -t file -E " .. table.concat(ignore_dirs, " -E ")

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
    "rg --no-ignore --hidden --no-heading --column --color=always -g '!" ..
      table.concat(ignore_dirs, "' -g '!") .. "' ^",
    false,
    vim.fn["fzf#vim#with_preview"]({dir = dir})
  )
end

return M
