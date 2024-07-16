vim.wo.relativenumber = true
vim.cmd("set expandtab")
vim.cmd("set tabstop=2")
vim.cmd("set softtabstop=2")
vim.cmd("set shiftwidth=2")
vim.cmd("set number relativenumber")
vim.cmd("set nu rnu")

vim.g.mapleader = " "
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable", -- latest stable release
		lazypath,
	})
end
vim.opt.rtp:prepend(lazypath)

opts = {}

require("lazy").setup("plugins")
-- autosave
vim.api.nvim_create_autocmd({ "BufLeave", "FocusLost" }, {
  callback = function()
    if not vim.bo.readonly and vim.fn.expand("%") ~= "" and vim.bo.buftype == "" then
      vim.api.nvim_command('silent update')
    end
  end,
})
vim.keymap.set("n", "<A-k>",":m -2<CR>==" , opts)
vim.keymap.set("n", "<A-j>",":m +1<CR>==" , opts)
vim.keymap.set("i", "<A-j>","<Esc>:m +1<CR>==gi" , opts)
vim.keymap.set("i", "<A-k>","<Esc>:m -2<CR>==gi" , opts)
vim.keymap.set("v", "<A-k>",":m '<-2<CR>gv=gv" , opts)
vim.keymap.set("v", "<A-j>",":m '>+1<CR>gv=gv", opts)
-- copy to clipboard
vim.keymap.set("n", "<leader>y","\"+y",opts)
vim.keymap.set("n", "<leader>Y","\"+yg_",opts)
vim.keymap.set("n", "<leader>yy","\"+yy",opts)
vim.keymap.set("v", "<leader>y","\"+y",opts)

vim.keymap.set("n","<leader>p","\"+p",opts)
vim.keymap.set("v","<leader>p","\"+p",opts)
