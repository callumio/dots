local dap = require("dap")
local dapui = require("dapui")
local dapvtext = require("nvim-dap-virtual-text")
local telescope = require("telescope").extensions.dap

dapui.setup()
dapvtext.setup()

dap.listeners.before.attach.dapui_config = function()
	dapui.open()
end

dap.listeners.before.launch.dapui_config = function()
	dapui.open()
end

dap.listeners.before.event_terminated.dapui_config = function()
	dapui.close()
end

dap.listeners.before.event_exited.dapui_config = function()
	dapui.close()
end

vim.keymap.set("n", "<leader>vdb", dap.toggle_breakpoint, {})
vim.keymap.set("n", "<leader>vdv", telescope.variables, {})
vim.keymap.set("n", "<leader>vdf", telescope.frames, {})
vim.keymap.set("n", "<leader>vdc", dap.continue, {})
