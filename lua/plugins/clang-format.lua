return {
	"rhysd/vim-clang-format",
	init = function()
		vim.cmd([[
			autocmd FileType proto ClangFormatAutoEnable
			autocmd FileType c ClangFormatAutoEnable
			autocmd FileType h ClangFormatAutoEnable
		]])
	end
}
