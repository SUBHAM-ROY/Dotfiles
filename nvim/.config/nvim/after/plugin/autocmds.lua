-- Highlight yanked text
vim.api.nvim_set_hl(0, "YankHighlight", { bg = "#928374" })
vim.api.nvim_create_autocmd("TextYankPost", {
	callback = function()
		vim.highlight.on_yank({ higroup = "YankHighlight", timeout = 500 })
	end,
})
