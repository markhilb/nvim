local autocmd = vim.api.nvim_create_autocmd
local augroup = vim.api.nvim_create_augroup

require("nvim-treesitter.configs").setup(
  {
    ensure_installed = "all",
    highlight = {enable = true},
    autotag = {enable = true}
  }
)

local read_file = function(path)
  local fd = assert(vim.loop.fs_open(path, "r", 438))
  local stat = assert(vim.loop.fs_fstat(fd))
  return vim.loop.fs_read(fd, stat.size, 0)
end

local override_queries = function(lang, query_name)
  local queries_folder = vim.fs.normalize("~/.config/nvim/after/queries")
  vim.treesitter.query.set_query(
    lang,
    query_name,
    read_file(queries_folder .. string.format("/%s/%s.scm", lang, query_name))
  )
end

autocmd(
  "FileType",
  {
    pattern = "rust",
    group = augroup("RustOverrideQuery", {clear = true}),
    callback = function()
      override_queries("rust", "injections")
    end,
    desc = "Override rust treesitter injection"
  }
)
