return {
	"olimorris/codecompanion.nvim",
	opts = {
		strategies = {
			chat = {
				adapter = {
					name = "copilot",
					model = "claude-sonnet-4",
				},
				roles = {
					user = "Subham",
				},
			},
		},
	},
	dependencies = {
		"nvim-lua/plenary.nvim",
		"nvim-treesitter/nvim-treesitter",
	},
	keys = {
		{ "<leader>cc", "<cmd>CodeCompanionChat Toggle<cr>", desc = "Code Companion Chat" },
		{ mode = { "n", "v" }, "<leader>ca", "<cmd>CodeCompanionChat Add<cr>", desc = "Code Companion Add" },
		{ mode = { "n", "v" }, "<leader>cl", ":'<,'>CodeCompanion<cr>", desc = "Code Companion Inline" },
	},
}
