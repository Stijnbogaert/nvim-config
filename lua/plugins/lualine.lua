function setup()
  require('lualine').setup({
      options = { theme  = 'dracula' }
    })
end
return {
    'nvim-lualine/lualine.nvim',
    dependencies = { 'nvim-tree/nvim-web-devicons'},
    config=setup
}
