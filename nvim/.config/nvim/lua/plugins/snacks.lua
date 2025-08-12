return {
  'folke/snacks.nvim',
  priority = 1000,
  lazy = false,
  ---@type snacks.Config
  opts = {
    rename = { enabled = true },
    input = { enabled = true },
    picker = {
      enabled = true,
      ui_select = true,
    },
    git = { enabled = true },
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
          icon = ' ',
          title = 'Projects',
          section = 'projects',
          indent = 2,
          padding = { 2, 1 },
        },
        { section = 'startup' },
      },
    },
  },
  keys = {
    -- Top Pickers & Explorer
    {
      '<leader><space>',
      function()
        Snacks.picker.smart()
      end,
      desc = 'Smart Find Files',
    },
    {
      '<leader>b',
      function()
        Snacks.picker.buffers()
      end,
      desc = 'Buffers',
    },
    {
      '<leader>/',
      function()
        Snacks.picker.grep()
      end,
      desc = 'Grep',
    },
    {
      '<leader>:',
      function()
        Snacks.picker.command_history()
      end,
      desc = 'Command History',
    },
    {
      '<leader>sn',
      function()
        Snacks.picker.notifications()
      end,
      desc = 'Notification History',
    },
    {
      '<leader>e',
      function()
        Snacks.explorer()
      end,
      desc = 'File Explorer',
    },

    -- find
    {
      '<leader>nv',
      function()
        Snacks.picker.files({ cwd = vim.fn.stdpath('config') })
      end,
      desc = 'Find Config File',
    },
    {
      '<leader>f',
      function()
        Snacks.picker.files({
          hidden = true,
        })
      end,
      desc = 'Find Files',
    },
    {
      '<leader>p',
      function()
        Snacks.picker.projects()
      end,
      desc = 'Projects',
    },
    {
      '<leader>r',
      function()
        Snacks.picker.recent()
      end,
      desc = 'Recent',
    },

    -- git
    {
      '<leader>gb',
      function()
        Snacks.picker.git_branches({ all = true })
      end,
      desc = 'Git Branches',
    },
    {
      '<leader>gl',
      function()
        Snacks.picker.git_log()
      end,
      desc = 'Git Log',
    },
    {
      '<leader>gs',
      function()
        Snacks.picker.git_status()
      end,
      desc = 'Git Status',
    },
    {
      '<leader>gS',
      function()
        Snacks.picker.git_stash()
      end,
      desc = 'Git Stash',
    },
    {
      '<leader>gd',
      function()
        Snacks.picker.git_diff()
      end,
      desc = 'Git Diff (Hunks)',
    },
    {
      '<leader>gg',
      function()
        Snacks.lazygit()
      end,
      desc = 'Lazygit',
    },

    -- Grep
    {
      '<leader>sb',
      function()
        Snacks.picker.lines()
      end,
      desc = 'Buffer Lines',
    },
    {
      '<leader>sB',
      function()
        Snacks.picker.grep_buffers()
      end,
      desc = 'Grep Open Buffers',
    },
    {
      '<leader>sw',
      function()
        Snacks.picker.grep_word()
      end,
      desc = 'Visual selection or word',
      mode = { 'n', 'x' },
    },

    -- Search
    {
      '<leader>s"',
      function()
        Snacks.picker.registers()
      end,
      desc = 'Registers',
    },
    {
      '<leader>s/',
      function()
        Snacks.picker.search_history()
      end,
      desc = 'Search History',
    },
    {
      '<leader>sa',
      function()
        Snacks.picker.autocmds()
      end,
      desc = 'Autocmds',
    },
    {
      '<leader>sc',
      function()
        Snacks.picker.commands()
      end,
      desc = 'Commands',
    },
    {
      '<leader>sh',
      function()
        Snacks.picker.help()
      end,
      desc = 'Help Pages',
    },
    {
      '<leader>sH',
      function()
        Snacks.picker.highlights()
      end,
      desc = 'Highlights',
    },
    {
      '<leader>si',
      function()
        Snacks.picker.icons()
      end,
      desc = 'Icons',
    },
    {
      '<leader>sj',
      function()
        Snacks.picker.jumps()
      end,
      desc = 'Jumps',
    },
    {
      '<leader>sk',
      function()
        Snacks.picker.keymaps()
      end,
      desc = 'Keymaps',
    },
    {
      '<leader>sl',
      function()
        Snacks.picker.loclist()
      end,
      desc = 'Location List',
    },
    {
      '<leader>sM',
      function()
        Snacks.picker.marks()
      end,
      desc = 'Marks',
    },
    {
      '<leader>sm',
      function()
        Snacks.picker.man({
          confirm = function(picker, item)
            picker:close()
            if item then
              vim.schedule(function()
                vim.cmd('vert Man ' .. item.ref)
              end)
            end
          end,
        })
      end,
      desc = 'Man Pages',
    },
    {
      '<leader>sq',
      function()
        Snacks.picker.qflist()
      end,
      desc = 'Quickfix List',
    },
    {
      '<leader>sR',
      function()
        Snacks.picker.resume()
      end,
      desc = 'Resume',
    },
    {
      '<leader>su',
      function()
        Snacks.picker.undo()
      end,
      desc = 'Undo History',
    },
    {
      '<leader>sC',
      function()
        Snacks.picker.colorschemes()
      end,
      desc = 'Colorschemes',
    },
    {
      '<leader>sp',
      function()
        Snacks.picker.pickers()
      end,
      desc = 'Snacks Pickers',
    },

    -- Code/LSP
    {
      '<leader>cx',
      function()
        Snacks.picker.diagnostics()
      end,
      desc = 'Diagnostics',
    },
    {
      '<leader>cX',
      function()
        Snacks.picker.diagnostics_buffer()
      end,
      desc = 'Buffer Diagnostics',
    },
    {
      '<leader>cd',
      function()
        Snacks.picker.lsp_definitions()
      end,
      desc = 'Goto Definition',
    },
    {
      '<leader>cD',
      function()
        Snacks.picker.lsp_declarations()
      end,
      desc = 'Goto Declaration',
    },
    {
      '<leader>cr',
      function()
        Snacks.picker.lsp_references()
      end,
      nowait = true,
      desc = 'References',
    },
    {
      '<leader>ci',
      function()
        Snacks.picker.lsp_implementations()
      end,
      desc = 'Goto Implementation',
    },
    {
      '<leader>ct',
      function()
        Snacks.picker.lsp_type_definitions()
      end,
      desc = 'Goto T[y]pe Definition',
    },
    {
      '<leader>cS',
      function()
        Snacks.picker.lsp_symbols({ filter = { default = true } })
      end,
      desc = 'LSP Symbols',
    },
    {
      '<leader>cs',
      function()
        Snacks.picker.lsp_workspace_symbols({ filter = { default = true } })
      end,
      desc = 'LSP Workspace Symbols',
    },
    {
      '<leader>c.',
      function()
        vim.lsp.buf.code_action()
      end,
      mode = { 'n', 'v' },
      desc = 'Code actions',
    },
    {
      '<leader>c,',
      function()
        vim.lsp.buf.rename()
      end,
      desc = 'Rename Variable',
    },
    {
      'K',
      function()
        vim.lsp.buf.hover({
          border = 'rounded',
          focusable = false,
        })
      end,
      desc = 'Code Hover',
    },

    -- Others
    {
      '<leader>cR',
      function()
        Snacks.rename.rename_file()
      end,
      desc = 'Rename File',
    },
    {
      '<leader>z',
      function()
        Snacks.picker.zoxide()
      end,
      desc = 'Zoxide',
    },
    {
      '<leader>`',
      function()
        Snacks.terminal.toggle(nil, { win = { height = 0.2 } })
      end,
      desc = 'Toggle Terminal',
      mode = { 'n', 't' },
    },
    {
      '<leader>,',
      function()
        Snacks.scratch()
      end,
      desc = 'Toggle Scratch Buffer',
    },
    {
      '<leader>.',
      function()
        Snacks.scratch.select()
      end,
      desc = 'Select Scratch Buffer',
    },
    {
      '<leader>h',
      function()
        Snacks.dashboard()
      end,
      desc = 'Home screen',
    },
    {
      '<leader>W',
      function()
        Snacks.bufdelete.all()
      end,
      desc = 'Delete All Buffers',
    },
    {

      '<leader>gw',
      function()
        Snacks.bufdelete.other()
      end,
      desc = 'Delete Other Buffers',
    },
  },
}
