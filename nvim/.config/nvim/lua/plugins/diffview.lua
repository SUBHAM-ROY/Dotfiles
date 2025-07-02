return {
	"sindrets/diffview.nvim",
	lazy = true,
	keys = {
		{
			"<leader>D",
			":DiffviewOpen<CR>",
			desc = "Open Diffview",
		},
		{
			"<leader>dc",
			":DiffviewClose<CR>",
			desc = "Close Diffview",
		},
	},
}
