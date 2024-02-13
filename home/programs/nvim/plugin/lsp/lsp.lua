local lspconfig = require("lspconfig")

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require("cmp_nvim_lsp").default_capabilities(capabilities)

require("neodev").setup()
lspconfig.lua_ls.setup({
	on_attach = lsp_on_attach,
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

lspconfig.rnix.setup({ on_attach = lsp_on_attach, capabilities = capabilities })
lspconfig.clangd.setup({ on_attach = lsp_on_attach, capabilities = capabilities })
lspconfig.pyright.setup({ on_attach = lsp_on_attach, capabilities = capabilities })
-- lspconfig.rust_analyzer.setup({ on_attach = lsp_on_attach, capabilities = capabilities })
-- lspconfig.hls.setup({ on_attach = lsp_on_attach, capabilities = capabilities })
lspconfig.tsserver.setup({
	on_attach = lsp_on_attach,
	capabilities = capabilities,
	filetypes = { "typescript", "javascript", "typescriptreact", "typescript.tsx" },
	cmd = { "typescript-language-server", "--stdio" },
})
lspconfig.dockerls.setup({ on_attach = lsp_on_attach, capabilities = capabilities })
lspconfig.docker_compose_language_service.setup({ on_attach = lsp_on_attach, capabilities = capabilities })
