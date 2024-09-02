return {
	"leoluz/nvim-dap-go",
	keys = {
		{ "<leader>dt",  function() require("dap-go").debug_test() end,      desc = "Debug test under cursor", noremap = true },
		{ "<leader>dlt", function() require("dap-go").debug_last_test() end, desc = "Debud last test",         noremap = true },
	},
	config = function()
		require('dap-go').setup {
			tests = {
				-- enables verbosity when running the test.
				verbose = true,
			},
		}
	end
}
