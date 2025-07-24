require('telescope').setup({
  defaults = {
    mappings = {
      i = {
        ["<C-j>"] = require('telescope.actions').move_selection_next,
        ["<C-k>"] = require('telescope.actions').move_selection_previous,
      }
    },
    layout_strategy = 'vertical'  -- Optional: better for diagnostics
  },
  pickers = {
    diagnostics = {
      severity_limit = 'Warning',
      initial_mode = 'normal'  -- Better for navigating diagnostics
    }
  }
})

-- Load extensions (if using fzf)
pcall(require('telescope').load_extension, 'fzf')

local builtin = require('telescope.builtin')

-- File searching
vim.keymap.set('n', '<leader>pf', builtin.find_files, { desc = '[P]roject [F]iles' })
vim.keymap.set('n', '<C-p>', builtin.git_files, { desc = 'Git files' })

-- Grep searching
vim.keymap.set('n', '<leader>ps', function()
  -- builtin.grep_string({ search = vim.fn.input("Grep > ") })
  builtin.live_grep({
    previewer = true,  -- Keep preview open
    layout_strategy = 'vertical'  -- Better for navigation
  })
end, { desc = '[P]roject [S]earch' })

-- Diagnostics (will now work if LSP is active)
vim.keymap.set('n', '<leader>ld', function()
  builtin.diagnostics({
    severity_limit = 'Error',
    layout_config = { width = 0.9 }  -- Wider view for diagnostics
  })
end, { desc = '[T]elescope [D]iagnostics' })

vim.keymap.set('n', '<leader>p?', builtin.commands, { desc = 'List all commands' })

