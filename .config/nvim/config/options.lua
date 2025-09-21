--24-bit colors
vim.opt.termguicolors = true

--Required by Vundle
vim.opt.filetype = "off"

--Don't create swapfiles
vim.opt.swapfile = false

--Enable smart indenting
vim.opt.smartindent = true

--Disable mouse
vim.opt.mouse = ""

-- Persistent undo
-- Save undo's after file closes^
vim.opt.undofile = true
-- Where to save undo histories
vim.opt.undodir = vim.fn.expand("$HOME/.vim/undo")
-- How many undos
vim.opt.undolevels = 1000
-- Number of lines to save for undo
vim.opt.undoreload = 10000

--Tabbing
vim.opt.complete = ".,w,b,u,U,t,i,d"
vim.opt.completeopt:remove("preview")
--<Tab> == two spaces
vim.opt.tabstop = 2
vim.opt.softtabstop = 0
vim.opt.expandtab = true
--The number--of spaces to use for indenting.
vim.opt.shiftwidth = 2

--And normal numbers
vim.opt.number = true
--Relative line numbers, can't live without them!
vim.opt.relativenumber = true
--Support modelines
vim.opt.modeline = true
--Don't wrap long lines
vim.opt.wrap = false
--Keep 10 lines on the screen
vim.opt.scrolloff = 10
--Show invisible characters
vim.opt.list = true
vim.opt.listchars = "tab:| ,trail:·"

--Add highlight at 80 and 110 chars
vim.opt.colorcolumn = "80,110"

--Don't close buffer when opening new files.
vim.opt.hidden = true

--Color the entire line the cursor is on
vim.opt.cursorline = true

--Disable folding of code
vim.opt.foldenable = false

--Always show the sign column. Prevents gitgutter and syntastic from making the
--text jump.
--[[
vim.api.nvim_create_autocmd({ "BufEnter" }, {
	pattern = { "*" },
	command = "execute sign define dummy",
})
vim.api.nvim_create_autocmd({ "BufEnter" }, {
	pattern = { "*" },
	command = "execute sign place 9999 line=1 name=dummy buffer=" .. vim.api.nvim_get_current_buf(),
})
]]

--Save history

local history_group = vim.api.nvim_create_augroup("nvimrc_aucmd", { clear = true })
vim.api.nvim_create_autocmd({ "FocusGained" }, {
	pattern = { "*" },
	group = history_group,
	command = "rshada",
})
vim.api.nvim_create_autocmd({ "FocusLost" }, {
	pattern = { "*" },
	group = history_group,
	command = "wshada",
})

vim.cmd.highlight({ "link", "NonASCII", "Error" })
vim.api.nvim_create_autocmd({ "Syntax" }, {
	pattern = { "*" },
	group = history_group,
	command = ':syntax match NonASCII "[^d0-d127]"',
})
