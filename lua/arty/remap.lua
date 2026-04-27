vim.opt.timeout = true
vim.opt.ttimeout = true
vim.opt.timeoutlen = 300
vim.opt.ttimeoutlen = 10

vim.keymap.set("n", "<Space>", "<Nop>", { silent = true, remap = false })
vim.g.mapleader = " "

vim.keymap.set("n", "::", "q:", { noremap = true, silent = true })
vim.keymap.set("n", "//", "q/", { noremap = true, silent = true })
vim.keymap.set("n", "??", "q?", { noremap = true, silent = true })

-- Keep context centered while navigating search and large files.
vim.keymap.set("n", "n", "nzzzv", { noremap = true, silent = true, desc = "Next search result centered" })
vim.keymap.set("n", "N", "Nzzzv", { noremap = true, silent = true, desc = "Prev search result centered" })
vim.keymap.set("n", "<C-d>", "<C-d>zz", { noremap = true, silent = true, desc = "Half-page down centered" })
vim.keymap.set("n", "<C-u>", "<C-u>zz", { noremap = true, silent = true, desc = "Half-page up centered" })

vim.cmd([[highlight ExtraWhitespace ctermbg=red guibg=red]])
vim.cmd([[match ExtraWhitespace /\s\+$/]])
-- terminal exit by esc
vim.keymap.set('t', '<Esc>', [[<C-\><C-n>]],
{ noremap = true, silent = true, nowait = true, desc = "Exit terminal mode" })


-- TOGGLETERM
local trim_spaces = true
vim.keymap.set("v", "<space>s", function()
    require("toggleterm").send_lines_to_terminal("single_line", trim_spaces, { args = vim.v.count })
end)

-- Send motion to terminal (operator map)
vim.keymap.set("n", [[<leader><c-\>]], function()
    vim.go.operatorfunc = "v:lua.require'toggleterm'.send_lines_to_terminal"
    vim.api.nvim_feedkeys("g@", "n", false)
end)
-- Double to send line to terminal
vim.keymap.set("n", [[<leader><c-\><c-\>]], function()
    vim.go.operatorfunc = "v:lua.require'toggleterm'.send_lines_to_terminal"
    vim.api.nvim_feedkeys("g@_", "n", false)
end)
-- Send whole file
vim.keymap.set("n", [[<leader><leader><c-\>]], function()
    vim.go.operatorfunc = "v:lua.require'toggleterm'.send_lines_to_terminal"
    vim.api.nvim_feedkeys("ggg@G''", "n", false)
end)

-- TOGGLETERM END
-- NvimTree
vim.keymap.set('n', '<C-n>', ':NvimTreeToggle<CR>', {silent = true})
local last_buf = nil

local function toggle_tree()
    local api = require("nvim-tree.api")

    if api.tree.is_visible() then
        if vim.bo.filetype == "NvimTree" then
            if last_buf and vim.api.nvim_buf_is_loaded(last_buf) then
                vim.api.nvim_set_current_buf(last_buf)
            else
                vim.cmd('buffer #')
            end
        else
            last_buf = vim.api.nvim_get_current_buf()
            api.tree.find_file({ open = true, focus = true })
        end
    else
        last_buf = vim.api.nvim_get_current_buf()
        api.tree.find_file({ open = true, focus = true })
    end
end
vim.keymap.set('n', '<leader>e', toggle_tree, { desc = "Toggle focus between tree and last buffer" })
vim.keymap.set("n", "<leader>pv", toggle_tree, { silent = true })

vim.api.nvim_create_user_command('RemoveCR', function()
    vim.cmd([[silent! %s/\r//g]])
    print("Carriage returns removed")
end, {})

vim.keymap.set('v', '<leader>cs', ':lua SnakeCase()<CR>', { noremap = true, silent = true, desc = "Convert to snake_case" })

function SnakeCase()
    local start_line = vim.fn.line("'<")
    local end_line = vim.fn.line("'>")
    local lines = {}

    local curpos = vim.fn.getpos('.')

    for l = start_line, end_line do
        local line_text = vim.fn.getline(l)
        local start_col = (l == start_line) and math.max(vim.fn.col("'<") - 1, 0) or 0
        local end_col = (l == end_line) and math.min(vim.fn.col("'>") - 1, #line_text - 1) or #line_text - 1

        if start_col <= end_col then
            local selected_text = line_text:sub(start_col + 1, end_col + 1)

            local snake = selected_text:gsub("([a-z])([A-Z])", "%1_%2")
                                          :gsub("([A-Z]+)([A-Z][a-z])", "%1_%2")
                                          :gsub("%s+", "_")
                                          :gsub("-", "_")
                                          :lower()

            local new_line = line_text:sub(1, start_col) .. snake .. line_text:sub(end_col + 2)
            table.insert(lines, new_line)
        else
            table.insert(lines, line_text)
        end
    end

    vim.api.nvim_buf_set_lines(0, start_line - 1, end_line, false, lines)

    vim.fn.setpos('.', curpos)
    vim.cmd('normal! gv')
end
