local function setup_mason()
  require("mason").setup()
end
local function setup_mason_lspconfig()
  require("mason-lspconfig").setup({
    ensure_installed = { "tsserver", "lua_ls", "marksman", "powershell_es", "pyright", "ruff", "omnisharp", "openscad_lsp", "rust_analyzer" },
  })
end
local function setup_lspconfig()
  local capabilities = require("cmp_nvim_lsp").default_capabilities()
  local lspconfig = require("lspconfig")
  lspconfig.lua_ls.setup({
    capabilities = capabilities,
  })
  lspconfig.marksman.setup({
    capabilities = capabilities,
  })
  lspconfig.powershell_es.setup({
    bundle_path = vim.fn.stdpath("data") .. "/mason/packages/powershell-editor-services/",
    capabilities = capabilities,
  })
  lspconfig.pyright.setup({
    capabilities = capabilities
    --cmd= {vim.fn.stdpath("data") .. "/mason/bin/omnisharp"},
  })
  lspconfig.ruff.setup({
    capabilities = capabilities
    --cmd= {vim.fn.stdpath("data") .. "/mason/bin/omnisharp"},
  })
  lspconfig.omnisharp.setup({
    capabilities = capabilities,
    cmd = { vim.fn.stdpath("data") .. "/mason/bin/omnisharp" },
  })
  lspconfig.openscad_lsp.setup({
    capabilities = capabilities,
  })
  lspconfig.rust_analyzer.setup({
    capabilities = capabilities
  })
  lspconfig.tsserver.setup({ capabilities = capabilities })
  -- Global mappings.
  -- See `:help vim.diagnostic.*` for documentation on any of the below functions
  vim.keymap.set("n", "<leader>e", vim.diagnostic.open_float)
  vim.keymap.set("n", "[d", vim.diagnostic.goto_prev)
  vim.keymap.set("n", "]d", vim.diagnostic.goto_next)
  vim.keymap.set("n", "<leader>q", vim.diagnostic.setloclist)
  -- Use LspAttach autocommand to only map the following keys
  -- after the language server attaches to the current buffer
  vim.api.nvim_create_autocmd("LspAttach", {
    group = vim.api.nvim_create_augroup("UserLspConfig", {}),
    callback = function(ev)
      -- Enable completion triggered by <c-x><c-o>
      vim.bo[ev.buf].omnifunc = "v:lua.vim.lsp.omnifunc"
      -- Buffer local mappings.
      -- See `:help vim.lsp.*` for documentation on any of the below functions
      local opts = { buffer = ev.buf }
      vim.keymap.set("n", "gD", vim.lsp.buf.declaration, opts)
      vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
      vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
      vim.keymap.set("n", "gi", vim.lsp.buf.implementation, opts)
      vim.keymap.set("n", "<C-k>", vim.lsp.buf.signature_help, opts)
      vim.keymap.set("n", "<leader>wa", vim.lsp.buf.add_workspace_folder, opts)
      vim.keymap.set("n", "<leader>wr", vim.lsp.buf.remove_workspace_folder, opts)
      vim.keymap.set("n", "<leader>wl", function()
        print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
      end, opts)
      vim.keymap.set("n", "<leader>D", vim.lsp.buf.type_definition, opts)
      vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)
      vim.keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, opts)
      vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)
      vim.keymap.set("n", "<leader>f", function()
        vim.lsp.buf.format({ async = true })
      end, opts)
    end,
  })
end
return {
  { "williamboman/mason.nvim",           config = setup_mason },
  { "williamboman/mason-lspconfig.nvim", config = setup_mason_lspconfig },
  { "neovim/nvim-lspconfig",             config = setup_lspconfig },
}
