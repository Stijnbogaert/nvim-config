local function setup_ui_select()
  -- This is your opts table
  require("telescope").setup({
    extensions = {
      ["ui-select"] = {
        require("telescope.themes").get_dropdown({
          -- even more opts
        }),
        -- pseudo code / specification for writing custom displays, like the one
        -- for "codeactions"
        -- specific_opts = {
        --   [kind] = {
        --     make_indexed = function(items) -> indexed_items, width,
        --     make_displayer = function(widths) -> displayer
        --     make_display = function(displayer) -> function(e)
        --     make_ordinal = function(e) -> string
        --   },
        --   -- for example to disable the custom builtin "codeactions" display
        --      do the following
        --   codeactions = false,
        -- }
      },
    },
  })
  -- To get ui-select loaded and working with telescope, you need to call
  -- load_extension, somewhere after setup function:
  require("telescope").load_extension("ui-select")
end
local function setup()
  local builtin = require("telescope.builtin")
  vim.keymap.set("n", "<C-p>", builtin.find_files, {})
  vim.keymap.set("n", "<leader>fs", builtin.grep_string, {})
  vim.keymap.set("n", "<leader>fb", builtin.buffers, {})
  vim.keymap.set("n", "<leader>fg", builtin.live_grep, {})
  vim.keymap.set("n", "<leader>fc", builtin.current_buffer_fuzzy_find, {})
  vim.keymap.set("n", "<leader>fd", builtin.diagnostics, {})
  vim.keymap.set("n", "<leader>fp", builtin.planets, {})
  vim.keymap.set("n", "<leader>fr", builtin.lsp_references, {})
end
return {
  { "nvim-telescope/telescope.nvim",           tag = "0.1.5",           dependencies = { "nvim-lua/plenary.nvim" }, config = setup },
  { "nvim-telescope/telescope-ui-select.nvim", config = setup_ui_select },
}
