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

return M
