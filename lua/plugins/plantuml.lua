return {

	'weirongxu/plantuml-previewer.vim',
	dependencies = {
		{ 'tyru/open-browser.vim' },
		{ 'aklt/plantuml-syntax', lazy = false }
	},
	cmd = { 'PlantumlStart', 'PlantumlStop', 'PlantumlOpen', 'PlantumlSave' },
	config = function()
		vim.g.my_jar_path = vim.fn.stdpath("data") .. "/opt/homebrew/Cellar/plantuml/1.2024.6/libexec/plantuml.jar"
		vim.cmd([[
        autocmd FileType plantuml let g:plantuml_previewer#plantuml_jar_path = g:my_jar_path
        let g:plantuml_previewer#save_format = "png"
        let g:plantuml_previewer#debug_mode = 1
      ]])
	end
}
