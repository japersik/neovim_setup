return {
	"rhysd/vim-clang-format",
	init = function()
		vim.cmd([[
			autocmd FileType proto ClangFormatAutoEnable

			autocmd FileType c ClangFormatAutoEnable
			autocmd FileType h ClangFormatAutoEnable
		]])
	end,
	config = function()
    vim.g["clang_format#style_options"] = {
      AccessModifierOffset = -6,
      AllowShortIfStatementsOnASingleLine = false,
      AlwaysBreakTemplateDeclarations = false,
      BreakStringLiterals = false,
      ColumnLimit = 120,
      Standard = "C++11",
    }
  end,
}
