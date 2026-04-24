vim.opt.splitright = true

require('nvim-tree').setup({
    renderer = {
        icons = {
            glyphs = {
                modified = "\u{25cf}",
                git = {
                    unstaged = "[unstg]",
                    staged = "[stg]",
                    untracked = "[untrc]",
                    deleted = "[del]",
                    ignored = "[ign]",
                },
            },
        },
    },
    hijack_netrw = true,
    hijack_cursor = true,
    sync_root_with_cwd = true,
    respect_buf_cwd = true,

    view = {
        width = 35,
        side = "left",
        preserve_window_proportions = true,
    },

    actions = {
        open_file = {
            quit_on_open = true,
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

        api.config.mappings.default_on_attach(bufnr)

        vim.keymap.set('n', 'o', function()
            api.node.open.edit()
        end, opts("Open file or folder"))

        vim.keymap.set('n', 'so', api.node.open.horizontal, opts("Open in Horizontal Split"))
        vim.keymap.set('n', 'vo', api.node.open.vertical, opts("Open in Vertical Split"))
        vim.keymap.set('n', 'to', api.node.open.tab, opts("Open in New Tab"))

        vim.keymap.set('n', 'h', api.node.navigate.parent_close, opts("Close Directory"))
        vim.keymap.set('n', 'P', api.node.navigate.parent, opts("Go to Parent Directory"))
        vim.keymap.set('n', 'l', api.node.open.edit, opts("Open File or Directory"))
    end
});
