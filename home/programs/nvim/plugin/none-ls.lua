local null_ls = require("null-ls")
local augroup = vim.api.nvim_create_augroup("LspFormatting", {})

local lsp_formatting = function(bufnr)
	vim.lsp.buf.format({
		filter = function(client)
			return client.name == "null-ls"
		end,
		bufnr = bufnr,
	})
end

local on_attach = function(client, bufnr)
	if client.supports_method("textDocument/formatting") then
		vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
		vim.api.nvim_create_autocmd("BufWritePre", {
			group = augroup,
			buffer = bufnr,
			callback = function()
				lsp_formatting(bufnr)
			end,
		})
	end
end

null_ls.setup({
	sources = {
		null_ls.builtins.formatting.stylua,
		null_ls.builtins.diagnostics.selene.with({
			cwd = function(_params)
				return vim.fs.dirname(
					vim.fs.find({ "selene.toml" }, { upward = true, path = vim.api.nvim_buf_get_name(0) })[1]
				) or vim.fn.expand("~/.config") -- fallback value
			end,
		}),

		null_ls.builtins.formatting.clang_format,
		null_ls.builtins.diagnostics.clang_check,

		null_ls.builtins.formatting.shfmt,
		null_ls.builtins.diagnostics.shellcheck,
		null_ls.builtins.code_actions.shellcheck,

		null_ls.builtins.formatting.nixfmt,
		null_ls.builtins.code_actions.statix,
		null_ls.builtins.diagnostics.statix,

		null_ls.builtins.formatting.fourmolu,

		null_ls.builtins.formatting.eslint_d,

		null_ls.builtins.formatting.rustfmt,
	},
	on_attach = on_attach,
})
