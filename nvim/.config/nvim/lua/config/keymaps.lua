local opts = { noremap = true, silent = true }

vim.keymap.set("n", "<Esc>", ":noh<CR><Esc>", opts) -- Clear search highlights and exit insert mode
vim.keymap.set({ "n", "i" }, "<C-s>", "<Esc>:w<CR>", opts) -- Save file with Ctrl+s
vim.keymap.set("n", "<leader>q", ":q<CR>", opts) -- Quit current window with <leader>q
vim.keymap.set("n", "<leader>Q", ":qall<CR>", opts) -- Quit all windows with <leader>Q
vim.keymap.set("n", "<leader>w", ":bdelete<CR>", opts) -- Close current buffer with <leader>w
vim.keymap.set("n", "<C-u>", "<C-u>zz", opts) -- Scroll up and center the cursor
vim.keymap.set("n", "<C-d>", "<C-d>zz", opts) -- Scroll down and center the cursor
vim.keymap.set("n", "<C-j>", "5jzz", opts) -- Move down 5 lines and center the cursor
vim.keymap.set("n", "<C-k>", "5kzz", opts) -- Move up 5 lines and center the cursor
vim.keymap.set("n", "<C-h>", "5h", opts) -- Move left 5 characters
vim.keymap.set("n", "<C-l>", "5l", opts) -- Move right 5 characters

-- Quickly jump to marks
for i = 0, 9 do
	vim.keymap.set("n", "<space>" .. i, "`" .. i, opts)
end
