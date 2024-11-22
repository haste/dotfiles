local lint = require("lint")

lint.linters_by_ft = {
	elixir = { "credo" },
	fish = { "fish" },
	javascript = { "biomejs", "eslint" },
	python = { "ruff", "flake8" },
}

vim.api.nvim_create_autocmd({ "BufWritePost" }, {
	callback = function()
		pcall(lint.try_lint)
	end,
})
