local opts = { noremap = true, silent = true }

-- Keymaps for normal mode
vim.keymap.set('n', '<Esc>', ':noh<CR><Esc>', opts) -- Clear search highlights and exit insert mode
vim.keymap.set({ 'n', 'i' }, '<C-s>', '<Esc>:w<CR>', opts) -- Save file with Ctrl+s
vim.keymap.set({ 'n', 'i' }, '<M-s>', vim.lsp.buf.signature_help, opts) -- Show LSP signature help with Alt+s
vim.keymap.set('n', '<leader>q', ':q<CR>', opts) -- Quit current window with <leader>q
vim.keymap.set('n', '<leader>Q', ':qall<CR>', opts) -- Quit all windows with <leader>Q
vim.keymap.set('n', '<leader>w', ':bdelete<CR>', opts) -- Close current buffer with <leader>w
vim.keymap.set('n', '<C-u>', '<C-u>zz', opts) -- Scroll up and center the cursor
vim.keymap.set('n', '<C-d>', '<C-d>zz', opts) -- Scroll down and center the cursor
vim.keymap.set('n', '<C-e>', '5<C-e>', opts) -- Scroll down 5 lines
vim.keymap.set('n', '<C-y>', '5<C-y>', opts) -- Scroll up 5 lines
vim.keymap.set({ 'n', 'v' }, '<C-j>', '5jzz', opts) -- Move down 5 lines and center the cursor
vim.keymap.set({ 'n', 'v' }, '<C-k>', '5kzz', opts) -- Move up 5 lines and center the cursor
vim.keymap.set({ 'n', 'v' }, '<C-h>', '5h', opts) -- Move left 5 characters
vim.keymap.set({ 'n', 'v' }, '<C-l>', '5l', opts) -- Move right 5 characters
vim.keymap.set('n', '<C-]>', '<C-]>zz', opts) -- Jump to definition and center the cursor

-- Keymaps for insert mode
vim.keymap.set({ 'i', 'c' }, 'jj', '<Esc>', opts) -- Exit insert and command mode with 'jj'
vim.keymap.set('i', '<M-j>', '<C-o>j', opts) -- Move down in insert mode with Alt+j
vim.keymap.set('i', '<M-k>', '<C-o>k', opts) -- Move up in insert mode with Alt+k
vim.keymap.set('i', '<M-h>', '<C-o>h', opts) -- Move left in insert mode with Alt+h
vim.keymap.set('i', '<M-l>', '<C-o>l', opts) -- Move right in insert mode with Alt+l
vim.keymap.set('i', '<M-o>', '<C-o>o', opts) -- Open a new line below in insert mode with Alt+o
vim.keymap.set('i', '<M-O>', '<C-o>O', opts) -- Open a new line above in insert mode with Alt+O

-- Map <space> + a..z to jump to marks A..Z
-- Map <space>m + a..z to set marks A..Z
for c = string.byte('a'), string.byte('z') do
  local lower = string.char(c)
  local upper = string.upper(lower)
  vim.keymap.set('n', '<space>n' .. lower, '`' .. upper, opts)
  vim.keymap.set('n', '<space>m' .. lower, 'm' .. upper, opts)
end
