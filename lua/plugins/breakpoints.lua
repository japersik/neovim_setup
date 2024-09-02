return {
	-- Neovim plugin for persistent breakpoints
	"Weissle/persistent-breakpoints.nvim",
	config = function(_, _)
		-- Allows breakpoints to last between sessions
		require('persistent-breakpoints').setup {
			-- when to load the breakpoints? "BufReadPost" is recommanded.
			load_breakpoints_event = "BufReadPost",
		}
	end
}
