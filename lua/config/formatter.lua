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
          return {
            exe = "sql-formatter",
            args = {},
            stdin = true
          }
        end
      }
    }
  }
)

local M = {}

function M.format(range)
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
      vim.cmd("'<,'>FormatWrite")
    else
      vim.cmd("w | FormatWrite")
    end
  end
end

return M
