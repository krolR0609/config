local status, nvim_lsp = pcall(require, "lspconfig")
if (not status) then return end

local protocol = require('vim.lsp.protocol')

local on_attach = function(client, bufnr)
    -- format on save
    --
    --     client.server_capabilities.documentFormattingProvider = trueo
    client.server_capabilities.documentFormattingProvider = true

    if client.server_capabilities.documentFormattingProvider then
        vim.api.nvim_create_autocmd("BufWritePre", {
            group = vim.api.nvim_create_augroup("Format", { clear = true }),
            buffer = bufnr,
            callback = function() vim.lsp.buf.format({ async = false }) end
        })
    end

    vim.diagnostic.enable(bufnr)
end

vim.api.nvim_create_autocmd('LspAttach', {
    callback = function(event)
        local opts = {buffer = event.buf}

        vim.keymap.set('n', 'K', '<cmd>lua vim.lsp.buf.hover()<cr>', opts)
        vim.keymap.set('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<cr>', opts)
        vim.keymap.set('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<cr>', opts)
        vim.keymap.set('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<cr>', opts)
        vim.keymap.set('n', 'go', '<cmd>lua vim.lsp.buf.type_definition()<cr>', opts)
        vim.keymap.set('n', 'gr', '<cmd>lua vim.lsp.buf.references()<cr>', opts)
        vim.keymap.set('n', 'gs', '<cmd>lua vim.lsp.buf.signature_help()<cr>', opts)
        vim.keymap.set('n', '<F2>', '<cmd>lua vim.lsp.buf.rename()<cr>', opts)
        vim.keymap.set({'n', 'x'}, '<F3>', '<cmd>lua vim.lsp.buf.format({async = true})<cr>', opts)
        vim.keymap.set('n', '<F4>', '<cmd>lua vim.lsp.buf.code_action()<cr>', opts)
        vim.keymap.set('n', 'ga', '<cmd>lua vim.lsp.buf.code_action()<cr>', opts)
        vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, { desc = 'Go to previous diagnostic' })
        vim.keymap.set('n', ']d', vim.diagnostic.goto_next, { desc = 'Go to next diagnostic' })
        vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float, { desc = 'Show error message' })
        vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostics list' })
    end,
})

-- TypeScript
nvim_lsp.ts_ls.setup {
    on_attach = on_attach,
    filetypes = { "typescript", "typescriptreact", "typescript.tsx" },
    cmd = { "typescript-language-server", "--stdio" },
    settings = {
        completions = {
            completeFunctionCalls = true, -- Helps with auto-import
        },
    },
}
nvim_lsp.omnisharp.setup({
    on_attach = on_attach,
    settings = {
        RoslynExtensionsOptions = {
            enableImportCompletion = true,
            enableDecompilationSupport = true,
            enableAnalyzersSupport = true,
            enableAsyncCompletion = true,
        },
        FormattingOptions = {
            enableEditorConfigSupport = true,
            organizeImports = true,
            useTabs = false,
            indentationSize = 4,
        },
        InlayHintsOptions = {
            enableForParameters = true,
            forLiteralParameters = true,
        },
        MsBuild = { useModernNet = true },
    },
    cmd = { "dotnet", "/Users/arty/.local/bin/omnisharp/OmniSharp.dll" },
    root_dir = nvim_lsp.util.root_pattern("*.sln", "*.csproj"),
    handlers = {            -- plug the extended definition handler
        ["textDocument/definition"] = require("omnisharp_extended").handler,
    },
})

vim.api.nvim_create_autocmd("FileType", {
    pattern = "cs",
    callback = function()
        vim.bo.autoindent = true
        vim.bo.smartindent = true
        vim.bo.cindent = false
        vim.bo.indentexpr = ""
        vim.bo.tabstop = 4
        vim.bo.shiftwidth = 4
        vim.bo.expandtab = true
    end
})
