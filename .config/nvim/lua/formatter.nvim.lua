local util = require("formatter.util")
local formatterJavascript = require("formatter.filetypes.javascript")

local javascript = {
	formatterJavascript.biome,
	formatterJavascript.prettiereslint,
	formatterJavascript.prettier,
}

-- The default setup is broken currently
local mixformat = function()
	local args
	local supports_stdin_filename = string.match(vim.fn.system("mix format --stdin-filename"), "Missing argument")

	if supports_stdin_filename ~= nil then
		args = { "format", "-", "--stdin-filename", util.escape_path(util.get_current_buffer_file_path()) }
	else
		args = { "format", "-" }
	end

	return { exe = "mix", args = args, stdin = true, cwd = vim.fn.expand("%:p:h") }
end

-- Provides the Format, FormatWrite, FormatLock, and FormatWriteLock commands
require("formatter").setup({
	-- Enable or disable logging
	logging = true,
	-- Set the log level
	log_level = vim.log.levels.WARN,
	-- All formatter configurations are opt-in
	filetype = {
		elixir = { mixformat() },
		javascript = javascript,
		javascriptreact = javascript,
		lua = { require("formatter.filetypes.lua").stylua },
		python = { require("formatter.filetypes.python").black },
		typescript = javascript,
		typescriptreact = javascript,
	},
})

local augroup = vim.api.nvim_create_augroup
local autocmd = vim.api.nvim_create_autocmd
augroup("__formatter__", { clear = true })
autocmd("BufWritePost", {
	group = "__formatter__",
	command = ":FormatWrite",
})
