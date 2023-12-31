local zen = require("zen-mode")

zen.setup({
	window = {
		width = 100,
		options = {},
	},
	plugins = {
		gitsigns = {
			enabled = true,
		},
		alacritty = {
			enabled = true,
		},
		tmux = {
			enabled = true,
		},
	},
})

vim.keymap.set("n", "<leader>zz", function()
	zen.toggle()
end)
