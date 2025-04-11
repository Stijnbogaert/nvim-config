vim.wo.number= true --set current line number to the line number in the file
vim.wo.relativenumber = true --set other line numbers to relative

vim.opt.expandtab = true --replace spaces with tabs
vim.opt.tabstop=2 --spaces shown per tab
vim.opt.softtabstop=2 --spaces applied when pressing tab
vim.opt.shiftwidth=2

vim.opt.smarttab = true
vim.opt.smartindent = true
vim.opt.autoindent = true

vim.opt.showmode = false

vim.opt.breakindent = true

vim.opt.ignorecase = true
vim.opt.smartcase = true

vim.opt.signcolumn = "yes"

vim.opt.splitright = true
vim.opt.splitbelow = true

vim.opt.list = true
vim.opt.listchars = { tab = "» ", trail = "·", nbsp = "␣" }

-- Minimal number of screen lines to keep above and below the cursor.
vim.opt.scrolloff = 10
