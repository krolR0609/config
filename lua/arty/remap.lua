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

vim.api.nvim_set_keymap('v', '<leader>ts', ':lua SnakeCase()<CR>', { noremap = true, silent = true })

function SnakeCase()
    -- Get visual selection bounds
    local start_line = vim.fn.line("'<")
    local end_line = vim.fn.line("'>")
    local lines = {}
    
    -- Remember the original cursor position and selection mode
    local curpos = vim.fn.getpos('.')
    
    for l = start_line, end_line do
        local line_text = vim.fn.getline(l)
        -- Calculate column positions (1-indexed in Lua, 0-indexed in Vim)
        local start_col = (l == start_line) and math.max(vim.fn.col("'<") - 1, 0) or 0
        local end_col = (l == end_line) and math.min(vim.fn.col("'>") - 1, #line_text - 1) or #line_text - 1
        
        if start_col <= end_col then
            local selected_text = line_text:sub(start_col + 1, end_col + 1)
            
            -- Convert to snake_case
            local snake = selected_text:gsub("([a-z])([A-Z])", "%1_%2")
                                          :gsub("([A-Z]+)([A-Z][a-z])", "%1_%2")
                                          :gsub("%s+", "_")
                                          :gsub("-", "_")
                                          :lower()
            
            -- Replace the selected portion
            local new_line = line_text:sub(1, start_col) .. snake .. line_text:sub(end_col + 2)
            table.insert(lines, new_line)
        else
            table.insert(lines, line_text)
        end
    end
    
    -- Set lines in buffer
    vim.api.nvim_buf_set_lines(0, start_line - 1, end_line, false, lines)
    
    -- Restore visual selection
    vim.fn.setpos('.', curpos)
    vim.cmd('normal! gv')
end
