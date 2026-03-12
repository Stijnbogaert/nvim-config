# NVIM Config

## Config structure

```
~/.config/nvim/
├── init.lua               # Entry point
├── lazy-lock.json         # Locked plugin versions
└── lua/
    ├── config/
    │   ├── autosave.lua   # Auto-save on BufLeave / FocusLost
    │   ├── keymaps.lua    # All keymaps (module, called from init.lua and plugins)
    │   ├── lazy.lua       # lazy.nvim bootstrap + setup, sets <leader> and <localleader>
    │   └── options.lua    # vim.opt settings (numbers, tabs, indent, splits, etc.)
    ├── plugins/           # One file per plugin (or group), auto-imported by lazy.nvim
    │   ├── blink.lua
    │   ├── codediff.lua
    │   ├── conform.lua
    │   ├── dressing.lua
    │   ├── fzf-lua.lua
    │   ├── git-blame.lua
    │   ├── kanagawa.lua
    │   ├── lazygit.lua    # snacks.nvim lazygit integration
    │   ├── lsp.lua
    │   ├── lsp.roslyn.lua # roslyn.nvim for C#
    │   ├── mini.lua       # All mini.* plugins grouped
    │   ├── minuet.lua     # minuet-ai (disabled by default, enabled = false)
    │   ├── oil.lua
    │   ├── treesitter.lua
    │   ├── treesitter-textobjects.lua
    │   ├── vim-sleuth.lua
    │   └── which-key.lua
    └── blink-mtg/
        └── init.lua       # Custom blink.cmp source: MTG card name completion (.dec files)
```

**Entry point** (`init.lua`) loads in order:

1. `config.autosave` — registers the auto-save autocmd
2. `config.options` — sets editor options
3. `config.lazy` — bootstraps lazy.nvim and imports all `lua/plugins/*.lua`
4. `config.keymaps.general()` — registers global keymaps

