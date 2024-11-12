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

		require('dap').set_log_level('DEBUG')
		
		vim.api.nvim_set_hl(0, "DapStoppedLine", { default = true, link = "Visual" })
		
		dap = require("dap")

		dap.adapters.gdb = {
			id = 'gdb',
    	type = 'executable',
    	command = 'xtensa-esp32-elf-gdb', -- Убедитесь, что это правильно указывает на ваш GDB
    	name = 'gdb',
			args = {  '--interpreter=dap', "--eval-command", "target remote localhost:3333"},
		}

-- Настройка конфигурации для запуска GDB
		dap.configurations.c = {
    	{
    		name = "Launch",
    		type = "gdb", -- Указываем, что используем адаптер "cpp"
    		request = "launch",
    		program = function()
      		return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
    		end,
    		cwd = '${workspaceFolder}',
    		stopOnEntry = true,
    		args = {},
    		miDebuggerPath = '/home/japersik/.espressif/tools/xtensa-esp-elf-gdb/14.2_20240403/xtensa-esp-elf-gdb/bin/xtensa-esp32-elf-gdb', -- путь к gdb
			}
}
	end
}
