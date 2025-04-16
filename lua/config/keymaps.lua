---@diagnostic disable: undefined-global

M = {

	general = function()
		-- fzf-lua keymaps
		local fzf = require("fzf-lua")
		vim.keymap.set("n", "<leader>ff", fzf.files, { desc = "Open file picker" })
		--oil
		vim.keymap.set("n", "-", "<CMD>Oil --float<CR>", { desc = "Open parent directory" })
		-- diagonstics float
		vim.keymap.set("n", "<leader>e", vim.diagnostic.open_float, { desc = "Open Diagnostics in Float" })
		-- copy to clipboard
		vim.keymap.set("n", "<leader>y", '"+y', opts)
		vim.keymap.set("n", "<leader>Y", '"+yg_', opts)
		vim.keymap.set("n", "<leader>yy", '"+yy', opts)
		vim.keymap.set("v", "<leader>y", '"+y', opts)
		vim.keymap.set("n", "<leader>p", '"+p', opts)
		vim.keymap.set("v", "<leader>p", '"+p', opts)

		-- lazygit
		vim.keymap.set("n", "<leader>lg", require("snacks").lazygit.open, { desc = "Open [L]azy[G]it" })
	end,

	mini_surround = function()
		mappings = {
			add = "<leader>sa", -- Add surrounding in Normal and Visual modes
			delete = "<leader>sd", -- Delete surrounding
			find = "<leader>sf", -- Find surrounding (to the right)
			find_left = "<leader>sF", -- Find surrounding (to the left)
			highlight = "<leader>sh", -- Highlight surrounding
			replace = "<leader>sr", -- Replace surrounding
			updute_n_lines = "<leader>sn", -- Update `n_lines`

			suffix_last = "l", -- Suffix to search with "prev" method
			suffix_next = "n", -- Suffix to search with "next" method
		}
		return mappings
	end,

	mini_comment = function()
		mappings = {
			-- Toggle comment (like `gcip` - comment inner paragraph) for both
			-- Normal and Visual modes
			comment = "<leader>k",
			-- Toggle comment on current line
			comment_line = "<leader>kk",
			-- Toggle comment on visual selection
			comment_visual = "<leader>k",
			-- Define 'comment' textobject (like `dgc` - delete whole comment block)
			-- Works also in Visual mode if mapping differs from `comment_visual`
			textobject = "<leader>k",
		}
		return mappings
	end,
	lsp = function(event, has_inlay_hint_enabled)
		local map = function(keys, func, desc, mode)
			mode = mode or "n"
			vim.keymap.set(mode, keys, func, { buffer = event.buf, desc = "LSP: " .. desc })
		end
		-- Jump to the definition of the word under your cursor.
		--  This is where a variable was first declared, or where a function is defined, etc.
		--  To jump back, press <C-t>.
		map("<leader>gd", require("fzf-lua").lsp_definitions, "[G]oto [D]efinition")

		-- Find references for the word under your cursor.
		map("<leader>fr", require("fzf-lua").lsp_references, "[G]oto [R]eferences")

		-- Jump to the implementation of the word under your cursor.
		--  Useful when your language has ways of declaring types without an actual implementation.
		map("<leader>gi", require("fzf-lua").lsp_implementations, "[G]oto [I]mplementation")

		-- Jump to the type of the word under your cursor.
		--  Useful when you're not sure what type a variable is and you want to see
		--  the definition of its *type*, not where it was *defined*.
		map("<leader>D", require("fzf-lua").lsp_typedefs, "Type [D]efinition")

		-- Fuzzy find all the symbols in your current document.
		--  Symbols are things like variables, functions, types, etc.
		map("<leader>ds", require("fzf-lua").lsp_document_symbols, "[D]ocument [S]ymbols")

		-- Fuzzy find all the symbols in your current workspace.
		--  Similar to document symbols, except searches over your entire project.
		map("<leader>ws", require("fzf-lua").lsp_live_workspace_symbols, "[W]orkspace [S]ymbols")

		-- Rename the variable under your cursor.
		--  Most Language Servers support renaming across files, etc.
		map("<leader>cr", vim.lsp.buf.rename, "[C]ode: [R]ename")

		-- Execute a code action, usually your cursor needs to be on top of an error
		-- or a suggestion from your LSP for this to activate.
		map("<leader>ca", vim.lsp.buf.code_action, "[C]ode [A]ction", { "n", "x" })

		-- WARN: This is not Goto Definition, this is Goto Declaration.
		--  For example, in C this would take you to the header.
		map("<leader>gD", vim.lsp.buf.declaration, "[G]oto [D]eclaration")

		-- List the diagnostics
		map("<leader>le", require("fzf-lua").diagnostics_document, "[l]ist [e]rrors")

		-- map("<C-space>", vim.lsp.buf.hover, "open the hover float")
		-- map("<C-space>", vim.lsp.buf.hover, "open the hover float", "i")
		-- try with K for the time being
		if has_inlay_hint_enabled then
			map("<leader>th", function()
				vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled({ bufnr = event.buf }))
			end, "[T]oggle Inlay [H]ints")
		end
	end,

	blink = function()
		return {
			preset = "default",
			["<tab>"] = { "accept", "fallback" },
		}
	end,
}
return M
