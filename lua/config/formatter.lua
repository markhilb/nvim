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
    )
  )

  (call_expression
    (field_expression
        field: (field_identifier) @_field (#any-of? @_field "query" "execute")
    )

    (arguments
        (raw_string_literal) @target
    )
  )
  ]]
)

function sql_format(sql)
  sql = string.gsub(sql, "'", "'\\''")
  local cmd = "echo '" .. sql .. "' | sql-formatter"

  local config = require("utils").reverse_find_file(".sql-formatter.json")
  if config then
    cmd = cmd .. " -c " .. config
  end

  local formatted_string = {}
  local job =
    vim.fn.jobstart(
    cmd,
    {
      on_stdout = function(_, d, _)
        -- For some reason this function gets called twice,
        -- once with the actual output from `cmd` and
        -- another time with `{ "" }`.
        -- This removes the second output.
        if #d == 1 and d[1] == "" then
          return
        end

        for _, s in pairs(d) do
          table.insert(formatted_string, s)
        end
      end
    }
  )
  vim.fn.jobwait({job})

  -- Remove trailing newlines from `formatted_string`
  for i = #formatted_string, 1, -1 do
    if formatted_string[i] ~= "" then
      break
    end
    table.remove(formatted_string, i)
  end

  return formatted_string
end

local C = {
  rust = function()
    local bufnr = vim.api.nvim_get_current_buf()
    local root = require("utils").get_treesitter_root("rust")
    local changes = {}

    for id, node in rust_sql:iter_captures(root, bufnr, 0, -1) do
      local name = rust_sql.captures[id]
      if name == "target" then
        -- { start_row, start_col, end_row, end_col}
        local range = {node:range()}
        local text = vim.treesitter.get_node_text(node, bufnr)
        text = string.sub(text, 4, #text - 3)

        local formatted = sql_format(text)
        table.insert(changes, 1, {start = range[1] + 1, final = range[3], formatted = formatted})
      end
    end

    for _, change in ipairs(changes) do
      vim.api.nvim_buf_set_lines(bufnr, change.start, change.final, false, change.formatted)
    end
  end
}

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
      if C[vim.bo.filetype] ~= nil then
        C[vim.bo.filetype]()
      end

      vim.cmd("w | FormatWrite")
    end
  end
end

return M
