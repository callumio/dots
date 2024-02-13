vim.api.nvim_set_keymap("n", "<C-Bslash>", ":split<CR>", { noremap = true })
vim.api.nvim_set_keymap("n", "<C-_>", ":vsplit<CR>", { noremap = true })
vim.api.nvim_set_keymap("n", "<BS>", ":noh<CR>", { noremap = false })

vim.api.nvim_set_keymap("n", "<C-H>", "<C-W><C-H>", { noremap = true })
vim.api.nvim_set_keymap("n", "<C-J>", "<C-W><C-J>", { noremap = true })
vim.api.nvim_set_keymap("n", "<C-K>", "<C-W><C-K>", { noremap = true })
vim.api.nvim_set_keymap("n", "<C-L>", "<C-W><C-L>", { noremap = true })

vim.o.clipboard = "unnamedplus"

vim.o.number = true
vim.o.relativenumber = true

vim.o.signcolumn = "yes"

vim.o.tabstop = 2
vim.o.shiftwidth = 2

vim.o.updatetime = 300

vim.o.termguicolors = true

vim.o.mouse = "n"

vim.o.splitright = true
vim.o.splitbelow = true

vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undodir = os.getenv("HOME") .. "/.cache/undo"
vim.opt.undofile = true

local notify = vim.notify
vim.notify = function(msg, ...)
	if msg:match("warning: multiple different client offset_encodings") then
		return
	end

	notify(msg, ...)
end
