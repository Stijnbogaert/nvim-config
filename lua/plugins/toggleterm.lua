local function setup()
  require("toggleterm").setup({
      open_mapping = [[<c-\>]],
  })


end
return   {'akinsho/toggleterm.nvim', version = "*", config =setup}
