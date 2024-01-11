require("cloak").setup({
	enabled = true,
	cloak_character = "*",
	hightlight_group = "Comment",
	patterns = {
		{
			file_pattern = {
				".env*",
				".dev.vars",
			},
			cloak_pattern = "=.+",
		},
	},
})
