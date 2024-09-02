return{
	"bluz71/vim-nightfly-colors",
        -- setup color scheme
        priority = 1000,
        config = function()
                vim.cmd([[colorscheme  nightfly]])
        end,
}
