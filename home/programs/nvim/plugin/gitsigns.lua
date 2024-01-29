require("gitsigns").setup({
	on_attach = function(bufnr)
		local gs = package.loaded.gitsigns
		local bufmap = function(keys, func)
			vim.keymap.set("n", keys, func, { buffer = bufnr })
		end

		bufmap("<leader>vgb", gs.toggle_current_line_blame)
	end,
})
