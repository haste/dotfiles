local conform = require("conform")

local slow_format_filetypes = {}

local javascript = { "biome", "prettier", stop_after_first = true }

conform.setup({
	formatters_by_ft = {
		css = javascript,
		elixir = { "mix" },
		javascript = javascript,
		javascriptreact = javascript,
		lua = { "stylua" },
		python = { "black" },
		scss = javascript,
		typescript = javascript,
		typescriptreact = javascript,
	},
	format_on_save = function(bufnr)
		if slow_format_filetypes[vim.bo[bufnr].filetype] then
			return
		end
		local function on_format(err)
			if err and err:match("timeout$") then
				slow_format_filetypes[vim.bo[bufnr].filetype] = true
			end
		end

		return { timeout_ms = 200, lsp_format = "fallback" }, on_format
	end,

	format_after_save = function(bufnr)
		if not slow_format_filetypes[vim.bo[bufnr].filetype] then
			return
		end
		return { lsp_format = "fallback" }
	end,
})

vim.api.nvim_create_autocmd("BufWritePre", {
	pattern = "*",
	callback = function(args)
		conform.format({ bufnr = args.buf })
	end,
})
