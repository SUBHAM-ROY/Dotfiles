return {
	"zbirenbaum/copilot.lua",
	opts = {
        filetypes = {
            markdown = true,
        },
		suggestion = {
			auto_trigger = true,
			keymap = {
				accept = "<C-l>",
				accept_word = "<C-]>",
				accept_line = "<C-\\>",
				dismiss = false,
			},
		},
	},
}
