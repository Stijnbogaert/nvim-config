# NVIM Config

heavily uses the MrJacob video series to set up the config as a starting point

## How to configure stuff

formatters: check conform.lua

tooling: lsp.lua, extend the ensure_installed table

## Keymaps

TODO: configure keymaps and list them here

- [ ] conform for formatting
- [ ] lsp config (refactor out of lsp file)
- [ ] function signature floats

resolve the c-space conflict on blink or hover float, trying `K` for the time being (only in normal mode), c-space is used for blink in edit mode

## List of plugins

- [x] lsp config
- [x] fzf-lua
- [x] dressing
- [x] treesitter
- [x] oil
- [x] mini
    - [x] statusline
    - [x] git
    - [x] diff
    - [x] icons
    - [ ] align
- [x] conform
- [ ] blink-cmp
- [ ] project.nvim
