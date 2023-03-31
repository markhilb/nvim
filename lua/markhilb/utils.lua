function path_pop(path)
    local new_path, _ = string.gsub(path, '/[^/]+$', '')
    return new_path == '' and '/' or new_path
end

local M = {}

function M.get_os_command_output(cmd, cwd)
    local result = {}
    local job = vim.fn.jobstart(cmd, {
        cwd = cwd,
        stdout_buffered = true,
        on_stdout = function(_, output, _) result = output end,
    })
    vim.fn.jobwait({ job })

    return result
end

function M.git_root()
    local git_root = M.get_os_command_output({ 'git', 'rev-parse', '--show-toplevel' }, vim.loop.cwd())[1]
    return git_root == nil and '' or git_root
end

function _reverse_find_file(file, dir)
    local files = M.get_os_command_output({ 'ls', '-a1' }, dir)
    for _, x in pairs(files) do
        if x == file then
            return dir .. '/' .. file
        end
    end

    return dir == '/' and nil or _reverse_find_file(file, path_pop(dir))
end

function M.reverse_find_file(file) return _reverse_find_file(file, path_pop(vim.api.nvim_buf_get_name(0))) end

function M.get_treesitter_root(language)
    local parser = vim.treesitter.get_parser(vim.api.nvim_get_current_buf(), language, {})
    local tree = parser:parse()[1]
    return tree:root()
end

return M
