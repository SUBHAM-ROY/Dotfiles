return {
	{
		"CopilotC-Nvim/CopilotChat.nvim",
		dependencies = {
			{ "zbirenbaum/copilot.lua" },
			{ "nvim-lua/plenary.nvim" },
		},
		build = "make tiktoken",
		opts = {},
		keys = {
			{ "<leader>cc", "<cmd>CopilotChatToggle<cr>", desc = "Copilot Chat" },
		},
	},
}
