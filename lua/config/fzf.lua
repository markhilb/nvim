function get_os_command_output(cmd, cwd)
  local command = table.remove(cmd, 1)
  local stderr = {}
  local stdout, ret =
    require("plenary.job"):new(
    {
      command = command,
      args = cmd,
      cwd = cwd,
      on_stderr = function(_, data)
        table.insert(stderr, data)
      end
    }
  ):sync()
  return stdout, ret, stderr
end

function get_git_root(dir)
  if dir ~= nil then
    return dir
  end

  local git_root, ret = get_os_command_output({"git", "rev-parse", "--show-toplevel"}, vim.loop.cwd())

  if ret ~= 0 then
    return dir
  end
  return git_root[1]
end

vim.env.FZF_DEFAULT_OPTS =
  "--bind ctrl-a:select-all,ctrl-d:deselect-all,up:preview-half-page-up,down:preview-half-page-down"

local ignore_dirs = {"node_modules", "target", ".git", "bin", "obj", "out-tsc"}

vim.env.FZF_DEFAULT_COMMAND =
  "find . -type d \\( -name " .. table.concat(ignore_dirs, " -o -name ") .. " \\) -prune -o -print"

local M = {}

function M.find_files(dir)
  vim.fn["fzf#vim#files"](get_git_root(dir), vim.fn["fzf#vim#with_preview"]())
end

function M.grep_files(dir)
  print(get_git_root(dir))
  vim.fn["fzf#vim#grep"](
    "ag --nogroup --column --color --ignore-dir={" .. table.concat(ignore_dirs, ",") .. "} -- '^(?=.)'",
    false,
    vim.fn["fzf#vim#with_preview"]({dir = get_git_root(dir)})
  )
end

return M
