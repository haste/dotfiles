--map escape to unfocus terminal
--Makes using fzf annoying..
--tnoremap <Esc> <C-\><C-n>

--Toggle folds with space
vim.keymap.set("n", "<space>", "za", { noremap = true })

--Swap ; and ; and save(!) our pinky.
vim.keymap.set("n", ";", ":", { noremap = true })
vim.keymap.set("n", ":", ";", { noremap = true })
vim.keymap.set("v", ";", ":", { noremap = true })
vim.keymap.set("v", ":", ";", { noremap = true })

-- Colemak setup

for _, mapping in pairs({
	-- Up/down/left/right
	{ modes = { "n", "o", "x" }, lhs = "n", rhs = "h", desc = "Left (h)" },
	{ modes = { "n", "o", "x" }, lhs = "u", rhs = "k", desc = "Up (k)" },
	{ modes = { "n", "o", "x" }, lhs = "e", rhs = "j", desc = "Down (j)" },
	{ modes = { "n", "o", "x" }, lhs = "i", rhs = "l", desc = "Right (l)" },
	-- Remappings
	{ modes = { "n", "o", "x" }, lhs = "h", rhs = "n" },
	{ modes = { "n", "o", "x" }, lhs = "k", rhs = "u" },
	{ modes = { "n", "o", "x" }, lhs = "j", rhs = "e" },
	{ modes = { "n", "o", "x" }, lhs = "l", rhs = "i" },
	{ modes = { "n", "o", "x" }, lhs = "H", rhs = "N" },
	{ modes = { "n", "o", "x" }, lhs = "K", rhs = "U" },
	{ modes = { "n", "o", "x" }, lhs = "J", rhs = "E" },
	{ modes = { "n", "o", "x" }, lhs = "L", rhs = "I" },
	{ modes = { "n", "o", "x" }, lhs = "N", rhs = "H" },
	{ modes = { "n", "o", "x" }, lhs = "U", rhs = "K" },
	{ modes = { "n", "o", "x" }, lhs = "E", rhs = "J" },
	{ modes = { "n", "o", "x" }, lhs = "I", rhs = "L" },

	-- Window navigation
	{ modes = { "n" }, lhs = "<C-w>n", rhs = "<C-w>h" },
	{ modes = { "n" }, lhs = "<C-w>u", rhs = "<C-w>k" },
	{ modes = { "n" }, lhs = "<C-w>e", rhs = "<C-w>j" },
	{ modes = { "n" }, lhs = "<C-w>i", rhs = "<C-w>l" },
	{ modes = { "n" }, lhs = "<C-w>N", rhs = "<C-w>H" },
	{ modes = { "n" }, lhs = "<C-w>U", rhs = "<C-w>K" },
	{ modes = { "n" }, lhs = "<C-w>E", rhs = "<C-w>J" },
	{ modes = { "n" }, lhs = "<C-w>I", rhs = "<C-w>L" },
}) do
	vim.keymap.set(mapping.modes, mapping.lhs, mapping.rhs, { desc = mapping.desc, noremap = true })
end
