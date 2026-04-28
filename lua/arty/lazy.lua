-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git", "clone", "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable",
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
  -- Telescope
  {
    "nvim-telescope/telescope.nvim",
    cmd = "Telescope",
    keys = {
      { "<leader>pf", function() require("telescope.builtin").find_files() end, desc = "Find files" },
      { "<C-p>",      function() require("telescope.builtin").git_files() end,  desc = "Git files" },
      { "<leader>ps", function() require("telescope.builtin").live_grep() end, desc = "Live grep" },
      { "<leader>ld", function() require("telescope.builtin").diagnostics({ severity_limit = "Error", layout_config = { width = 0.9 } }) end, desc = "Diagnostics" },
      { "<leader>p?", function() require("telescope.builtin").commands() end, desc = "Commands" },
      { "<leader>pc", function() require("telescope.builtin").current_buffer_fuzzy_find() end, desc = "Buffer fuzzy find" },
      { "<leader>pb", function() require("telescope.builtin").buffers() end, desc = "Open buffers" },
      { "<leader>po", function() require("telescope.builtin").oldfiles() end, desc = "Recent files" },
      { "<leader>pj", function() require("telescope.builtin").jumplist() end, desc = "Jump list" },
      { "<leader>sw", function() require("telescope.builtin").grep_string({ search = vim.fn.expand("<cword>") }) end, desc = "Search word under cursor" },
      { "<leader>ss", function() require("telescope.builtin").lsp_document_symbols() end, desc = "Document symbols" },
      { "<leader>sS", function() require("telescope.builtin").lsp_workspace_symbols() end, desc = "Workspace symbols" },
      { "<leader>sr", function() require("telescope.builtin").lsp_references() end, desc = "LSP references (picker)" },
      { "<leader>sd", function() require("telescope.builtin").lsp_definitions() end, desc = "LSP definitions (picker)" },
      { "<leader>nf", function() require("telescope.builtin").find_files({ cwd = "~/work/spec", prompt_title = "Notes files" }) end, desc = "Find notes" },
      { "<leader>nn", function() require("telescope.builtin").live_grep({ cwd = "~/work/spec", prompt_title = "Search Notes" }) end, desc = "Search notes" },
    },
    dependencies = {
      "nvim-lua/plenary.nvim",
      { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
    },
    config = function()
      require("telescope").setup({
        defaults = {
          mappings = {
            i = {
              ["<C-j>"] = require("telescope.actions").move_selection_next,
              ["<C-k>"] = require("telescope.actions").move_selection_previous,
            },
          },
          layout_strategy = "vertical",
          layout_config = {
            vertical = {
              preview_height = 0.5,
              preview_cutoff = 40,
            },
          },

        },
        pickers = {
          diagnostics = {
            severity_limit = "Warning",
            initial_mode = "normal",
          },
        },
      })
      pcall(require("telescope").load_extension, "fzf")
    end,
  },

  -- Harpoon 2
  {
    "ThePrimeagen/harpoon",
    branch = "harpoon2",
    dependencies = { "nvim-lua/plenary.nvim" },
    keys = {
      { "<leader>a",   function() require("harpoon"):list():add() end, desc = "Harpoon add" },
      { "<leader>hd",  function() require("harpoon"):list():remove() end, desc = "Harpoon remove" },
      { "<C-e>",       function()
          local harpoon = require("harpoon")
          local conf = require("telescope.config").values
          local items = harpoon:list().items
          local paths = {}
          for _, item in ipairs(items) do table.insert(paths, item.value) end
          require("telescope.pickers").new({}, {
            prompt_title = "Harpoon",
            finder = require("telescope.finders").new_table({ results = paths }),
            previewer = conf.file_previewer({}),
            sorter = conf.generic_sorter({}),
          }):find()
        end, desc = "Harpoon menu (telescope)" },
      { "<C-h>", function() require("harpoon"):list():select(1) end, desc = "Harpoon 1" },
      { "<C-j>", function() require("harpoon"):list():select(2) end, desc = "Harpoon 2" },
      { "<C-k>", function() require("harpoon"):list():select(3) end, desc = "Harpoon 3" },
      { "<C-l>", function() require("harpoon"):list():select(4) end, desc = "Harpoon 4" },
      { "<C-S-P>", function() require("harpoon"):list():prev() end, desc = "Harpoon prev" },
      { "<C-S-N>", function() require("harpoon"):list():next() end, desc = "Harpoon next" },
    },
    config = function()
      require("harpoon"):setup()
    end,
  },

  -- Status line
  {
    "nvim-lualine/lualine.nvim",
    event = "VeryLazy",
    dependencies = { "nvim-tree/nvim-web-devicons" },
  },

  -- Treesitter
  {
    "nvim-treesitter/nvim-treesitter",
    branch = "main",
    build = ":TSUpdate",
    event = { "BufReadPost", "BufNewFile" },
    config = function()
      require("nvim-treesitter.install").compilers = { "gcc", "cc", "clang" }
      require("nvim-treesitter").setup({})
      -- nvim-treesitter main branch dropped highlight/indent modules.
      -- Enable Neovim's built-in treesitter highlighting per buffer.
      vim.api.nvim_create_autocmd("FileType", {
        callback = function(ev)
          pcall(vim.treesitter.start, ev.buf)
        end,
      })
    end,
  },

  -- Auto-close HTML tags
  {
    "windwp/nvim-ts-autotag",
    event = "InsertEnter",
    opts = {},
  },

  -- File explorer (not lazy — needed by <leader>e and <leader>pv on startup)
  {
    "nvim-tree/nvim-tree.lua",
    lazy = false,
    dependencies = { "nvim-tree/nvim-web-devicons" },
  },

  -- File icons
  { "nvim-tree/nvim-web-devicons", lazy = true },

  -- Buffer tabs
  {
    "akinsho/nvim-bufferline.lua",
    event = "VeryLazy",
    opts = {},
  },

  -- Tmux navigation
  { "christoomey/vim-tmux-navigator", event = "VeryLazy" },

  -- Terminal
  {
    "akinsho/toggleterm.nvim",
    version = "*",
    lazy = false,
    config = function()
      local toggleterm = require("toggleterm")

      toggleterm.setup({
        size = function(term)
          if term.direction == "horizontal" then
            return 25 
          elseif term.direction == "vertical" then
            return math.floor(vim.o.columns * 0.40)
          end
        end,
        hide_numbers = true,
        shade_terminals = true,
        shading_factor = 2,
        direction = "float",
        start_in_insert = true,
        insert_mappings = true,
        persist_size = true,
        close_on_exit = true,
        shell = vim.o.shell,
        float_opts = {
        -- The border key is *almost* the same as 'nvim_open_win'
        -- see :h nvim_open_win for details on borders however
        -- the 'curved' border is a custom border type
        -- not natively supported but implemented in this plugin.
        -- border = 'single' | 'double' | 'shadow' | 'curved' | ... other options supported by win open
        -- like `size`, width, height, row, and col can be a number or function which is passed the current terminal
        -- width = 98,
        height = 100,
        -- winblend = 3,
        -- title_pos = 'left' | 'center' | 'right', position of the title of the floating window
        },
      })

      local Terminal = require("toggleterm.terminal").Terminal
      local toggle   = require("toggleterm").toggle

      local server_term = Terminal:new({ hidden = true, direction = "float", count = 1 })
      local git_term    = Terminal:new({ hidden = true, direction = "float", count = 2 })
      local db_term     = Terminal:new({ hidden = true, direction = "tab",   count = 3 })
      local claude_term = Terminal:new({ cmd = "claude", hidden = true, direction = "float", count = 201, close_on_exit = false })
      local claude_continue_term = Terminal:new({ cmd = "claude --continue", hidden = true, direction = "float", count = 202, close_on_exit = false })
      local cursor_agent_term = Terminal:new({ cmd = "cursor-agent", hidden = true, direction = "float", count = 203, close_on_exit = false })

      local map  = vim.keymap.set
      local opts = { noremap = true, silent = true }
      local function executable_or_notify(cmd, label)
        if vim.fn.executable(cmd) == 1 then
          return true
        end
        vim.notify(label .. " is not installed or not in PATH", vim.log.levels.WARN)
        return false
      end

      map("n", "<leader>ta", "<Cmd>ToggleTermToggleAll<CR>",              { desc = "Toggle all terminals" })
      map("n", "<leader>ts", function() server_term:toggle() end,         { desc = "Toggle Server Terminal" })
      map("n", "<leader>tg", function() git_term:toggle() end,            { desc = "Toggle Git Terminal" })
      map("n", "<leader>td", function() db_term:toggle() end,             { desc = "Toggle Database Terminal" })
      map("n", "<leader>tc", function()
        if executable_or_notify("claude", "claude") then
          claude_term:toggle()
        end
      end, { desc = "Toggle Claude terminal" })
      map("n", "<leader>tC", function()
        if executable_or_notify("claude", "claude") then
          claude_continue_term:toggle()
        end
      end, { desc = "Toggle Claude resume terminal" })
      map("n", "<leader>tA", function()
        if executable_or_notify("cursor-agent", "cursor-agent") then
          cursor_agent_term:toggle()
        end
      end, { desc = "Toggle Cursor Agent terminal" })
      map("n", "<leader>th", function() toggle(1, 15, vim.fn.getcwd(), "horizontal") end,
        vim.tbl_extend("force", opts, { desc = "ToggleTerm #1 (horizontal)" }))
      map("n", "<leader>tv", function() toggle(2, 0,  vim.fn.getcwd(), "vertical") end,
        vim.tbl_extend("force", opts, { desc = "ToggleTerm #2 (vertical-1)" }))
      map("n", "<leader>tV", function() toggle(3, 0,  vim.fn.getcwd(), "vertical") end,
        vim.tbl_extend("force", opts, { desc = "ToggleTerm #3 (vertical-2)" }))
      map("n", "<leader>tf", function() toggle(4, 20, vim.fn.getcwd(), "float") end,
        vim.tbl_extend("force", opts, { desc = "ToggleTerm #4 (float)" }))
      map("n", "<leader>t1", function() toggle(101, 20, vim.fn.getcwd(), "float") end,
        vim.tbl_extend("force", opts, { desc = "Any Term #101 (float)" }))
      map("n", "<leader>t2", function() toggle(102, 20, vim.fn.getcwd(), "float") end,
        vim.tbl_extend("force", opts, { desc = "Any Term #102 (float)" }))
      map("n", "<leader>t3", function() toggle(103, 20, vim.fn.getcwd(), "float") end,
        vim.tbl_extend("force", opts, { desc = "Any Term #103 (float)" }))
      map("n", "<leader>t4", function() toggle(104, 20, vim.fn.getcwd(), "float") end,
        vim.tbl_extend("force", opts, { desc = "Any Term #104 (float)" }))
      map("n", "<leader>t0", function()
        toggle(10, 15, vim.fn.getcwd(), "horizontal")
        vim.cmd("wincmd j")
        toggle(11, 15, vim.fn.getcwd(), "horizontal")
      end, { desc = "Open 2 horizontal terminals" })
      map("n", "<leader>tt", "<cmd>ToggleTerm<CR>", { desc = "Toggle General Terminal" })
      map("n", [[<C-\>]], "<cmd>ToggleTerm<CR>", vim.tbl_extend("force", opts, { desc = "Toggle terminal" }))
      map("i", [[<C-\>]], "<Esc><cmd>ToggleTerm<CR>", vim.tbl_extend("force", opts, { desc = "Toggle terminal" }))
      map("t", "<C-q>", [[<C-\><C-n>]], { noremap = true })
    end,
  },

  -- Undo tree
  {
    "mbbill/undotree",
    cmd = "UndotreeToggle",
    keys = { { "<leader>u", "<cmd>UndotreeToggle<CR>", desc = "Toggle undotree" } },
  },

  -- Git
  {
    "tpope/vim-fugitive",
    cmd = { "Git", "Gdiffsplit" },
    keys = {
      { "<leader>gs", "<cmd>Git<CR>",        desc = "Git status (fugitive)" },
      { "<leader>gd", "<cmd>Gdiffsplit<CR>", desc = "Git diff vs index" },
      { "<leader>gb", "<cmd>Git blame<CR>",  desc = "Git blame" },
      { "<leader>gl", "<cmd>Git log<CR>",    desc = "Git log (file)" },
    },
  },

  -- Diffview
  {
    "sindrets/diffview.nvim",
    cmd = { "DiffviewOpen", "DiffviewClose", "DiffviewFileHistory", "DiffviewToggleFiles" },
    keys = {
      { "<leader>gT", desc = "Toggle diffview files" },
      { "<leader>gq", desc = "Close diffview" },
      { "<leader>gh", desc = "File history" },
      { "<leader>gH", desc = "Current file history" },
      { "]f", desc = "Next diff file" },
      { "[f", desc = "Prev diff file" },
    },
  },

  -- Colorscheme
  {
    "catppuccin/nvim",
    name = "catppuccin",
    lazy = false,
    priority = 1000,
  },

  -- Surround
  {
    "kylechui/nvim-surround",
    version = "*",
    event = "VeryLazy",
    opts = {},
  },

  -- Auto pairs
  {
    "windwp/nvim-autopairs",
    event = "InsertEnter",
    opts = {},
  },

  -- LSP
  {
    "neovim/nvim-lspconfig",
    lazy = false,
    dependencies = { "hrsh7th/cmp-nvim-lsp" },
  },

  -- Mason (package manager for LSP/DAP/formatters)
  {
    "williamboman/mason.nvim",
    cmd = "Mason",
    build = ":MasonUpdate",
    config = function()
      require("mason").setup({
        registries = {
          "github:mason-org/mason-registry",
          "github:Crashdummyy/mason-registry",
        },
      })
    end,
  },
  { "williamboman/mason-lspconfig.nvim", lazy = true },

  -- Completion
  {
    "hrsh7th/nvim-cmp",
    event = "InsertEnter",
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path",
      "saadparwaiz1/cmp_luasnip",
      "hrsh7th/cmp-nvim-lua",
      "onsails/lspkind-nvim",
    },
  },

  -- Snippets
  {
    "L3MON4D3/LuaSnip",
    dependencies = { "rafamadriz/friendly-snippets" },
    lazy = true,
  },

  -- DAP (debugging)
  {
    "mfussenegger/nvim-dap",
    keys = {
      { "<F5>", desc = "DAP continue" },
      { "<F10>", desc = "DAP step over" },
      { "<F11>", desc = "DAP step into" },
      { "<F12>", desc = "DAP step out" },
      { "<leader>b", desc = "Toggle breakpoint" },
      { "<leader>B", desc = "Conditional breakpoint" },
      { "<leader>ui", desc = "Toggle DAP UI" },
    },
    dependencies = {
      "rcarriga/nvim-dap-ui",
      "nvim-neotest/nvim-nio",
      "mfussenegger/nvim-dap-vscode-js",
      {
        "jay-babu/mason-nvim-dap.nvim",
        dependencies = { "williamboman/mason.nvim" },
        config = function()
          require("mason-nvim-dap").setup({
            ensure_installed = { "js-debug-adapter", "coreclr" },
            automatic_setup = true,
          })
        end,
      },
    },
  },

  -- C# LSP (Roslyn)
  {
    "seblyng/roslyn.nvim",
    ft = "cs",
    opts = {
      config = {
        settings = {
          ["csharp|inlay_hints"] = {
            csharp_enable_inlay_hints_for_implicit_object_creation = true,
            csharp_enable_inlay_hints_for_implicit_variable_types = true,
          },
          ["csharp|code_lens"] = {
            dotnet_enable_references_code_lens = true,
          },
        },
      },
    },
  },

  -- Extended C# support
  { "Hoffs/omnisharp-extended-lsp.nvim", lazy = true },

  -- LazyGit
  {
    "kdheepak/lazygit.nvim",
    cmd = "LazyGit",
    config = function()
      vim.g.lazygit_floating_window_winblend = 0
      vim.g.lazygit_floating_window_scaling_factor = 0.9
    end,
  },

  -- Markdown rendering
  {
    "MeanderingProgrammer/render-markdown.nvim",
    ft = "markdown",
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
      "nvim-tree/nvim-web-devicons",
    },
    opts = {
      heading = {
        icons = { "[h]", "[h]", "\u{f0925} ", "\u{f0927} ", "\u{f0929} ", "\u{f092b} " },
      },
    },
  },

  -----------------------------------------------
  -- NEW PLUGINS
  -----------------------------------------------

  -- Git signs in gutter
  {
    "lewis6991/gitsigns.nvim",
    event = { "BufReadPre", "BufNewFile" },
    opts = {
      signs = {
        add          = { text = "+" },
        change       = { text = "~" },
        delete       = { text = "_" },
        topdelete    = { text = "\u{203e}" },
        changedelete = { text = "~" },
      },
      on_attach = function(bufnr)
        local gs = package.loaded.gitsigns
        local function map(mode, l, r, opts)
          opts = opts or {}
          opts.buffer = bufnr
          vim.keymap.set(mode, l, r, opts)
        end
        -- Navigation
        map("n", "]c", function()
          if vim.wo.diff then return "]c" end
          vim.schedule(function() gs.next_hunk() end)
          return "<Ignore>"
        end, { expr = true, desc = "Next hunk" })
        map("n", "[c", function()
          if vim.wo.diff then return "[c" end
          vim.schedule(function() gs.prev_hunk() end)
          return "<Ignore>"
        end, { expr = true, desc = "Prev hunk" })
        -- Actions
        map("n", "<leader>hs", gs.stage_hunk, { desc = "Stage hunk" })
        map("n", "<leader>hr", gs.reset_hunk, { desc = "Reset hunk" })
        map("v", "<leader>hs", function() gs.stage_hunk({ vim.fn.line("."), vim.fn.line("v") }) end, { desc = "Stage hunk" })
        map("v", "<leader>hr", function() gs.reset_hunk({ vim.fn.line("."), vim.fn.line("v") }) end, { desc = "Reset hunk" })
        map("n", "<leader>hS", gs.stage_buffer, { desc = "Stage buffer" })
        map("n", "<leader>hu", gs.undo_stage_hunk, { desc = "Undo stage hunk" })
        map("n", "<leader>hR", gs.reset_buffer, { desc = "Reset buffer" })
        map("n", "<leader>hp", gs.preview_hunk, { desc = "Preview hunk" })
        map("n", "<leader>hb", function() gs.blame_line({ full = true }) end, { desc = "Blame line" })
        map("n", "<leader>hB", gs.toggle_current_line_blame, { desc = "Toggle line blame" })
      end,
    },
  },

  -- Better diagnostics list
  {
    "folke/trouble.nvim",
    cmd = "Trouble",
    keys = {
      { "<leader>xx", "<cmd>Trouble diagnostics toggle<cr>", desc = "Diagnostics (Trouble)" },
      { "<leader>xX", "<cmd>Trouble diagnostics toggle filter.buf=0<cr>", desc = "Buffer diagnostics" },
      { "<leader>xq", "<cmd>Trouble quickfix toggle<cr>", desc = "Quickfix (Trouble)" },
    },
    opts = {},
  },

  -- Fast in-buffer jump navigation
  {
    "folke/flash.nvim",
    event = "VeryLazy",
    opts = {},
    keys = {
      { "<leader>jj", function() require("flash").jump() end, mode = { "n", "x", "o" }, desc = "Flash jump" },
      { "<leader>jt", function() require("flash").treesitter() end, mode = { "n", "x", "o" }, desc = "Flash treesitter" },
      { "<leader>jr", function() require("flash").remote() end, mode = "o", desc = "Flash remote" },
      { "<leader>js", function() require("flash").treesitter_search() end, mode = { "o", "x" }, desc = "Flash treesitter search" },
    },
  },

  -- Symbols outline and symbol-to-symbol navigation
  {
    "stevearc/aerial.nvim",
    cmd = { "AerialToggle", "AerialOpen", "AerialClose", "AerialNavToggle" },
    keys = {
      { "<leader>so", "<cmd>AerialToggle!<CR>", desc = "Symbols outline" },
      { "]s", function() require("aerial").next({ jump = true }) end, desc = "Next symbol" },
      { "[s", function() require("aerial").prev({ jump = true }) end, desc = "Prev symbol" },
    },
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
      "nvim-tree/nvim-web-devicons",
    },
    opts = {
      backends = { "lsp", "treesitter", "markdown", "man" },
      layout = {
        default_direction = "prefer_right",
        min_width = 30,
        max_width = 40,
      },
      show_guides = true,
    },
  },

  -- Which-key (leader mappings only)
  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    opts = {
      delay = 300,
      triggers = {
        { "<leader>", mode = { "n", "v" } },
      },
    },
  },

  -- Formatting
  {
    "stevearc/conform.nvim",
    event = { "BufWritePre" },
    cmd = { "ConformInfo" },
    keys = {
      {
        "<leader>cf",
        function() require("conform").format({ async = true, lsp_fallback = true }) end,
        mode = { "n", "v" },
        desc = "Format buffer",
      },
    },
    opts = {
      formatters_by_ft = {
        go = { "gofumpt", "goimports" },
        javascript = { "prettier" },
        typescript = { "prettier" },
        typescriptreact = { "prettier" },
        javascriptreact = { "prettier" },
        json = { "prettier" },
        yaml = { "prettier" },
        markdown = { "prettier" },
        css = { "prettier" },
        html = { "prettier" },
        lua = { "stylua" },
      },
      -- format_on_save = {
      --   timeout_ms = 500,
      --   lsp_fallback = true,
      -- },
    },
  },

  -- TODO comments
  {
    "folke/todo-comments.nvim",
    event = { "BufReadPost", "BufNewFile" },
    dependencies = { "nvim-lua/plenary.nvim" },
    opts = {},
  },

  -- Indent guides
  {
    "lukas-reineke/indent-blankline.nvim",
    main = "ibl",
    event = { "BufReadPost", "BufNewFile" },
    opts = {
      indent = { char = "\u{2502}" },
      scope = { enabled = true },
    },
  },
}, {
  defaults = { lazy = false },
  checker = { enabled = false },
  change_detection = { notify = false },
})
