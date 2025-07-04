return {
	"folke/flash.nvim",
	event = "VeryLazy",
	opts = {},
	init = function()
		require("flash").toggle(true)
	end,
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
