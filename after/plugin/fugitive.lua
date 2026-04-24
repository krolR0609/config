local map = vim.keymap.set

-- Diffview
map("n", "]f", ":DiffviewNext<CR>", { desc = "Next diff file", noremap = true, silent = true })
map("n", "[f", ":DiffviewPrev<CR>", { desc = "Prev diff file", noremap = true, silent = true })
map('n', '<leader>gT', ':DiffviewToggleFiles<CR>', { desc = 'Toggle Diffview file panel' })
map('n', '<leader>gq', ':DiffviewClose<CR>', { desc = 'Close Diffview' })
map('n', '<leader>gh', ':DiffviewFileHistory<CR>', { desc = 'File history (Diffview)' })
map('n', '<leader>gH', ':DiffviewFileHistory %<CR>', { desc = 'Current file history (Diffview)' })

-- Git worktree
map('n', '<leader>gwa', ':Gworktree add<CR>', { desc = 'Add git worktree' })
map('n', '<leader>gwl', ':Gworktree list<CR>', { desc = 'List git worktrees' })
map('n', '<leader>gwr', ':Gworktree remove<CR>', { desc = 'Remove git worktree' })
