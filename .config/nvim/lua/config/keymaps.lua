local opts = { noremap = true, silent = true }

vim.keymap.set("n", "<Esc>", ":noh<CR><Esc>", opts)
vim.keymap.set({ "n", "i" }, "<C-s>", "<Esc>:w<CR>", opts)
vim.keymap.set("n", "<leader>q", ":q<CR>", opts)
vim.keymap.set("n", "<leader>Q", ":qall<CR>", opts)
vim.keymap.set("n", "<leader>w", ":bdelete<CR>", opts)
vim.keymap.set("n", "<C-u>", "<C-u>zz", opts)
vim.keymap.set("n", "<C-d>", "<C-d>zz", opts)
vim.keymap.set("n", "<C-j>", "5jzz", opts)
vim.keymap.set("n", "<C-k>", "5kzz", opts)
vim.keymap.set("n", "<C-h>", "5h", opts)
vim.keymap.set("n", "<C-l>", "5l", opts)
