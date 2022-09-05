function map(mode, left, right, opts)
  local options = {noremap = true}
  if opts then
    options = vim.tbl_extend("force", options, opts)
  end
  vim.api.nvim_set_keymap(mode, left, right, options)
end

function path_pop(path)
  local new_path, _ = string.gsub(path, "/[^/]+$", "")
  return new_path == "" and "/" or new_path
end

function _reverse_find_file(file, dir)
  local files = get_os_command_output({"ls", "-a1"}, dir)
  for _, x in pairs(files) do
    if x == file then
      return dir .. "/" .. file
    end
  end

  return dir == "/" and nil or _reverse_find_file(file, path_pop(dir))
end

local M = {}

function M.get_os_command_output(cmd, cwd)
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
  local git_root, _ = M.get_os_command_output({"git", "rev-parse", "--show-toplevel"}, vim.loop.cwd())
  return git_root[1] == nil and "" or git_root[1]
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
  return _reverse_find_file(file, path_pop(vim.api.nvim_buf_get_name(0)))
end

function M.get_treesitter_root(language)
  local parser = vim.treesitter.get_parser(vim.api.nvim_get_current_buf(), language, {})
  local tree = parser:parse()[1]
  return tree:root()
end

return M
