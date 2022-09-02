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

function _reverse_find_file(file, dir)
  local files = get_os_command_output({"ls", "-a1"}, dir)
  for _, x in pairs(files) do
    if x == file then
      return dir .. "/" .. file
    end
  end

  if dir == "/" then
    return nil
  else
    local new_dir, _ = string.gsub(dir, "/[^/]+$", "")
    if new_dir == "" then
      return _reverse_find_file(file, "/")
    else
      return _reverse_find_file(file, new_dir)
    end
  end
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

function M.git_root()
  local git_root, _ = get_os_command_output({"git", "rev-parse", "--show-toplevel"}, vim.loop.cwd())

  if git_root[1] == nil then
    return ""
  else
    return git_root[1]
  end
end

function M.dump_table(t)
  if type(t) == "table" then
    local s = "{ "
    for k, v in pairs(t) do
      if type(k) ~= "number" then
        k = '"' .. k .. '"'
      end
      s = s .. "[" .. k .. "] = " .. dump(v) .. ","
    end
    return s .. "} "
  else
    return tostring(t)
  end
end

function M.reverse_find_file(file)
  return _reverse_find_file(file, vim.loop.cwd())
end

return M
