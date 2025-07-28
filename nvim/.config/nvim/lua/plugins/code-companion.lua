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
		prompt_library = {
			["Git PR Description"] = {
				strategy = "chat",
				description = "Generate PR description from git diff between HEAD and master",
				prompts = {
					{
						role = "system",
						content = "You are an expert at analyzing git diffs and writing clear, comprehensive pull request descriptions. You excel at organizing changes by file and providing specific details about modifications.",
					},
					{
						role = "user",
						content = "Please analyze the git diff between HEAD and master branch using @{cmd_runner} tool and create a structured PR description. Format it as follows:\n\n1. Start with a brief summary of the overall changes\n2. Group changes by filename using headers (## filename)\n3. Under each file header, list the specific changes as bullet points\n4. Include function names, class names, and other specific identifiers where relevant\n5. Be concise but descriptive about what each change accomplishes\n\nReturn only the formatted PR description without markdown code blocks.",
					},
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
		{ mode = { "v" }, "<leader>cA", "<cmd>CodeCompanionChat Add<cr>", desc = "Code Companion Add" },
		{ "<leader>ca", "<cmd>CodeCompanionActions<cr>", desc = "Code Companion Actions" },
		{ mode = { "n", "v" }, "<leader>cl", ":'<,'>CodeCompanion<cr>", desc = "Code Companion Inline" },
	},
}
