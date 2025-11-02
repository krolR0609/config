-- local status, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
-- if (not status) then return end
--
-- local protocol = require('vim.lsp.protocol')
-- local capabilities = cmp_nvim_lsp.default_capabilities()
--
-- local on_attach = function(client, bufnr)
--     client.server_capabilities.documentFormattingProvider = true
--
--     -- Format on save
--     vim.api.nvim_create_autocmd('BufWritePre', {
--       buffer = bufnr,
--       callback = function()
--         vim.lsp.buf.format({ async = false })
--       end
--     })
-- end
--
-- vim.api.nvim_create_autocmd('LspAttach', {
--     callback = function(event)
--         local opts = {buffer = event.buf}
--
--         vim.keymap.set('n', 'K', '<cmd>lua vim.lsp.buf.hover()<cr>', opts)
--         vim.keymap.set('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<cr>', opts)
--         vim.keymap.set('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<cr>', opts)
--         vim.keymap.set('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<cr>', opts)
--         vim.keymap.set('n', 'go', '<cmd>lua vim.lsp.buf.type_definition()<cr>', opts)
--         vim.keymap.set('n', 'gr', '<cmd>lua vim.lsp.buf.references()<cr>', opts)
--         vim.keymap.set('n', 'gs', '<cmd>lua vim.lsp.buf.signature_help()<cr>', opts)
--         vim.keymap.set('n', '<F2>', '<cmd>lua vim.lsp.buf.rename()<cr>', opts)
--         vim.keymap.set({'n', 'x'}, '<F3>', '<cmd>lua vim.lsp.buf.format({async = true})<cr>', opts)
--         vim.keymap.set('n', '<F4>', '<cmd>lua vim.lsp.buf.code_action()<cr>', opts)
--         vim.keymap.set('n', 'ga', '<cmd>lua vim.lsp.buf.code_action()<cr>', opts)
--         vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, { desc = 'Go to previous diagnostic' })
--         vim.keymap.set('n', ']d', vim.diagnostic.goto_next, { desc = 'Go to next diagnostic' })
--         vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float, { desc = 'Show error message' })
--         vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostics list' })
--     end,
-- })
--
-- -- Helper function to setup LSP servers
-- local function setup_lsp(config)
--     -- Auto-start LSP when opening supported file types
--     vim.api.nvim_create_autocmd('FileType', {
--         pattern = config.filetypes or { config.name },
--         callback = function(args)
--             -- Only start if not already attached
--             local clients = vim.lsp.get_active_clients({ bufnr = args.buf, name = config.name })
--             if #clients == 0 then
--                 vim.lsp.start(vim.tbl_extend('keep', config, {
--                     bufnr = args.buf,
--                 }))
--             end
--         end
--     })
-- end
--
-- -- TypeScript/JavaScript
-- setup_lsp({
--     name = 'tsserver',
--     filetypes = { "typescript", "typescriptreact", "typescript.tsx", "javascript", "javascriptreact", "javascript.jsx" },
--     cmd = { "typescript-language-server", "--stdio" },
--     on_attach = on_attach,
--     capabilities = capabilities,
--     root_dir = function(fname)
--         return vim.fs.dirname(vim.fs.find({ 'tsconfig.json', 'jsconfig.json', 'package.json', '.git' }, { upward = true, path = fname })[1])
--     end,
--     settings = {
--         completions = {
--             completeFunctionCalls = true,
--         },
--     },
-- })
--
-- -- C# / .NET
-- setup_lsp({
--     name = 'omnisharp',
--     filetypes = { 'cs' },
--     on_attach = on_attach,
--     capabilities = capabilities,
--     settings = {
--         RoslynExtensionsOptions = {
--             enableImportCompletion = true,
--             enableDecompilationSupport = true,
--             enableAnalyzersSupport = true,
--             enableAsyncCompletion = true,
--         },
--         FormattingOptions = {
--             enableEditorConfigSupport = true,
--             organizeImports = true,
--             useTabs = false,
--             indentationSize = 4,
--         },
--         InlayHintsOptions = {
--             enableForParameters = true,
--             forLiteralParameters = true,
--         },
--         MsBuild = { useModernNet = true },
--     },
--     cmd = {
--         os.getenv("HOME") .. "/.local/share/omnisharp/OmniSharp",
--         "--languageserver",
--         "--hostPID",
--         tostring(vim.fn.getpid())
--     },
--     root_dir = function(fname)
--         return vim.fs.dirname(vim.fs.find({ '*.sln', '*.csproj', '.git' }, { upward = true, path = fname })[1])
--     end,
--     handlers = {
--         ["textDocument/definition"] = require("omnisharp_extended").handler,
--     },
-- })
--
-- -- Go
-- setup_lsp({
--     name = 'gopls',
--     filetypes = { 'go', 'gomod', 'gowork', 'gotmpl' },
--     on_attach = on_attach,
--     capabilities = capabilities,
--     cmd = { 'gopls' },
--     root_dir = function(fname)
--         return vim.fs.dirname(vim.fs.find({ 'go.mod', '.git' }, { upward = true, path = fname })[1])
--     end,
--     settings = {
--         gopls = {
--             gofumpt = true,
--             analyses = {
--                 unusedparams = true,
--                 shadow = true,
--             },
--             staticcheck = true,
--         },
--     },
-- })
--
-- -- Filetype-specific settings
-- vim.api.nvim_create_autocmd("FileType", {
--     pattern = "cs",
--     callback = function()
--         vim.bo.autoindent = true
--         vim.bo.smartindent = true
--         vim.bo.cindent = false
--         vim.bo.indentexpr = ""
--         vim.bo.tabstop = 4
--         vim.bo.shiftwidth = 4
--         vim.bo.expandtab = true
--     end
-- })
--
-- vim.api.nvim_create_autocmd("FileType", {
--     pattern = {"go", "cs", "typescript", "typescriptreact", "typescript.tsx", "javascript", "javascriptreact"},
--     callback = function(args)
--         -- Give Treesitter time to load before LSP
--         vim.defer_fn(function()
--             -- Force refresh syntax highlighting
--             if vim.treesitter.highlighter.active then
--                 vim.cmd("syntax on")
--             end
--         end, 10)
--     end
-- })
--
--
--
--
--
-- local status, nvim_lsp = pcall(require, "lspconfig")
-- if (not status) then return end

