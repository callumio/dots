local lsp_on_attach = function(client, bufnr)
	local bufmap = function(keys, func)
		vim.keymap.set("n", keys, func, { buffer = bufnr })
	end

	bufmap("K", vim.lsp.buf.hover)
	bufmap("gd", vim.lsp.buf.definition)
	bufmap("gD", vim.lsp.buf.declaration)
	bufmap("<leader>vsw", require("telescope.builtin").lsp_dynamic_workspace_symbols)
	bufmap("<leader>vsd", require("telescope.builtin").lsp_document_symbols)
	bufmap("<leader>vd", require("telescope.builtin").diagnostics)
	bufmap("[d", vim.diagnostic.goto_next)
	bufmap("]d", vim.diagnostic.goto_prev)
	bufmap("<leader>vca", vim.lsp.buf.code_action)
	bufmap("<leader>vrr", require("telescope.builtin").lsp_references)
	bufmap("<leader>vts", require("telescope.builtin").treesitter)
	bufmap("<leader>vrn", vim.lsp.buf.rename)
	bufmap("<C-h>", vim.lsp.buf.signature_help)

	vim.api.nvim_buf_create_user_command(bufnr, "Format", function(_)
		vim.lsp.buf.format()
	end, {})

	if client.server_capabilities.inlayHintProvider then
		vim.lsp.inlay_hint.enable(bufnr, true)
	end
end
