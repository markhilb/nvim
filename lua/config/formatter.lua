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
      }
    }
  }
)

local M = {}

function M.format()
  if vim.bo.filetype == "" then
    vim.cmd("w")
  elseif require("formatter.config")["values"]["filetype"][vim.bo.filetype] == nil then
    vim.cmd("lua vim.lsp.buf.formatting_sync()")
    vim.cmd("w")
  else
    vim.cmd("w | FormatWrite")
  end
end

return M
