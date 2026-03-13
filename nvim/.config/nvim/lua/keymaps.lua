-- [[ Basic Keymaps ]]
--  See `:help vim.keymap.set()`

-- Clear highlights on search when pressing <Esc> in normal mode
--  See `:help hlsearch`
vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')

-- managing tabs
vim.keymap.set('n', '<leader><Tab>', '<cmd>tabnext<CR>')
vim.keymap.set('n', '<leader>n<Tab>', '<cmd>tabnew<CR>')

-- managing buffers
vim.keymap.set('n', '<leader>bd', '<cmd>bd<CR>', { desc = 'Close buffer' })
vim.keymap.set('n', '<leader>Q', '<cmd>qa<CR>', { desc = 'Close Neovim' })
vim.keymap.set('n', '<leader>w', '<cmd>w<CR>', { desc = 'Save file' })
vim.keymap.set('n', '<leader>x', '<cmd>x<CR>', { desc = 'Save and quit' })
vim.keymap.set('n', '<C-C>', '<Esc>', { desc = 'Save and quit' })

vim.keymap.set('t', '<C-[>', '<C-\\><C-n>', { desc = 'escape terminal mode' })
-- Diagnostic keymaps

vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostic [Q]uickfix list' })

-- Exit terminal mode in the builtin terminal with a shortcut that is a bit easier
-- for people to discover. Otherwise, you normally need to press <C-\><C-n>, which
-- is not what someone will guess without a bit more experience.

vim.keymap.set('t', '<Esc><Esc>', '<C-\\><C-n>', { desc = 'Exit terminal mode' })
vim.api.nvim_create_autocmd('TermOpen', {
  group = vim.api.nvim_create_augroup('custom-term-open', { clear = true }),
  callback = function()
    vim.opt.number = false
    vim.opt.relativenumber = false
  end,
})

vim.keymap.set('n', '<leader>st', function()
  vim.cmd.vnew()
  vim.cmd.term()
  vim.cmd.wincmd 'J'
  vim.api.nvim_win_set_height(0, 15)
end)

vim.keymap.set('n', '<leader>td', function()
  -- Check if diagnostics are currently enabled globally
  local is_enabled = vim.diagnostic.is_enabled()
  
  vim.diagnostic.enable(not is_enabled)
  
  print("Diagnostics " .. (is_enabled and "Disabled" or "Enabled"))
end, { desc = '[T]oggle [D]iagnostics (Global)' })

-- Keybinds to make split navigation easier.
--  Use CTRL+<hjkl> to switch between windows
vim.keymap.set('n', '<C-h>', '<C-w><C-h>', { desc = 'Move focus to the left window' })
vim.keymap.set('n', '<C-l>', '<C-w><C-l>', { desc = 'Move focus to the right window' })
vim.keymap.set('n', '<C-j>', '<C-w><C-j>', { desc = 'Move focus to the lower window' })
vim.keymap.set('n', '<C-k>', '<C-w><C-k>', { desc = 'Move focus to the upper window' })

-- [[ Basic Autocommands ]]
--  See `:help lua-guide-autocommands`

-- Highlight when yanking (copying) text
--  Try it with `yap` in normal mode
--  See `:help vim.hl.on_yank()`
vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking (copying) text',
  group = vim.api.nvim_create_augroup('kickstart-highlight-yank', { clear = true }),
  callback = function()
    vim.hl.on_yank()
  end,
})

-- vim: ts=2 sts=2 sw=2 et