local protocol = require('vim.lsp.protocol')
local capabilities = require("cmp_nvim_lsp").default_capabilities()

local on_attach = function(client, bufnr)
    client.server_capabilities.documentFormattingProvider = true

    -- Format on save
    vim.api.nvim_create_autocmd('BufWritePre', {
      buffer = bufnr,
      callback = function()
        vim.lsp.buf.format({ async = false })
      end
    })
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

local lsps = {
    {
        "gopls",
        {
            gofumpt = true, -- use gofumpt formatting
            analyses = {
                unusedparams = true,
                shadow = true,
            },
            staticcheck = true,
        }
    },
}

for _, lsp in pairs(lsps) do
    local name, config = lsp[1], lsp[2]
    vim.lsp.enable(name)
    if config then
        vim.lsp.config(name, config)
    end
end

-- -- TypeScript
-- nvim_lsp.ts_ls.setup {
--     on_attach = on_attach,
--     filetypes = { "typescript", "typescriptreact", "typescript.tsx" },
--     cmd = { "typescript-language-server", "--stdio" },
--     settings = {
--         completions = {
--             completeFunctionCalls = true, -- Helps with auto-import
--         },
--     },
-- }
--
-- nvim_lsp.omnisharp.setup({
--     on_attach = on_attach,
--     settings = {
--         RoslynExtensionsOptions = {
--             enableImportCompletion = true,
--             enableDecompilationSupport = true,
--             enableAnalyzersSupport = true,
--             enableAsyncCompletion = true,
--         },
--         FormattingOptions = {
--             enableEditorConfigSupport = true,
--             organizeImports = true,
--             useTabs = false,
--             indentationSize = 4,
--         },
--         InlayHintsOptions = {
--             enableForParameters = true,
--             forLiteralParameters = true,
--         },
--         MsBuild = { useModernNet = true },
--     },
--     cmd = {
--         os.getenv("HOME") .. "/.local/share/omnisharp/OmniSharp",
--         "--languageserver",
--         "--hostPID",
--         tostring(vim.fn.getpid())
--     },
--    -- cmd = { "dotnet", "/Users/arty/.local/bin/omnisharp/OmniSharp.dll" },
--     root_dir = nvim_lsp.util.root_pattern("*.sln", "*.csproj"),
--     handlers = {            -- plug the extended definition handler
--         ["textDocument/definition"] = require("omnisharp_extended").handler,
--     },
-- })
--
-- nvim_lsp.gopls.setup {
--   on_attach = on_attach,
--   capabilities = capabilities,
--   settings = {
--     gopls = {
--       gofumpt = true, -- use gofumpt formatting
--       analyses = {
--         unusedparams = true,
--         shadow = true,
--       },
--       staticcheck = true,
--     },
--   },
-- }
--
-- vim.api.nvim_create_autocmd("FileType", {
--     pattern = "cs",
--     callback = function()
--         vim.bo.autoindent = true
--         vim.bo.smartindent = true
--         vim.bo.cindent = false
--         vim.bo.indentexpr = ""
--         vim.bo.tabstop = 4
--         vim.bo.shiftwidth = 4
--         vim.bo.expandtab = true
--     end
-- })
--
-- vim.api.nvim_create_autocmd("FileType", {
--     pattern = {"go", "cs", "typescript", "typescriptreact", "typescript.tsx"},
--     callback = function()
--         -- Give Treesitter time to load before LSP
--         vim.defer_fn(function()
--             -- Force refresh syntax highlighting
--             if vim.treesitter.highlighter.active then
--                 vim.cmd("syntax on")
--             end
--         end, 50)
--     end
-- })
--
-- -- -- Filetype-specific settings
-- -- vim.api.nvim_create_autocmd("FileType", {
-- --     pattern = "cs",
-- --     callback = function()
-- --         vim.bo.autoindent = true
-- --         vim.bo.smartindent = true
-- --         vim.bo.cindent = false
-- --         vim.bo.indentexpr = ""
-- --         vim.bo.tabstop = 4
-- --         vim.bo.shiftwidth = 4
-- --         vim.bo.expandtab = true
-- --     end
-- -- })
--
vim.api.nvim_create_autocmd("FileType", {
    pattern = {"go", "cs", "typescript", "typescriptreact", "typescript.tsx", "javascript", "javascriptreact"},
    callback = function(args)
        -- Give Treesitter time to load before LSP
        vim.defer_fn(function()
            -- Force refresh syntax highlighting
            if vim.treesitter.highlighter.active then
                vim.cmd("syntax on")
            end
        end, 10)
    end
})

-- Auto-attach LSP to buffers
vim.api.nvim_create_autocmd('FileType', {
  pattern = 'go',
  callback = function()
    vim.lsp.start({
      name = 'gopls',
      cmd = { 'gopls' },
      root_dir = vim.fs.dirname(vim.fs.find({'go.mod', '.git'}, { upward = true })[1]),
    })
  end,
})
