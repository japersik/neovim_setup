return {
	"hrsh7th/nvim-cmp",
	dependencies = {
		"hrsh7th/cmp-nvim-lsp", -- cmp_nvim_lsp
		"neovim/nvim-lspconfig", -- lspconfig
		"onsails/lspkind-nvim", -- lspkind (VS pictograms)
		"ray-x/lsp_signature.nvim",
		{
			"L3MON4D3/LuaSnip",
			build = "make install_jsregexp",
			dependencies = { "rafamadriz/friendly-snippets" }, -- Snippets
			config = function()
				require("luasnip.loaders.from_vscode").lazy_load()
				-- https://github.com/rafamadriz/friendly-snippets/blob/main/snippets/go.json
			end
		}, { "saadparwaiz1/cmp_luasnip", enabled = true }
	},
	config = function()
		local luasnip = require("luasnip")
		local types = require("luasnip.util.types")

		-- Display virtual text to indicate snippet has more nodes
		luasnip.config.setup({
			ext_opts = {
				[types.choiceNode] = {
					active = { virt_text = { { "⇥", "GruvboxRed" } } }
				},
				[types.insertNode] = {
					active = { virt_text = { { "⇥", "GruvboxBlue" } } }
				}
			}
		})

		local cmp = require("cmp")
		local lspkind = require("lspkind")

		cmp.setup({
			snippet = {
				expand = function(args)
					luasnip.lsp_expand(args.body)
				end
			},
			window = {
				completion = cmp.config.window.bordered(),
				documentation = cmp.config.window.bordered()
			},
			mapping = cmp.mapping.preset.insert({
				["<C-b>"] = cmp.mapping.scroll_docs(-4),
				["<C-f>"] = cmp.mapping.scroll_docs(4),
				["<C-Space>"] = cmp.mapping.complete(),
				["<C-e>"] = cmp.mapping.abort(),
				["<CR>"] = cmp.mapping.confirm({ select = true }),
				["<Tab>"] = cmp.mapping(function(fallback)
					if cmp.visible() then
						cmp.select_next_item()
					elseif luasnip.locally_jumpable(1) then
						luasnip.jump(1)
					else
						fallback()
					end
				end, { "i", "s" })
			}),
			sources = cmp.config.sources({
				{ name = "nvim_lsp" }, { name = "luasnip" }, { name = "buffer" }
			}),
			formatting = {
				format = lspkind.cmp_format({
					mode = "symbol_text",
					maxwidth = 120,
					show_labelDetails = true
				})
			}
		})


		-- setup custom lsp configs
		local lspconfig = vim.lsp.config

		lspconfig("gopls", { settings = { buildFlags = { "-tags=integration,e2e" } } })
		-- enable capabilities by default
		--	lspconfig("*", { capabilities = require("cmp_nvim_lsp").default_capabilities() })
		lspconfig("clangd", { filetypes = { 'c', 'cpp', 'objc', 'objcpp', 'cuda' } })

		-- enable lsp plugins with default configs
		local lspenable = vim.lsp.enable

		-- -- All languages: https://github.com/neovim/nvim-lspconfig/blob/master/doc/configs.md
		-- Go: go install golang.org/x/tools/gopls@latest
		lspenable("gopls")
		-- Python: brew install pyright
		lspenable("pyright")
		-- https://github.com/bufbuild/buf/
		-- brew install bufbuild/buf/buf
		lspenable('buf_ls')
		--		vim.lsp.enable('vue_ls')
		--[[
		lspconfig("volar", {
			filetypes = { 'typescript', 'javascript', 'javascriptreact', 'typescriptreact', 'vue', 'json' },
			init_options = {
				typescript = {
					tsdk = vim.fn.expand("~/.npm-global/lib/node_modules/typescript/lib")
				}
			}
		})
		]] --
		-- installation https://clangd.llvm.org/installation.html
		lspenable("clangd")
		-- for bash,json,lua, md and yaml
		lspenable("bashls")
		lspenable("jsonls")
		lspenable("lua_ls")

		lspenable("sqls")
		lspconfig("postgres_lsp", { filetypes = { "sql" }, cmd = { "postgres-language-server", "lsp-proxy" } })
		lspenable("postgres_lsp")
		--	lspconfig["marksman"].setup {}
	end
}
