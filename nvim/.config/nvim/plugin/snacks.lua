vim.pack.add({
  'https://github.com/folke/snacks.nvim',
})

---@type snacks.Config
Snacks.setup({
  rename = { enabled = true },
  input = { enabled = true },
  picker = {
    enabled = true,
    ui_select = true,
  },
  git = { enabled = true },
  gh = { enabled = true },
  explorer = { enabled = true },
  indent = { enabled = true },
  terminal = { enabled = true },
  scratch = { enabled = true, ft = 'markdown' },
  notifier = { enabled = true },
  statuscolumn = { enabled = true },
  bufdelete = { enabled = true },
  dashboard = {
    enabled = true,
    preset = {
      header = [[
███████╗██╗   ██╗██████╗ ██╗  ██╗ █████╗ ███╗   ███╗
██╔════╝██║   ██║██╔══██╗██║  ██║██╔══██╗████╗ ████║
███████╗██║   ██║██████╔╝███████║███████║██╔████╔██║
╚════██║██║   ██║██╔══██╗██╔══██║██╔══██║██║╚██╔╝██║
███████║╚██████╔╝██████╔╝██║  ██║██║  ██║██║ ╚═╝ ██║
╚══════╝ ╚═════╝ ╚═════╝ ╚═╝  ╚═╝╚═╝  ╚═╝╚═╝     ╚═╝
]],
      keys = {
        {
          icon = ' ',
          key = 'n',
          desc = 'New File',
          action = ':ene | startinsert',
        },
        {
          icon = '󱄍 ',
          key = 's',
          desc = 'Restore Session',
          action = ":lua require('persistence').load()",
        },
        {
          icon = ' ',
          key = 'r',
          desc = 'Restart Nvim',
          action = ':restart',
        },
      },
    },
    sections = {
      { section = 'header' },
      { section = 'keys', padding = 2 },
      {
        icon = ' ',
        title = 'Recent Files',
        section = 'recent_files',
        indent = 2,
        padding = { 2, 1 },
      },
      {
        icon = ' ',
        title = 'Projects',
        section = 'projects',
        indent = 2,
        padding = { 2, 1 },
      },
    },
  },
})

local map = vim.keymap.set

-- Top Pickers & Explorer
map('n', '<leader><space>', function() Snacks.picker.smart() end, { desc = 'Smart Find Files' })
map('n', '<leader>b', function() Snacks.picker.buffers() end, { desc = 'Buffers' })
map('n', '<leader>/', function() Snacks.picker.grep() end, { desc = 'Grep' })
map('n', '<leader>:', function() Snacks.picker.command_history() end, { desc = 'Command History' })
map('n', '<leader>sn', function() Snacks.picker.notifications() end, { desc = 'Notification History' })
map('n', '<leader>e', function() Snacks.explorer() end, { desc = 'File Explorer' })

-- Find
map(
  'n',
  '<leader>;',
  function() Snacks.picker.files({ cwd = vim.fn.stdpath('config') }) end,
  { desc = 'Find Config File' }
)
map('n', '<leader>f', function() Snacks.picker.files({ hidden = true }) end, { desc = 'Find Files' })
map('n', '<leader>r', function() Snacks.picker.recent() end, { desc = 'Recent' })

-- Git
map('n', '<leader>gb', function() Snacks.picker.git_branches({ all = true }) end, { desc = 'Git Branches' })
map('n', '<leader>gl', function() Snacks.picker.git_log() end, { desc = 'Git Log' })
map('n', '<leader>gs', function() Snacks.picker.git_status() end, { desc = 'Git Status' })
map('n', '<leader>gS', function() Snacks.picker.git_stash() end, { desc = 'Git Stash' })
map('n', '<leader>gd', function() Snacks.picker.git_diff() end, { desc = 'Git Diff (Hunks)' })
map('n', '<leader>gg', function() Snacks.lazygit() end, { desc = 'Lazygit' })

-- Grep
map('n', '<leader>sb', function() Snacks.picker.lines() end, { desc = 'Buffer Lines' })
map('n', '<leader>sB', function() Snacks.picker.grep_buffers() end, { desc = 'Grep Open Buffers' })
map({ 'n', 'x' }, '<leader>sw', function() Snacks.picker.grep_word() end, { desc = 'Visual selection or word' })

