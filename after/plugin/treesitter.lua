-- New nvim-treesitter is a parser manager only.
-- Highlighting is built into Neovim — enable it for all buffers with a parser.
vim.api.nvim_create_autocmd('FileType', {
  callback = function()
    pcall(vim.treesitter.start)
  end,
})
