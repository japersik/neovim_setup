require("config.lazy")
require("config.default")

--[[
local readme_group = vim.api.nvim_create_augroup("AutoOpenReadme", { clear = true })

vim.api.nvim_create_autocmd("VimEnter", {
	group = readme_group,
	callback = function()
		local arg = vim.fn.argv(0)

		if arg ~= "" and vim.fn.isdirectory(arg) == 1 then
			local readme_variants = { "README.md", "readme.md", "README.txt", "README" }

			for _, name in ipairs(readme_variants) do
				local readme_path = arg .. "/" .. name

				if vim.fn.filereadable(readme_path) == 1 then
					vim.cmd("edit " .. vim.fn.fnameescape(readme_path))

					-- Если открылся именно Markdown-файл, запускаем превью в браузере
					if name:match("%.md$") then
						-- Даем небольшую задержку в 200мс, чтобы плагин успел инициализироваться
						vim.defer_fn(function()
							--				vim.cmd("MarkdownPreview")
						end, 200)
					end

					break
				end
			end
		end
	end,
})
]]
