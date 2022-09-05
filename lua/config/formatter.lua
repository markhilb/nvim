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

local rust_sql =
  vim.treesitter.parse_query(
  "rust",
  [[
  (macro_invocation
    (scoped_identifier
      path: (identifier) @path (#eq? @path "sqlx")
      name: (identifier) @name (#match? @name "query")
    )

    (token_tree
      (raw_string_literal) @target
      (#offset! @target 1 0 -1 0)
    )
  )
  ]]
)

local M = {}

function sql_format(sql)
    local cmd = {"sql-formatter"}
          local config = require("utils").reverse_find_file(".sql-formatter.json")
          if config then
            table.insert(cmd, {"-c", config})
          end
          require("utils").get_os_command_output()

end

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
      local bufnr = vim.api.nvim_get_current_buf()
      -- vim.cmd("w | FormatWrite")
      local old = vim.bo.filetype
      vim.cmd("set filetype=sql")
      local root = require("utils").get_treesitter_root("rust")
      for id, node in rust_sql:iter_captures(root, bufnr, 0, -1) do
        local name = rust_sql.captures[id]
        if name == "target" then
          -- { start_row, start_col, end_row, end_col}
          local _range = {node:range()}
          local text = vim.treesitter.get_node_text(node, bufnr)
          print(text)
          print(_range[1], _range[2], _range[3], _range[4])
          vim.cmd(string.format("%d.%d,%d.%d Format", _range[1], _range[2], _range[3], _range[4]))
        end
      end
      vim.cmd("set filetype=" .. old)
    end
  end
end

return M
