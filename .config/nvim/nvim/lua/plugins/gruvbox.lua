return {
	"ellisonleao/gruvbox.nvim",
	priority = 1000,
	lazy = false,
	config = function()
		require("gruvbox").setup({
			overrides = {
				LineNr = { bg = "#1d2021", fg = "#665c54" },
				SignColumn = { bg = "#1d2021" },
			},
		})
		vim.cmd("colorscheme gruvbox")
	end,
}
