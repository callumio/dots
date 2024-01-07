local on_attach = function(_, bufnr)
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
end

local lspconfig = require("lspconfig")

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require("cmp_nvim_lsp").default_capabilities(capabilities)

require("neodev").setup()
lspconfig.lua_ls.setup({
	on_attach = on_attach,
	capabilities = capabilities,
	root_dir = function()
		return vim.loop.cwd()
	end,
	cmd = { "lua-language-server" },
	settings = {
		Lua = {
			workspace = { checkThirdParty = false },
			telemetry = { enable = false },
		},
	},
})

lspconfig.rnix.setup({
	on_attach = on_attach,
	capabilities = capabilities,
})

lspconfig.clangd.setup({ on_attach = on_attach, capabilities = capabilities })
lspconfig.pyright.setup({ on_attach = on_attach, capabilities = capabilities })
lspconfig.rust_analyzer.setup({ on_attach = on_attach, capabilities = capabilities })
lspconfig.rust_analyzer.setup({ on_attach = on_attach, capabilities = capabilities })
lspconfig.tsserver.setup({
	on_attach = on_attach,
	capabilities = capabilities,
	filetypes = { "typescript", "typescriptreact", "typescript.tsx" },
	cmd = { "typescript-language-server", "--stdio" },
})
