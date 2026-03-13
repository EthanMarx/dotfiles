return {
  { -- Autoformat
    'stevearc/conform.nvim',
    cmd = { 'ConformInfo' },
    keys = {
      {
        '<leader>ff',
        function()
          require('conform').format { async = true, lsp_format = 'fallback' }
        end,
        mode = '',
        desc = '[F]ormat buffer',
      },
    },
    opts = {
      notify_on_error = false,
      formatters_by_ft = {
        lua = { 'stylua' },
        python = { 'ruff_organize_imports', 'ruff_fix', 'ruff_format' },
        cpp = { 'clang-format' },
        markdown = { 'markdownlint-cli2' },
      },
    },
  },
}
-- vim: ts=2 sts=2 sw=2 et
