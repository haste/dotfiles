local elixir = require("elixir")

elixir.setup {
  nextls = {
    enable = true,
    on_attach = function(client, bufnr)
        vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
        vim.api.nvim_create_autocmd("BufWritePre", {
          group = augroup,
          buffer = bufnr,
          callback = function()
          end,
        })
    end,
  },
  credo = {
    enable = true
  },
  elixirls = {
    enable = false,
  }
}
