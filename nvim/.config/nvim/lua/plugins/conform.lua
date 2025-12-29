return {
  'stevearc/conform.nvim',
  opts = {
    formatters_by_ft = {
      lua = { 'stylua' },
      python = { 'ruff_format' },
      json = { 'jq' },
      jsonc = { 'jq' },
      markdown = { 'markdownlint-cli2' },
      ['_'] = { 'prettierd' },
    },
    format_on_save = {
      lsp_format = 'last',
      timeout_ms = 500,
    },
    formatters = {
      prettierd = {
        require_cwd = true,
      },
      ['markdownlint-cli2'] = {
        require_cwd = true,
      },
    },
  },
}
