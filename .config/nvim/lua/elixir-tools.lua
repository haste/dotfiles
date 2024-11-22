local elixir = require("elixir")
local elixirls = require("elixir.elixirls")

elixir.setup({
	nextls = {
		enable = true,
		init_options = {
			mix_env = "test",
			mix_target = "host",
		},
		on_attach = function(client, bufnr)
			vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
			vim.api.nvim_create_autocmd("BufWritePre", {
				group = augroup,
				buffer = bufnr,
				callback = function() end,
			})
		end,
	},
	credo = {
		enable = true,
	},
	elixirls = {
		enable = false,
		settings = elixirls.settings({
			dialyzerEnabled = false,
			enableTestLenses = false,
		}),
	},
})
