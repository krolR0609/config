vim.opt.guicursor = ""

vim.opt.nu = true
vim.opt.relativenumber = true

vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true

vim.opt.smartindent = true

vim.opt.wrap = false

vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undodir = os.getenv("HOME") .. "/.vim/undodir"
vim.opt.undofile = true

vim.opt.hlsearch = false
vim.opt.incsearch = true

vim.opt.termguicolors = true

vim.opt.scrolloff = 10
vim.opt.signcolumn = "yes"
vim.opt.isfname:append("@-@")
vim.opt.sidescroll = 1

vim.opt.updatetime = 50

vim.opt.colorcolumn = "100"

require("catppuccin").setup()
vim.cmd.colorscheme "catppuccin"

vim.opt.incsearch = true
vim.opt.spelllang = 'en_us'
vim.opt.clipboard = 'unnamedplus'

-- use :make to buidl typescript
vim.api.nvim_create_autocmd("FileType", {
  pattern = "typescript",
  callback = function()
    vim.opt_local.makeprg = "npx tsc --noEmit"
    vim.opt_local.errorformat = "%f(%l,%c): %m"
  end,
})

vim.api.nvim_create_autocmd("BufEnter", {
  nested = true,
  callback = function()
    local wins = vim.api.nvim_list_wins()
    local tabwins = #wins
    local bufs = vim.fn.getbufinfo({ buflisted = 1 })
    if tabwins == 1 and #bufs == 1 and bufs[1].name:match("NvimTree_") then
      vim.cmd("quit")
    end
  end,
})

-- vim.g.lspconfig_disable_health_check = true
