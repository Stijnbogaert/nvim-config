function setup()
  require('lualine').setup({
      options = { theme  = 'dracula' },
      sections ={
        lualine_c = {{'filename', path=1}}
      }
    })
end
return {
    'nvim-lualine/lualine.nvim',
    dependencies = { 'nvim-tree/nvim-web-devicons'},
    config=setup
}
