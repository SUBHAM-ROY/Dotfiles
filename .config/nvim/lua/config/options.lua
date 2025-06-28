vim.o.number = true -- Show line numbers
vim.o.cursorline = true -- Show current line highlights
--vim.o.relativenumber=true -- Show relative numbers from current
vim.o.splitright = true -- Split vertical on right
vim.o.splitbelow = true -- Split horizontal on bottom
vim.o.clipboard = "unnamedplus" -- Shared clipboard

vim.o.expandtab = true -- Convert tabs to spaces
vim.o.shiftwidth = 4 -- Use 4 spaces for autoindent
vim.o.tabstop = 4 -- Display tabs as 4 spaces
vim.o.softtabstop = 4 -- Insert 4 spaces when you hit Tab
vim.o.smartindent = true -- Smart indenting
vim.o.autoindent = true -- Keep indent from current line
vim.o.breakindent = true -- Keep indent on wrapped lines

vim.wo.foldmethod = "expr"
vim.wo.foldexpr = "v:lua.vim.treesitter.foldexpr()"
vim.wo.foldenable = false
vim.wo.foldlevel = 99

-- Make Vim windows transparent
vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
