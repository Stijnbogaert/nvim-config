local function setup()
	local config = require("nvim-treesitter.configs")

	config.setup({
		auto_install = true,
		highlight = { enabled = true },
		indent = { enabled = true },
	})
end

return { "nvim-treesitter/nvim-treesitter", build = ":TSUpdate", config = setup }
