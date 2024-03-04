function setup()
 local config = require("nvim-treesitter.configs")

  config.setup({
    ensure_installed = {"rust", "lua"},
    highlight = {enabled=true},
    indent = {enabled = true},
  })
 
end
return {"nvim-treesitter/nvim-treesitter", build = ":TSUpdate",config=setup}
