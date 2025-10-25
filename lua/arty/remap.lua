vim.opt.timeout = true
vim.opt.ttimeout = true          -- важен именно ttimeout/ttimeoutlen
vim.opt.timeoutlen = 300         -- обычные маппинги (норм. режим)
vim.opt.ttimeoutlen = 10         -- << сделайте маленьким: 0–20 мс

vim.keymap.set("n", "<Space>", "<Nop>", { silent = true, remap = false })
vim.g.mapleader = " "

vim.api.nvim_set_keymap("n", "::", "q:", { noremap = true, silent = true });
vim.api.nvim_set_keymap("n", "//", "q/", { noremap = true, silent = true });
vim.api.nvim_set_keymap("n", "??", "q?", { noremap = true, silent = true });
vim.cmd([[highlight ExtraWhitespace ctermbg=red guibg=red]])
vim.cmd([[match ExtraWhitespace /\s\+$/]])
-- terminal exit by esc
vim.keymap.set('t', '<Esc>', [[<C-\><C-n>]],
{ noremap = true, silent = true, nowait = true, desc = "Exit terminal mode" })


-- TOGGLETERM
local trim_spaces = true vim.keymap.set("v", "<space>s", function()
    require("toggleterm").send_lines_to_terminal("single_line", trim_spaces, { args = vim.v.count })
end)
-- Replace with these for the other two options
-- require("toggleterm").send_lines_to_terminal("visual_lines", trim_spaces, { args = vim.v.count })
-- require("toggleterm").send_lines_to_terminal("visual_selection", trim_spaces, { args = vim.v.count })

-- For use as an operator map:
-- Send motion to terminal
vim.keymap.set("n", [[<leader><c-\>]], function()
    set_opfunc(function(motion_type)
        require("toggleterm").send_lines_to_terminal(motion_type, false, { args = vim.v.count })
    end)
    vim.api.nvim_feedkeys("g@", "n", false)
end)
-- Double the command to send line to terminal
vim.keymap.set("n", [[<leader><c-\><c-\>]], function()
    set_opfunc(function(motion_type)
        require("toggleterm").send_lines_to_terminal(motion_type, false, { args = vim.v.count })
    end)
    vim.api.nvim_feedkeys("g@_", "n", false)
end)
-- Send whole file
vim.keymap.set("n", [[<leader><leader><c-\>]], function()
    set_opfunc(function(motion_type)
        require("toggleterm").send_lines_to_terminal(motion_type, false, { args = vim.v.count })
    end)
    vim.api.nvim_feedkeys("ggg@G''", "n", false)
end)

-- TOGGLETERM END
-- NvimTree
vim.keymap.set('n', '<C-n>', ':NvimTreeToggle<CR>', {silent = true})
-- vim.keymap.set('n', '<leader>e', ':NvimTreeFocus<CR>', { silent = true })
local last_buf = nil

toggle = function()
    local api = require("nvim-tree.api")

    if api.tree.is_visible() then
        if vim.bo.filetype == "NvimTree" then
            if last_buf and vim.api.nvim_buf_is_loaded(last_buf) then
                vim.api.nvim_set_current_buf(last_buf)
            else
                vim.cmd('buffer #') -- fallback
            end
        else
            last_buf = vim.api.nvim_get_current_buf()
            api.tree.focus()
        end
    else
        last_buf = vim.api.nvim_get_current_buf()
        api.tree.open()
        api.tree.focus()
    end
end
vim.keymap.set('n', '<leader>e', toggle , { desc = "Toggle focus between tree and last buffer" })
vim.keymap.set("n", "<leader>pv", toggle, {silent = true})
-- vim.keymap.set("n", "<leader>pv", vim.cmd.Ex)
--
vim.api.nvim_create_user_command('RemoveCR', function()
    vim.cmd([[silent! %s/\r//g]])
    print("Carriage returns removed")
end, {})

vim.g.clipboard = {
  name = 'win32yank-wsl',
  copy = {
    ['+'] = 'win32yank.exe -i --crlf',
    ['*'] = 'win32yank.exe -i --crlf',
  },
  paste = {
    ['+'] = 'win32yank.exe -o --lf',
    ['*'] = 'win32yank.exe -o --lf',
  },
  cache_enabled = 0,
}
