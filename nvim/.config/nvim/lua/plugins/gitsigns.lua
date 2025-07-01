return {
	"lewis6991/gitsigns.nvim",
	opts = {
		current_line_blame = true,
		current_line_blame_opts = {
			delay = 300,
		},
		current_line_blame_formatter = "    <author>, <author_time:%R>, <abbrev_sha> - <summary>",
		current_line_blame_formatter_nc = "    You, <author_time:%R>, Not commited yet",
	},
	event = "VeryLazy",
	keys = {
		{ "]h", ":Gitsigns next_hunk<CR>", desc = "Next Git hunk" },
		{ "[h", ":Gitsigns prev_hunk<CR>", desc = "Previous Git hunk" },
		{ "<leader>Gh", ":Gitsigns preview_hunk<CR>", desc = "Preview Git hunk" },
		{ "<leader>Gd", ":Gitsigns diffthis<CR>", desc = "Diff this hunk" },
		{ "<leader>Gb", ":Gitsigns blame_line<CR>", desc = "Git blame line" },
		{ "<leader>Gs", ":Gitsigns stage_hunk<CR>", desc = "Stage Git hunk" },
		{ "<leader>Gu", ":Gitsigns undo_stage_hunk<CR>", desc = "Unstage Git hunk" },
	},
	init = function()
		vim.cmd([[
      highlight GitSignsCurrentLineBlame guifg=#928374 gui=italic
    ]])
	end,
}
