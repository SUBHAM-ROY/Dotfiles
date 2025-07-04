-- Highlight yanked text
vim.api.nvim_set_hl(0, "Visual", { bg = "#4a4a4a" })
vim.api.nvim_create_autocmd("TextYankPost", {
	callback = function()
		vim.highlight.on_yank({ higroup = "Visual", timeout = 500 })
	end,
})