**Leader keys:** `<Space>` (leader), `\` (localleader) — set in `lazy.lua` before lazy loads.

**Adding a plugin:** create a new file in `lua/plugins/` returning a lazy.nvim spec table. It is auto-imported.

**Custom blink source (`blink-mtg`):** active only in `.dec` files (MTG deck lists). Reads card names from `$XDG_DATA_HOME/nvim/mtg-cards.txt` (one name per line).

## How to configure external dev tools

formatters: check conform.lua

tooling: lsp.lua, extend the ensure_installed table

## Keymaps

All mappings are defined in `lua/config/keymaps.lua`.

> `K` is used for hover float (normal mode). `C-space` is reserved for blink.cmp in insert mode.

### General (`<leader>`)

| Key | Mode | Description |
|-----|------|-------------|
| `<leader>ff` | n | [fzf] Open file picker |
| `<leader>fg` | n | [fzf] Live grep |
| `<leader>fp` | n | [fzf] Register picker |
| `<leader>fzf` | n | [fzf] Open fzf picker picker |
| `<leader>f?` | n | [fzf] Search through keymaps |
| `<leader>fm` | n | [fzf] Search through marks |
| `<leader>fj` | n | [fzf] Search through jumps |
| `-` | n | Open parent directory (oil, float) |
| `<leader>e` | n | Open diagnostics float |
| `<leader>y` | n/v | Yank to system clipboard |
| `<leader>Y` | n | Yank to end of line to system clipboard |
| `<leader>yy` | n | Yank current line to system clipboard |
| `<leader>p` | n/v | Paste from system clipboard |
| `<leader>yp` | n | Yank current file path to clipboard |
| `<leader>b` | n | Jump back (`<C-o>`) |
| `<leader>lg` | n | Open lazygit |
| `<leader>id` | n | Insert current date (`YYYY-MM-DD`) |

### LSP (buffer-local, set on `LspAttach`)

| Key | Mode | Description |
|-----|------|-------------|
| `<leader>fd` | n | Go to definition |
| `<leader>fr` | n | Go to references |
| `<leader>fi` | n | Go to implementation |
| `<leader>D` | n | Go to type definition |
| `<leader>ds` | n | Document symbols |
| `<leader>ws` | n | Workspace symbols |
| `<leader>cr` | n | Rename symbol |
| `<leader>ca` | n/x | Code action |
| `<leader>gD` | n | Go to declaration |
| `<leader>le` | n | List document diagnostics |
| `<leader>lwe` | n | List workspace diagnostics |
| `<leader>th` | n | Toggle inlay hints (if supported by server) |

### Completion (blink.cmp, insert mode)

| Key | Description |
|-----|-------------|
| `<C-space>` | Open completion menu / open docs |
| `<C-n>` / `<C-p>` | Select next/previous item |
| `<C-e>` | Hide menu |
| `<Tab>` | Accept suggestion |
| `<C-k>` | Toggle signature help |

### Treesitter textobjects

**Select** (visual/operator-pending):

| Key | Description |
|-----|-------------|
| `af` / `if` | Outer / inner function |
| `ac` / `ic` | Outer / inner class |
| `ao` | Outer comment |
| `as` | Language scope |
| `in` | Inner number |

**Move**:

| Key | Description |
|-----|-------------|
| `]m` / `[m` | Next/prev function start |
| `]M` / `[M` | Next/prev function end |
| `]]` / `[[` | Next/prev class start |
| `][` / `[]` | Next/prev class end |
| `]o` | Next loop |
| `]s` / `[s` | Next/prev scope |
| `]z` / `[z` | Next/prev fold |
| `]d` / `[d` | Next/prev conditional |

**Swap**:

| Key | Description |
|-----|-------------|
| `<leader>a` | Swap with next parameter |
| `<leader>A` | Swap with previous parameter |

### mini.surround

| Key | Description |
|-----|-------------|
| `<leader>sa` | Add surrounding |
| `<leader>sd` | Delete surrounding |
| `<leader>sf` / `<leader>sF` | Find surrounding right/left |
| `<leader>sh` | Highlight surrounding |
| `<leader>sr` | Replace surrounding |
| `<leader>sn` | Update `n_lines` |

### mini.comment

| Key | Mode | Description |
|-----|------|-------------|
| `<leader>k` | n/v | Toggle comment |
| `<leader>kk` | n | Toggle comment on current line |

## List of plugins

Current plugins (as configured in `lua/plugins/*`):

- `saghen/blink.cmp` (completion frontend)
- `rafamadriz/friendly-snippets` (snippet collection)
- `moyiz/blink-emoji.nvim` (emoji source for blink.cmp)
- `milanglacier/minuet-ai.nvim` (AI provider — present as a dependency; main config currently disabled)
- `nvim-treesitter/nvim-treesitter` (parsers & highlighting)
- `nvim-treesitter/nvim-treesitter-textobjects` (textobjects for treesitter)
- `williamboman/mason.nvim`, `williamboman/mason-lspconfig.nvim`, `WhoIsSethDaniel/mason-tool-installer.nvim` (LSP / tooling installer)
- `neovim/nvim-lspconfig` (LSP configurations)
- `j-hui/fidget.nvim` (LSP status UI)
- `stevearc/conform.nvim` (formatting)
- `folke/dressing.nvim` (UI for inputs/menus)
- `ibhagwan/fzf-lua` (fuzzy finder)
- `rebelot/kanagawa.nvim` (colorscheme)
- `folke/snacks.nvim` (lazygit integration via snacks)
- `stevearc/oil.nvim` (file browser; configured as non-lazy)

- Mini plugins (echasnovski): `mini-git`, `mini.diff`, `mini.icons`, `mini.statusline`, `mini.comment`, `mini.surround`, `mini.align`

- Utilities & extras: `esmuellert/codediff.nvim`, `f-person/git-blame.nvim`, `seblyng/roslyn.nvim`

Notes:
- Some plugins are listed as dependencies only (e.g. `nvim-lua/plenary.nvim`, `hrsh7th/nvim-cmp`, `nvim-tree/nvim-web-devicons`, `MunifTanjim/nui.nvim`).
- `milanglacier/minuet-ai.nvim` exists in the repo but its plugin file sets `enabled = false` — it's available as a dependency for blink but not currently active by default.
- If you add/remove plugins, update `lua/plugins/` and the `ensure_installed` or `lazy` config where appropriate.
