function map(mode, left, right, opts)
  local options = {noremap = true}
  if opts then
    options = vim.tbl_extend("force", options, opts)
  end
  vim.api.nvim_set_keymap(mode, left, right, options)
end

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

local M = {}

function M.nmap(left, right, opts)
  map("n", left, right, opts)
end
function M.vmap(left, right, opts)
  map("v", left, right, opts)
end
function M.imap(left, right, opts)
  map("i", left, right, opts)
end

function M.git_root_or_default(dir)
  if dir ~= nil then
    return dir
  end

  local git_root, ret = get_os_command_output({"git", "rev-parse", "--show-toplevel"}, vim.loop.cwd())

  if ret ~= 0 then
    return dir
  end
  return git_root[1]
end

return M
