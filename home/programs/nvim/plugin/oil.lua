require("oil").setup()
vim.api.nvim_set_keymap("n", "-", "<CMD>Oil<CR>", { noremap = true, desc = "Open parent directory" })
