# Neovim Configuration

Personal Neovim config for Go, TypeScript/JavaScript, and C# development.

- **Neovim:** 0.12.1
- **Plugin Manager:** [lazy.nvim](https://github.com/folke/lazy.nvim)
- **Colorscheme:** [Catppuccin](https://github.com/catppuccin/nvim) (Frappe, transparent background)
- **Leader:** `<Space>`

## Directory Structure

```
~/.config/nvim/
├── init.lua                  Entry point
├── lua/arty/
│   ├── init.lua              Loads remap + set
│   ├── lazy.lua              Plugin declarations (lazy.nvim)
│   ├── remap.lua             Global keybindings + custom functions
│   └── set.lua               Editor settings + colorscheme
└── after/plugin/
    ├── cmp.lua               Completion config
    ├── dap.lua               Debug adapter config
    ├── dapui.lua             DAP UI (minimal, handled in dap.lua)
    ├── fugitive.lua          Git keybindings
    ├── harpoon.lua           Harpoon config + telescope integration
    ├── lsp.lua               LSP servers + keybindings
    ├── lualine.lua           Statusline config
    ├── nvim-tree.lua         File explorer config
    ├── telescope.lua         Fuzzy finder config
    ├── toggleterm.lua        Terminal config
    ├── treesitter.lua        (handled in lazy.lua)
    └── undotree.lua          Undo tree keybinding
```

## Plugins

### Core

| Plugin | Purpose |
|--------|---------|
| [lazy.nvim](https://github.com/folke/lazy.nvim) | Plugin manager |
| [catppuccin](https://github.com/catppuccin/nvim) | Colorscheme (Frappe variant) |
| [plenary.nvim](https://github.com/nvim-lua/plenary.nvim) | Common Lua utilities |
| [nvim-web-devicons](https://github.com/nvim-tree/nvim-web-devicons) | File icons |

### Navigation & Files

| Plugin | Purpose |
|--------|---------|
| [telescope.nvim](https://github.com/nvim-telescope/telescope.nvim) | Fuzzy finder (files, grep, diagnostics) |
| [harpoon](https://github.com/ThePrimeagen/harpoon) (v2) | Quick file jumping (4 slots) |
| [nvim-tree.lua](https://github.com/nvim-tree/nvim-tree.lua) | File explorer sidebar |
| [nvim-bufferline.lua](https://github.com/akinsho/nvim-bufferline.lua) | Buffer tabs |

### LSP & Completion

| Plugin | Purpose |
|--------|---------|
| [nvim-lspconfig](https://github.com/neovim/nvim-lspconfig) | LSP configuration |
| [mason.nvim](https://github.com/williamboman/mason.nvim) | LSP/DAP/formatter installer |
| [mason-lspconfig.nvim](https://github.com/williamboman/mason-lspconfig.nvim) | Mason + LSP bridge |
| [nvim-cmp](https://github.com/hrsh7th/nvim-cmp) | Completion engine |
| [cmp-nvim-lsp](https://github.com/hrsh7th/cmp-nvim-lsp) | LSP completion source |
| [cmp-buffer](https://github.com/hrsh7th/cmp-buffer) | Buffer word completion |
| [cmp-path](https://github.com/hrsh7th/cmp-path) | File path completion |
| [cmp-nvim-lua](https://github.com/hrsh7th/cmp-nvim-lua) | Neovim Lua API completion |
| [cmp_luasnip](https://github.com/saadparwaiz1/cmp_luasnip) | Snippet completion source |
| [LuaSnip](https://github.com/L3MON4D3/LuaSnip) | Snippet engine |
| [friendly-snippets](https://github.com/rafamadriz/friendly-snippets) | Snippet collection |
| [lspkind-nvim](https://github.com/onsails/lspkind-nvim) | LSP kind icons in completion |
| [roslyn.nvim](https://github.com/seblyng/roslyn.nvim) | C# LSP (Roslyn) |
| [omnisharp-extended-lsp.nvim](https://github.com/Hoffs/omnisharp-extended-lsp.nvim) | Extended C# support |
| [conform.nvim](https://github.com/stevearc/conform.nvim) | Formatting engine (format-on-save) |

### Syntax & Editing

| Plugin | Purpose |
|--------|---------|
| [nvim-treesitter](https://github.com/nvim-treesitter/nvim-treesitter) | Syntax highlighting + parsing |
| [nvim-ts-autotag](https://github.com/windwp/nvim-ts-autotag) | Auto-close/rename HTML tags |
| [nvim-surround](https://github.com/kylechui/nvim-surround) | Add/change/delete surrounding pairs |
| [nvim-autopairs](https://github.com/windwp/nvim-autopairs) | Auto-close brackets/quotes |
| [indent-blankline.nvim](https://github.com/lukas-reineke/indent-blankline.nvim) | Visual indent guides |
| [todo-comments.nvim](https://github.com/folke/todo-comments.nvim) | Highlight TODO/FIXME/HACK |

### Debugging

| Plugin | Purpose |
|--------|---------|
| [nvim-dap](https://github.com/mfussenegger/nvim-dap) | Debug Adapter Protocol client |
| [nvim-dap-ui](https://github.com/rcarriga/nvim-dap-ui) | DAP UI (auto-opens on debug) |
| [nvim-dap-vscode-js](https://github.com/mfussenegger/nvim-dap-vscode-js) | JS/TS debug adapter |
| [mason-nvim-dap.nvim](https://github.com/jay-babu/mason-nvim-dap.nvim) | Auto-install debug adapters |
| [nvim-nio](https://github.com/nvim-neotest/nvim-nio) | Async I/O (DAP dependency) |

### Git

| Plugin | Purpose |
|--------|---------|
| [vim-fugitive](https://github.com/tpope/vim-fugitive) | Git commands in Vim |
| [diffview.nvim](https://github.com/sindrets/diffview.nvim) | Git diff viewer |
| [gitsigns.nvim](https://github.com/lewis6991/gitsigns.nvim) | Git signs in gutter + hunk staging |
| [lazygit.nvim](https://github.com/kdheepak/lazygit.nvim) | LazyGit integration |

### Terminal & UI

| Plugin | Purpose |
|--------|---------|
| [toggleterm.nvim](https://github.com/akinsho/toggleterm.nvim) | Terminal management (float/split/tab) |
| [lualine.nvim](https://github.com/nvim-lualine/lualine.nvim) | Statusline |
| [trouble.nvim](https://github.com/folke/trouble.nvim) | Better diagnostics/quickfix list |
| [undotree](https://github.com/mbbill/undotree) | Undo history visualizer |
| [render-markdown.nvim](https://github.com/MeanderingProgrammer/render-markdown.nvim) | Markdown rendering |
| [vim-tmux-navigator](https://github.com/christoomey/vim-tmux-navigator) | Tmux pane navigation |

## LSP Servers

Configured via Neovim 0.11+ native LSP API (`vim.lsp.config` / `vim.lsp.enable`).

| Server | Language | Features |
|--------|----------|----------|
| `gopls` | Go | gofumpt, staticcheck, shadow analysis, unused params |
| `ts_ls` | TypeScript/JavaScript | TS/JS/TSX/JSX |
| `roslyn` | C# | Inlay hints, code lens, references |

## Keybindings

Leader key: `<Space>`

### General

| Key | Mode | Action |
|-----|------|--------|
| `::` | n | Open command history |
| `//` | n | Open search history |
| `??` | n | Open reverse search history |
| `<Esc>` | t | Exit terminal mode |
| `<C-q>` | t | Exit terminal mode (alt) |
| `<leader>cs` | v | Convert selection to snake_case |
| `:RemoveCR` | cmd | Remove carriage returns from file |

### File Explorer (NvimTree)

| Key | Mode | Action |
|-----|------|--------|
| `<C-n>` | n | Toggle NvimTree |
| `<leader>e` | n | Open tree and reveal current file |
| `<leader>pv` | n | Open tree and reveal current file (alias) |

**Inside NvimTree:**

| Key | Action |
|-----|--------|
| `o` / `l` | Open file or folder |
| `h` | Close directory |
| `P` | Go to parent directory |
| `so` | Open in horizontal split |
| `vo` | Open in vertical split |
| `to` | Open in new tab |

### Telescope (Fuzzy Finder)

| Key | Mode | Action |
|-----|------|--------|
| `<leader>pf` | n | Find files |
| `<C-p>` | n | Git files |
| `<leader>ps` | n | Live grep (project search) |
| `<leader>ld` | n | Diagnostics |
| `<leader>p?` | n | List all commands |
| `<leader>pc` | n | Current buffer fuzzy find |
| `<leader>nf` | n | Find notes (~/work/spec) |
| `<leader>nn` | n | Search notes content |

**Inside Telescope:**

| Key | Action |
|-----|--------|
| `<C-j>` | Next item |
| `<C-k>` | Previous item |

### Harpoon (Quick File Jumping)

| Key | Mode | Action |
|-----|------|--------|
| `<leader>a` | n | Add current file to harpoon |
| `<leader>hd` | n | Remove current file from harpoon |
| `<C-e>` | n | Open harpoon menu (via Telescope) |
| `<C-h>` | n | Jump to harpoon slot 1 |
| `<C-j>` | n | Jump to harpoon slot 2 |
| `<C-k>` | n | Jump to harpoon slot 3 |
| `<C-l>` | n | Jump to harpoon slot 4 |
| `<C-S-P>` | n | Previous harpoon file |
| `<C-S-N>` | n | Next harpoon file |

### LSP Management

| Key | Mode | Action |
|-----|------|--------|
| `<leader>lr` | n | Restart LSP (stop all clients + reload buffer) |
| `<leader>li` | n | LSP info |
| `<leader>lh` | n | LSP checkhealth |

### LSP

Available in buffers with an active language server.

| Key | Mode | Action |
|-----|------|--------|
| `K` | n | Hover documentation |
| `gd` | n | Go to definition |
| `gD` | n | Go to declaration |
| `gi` | n | Go to implementation |
| `go` | n | Go to type definition |
| `gr` | n | Find references |
| `gs` | n | Signature help |
| `ga` | n | Code action |
| `gl` | n | Show diagnostic float |
| `<F2>` | n | Rename symbol |
| `<F3>` | n, x | Format (async) |
| `<F4>` | n | Code action |
| `[d` | n | Previous diagnostic |
| `]d` | n | Next diagnostic |
| `<leader>q` | n | Open diagnostics list |

### Formatting (conform.nvim)

| Key | Mode | Action |
|-----|------|--------|
| `<leader>cf` | n, v | Format buffer/selection |
| (auto) | - | Format on save (all configured filetypes) |

**Configured formatters:**
- Go: gofumpt, goimports
- JS/TS/TSX/JSX: prettier
- JSON/YAML/Markdown/CSS/HTML: prettier
- Lua: stylua

### Completion (nvim-cmp)

| Key | Mode | Action |
|-----|------|--------|
| `<CR>` | i | Confirm selection |
| `<C-c>` | i | Trigger completion |
| `<C-e>` | i | Abort completion |
| `<Tab>` | i, s | Next item (or insert tab) |
| `<S-Tab>` | i, s | Previous item |

**Sources (priority order):** LSP > Snippets > Path > Buffer

### Debugging (DAP)

| Key | Mode | Action |
|-----|------|--------|
| `<F5>` | n | Start/continue debugging |
| `<F10>` | n | Step over |
| `<F11>` | n | Step into |
| `<F12>` | n | Step out |
| `<leader>b` | n | Toggle breakpoint |
| `<leader>B` | n | Conditional breakpoint |
| `<leader>ui` | n | Toggle DAP UI |

**Configured adapters:**
- **JS/TS:** pwa-node, pwa-chrome (via js-debug-adapter)
- **C#:** coreclr (via netcoredbg)
- **Go:** delve (local launch, package, test, attach, remote)

### Git

| Key | Mode | Action |
|-----|------|--------|
| `<leader>gs` | n | Git status (fugitive) |
| `<leader>gd` | n | Git diff vs index |
| `<leader>gb` | n | Git blame |
| `<leader>gl` | n | Git log (file) |
| `<leader>gT` | n | Toggle Diffview file panel |
| `<leader>gq` | n | Close Diffview |
| `<leader>gh` | n | File history (Diffview) |
| `<leader>gH` | n | Current file history (Diffview) |
| `<leader>gwa` | n | Add git worktree |
| `<leader>gwl` | n | List git worktrees |
| `<leader>gwr` | n | Remove git worktree |
| `]f` | n | Next diff file |
| `[f` | n | Previous diff file |

### Git Signs (gitsigns.nvim)

| Key | Mode | Action |
|-----|------|--------|
| `]c` | n | Next hunk |
| `[c` | n | Previous hunk |
| `<leader>hs` | n, v | Stage hunk |
| `<leader>hr` | n, v | Reset hunk |
| `<leader>hS` | n | Stage entire buffer |
| `<leader>hu` | n | Undo stage hunk |
| `<leader>hR` | n | Reset entire buffer |
| `<leader>hp` | n | Preview hunk |
| `<leader>hb` | n | Blame line (full) |
| `<leader>hB` | n | Toggle inline blame |

### Diagnostics (trouble.nvim)

| Key | Mode | Action |
|-----|------|--------|
| `<leader>xx` | n | Toggle workspace diagnostics |
| `<leader>xX` | n | Toggle buffer diagnostics |
| `<leader>xq` | n | Toggle quickfix list |

### Terminal (toggleterm)

| Key | Mode | Action |
|-----|------|--------|
| `<C-\>` | all | Toggle terminal (default float) |
| `<leader>tt` | n | Toggle general terminal |
| `<leader>ta` | n | Toggle all terminals |
| `<leader>ts` | n | Toggle server terminal (float) |
| `<leader>tg` | n | Toggle git terminal (float) |
| `<leader>td` | n | Toggle database terminal (tab) |
| `<leader>th` | n | Terminal #1 (horizontal) |
| `<leader>tv` | n | Terminal #2 (vertical) |
| `<leader>tV` | n | Terminal #3 (vertical) |
| `<leader>tf` | n | Terminal #4 (float) |
| `<leader>t1`-`t4` | n | Float terminals #101-104 |
| `<leader>t0` | n | Open 2 horizontal terminals |

**Send to terminal:**

| Key | Mode | Action |
|-----|------|--------|
| `<Space>s` | v | Send visual selection to terminal |
| `<leader><C-\>` | n | Send motion to terminal |
| `<leader><C-\><C-\>` | n | Send current line to terminal |
| `<leader><leader><C-\>` | n | Send whole file to terminal |

### Undo

| Key | Mode | Action |
|-----|------|--------|
| `<leader>u` | n | Toggle undo tree |

## Editor Settings

| Setting | Value |
|---------|-------|
| Tab width | 4 spaces (expandtab) |
| Line numbers | Relative + absolute |
| Color column | 100 |
| Scroll offset | 10 lines |
| Search | Incremental, no persistent highlight |
| Swap/backup | Disabled |
| Undo | Persistent (`~/.vim/undodir`) |
| Clipboard | System clipboard (`unnamedplus`) |
| Sign column | Always visible |
| Smart indent | Enabled |
| Word wrap | Disabled |

## Custom Commands

| Command | Action |
|---------|--------|
| `:RemoveCR` | Remove carriage returns from file |
| `:make` (in .ts files) | Run `npx tsc --noEmit` |
| `:LazyGit` | Open LazyGit |
| `:Mason` | Open Mason package manager |
| `:Lazy` | Open lazy.nvim plugin manager |
| `:ConformInfo` | Show formatter info |
| `:Trouble` | Open trouble.nvim |

## First-Time Setup

1. Open Neovim: `v`
2. Lazy.nvim will auto-bootstrap and install all plugins
3. Run `:Lazy sync` to ensure everything is up to date
4. Run `:Mason` to verify LSP servers / debug adapters are installed
5. Run `:checkhealth` to verify everything is healthy
