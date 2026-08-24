return {
	"ray-x/go.nvim",
	branch = "nvim_0.11",
	dependencies = { -- optional packages
		"ray-x/guihua.lua",
		"neovim/nvim-lspconfig",
		"nvim-treesitter/nvim-treesitter",
	},
	config = function()
		require("go").setup({
			build_tags = "e2e,integration",
		}
		)

		--[[local format_sync_grp = vim.api.nvim_create_augroup("GoFormat", {})
		vim.api.nvim_create_autocmd("BufWritePre", {
			pattern = "*.go",
			callback = function()
				require('go.format').goimports()
			end,
			group = format_sync_grp,
		})
		]]
	end,
	event = { "CmdlineEnter" },
	ft = { "go", 'gomod' },
	build = ':lua require("go.install").update_all_sync()' -- if you need to install/update all binaries
}

--[[
return
{
	"ray-x/go.nvim",
	dependencies = { -- optional packages
		"ray-x/guihua.lua",
		"neovim/nvim-lspconfig",
		-- { "nvim-treesitter/nvim-treesitter", branch = 'main' } -- optional for master version
	},
	opts = function()
		require("go").setup({
			build_tags = "e2e,integration",
		}
		)
		local format_sync_grp = vim.api.nvim_create_augroup("GoFormat", {})
		vim.api.nvim_create_autocmd("BufWritePre", {
			pattern = "*.go",
			callback = function()
				require('go.format').goimports()
			end,
			group = format_sync_grp,
		})
		return {
			-- lsp_keymaps = false,
			-- other options
		}
	end,
	event = { "CmdlineEnter" },
	ft = { "go", 'gomod' },
	build = ':lua require("go.install").update_all_sync()' -- if you need to install/update all binaries
}
]]
