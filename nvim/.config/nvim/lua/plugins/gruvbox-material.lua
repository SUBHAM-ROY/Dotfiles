return {
	"sainnhe/gruvbox-material",
	lazy = false,
	priority = 1000,
	config = function()
		vim.g.gruvbox_material_enable_italic = true
		vim.g.gruvbox_material_foreground = "mix"
		vim.g.gruvbox_material_diagnostic_virtual_text = "colored"
		vim.cmd.colorscheme("gruvbox-material")
		vim.api.nvim_set_hl(0, "LineNr", { fg = "#665c54", bg = "#1d2021" })
	end,
}
