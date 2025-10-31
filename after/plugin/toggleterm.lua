local toggleterm = require("toggleterm")

toggleterm.setup({
  size = function(term)
      if term.direction == "horizontal" then
        return 15
      elseif term.direction == "vertical" then
        return math.floor(vim.o.columns * 0.40)
      end
    end,
  open_mapping = [[<C-\>]],
  hide_numbers = true,
  shade_terminals = true,
  shading_factor = 2,
  direction = "float", -- default direction (can override per-terminal)
  start_in_insert = true,
  insert_mappings = true,
  persist_size = true,
  close_on_exit = true,
  shell = vim.o.shell,
})

local Terminal  = require("toggleterm.terminal").Terminal
local toggle    = require("toggleterm").toggle

-- Server terminal in horizontal split
local term1 = Terminal:new({
  hidden = true,
  direction = "float",
  count = 101,
})

local term2 = Terminal:new({
  hidden = true,
  direction = "float",
  count = 102,
})

local term3 = Terminal:new({
  hidden = true,
  direction = "float",
  count = 103,
})

local term4 = Terminal:new({
  hidden = true,
  direction = "float",
  count = 104,
})

local server_term = Terminal:new({
  hidden = true,
  direction = "float",
  count = 1,
})

-- Client terminal in vertical split
-- local build_term = Terminal:new({
--   cmd = 'tsc -w',
--   hidden = true,
--   direction = "float",
--   count = 10,
-- })

local git_term = Terminal:new({
  hidden = true,
  direction = "float",
  count = 2,
})

local db_term = Terminal:new({
    hidden = true,
    direction = "tab", -- opens in a new tab
    count = 3,
})
local map = vim.keymap.set
local opts = { noremap = true, silent = true }

-- Key mappings
vim.keymap.set(
  'n',
  '<leader>ta',                       -- ⇧ pick any keys you like
  '<Cmd>ToggleTermToggleAll<CR>',     -- the command above
  { desc = 'Toggle **all** terminals' }
)

vim.keymap.set("n", "<leader>ts", function() server_term:toggle() end, { desc = "Toggle Server Terminal" })
vim.keymap.set("n", "<leader>tb", function() build_term:toggle() end, { desc = "Toggle Client Terminal" })
vim.keymap.set("n", "<leader>tg", function() git_term:toggle() end, { desc = "Toggle Lazygit Terminal" })
vim.keymap.set("n", "<leader>td", function() db_term:toggle() end, { desc = "Toggle Database Terminal" })
map("n", "<leader>th",
function() toggle(1, 15, vim.fn.getcwd(), "horizontal") end,
vim.tbl_extend("force", opts, { desc = "ToggleTerm #1  (horizontal)" }))

-- ID 2:  first vertical split (right) -----------------------------------
map("n", "<leader>tv",
function() toggle(2, 0,  vim.fn.getcwd(), "vertical")   end,
vim.tbl_extend("force", opts, { desc = "ToggleTerm #2  (vertical-1)" }))

-- ID 3:  second vertical split (right of the previous) ------------------
map("n", "<leader>tV",
function() toggle(3, 0,  vim.fn.getcwd(), "vertical")   end,
vim.tbl_extend("force", opts, { desc = "ToggleTerm #3  (vertical-2)" }))

-- ID 4:  floating scratch pad  -----------------------------------------
map("n", "<leader>tf",
function() toggle(4, 20, vim.fn.getcwd(), "float")      end,
vim.tbl_extend("force", opts, { desc = "ToggleTerm #4  (float)" }))

map("n", "<leader>t1",
function() toggle(101, 20, vim.fn.getcwd(), "float")      end,
vim.tbl_extend("force", opts, { desc = "Any Term #101  (float)" }))

map("n", "<leader>t2",
function() toggle(102, 20, vim.fn.getcwd(), "float")      end,
vim.tbl_extend("force", opts, { desc = "Any Term #102  (float)" }))

map("n", "<leader>t3",
function() toggle(103, 20, vim.fn.getcwd(), "float")      end,
vim.tbl_extend("force", opts, { desc = "Any Term #103  (float)" }))

map("n", "<leader>t4",
function() toggle(104, 20, vim.fn.getcwd(), "float")      end,
vim.tbl_extend("force", opts, { desc = "Any Term #104  (float)" }))

vim.keymap.set('n', '<leader>t0', function()
  local toggle = require('toggleterm').toggle

  -- First terminal (top horizontal)
  toggle(10, 15, vim.fn.getcwd(), 'horizontal')

  -- Move to next split and open another terminal
  vim.cmd('wincmd j')
  toggle(11, 15, vim.fn.getcwd(), 'horizontal')
end, { desc = 'Open 2 horizontal terminals' })

-- Optional: General terminal (opens float)
vim.keymap.set("n", "<leader>tt", "<cmd>ToggleTerm<CR>", { desc = "Toggle General Terminal" })
vim.cmd([[tnoremap <Esc> <C-\><C-n>]])
vim.keymap.set("t", "<C-q>", [[<C-\><C-n>]], { noremap = true })

