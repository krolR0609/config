vim.keymap.set("n", "<leader>gs", vim.cmd.Git);

-- Cycle to next/prev file in Diffview
vim.keymap.set("n", "]f", function()
  require("diffview.lib").file_panel_next_entry()
  require("diffview.actions").select_entry()
end, { desc = "Next diff file (Diffview)" })

vim.keymap.set("n", "[f", function()
  require("diffview.lib").file_panel_prev_entry()
  require("diffview.actions").select_entry()
end, { desc = "Prev diff file (Diffview)" })

-- in lua/init.lua or after/plugin/fugitive.lua
local map = vim.keymap.set
map('n', '<leader>gs', ':Git<CR>',             { desc = 'Git status (fugitive)' })
map('n', '<leader>gd', ':Gdiffsplit<CR>',      { desc = 'Git diff vs index' })
map('n', '<leader>gb', ':Gblame<CR>',          { desc = 'Git blame' })
map('n', '<leader>gl', ':Gclog<CR>',           { desc = 'Git log (file)' })

-- Toggle file panel and close Diffview
map('n', '<leader>gT', ':DiffviewToggleFiles<CR>', { desc = 'Toggle Diffview file panel' })
map('n', '<leader>gq', ':DiffviewClose<CR>', { desc = 'Close Diffview' })

-- Open specific Diffview views
map('n', '<leader>gh', ':DiffviewFileHistory<CR>', { desc = 'File history (Diffview)' })
map('n', '<leader>gH', ':DiffviewFileHistory %<CR>', { desc = 'Current file history (Diffview)' })

-- Git worktree commands
map('n', '<leader>gwa', ':Gworktree add<CR>', { desc = 'Add git worktree' })
map('n', '<leader>gwl', ':Gworktree list<CR>', { desc = 'List git worktrees' })
map('n', '<leader>gwr', ':Gworktree remove<CR>', { desc = 'Remove git worktree' })


-- map('n', '<leader>gc', ':Gcommit<CR>',         { desc = 'Git commit' })
-- map('n', '<leader>gp', ':Gpush<CR>',           { desc = 'Git push' })
-- map('n', '<leader>gP', ':Gpull<CR>',           { desc = 'Git pull' })
