table.insert(vim._so_trails, "/?.dylib")
-- require("dap-vscode-js").setup({
--   debugger_path = vim.fn.stdpath("data") .. "mason/packages/js-debug-adapter/js-debug",
--   adapters = { "pwa-node", "pwa-chrome", "pwa-msedge", "node-terminal" },
-- })
--
-- require("dap-vscode-js").setup({
--     debugger_path = vim.fn.resolve(vim.fn.stdpath("data") .. "/site/pack/packer/opt/vscode-js-debug"),
--     adapters = { 'chrome', 'pwa-node', 'pwa-chrome', 'pwa-msedge', 'node-terminal', 'pwa-extensionhost', 'node', 'chrome' }, -- which adapters to register in nvim-dap
--   -- log_file_path = "(stdpath cache)/dap_vscode_js.log" -- path for file logging
--   -- log_file_level = false -- logging level for output to file. set to false to disable file logging.
--   -- log_console_level = vim.log.levels.error -- logging level for output to console. set to false to disable console output.
-- })
--
local exts = {
        "javascript",
        "typescript",
        "javascriptreact",
        "typescriptreact",
        "vue",
        "svelte",
        "csharp",
      }

local dap = require("dap")
dap.adapters["node"] = {
    type = "server",
    host = "localhost",
    port = "${port}",
    executable = {
        command = "node",
        args = { vim.fn.stdpath("data") .. "/mason/packages/js-debug-adapter/js-debug/src/dapDebugServer.js", "${port}" },
    }
}
dap.adapters["pwa-node"] = {
    type = "server",
    host = "localhost",
    port = "${port}",
    executable = {
        command = "node",
        args = { vim.fn.stdpath("data") .. "/mason/packages/js-debug-adapter/js-debug/src/dapDebugServer.js", "${port}" },
    }
}
for i, ext in ipairs(exts) do
    dap.configurations[ext] = {
        {
            type = "pwa-node",
            request = "launch",
            name = "Launch file",
            program = "${file}",
            cwd = vim.fn.getcwd(),
            sourceMaps = true,
        },
        {
            type = "pwa-chrome",
            request = "launch",
            name = "Launch Chrome with \"localhost\"",
            url = function()
                local co = coroutine.running()
                return coroutine.create(function()
                    vim.ui.input({ prompt = 'Enter URL: ', default = 'http://localhost:3000' }, function(url)
                        if url == nil or url == '' then
                            return
                        else
                            coroutine.resume(co, url)
                        end
                    end)
                end)
            end,
            webRoot = '${workspaceFolder}',
            protocol = 'inspector',
            sourceMaps = true,
            userDataDir = false,
            skipFiles = { "<node_internals>/**", "node_modules/**", "${workspaceFolder}/node_modules/**" },
            resolveSourceMapLocations = {
                "${webRoot}/*",
                "${webRoot}/apps/**/**",
                "${workspaceFolder}/apps/**/**",
                "${webRoot}/packages/**/**",
                "${workspaceFolder}/packages/**/**",
                "${workspaceFolder}/*",
                "!**/node_modules/**",
            }
        }
    }
end

dap.adapters.coreclr = {
  type = 'executable',
  command = vim.fn.stdpath("data") .. '/mason/packages/netcoredbg/netcoredbg',
  args = { '--interpreter=vscode' }
}

dap.configurations.cs = {
    {
        type = "coreclr",
        name = "Launch - NetCoreDbg",
        request = "launch",
        program = function()
            local cwd = vim.fn.getcwd()
            local handle = io.popen("find " .. cwd .. "/bin/Debug -name '*.dll' | head -n 1")
            local result = handle:read("*a")
            handle:close()

            local dll_path = result:gsub("%s+", "") -- trim any whitespace/newline
            if dll_path == "" then
                error("Could not find a .dll in bin/Debug. Make sure the project is built.")
            end
            return dll_path
        end,
    }
}

require("dapui").setup()

local dapui = require("dapui")

dap.listeners.after.event_initialized["dapui_config"] = function()
  dapui.open({})
end
dap.listeners.before.event_terminated["dapui_config"] = function()
  dapui.close({})
end
dap.listeners.before.event_exited["dapui_config"] = function()
  dapui.close({})
end

vim.keymap.set('n', '<leader>ui', require 'dapui'.toggle)

-- Set keymaps to control the debugger
vim.keymap.set('n', '<F5>', function()
    if vim.fn.filereadable(".vscode/launch.json") then
        local dap_vscode = require("dap.ext.vscode")
        dap_vscode.load_launchjs(nil, {
            ["node"] = js_based_languages,
            ["pwa-node"] = js_based_languages,
            ["chrome"] = js_based_languages,
            ["pwa-chrome"] = js_based_languages,
        })
    end
    require("dap").continue()
end)
vim.keymap.set('n', '<F10>', require 'dap'.step_over)
vim.keymap.set('n', '<F11>', require 'dap'.step_into)
vim.keymap.set('n', '<F12>', require 'dap'.step_out)
vim.keymap.set('n', '<leader>b', require 'dap'.toggle_breakpoint)
vim.keymap.set('n', '<leader>B', function()
    require 'dap'.set_breakpoint(vim.fn.input('Breakpoint condition: '))
end)
--
-- require('dap.ext.vscode').load_launchjs(nil,
--   { ['pwa-node'] = js_based_languages,
--     ['node'] = js_based_languages,
--     ['chrome'] = js_based_languages,
--     ['pwa-chrome'] = js_based_languages }
-- )
