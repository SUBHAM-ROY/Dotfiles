return {
	"folke/flash.nvim",
	event = "VeryLazy",
	opts = {
		modes = {
			char = {
				highlight = { backdrop = false },
			},
		},
	},
	keys = {
		{
			"<leader>j",
			function()
				require("flash").jump()
			end,
			desc = "Flash Jump",
		},
	},
}
