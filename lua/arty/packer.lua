-- This file can be loaded by calling `lua require('plugins')` from your init.vim

-- Only required if you have packer configured as `opt`
vim.cmd [[packadd packer.nvim]]

return require('packer').startup(function(use)
    -- Packer can manage itself
    use 'wbthomason/packer.nvim'
    use {
        'nvim-telescope/telescope.nvim',  -- Correct spelling
        requires = { 
            'nvim-lua/plenary.nvim',
            'BurntSushi/ripgrep',  -- For live_grep
            'sharkdp/fd',         -- For find_files
        }
    }
    -- HARPOON2
    use "nvim-lua/plenary.nvim" -- don't forget to add this one if you don't have it yet!
    use {
        "ThePrimeagen/harpoon",
        branch = "harpoon2",
        requires = { {"nvim-lua/plenary.nvim"} }
    }

    use {
        'nvim-lualine/lualine.nvim',
        requires = { 'nvim-tree/nvim-web-devicons', opt = true }
    }

    use('nvim-treesitter/nvim-treesitter', {run = ':TSUpdate'} )
    use 'nvim-telescope/telescope-file-browser.nvim'
    use 'nvim-tree/nvim-tree.lua'
    use 'nvim-tree/nvim-web-devicons'   -- File icons (optional)
    use 'akinsho/nvim-bufferline.lua'
    use 'christoomey/vim-tmux-navigator'
    use 'windwp/nvim-ts-autotag'
    use {
        "akinsho/toggleterm.nvim",
        version = "*",
        config = function()
            require("toggleterm").setup()
        end
    }
    use('mbbill/undotree')
    use('tpope/vim-fugitive')
    use { "catppuccin/nvim", as = "catppuccin" }
    use({
        "kylechui/nvim-surround",
        tag = "*", -- Use for stability; omit to use `main` branch for the latest features
        config = function()
            require("nvim-surround").setup({
                -- Configuration here, or leave empty to use defaults
            })
        end
    })

    -- Utilities
    use {
        "windwp/nvim-autopairs",
        event = "InsertEnter",
        config = function()
            require("nvim-autopairs").setup {}
        end
    }
    -- LSP
    use {
        'VonHeikemen/lsp-zero.nvim',
        branch = 'v1.x',
        requires = {
            -- LSP Support
            {'neovim/nvim-lspconfig'},             -- Required
            {'williamboman/mason.nvim'},           -- Optional
            {'williamboman/mason-lspconfig.nvim'}, -- Optional

            -- Autocompletion
            {'hrsh7th/nvim-cmp'},         -- Required
            {'hrsh7th/cmp-nvim-lsp'},     -- Required
            {'hrsh7th/cmp-buffer'},       -- Optional
            {'hrsh7th/cmp-path'},         -- Optional
            {'saadparwaiz1/cmp_luasnip'}, -- Optional
            {'hrsh7th/cmp-nvim-lua'},     -- Optional

            -- Snippets
            {'L3MON4D3/LuaSnip'},             -- Required
            {'rafamadriz/friendly-snippets'}, -- Optional
        }
    }
    use 'neovim/nvim-lspconfig'         -- LSP support
    use 'hrsh7th/nvim-cmp'              -- Autocomplete engine
    use 'hrsh7th/cmp-nvim-lsp'          -- LSP completion source
    use 'mfussenegger/nvim-dap'         -- Debug Adapter Protocol
    use 'mfussenegger/nvim-dap-vscode-js' -- Debug adapter for JavaScript/TypeScript
    use 'L3MON4D3/LuaSnip'              -- Snippet engine
    use 'saadparwaiz1/cmp_luasnip'      -- Snippet completionv
    use 'onsails/lspkind-nvim'
    use { "rcarriga/nvim-dap-ui", requires = {"mfussenegger/nvim-dap", "nvim-neotest/nvim-nio"} }

    -- Required dependencies
    use "nvim-neotest/nvim-nio"
    use {
        "mfussenegger/nvim-dap",
        requires = {
            "rcarriga/nvim-dap-ui",      -- UI for DAP
            "jay-babu/mason-nvim-dap.nvim", -- Ensure DAP installations
            "williamboman/mason.nvim",    -- Manage LSP/DAP installations
            "mfussenegger/nvim-dap-vscode-js", -- JS/TS Debugging
        }
    }

    use {
        "williamboman/mason.nvim",
        "mfussenegger/nvim-dap",
        "jay-babu/mason-nvim-dap.nvim",
        "Hoffs/omnisharp-extended-lsp.nvim", -- optional for extended support
    }

    require("mason").setup({
        registries = {
            "github:mason-org/mason-registry",
            "github:Crashdummyy/mason-registry",
        },
        ensure_installed = {
            -- "omnisharp",
            "roslyn",
        }
    })
    require("mason-nvim-dap").setup({
        ensure_installed = { "js-debug-adapter", "coreclr" }, -- Auto-install JS Debug Adapter
        automatic_setup = true,
    })

    use {
        "seblyng/roslyn.nvim",
        ---@module 'roslyn.config'
        ---@type RoslynNvimConfig
        opts = {
            -- your configuration comes here; leave empty for default settings
        },
    }
    use 'fatih/vim-go'
    use 'ggandor/leap.nvim'
    -- use 'folke/which-key.nvim'
    use {
        "kdheepak/lazygit.nvim",
        cmd = "LazyGit",
        config = function()
            -- Optional: Add any basic configuration here
            vim.g.lazygit_floating_window_winblend = 0 -- Transparency (0-100)
            vim.g.lazygit_floating_window_scaling_factor = 0.9 -- Window size
        end,
    }

    use {
        "LuxVim/nvim-luxmotion",
        config = function()
            require("luxmotion").setup({
                cursor = {
                    duration = 50,
                    easing = "linear",
                },
                performance = { enabled = true },
            }
          )
      end
  }

  use({
      'MeanderingProgrammer/render-markdown.nvim',
      after = { 'nvim-treesitter' },
      requires = { 'nvim-mini/mini.nvim', opt = true },            -- if you use the mini.nvim suite
      requires = { 'nvim-mini/mini.icons', opt = true },        -- if you use standalone mini plugins
      requires = { 'nvim-tree/nvim-web-devicons', opt = true }, -- if you prefer nvim-web-devicons
      config = function()
          require('render-markdown').setup({
              heading = {
                  icons = { '[h]', '[h]', '󰲥 ', '󰲧 ', '󰲩 ', '󰲫 ' },
              },
          })
      end,
  })

  use "sindrets/diffview.nvim" 

end)

