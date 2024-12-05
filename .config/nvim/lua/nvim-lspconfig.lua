--[[
require("lspconfig").elixirls.setup({
	cmd = { "/home/haste/.elixir-ls/release/language_server.sh" },
	flags = {
		debounce_text_changes = 150,
	},
	elixirLS = {
		dialyzerEnabled = false,
		fetchDeps = false,
	},
})
]]
