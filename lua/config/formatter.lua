local function prettier()
  return {
    exe = "prettier",
    args = {"--stdin-filepath", vim.fn.fnameescape(vim.api.nvim_buf_get_name(0)), "--stdin"},
    stdin = true
  }
end

require("formatter").setup(
  {
    filetype = {
      javascript = {prettier},
      typescript = {prettier},
      typescriptreact = {prettier},
      javascriptreact = {prettier},
      html = {prettier},
      css = {prettier},
      scss = {prettier},
      json = {prettier},
      lua = {
        function()
          return {
            exe = "luafmt",
            args = {"--indent-count", 2, "--stdin"},
            stdin = true
          }
        end
      },
      rust = {
        function()
          return {
            exe = "rustfmt",
            args = {"--emit=stdout"},
            stdin = true
          }
        end
      },
      sql = {
        function()
          local config = require("utils").reverse_find_file(".sql-formatter.json")
          return {
            exe = "sql-formatter",
            args = config == nil and {} or {"--config", config},
            stdin = true
          }
        end
      }
    }
  }
)

local M = {}

function M.format(range, filetype)
  if vim.bo.filetype == "" then
    vim.cmd("w")
  elseif require("formatter.config")["values"]["filetype"][vim.bo.filetype] == nil then
    if range then
      vim.cmd("lua vim.lsp.buf.range_formatting()")
    else
      vim.cmd("lua vim.lsp.buf.formatting_sync()")
    end

    vim.cmd("w")
  else
    if range then
      vim.api.nvim_feedkeys("\027", "xt", false)

      if filetype ~= nil then
        local old = vim.bo.filetype
        vim.cmd("set filetype=" .. filetype)
        vim.cmd("'<,'>FormatWrite")
        vim.cmd("set filetype=" .. old)
      else
        vim.cmd("'<,'>FormatWrite")
      end
    else
      vim.cmd("w | FormatWrite")
    end
  end
end

return M
