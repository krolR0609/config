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
for _, ext in ipairs(exts) do
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
            if not handle then
                error("Failed to search for .dll files in bin/Debug")
            end
            local result = handle:read("*a")
            handle:close()

            local dll_path = result:gsub("%s+", "")
            if dll_path == "" then
                error("Could not find a .dll in bin/Debug. Make sure the project is built.")
            end
            return dll_path
        end,
    }
}

-- Go (delve) adapter
local dlv_path = vim.fn.exepath("dlv")
if dlv_path == "" then
    dlv_path = "/home/nick/.gvm/pkgsets/go1.24.5/global/bin/dlv"
end

dap.adapters.delve = {
    type = "server",
    port = "${port}",
    executable = {
        command = dlv_path,
        args = { "dap", "-l", "127.0.0.1:${port}" },
    },
}

-- For attaching to a dlv DAP server you started manually:
-- Run: dlv debug . --headless --listen=:38697 --api-version=2 --accept-multiclient
dap.adapters.delve_remote = function(cb, config)
    vim.ui.input({ prompt = "Delve port (default 38697): ", default = "38697" }, function(port)
        cb({
            type = "server",
            host = "127.0.0.1",
            port = tonumber(port) or 38697,
        })
    end)
end

dap.configurations.go = {
    {
        type = "delve",
        name = "Debug",
        request = "launch",
        program = "${file}",
    },
    {
        type = "delve",
        name = "Debug Package",
        request = "launch",
        program = "${workspaceFolder}",
    },
    {
        type = "delve",
        name = "Debug Test",
        request = "launch",
        mode = "test",
        program = "${file}",
    },
    {
        type = "delve",
        name = "Debug Test (go.mod)",
        request = "launch",
        mode = "test",
        program = "./${relativeFileDirname}",
    },
    {
        type = "delve",
        name = "Attach to process",
        request = "attach",
        mode = "local",
        processId = require("dap.utils").pick_process,
    },
    {
        type = "delve_remote",
        name = "Attach to running dlv server",
        request = "attach",
        mode = "remote",
    },
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

vim.keymap.set('n', '<leader>ui', dapui.toggle)

-- Debugger keymaps
vim.keymap.set('n', '<F5>', function()
    if vim.fn.filereadable(".vscode/launch.json") == 1 then
        local dap_vscode = require("dap.ext.vscode")
        dap_vscode.load_launchjs(nil, {
            ["node"] = exts,
            ["pwa-node"] = exts,
            ["chrome"] = exts,
            ["pwa-chrome"] = exts,
        })
    end
    require("dap").continue()
end)
vim.keymap.set('n', '<F10>', require('dap').step_over)
vim.keymap.set('n', '<F11>', require('dap').step_into)
vim.keymap.set('n', '<F12>', require('dap').step_out)
vim.keymap.set('n', '<leader>b', require('dap').toggle_breakpoint)
vim.keymap.set('n', '<leader>B', function()
    require('dap').set_breakpoint(vim.fn.input('Breakpoint condition: '))
end)