-- Search
map('n', '<leader>s"', function() Snacks.picker.registers() end, { desc = 'Registers' })
map('n', '<leader>s/', function() Snacks.picker.search_history() end, { desc = 'Search History' })
map('n', '<leader>sa', function() Snacks.picker.autocmds() end, { desc = 'Autocmds' })
map('n', '<leader>sc', function() Snacks.picker.commands() end, { desc = 'Commands' })
map('n', '<leader>sh', function() Snacks.picker.help() end, { desc = 'Help Pages' })
map('n', '<leader>sH', function() Snacks.picker.highlights() end, { desc = 'Highlights' })
map('n', '<leader>si', function() Snacks.picker.icons() end, { desc = 'Icons' })
map('n', '<leader>sj', function() Snacks.picker.jumps() end, { desc = 'Jumps' })
map('n', '<leader>sk', function() Snacks.picker.keymaps() end, { desc = 'Keymaps' })
map('n', '<leader>sM', function() Snacks.picker.marks() end, { desc = 'Marks' })
map('n', '<leader>sm', function() Snacks.picker.man() end, { desc = 'Man Pages' })
map('n', '<leader>sq', function() Snacks.picker.qflist() end, { desc = 'Quickfix List' })
map('n', '<leader>sr', function() Snacks.picker.resume() end, { desc = 'Resume' })
map('n', '<leader>su', function() Snacks.picker.undo() end, { desc = 'Undo History' })
map('n', '<leader>sC', function() Snacks.picker.colorschemes() end, { desc = 'Colorschemes' })
map('n', '<leader>sp', function() Snacks.picker.pickers() end, { desc = 'Snacks Pickers' })

-- Code/LSP
map('n', '<leader>cx', function() Snacks.picker.diagnostics() end, { desc = 'Diagnostics' })
map('n', '<leader>cX', function() Snacks.picker.diagnostics_buffer() end, { desc = 'Buffer Diagnostics' })
map('n', '<leader>cd', function() Snacks.picker.lsp_definitions() end, { desc = 'Goto Definition' })
map('n', '<leader>cD', function() Snacks.picker.lsp_declarations() end, { desc = 'Goto Declaration' })
map('n', '<leader>cr', function() Snacks.picker.lsp_references() end, { desc = 'References', nowait = true })
map('n', '<leader>ci', function() Snacks.picker.lsp_implementations() end, { desc = 'Goto Implementation' })
map('n', '<leader>ct', function() Snacks.picker.lsp_type_definitions() end, { desc = 'Goto T[y]pe Definition' })
map(
  'n',
  '<leader>cS',
  function() Snacks.picker.lsp_symbols({ filter = { default = true } }) end,
  { desc = 'LSP Symbols' }
)
map(
  'n',
  '<leader>cs',
  function() Snacks.picker.lsp_workspace_symbols({ filter = { default = true } }) end,
  { desc = 'LSP Workspace Symbols' }
)
map({ 'n', 'v' }, '<leader>c.', function() vim.lsp.buf.code_action() end, { desc = 'Code actions' })
map('n', '<leader>c,', function() vim.lsp.buf.rename() end, { desc = 'Rename Variable' })
map('n', 'K', function() vim.lsp.buf.hover({ border = 'rounded' }) end, { desc = 'Code Hover' })

-- Others
map('n', '<leader>cR', function() Snacks.rename.rename_file() end, { desc = 'Rename File' })
map('n', '<leader>z', function() Snacks.picker.zoxide() end, { desc = 'Zoxide' })
map(
  { 'n', 't' },
  '<leader>``',
  function() Snacks.terminal.toggle(nil, { win = { height = 0.2 } }) end,
  { desc = 'Toggle Terminal' }
)
map('n', '<leader>,', function() Snacks.scratch() end, { desc = 'Toggle Scratch Buffer' })
map('n', '<leader>.', function() Snacks.scratch.select() end, { desc = 'Select Scratch Buffer' })
map('n', '<leader>h', function() Snacks.dashboard() end, { desc = 'Home screen' })
map('n', '<leader>w', function() Snacks.bufdelete() end, { desc = 'Delete Current Buffer' })
map('n', '<leader>W', function() Snacks.bufdelete.all() end, { desc = 'Delete All Buffers' })
map('n', '<leader>gw', function() Snacks.bufdelete.other() end, { desc = 'Delete Other Buffers' })
