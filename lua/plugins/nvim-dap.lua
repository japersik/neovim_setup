return {
	"mfussenegger/nvim-dap",
	recommended = true,
	desc = "Debugging support. Requires language specific adapters to be configured. (see lang extras)",

	dependencies = {
		"rcarriga/nvim-dap-ui",
		"Weissle/persistent-breakpoints.nvim",
		-- virtual text for the debugger
		{ "theHamsta/nvim-dap-virtual-text", opts = {}, },
		{ "williamboman/mason.nvim",         opts = { ensure_installed = { "delve" } }, },
		"leoluz/nvim-dap-go",
	},

	-- stylua: ignore
	keys = {
		{ "<leader>d",  "",                                                                       desc = "+debug",           mode = { "n", "v" } },

		--
		{ "<leader>db", function() require("persistent-breakpoints.api").toggle_breakpoint() end, desc = "Toggle Breakpoint" },

		--
		{ "<leader>dc", function() require("dap").continue() end,                                 desc = "Continue" },
		{ "<leader>dg", function() require("dap").run_to_cursor() end,                            desc = "Run to Cursor" },
		{ "<leader>dp", function() require("dap").pause() end,                                    desc = "Pause" },
		--
		{ "<leader>di", function() require("dap").step_into() end,                                desc = "Step Into" },
		{ "<leader>do", function() require("dap").step_out() end,                                 desc = "Step Out" },
		{ "<leader>dO", function() require("dap").step_over() end,                                desc = "Step Over" },
		{ "<leader>dj", function() require("dap").down() end,                                     desc = "Down" },
		{ "<leader>dk", function() require("dap").up() end,                                       desc = "Up" },
		-- { "<leader>dl", function() require("dap").run_last() end, desc = "Run Last" },
		-- { "<leader>ds", function() require("dap").session() end, desc = "Session" },
		-- { "<leader>dt", function() require("dap").terminate() end, desc = "Terminate" },
		-- { "<leader>dg", function() require("dap").goto_() end, desc = "Go to Line (No Execute)" },
		-- { "<leader>dw", function() require("dap.ui.widgets").hover() end, desc = "Widgets" },
		-- { "<leader>dB", function() require("dap").set_breakpoint(vim.fn.input('Breakpoint condition: ')) end, desc = "Breakpoint Condition" },
		-- { "<leader>dr", function() require("dap").repl.toggle() end, desc = "Toggle REPL" },
		-- { "<leader>da", function() require("dap").continue({ before = get_args }) end, desc = "Run with Args" },
	},

	config = function()
		-- load mason-nvim-dap here, after all adapters have been setup
		require("mason-nvim-dap")

		vim.api.nvim_set_hl(0, "DapStoppedLine", { default = true, link = "Visual" })
		-- setup dap config by VsCode launch.json file
		local vscode = require("dap.ext.vscode")
		local json = require("plenary.json")
		vscode.json_decode = function(str)
			return vim.json.decode(json.json_strip_comments(str))
		end

		-- Extends dap.configurations with entries read from .vscode/launch.json
		if vim.fn.filereadable(".vscode/launch.json") then
			vscode.load_launchjs()
		end
	end,
}
