-- plugin for automatic closing of open brackets and quotes
return {
	'echasnovski/mini.pairs',
	version = false,

	config = function()
		require('mini.pairs').setup()
	end,
}
