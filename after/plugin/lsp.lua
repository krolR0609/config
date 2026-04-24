local ok, cmp_lsp = pcall(require, "cmp_nvim_lsp")
local capabilities = ok and cmp_lsp.default_capabilities() or vim.lsp.protocol.make_client_capabilities()

vim.lsp.config('*', { capabilities = capabilities })

vim.api.nvim_create_autocmd('LspAttach', {
    callback = function(event)
        local opts = {buffer = event.buf}

        vim.keymap.set('n', 'K', '<cmd>lua vim.lsp.buf.hover()<cr>', opts)
        vim.keymap.set('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<cr>', opts)
        vim.keymap.set('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<cr>', opts)
        vim.keymap.set('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<cr>', opts)
        vim.keymap.set('n', 'go', '<cmd>lua vim.lsp.buf.type_definition()<cr>', opts)
        vim.keymap.set('n', 'gr', '<cmd>lua vim.lsp.buf.references()<cr>', vim.tbl_extend('force', opts, { nowait = true }))
        vim.keymap.set('n', 'gs', '<cmd>lua vim.lsp.buf.signature_help()<cr>', opts)
        vim.keymap.set('n', '<F2>', '<cmd>lua vim.lsp.buf.rename()<cr>', opts)
        vim.keymap.set({'n', 'x'}, '<F3>', '<cmd>lua vim.lsp.buf.format({async = true})<cr>', opts)
        vim.keymap.set('n', '<F4>', '<cmd>lua vim.lsp.buf.code_action()<cr>', opts)
        vim.keymap.set('n', 'ga', '<cmd>lua vim.lsp.buf.code_action()<cr>', opts)
        vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, { desc = 'Go to previous diagnostic' })
        vim.keymap.set('n', ']d', vim.diagnostic.goto_next, { desc = 'Go to next diagnostic' })
        vim.keymap.set('n', 'gl', vim.diagnostic.open_float, { desc = 'Show diagnostic float' })
        vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostics list' })
    end,
})

vim.keymap.set('n', '<leader>lh', '<cmd>checkhealth lsp<cr>', { desc = 'LSP checkhealth' })
vim.keymap.set('n', '<leader>lr', function()
    vim.lsp.stop_client(vim.lsp.get_clients())
    vim.cmd('e')
end, { desc = 'LSP reload' })
vim.keymap.set('n', '<leader>li', '<cmd>LspInfo<cr>', { desc = 'LSP info' })

local lsps = {
    {
        "gopls",
        {
            settings = {
                gopls = {
                    gofumpt = true,
                    analyses = {
                        unusedparams = true,
                        shadow = true,
                    },
                    staticcheck = true,
                },
            },
        }
    },
    {
        "ts_ls",
        {
            filetypes = { "typescript", "javascript", "typescriptreact", "javascriptreact" },
            root_markers = { 'package.json', 'tsconfig.json', '.git' },
        }
    },
}

for _, lsp in pairs(lsps) do
    local name, config = lsp[1], lsp[2]
    if config then
        vim.lsp.config(name, config)
    end
    vim.lsp.enable(name)
end


