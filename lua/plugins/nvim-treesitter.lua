return {
	"nvim-treesitter/nvim-treesitter",
	build = ":TSUpdate",
	dependencies = {
		{ "nvim-treesitter/nvim-treesitter-textobjects" }, -- Syntax aware text-objects
		{
			"nvim-treesitter/nvim-treesitter-context", -- Show code context
			opts = { enable = true, mode = "topline", line_numbers = true }
		}
	},
	config = function()
		local treesitter = require("nvim-treesitter.configs")

		vim.api.nvim_create_autocmd("FileType", {
			pattern = { "markdown" },
			callback = function(_)
				-- treesitter-context is buggy with Markdown files
				require("treesitter-context").disable()
			end
		})
		vim.api.nvim_create_autocmd("FileType", {
			pattern = "yaml",
			callback = function()
				vim.opt_local.expandtab = true -- Use spaces instead of tabs
				vim.opt_local.tabstop = 2 -- A tab counts as 2 spaces
				vim.opt_local.shiftwidth = 2 -- Auto-indent uses 2 spaces
				vim.opt_local.softtabstop = 2 -- Backspace/tab key deletes/inserts 2 spaces
			end,
		})
		treesitter.setup({
			ensure_installed = {
				"c", "cpp",
				"csv", "dockerfile", "gitignore", "go", "gomod", "gosum",
				"gowork", "javascript", "json", "lua", "markdown", "proto",
				"python", "rego", "ruby", "sql", "svelte", "yaml", "php"
			},
			indent = { enable = true },
			auto_install = true,
			sync_install = false,
			highlight = {
				enable = true,
				disable = { "csv" } -- preferring chrisbra/csv.vim
			},
			textobjects = { select = { enable = true, lookahead = true } }
		})
	end
}
