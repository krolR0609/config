-- require('lualine').setup()
vim.opt.termguicolors = true
-- vim.opt.guifont = "FiraCode Nerd Font Mono:h12"

-- For plugins that use Nerd Font icons
require('lualine').setup({
  options = {
    theme = 'auto',
    icons_enabled = true,
    component_separators = { left = '', right = ''},
    section_separators = { left = '', right = ''},
  }
})
