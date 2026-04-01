require("config.autosave")
require("config.options")
require("config.lazy")
require("config.keymaps").general()

langs = { "c", "lua", "vim", "vimdoc", "rust", "query", "elixir", "typescript", "javascript", "html" }

require("nvim-treesitter").install(langs)

vim.cmd("packadd nvim.undotree")
vim.keymap.set("n", "<leader>u", require("undotree").open)
