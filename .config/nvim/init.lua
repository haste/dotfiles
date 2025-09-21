local config = vim.fn.stdpath("config")

for _, file in pairs({
	config .. "/config/options.lua",
	config .. "/config/keys.lua",
	config .. "/config/plugins.lua",
	table.unpack(vim.split(vim.fn.glob("~/.config/nvim/plugin.d/*.lua"), "\n")),
}) do
	vim.cmd("source " .. file)
end

vim.cmd.colorscheme("dracula")
