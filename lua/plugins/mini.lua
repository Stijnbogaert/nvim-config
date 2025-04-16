return {
	{ "echasnovski/mini-git", version = false, main = "mini.git", opts = {} },
	{ "echasnovski/mini.diff", version = false, opts = {} },
	{ "echasnovski/mini.icons", version = false, opts = {} },
	{ "echasnovski/mini.statusline", version = false, opts = {} },
	{ "echasnovski/mini.comment", version = "*", opts = { mappings = require("config.keymaps").mini_comment() } },
	{ "echasnovski/mini.surround", version = "*", opts = { mappings = require("config.keymaps").mini_surround() } },
	{ "echasnovski/mini.align", version = "*", opts = {} },
}
