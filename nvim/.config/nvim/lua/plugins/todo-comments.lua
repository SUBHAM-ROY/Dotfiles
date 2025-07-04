return {
	"folke/todo-comments.nvim",
	dependencies = { "nvim-lua/plenary.nvim" },
	opts = {},
	keys = {
		{ "<leader>xt", "<cmd>TodoTrouble<cr>", desc = "Todo Trouble" },
		{
			"<leader>st",
			function()
				Snacks.picker.todo_comments()
			end,
			desc = "Todo Comments",
		},
	},
}
