---@diagnostic disable: undefined-global

M = {

	general = function()
		-- fzf-lua keymaps
		local fzf = require("fzf-lua")
		vim.keymap.set("n", "<leader>ff", fzf.files, { desc = "Open file picker" })
		vim.keymap.set("n", "<leader>fg", fzf.live_grep, { desc = "Search on grep" })
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

		-- insert text snippets
		vim.keymap.set("n", "<leader>id", "<CMD>pu=strftime('%Y-%m-%d')<CR>", { desc = "[I]nsert [D]ate" })
	end,
	treesitter_text_objects = {
		select = {
			-- You can use the capture groups defined in textobjects.scm
			["af"] = "@function.outer",
			["if"] = "@function.inner",
			["ac"] = "@class.outer",
			["ao"] = "@comment.outer",
			-- You can optionally set descriptions to the mappings (used in the desc parameter of
			-- nvim_buf_set_keymap) which plugins like which-key display
			["ic"] = { query = "@class.inner", desc = "Select inner part of a class region" },
			-- You can also use captures from other query groups like `locals.scm`
			["as"] = { query = "@local.scope", query_group = "locals", desc = "Select language scope" },
		},
		move = {
			next_start = {
				["]m"] = "@function.outer",
				["]]"] = { query = "@class.outer", desc = "Next class start" },
				--
				-- You can use regex matching (i.e. lua pattern) and/or pass a list in a "query" key to group multiple queries.
				["]o"] = "@loop.*",
				-- ["]o"] = { query = { "@loop.inner", "@loop.outer" } }
				--
				-- You can pass a query group to use query from `queries/<lang>/<query_group>.scm file in your runtime path.
				-- Below example nvim-treesitter's `locals.scm` and `folds.scm`. They also provide highlights.scm and indent.scm.
				["]s"] = { query = "@local.scope", query_group = "locals", desc = "Next scope" },
				["]z"] = { query = "@fold", query_group = "folds", desc = "Next fold" },
			},
			next_end = {
				["]M"] = "@function.outer",
				["]["] = "@class.outer",
			},
			previous_start = {
				["[m"] = "@function.outer",
				["[["] = "@class.outer",
			},
			previous_end = {
				["[M"] = "@function.outer",
				["[]"] = "@class.outer",
			},
			-- Below will go to either the start or the end, whichever is closer.
			-- Use if you want more granular movements
			-- Make it even more gradual by adding multiple queries and regex.
			next = {
				["]d"] = "@conditional.outer",
			},
			previous = {
				["[d"] = "@conditional.outer",
			},
		},
		swap = {
			next = {
				["<leader>a"] = { query = "@parameter.inner", desc = "Swap with next parameter" },
			},
			previous = {
				["<leader>A"] = "@parameter.inner",
			},
		},
	},
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
		map("<leader>fd", require("fzf-lua").lsp_definitions, "[G]oto [D]efinition")

		-- Find references for the word under your cursor.
		map("<leader>fr", require("fzf-lua").lsp_references, "[G]oto [R]eferences")

		-- Jump to the implementation of the word under your cursor.
		--  Useful when your language has ways of declaring types without an actual implementation.
		map("<leader>fi", require("fzf-lua").lsp_implementations, "[G]oto [I]mplementation")

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
