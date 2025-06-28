return {
	"nvim-treesitter/nvim-treesitter",
	branch = "master",
	event = VeryLazy,
	build = ":TSUpdate",
	config = function()
		require("nvim-treesitter.configs").setup({
			ensure_installed = { "lua", "typescript", "tsx", "markdown", "python" },
			sync_install = true,
			highlight = {
				enable = true,
			},
			incremental_selection = {
				enable = true,
				keymaps = {
					init_selection = "<leader><TAB>", -- start smart selection
					node_incremental = "<TAB>", -- expand to bigger node
					scope_incremental = "<S-TAB>", -- expand to scope level (less used)
					node_decremental = "<BS>", -- shrink back
				},
			},
		})
	end,
}
