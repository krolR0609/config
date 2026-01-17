vim.opt.splitright = true 

require('nvim-tree').setup({
    renderer = {
        icons = {
            glyphs = {
                modified = "●",
                git = {
                    unstaged = "[unstg]",
                    staged = "[stg]",
                    -- unmerged = "",
                    -- renamed = "➜",
                    untracked = "[untrc]",
                    deleted = "[del]",
                    ignored = "[ign]",
                },
            },
        },
    },
    hijack_netrw = true,               -- отключить встроенный netrw
    hijack_cursor = true,              -- курсор прыгает в дерево при открытии
    sync_root_with_cwd = true,
    respect_buf_cwd = true,

    view = {
        width = 35,
        side = "left",
        preserve_window_proportions = true,
    },

    actions = {
        open_file = {
            quit_on_open = true,          -- НЕ закрывать дерево при открытии файла
            resize_window = true,
        },
    },
    filters = {
        dotfiles = false,
    },
    log = { enable = false },

    on_attach = function(bufnr)
        local api = require('nvim-tree.api')
        local function opts(desc)
            return {desc='nvim-tree: '..desc, buffer=bufnr, noremap=true, silent=true, nowait=true}
        end

        api.config.mappings.default_on_attach(bufnr)  -- базовые бинды

        -- o  →  открыть файл + закрыть nvim-tree
        vim.keymap.set('n', 'o', function()
            api.node.open.edit()   -- open file or expand folder
        end, {
        desc = "Open file or folder without closing nvim-tree",
        buffer = bufnr,
        noremap = true,
        silent = true,
        nowait = true
    })

        -- Open in horizontal split
        vim.keymap.set('n', 'so', api.node.open.horizontal, opts("Open in Horizontal Split"))
        -- Open in vertical split
        vim.keymap.set('n', 'vo', api.node.open.vertical, opts("Open in Vertical Split"))
        -- Open in new tab
        vim.keymap.set('n', 'to', api.node.open.tab, opts("Open in New Tab"))

        vim.keymap.set('n', 'h', api.node.navigate.parent_close, opts("Close Directory"))
        vim.keymap.set('n', 'P', require('nvim-tree.api').node.navigate.parent, {
            desc = "nvim-tree: Go to Parent Directory",
            buffer = bufnr,
            noremap = true,
            silent = true,
            nowait = true,
        })

        vim.keymap.set('n', 'l', api.node.open.edit, opts("Open File or Directory"))
        vim.keymap.set('n', 'l', api.node.open.edit, opts("Open File or Directory"))
        vim.keymap.set('n', '<leader>e', '<cmd>NvimTreeFindFileToggle<cr>', { desc = 'Explorer Find File' })
        -- vim.keymap.set('n', 'j', api.node.navigate.sibling.next, opts("Next Node"))
        -- vim.keymap.set('n', 'k', api.node.navigate.sibling.prev, opts("Previous Node"))

    end


});
