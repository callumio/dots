local builtin = require("telescope.builtin")
vim.keymap.set("n", "<S-Tab>", builtin.find_files, {})
vim.keymap.set("n", "<leader>fg", builtin.live_grep, {})
vim.keymap.set("n", "<Tab>", builtin.buffers, {})
vim.keymap.set("n", "<leader>fh", builtin.help_tags, {})

vim.api.nvim_set_keymap("n", "<C-Bslash>", ":split<CR>", { noremap = true })
vim.api.nvim_set_keymap("n", "<C-_>", ":vsplit<CR>", { noremap = true })
vim.api.nvim_set_keymap("n", "<BS>", ":noh<CR>", { noremap = false })

vim.api.nvim_set_keymap("n", "<C-H>", "<C-W><C-H>", { noremap = true })
vim.api.nvim_set_keymap("n", "<C-J>", "<C-W><C-J>", { noremap = true })
vim.api.nvim_set_keymap("n", "<C-K>", "<C-W><C-K>", { noremap = true })
vim.api.nvim_set_keymap("n", "<C-L>", "<C-W><C-L>", { noremap = true })

vim.api.nvim_set_keymap("n", "-", "<CMD>Oil<CR>", { noremap = true, desc = "Open parent directory" })

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

vim.opt.swapfile = true
vim.opt.backup = false
vim.opt.undodir = os.getenv("HOME") .. "/.cache/undo"
vim.opt.undofile = true
