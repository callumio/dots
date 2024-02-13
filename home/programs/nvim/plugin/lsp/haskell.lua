vim.g.haskell_tools = {
	hls = {
		on_attach = function(client, bufnr, ht)
			lsp_on_attach(client, bufnr)
		end,
	},
}
