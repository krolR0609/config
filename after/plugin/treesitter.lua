-- Add nvim-treesitter runtime queries to runtimepath
local ts_path = vim.fn.stdpath('data') .. '/site/pack/packer/start/nvim-treesitter/runtime'
if vim.uv.fs_stat(ts_path) then
  vim.opt.rtp:append(ts_path)
end

-- Enable treesitter highlighting for all buffers with a parser
vim.api.nvim_create_autocmd('FileType', {
  callback = function()
    pcall(vim.treesitter.start)
  end,
})
