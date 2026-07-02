vim.g.mapleader = [[ ]]
vim.g.maplocalleader = [[\]]

-- show absolute line number on current line
-- show relative numbers everywhere else
vim.wo.number = true
vim.wo.relativenumber = true

-- when splitting pane, default to the right and below
vim.o.splitright = true
vim.o.splitbelow = true

-- always show sign (warnings, errors, etc.) column
vim.wo.signcolumn = 'yes'

-- don't wrap text virtually
vim.wo.wrap = false
-- don't wrap text literally either
vim.bo.textwidth = 0
-- show a column right before the 120th character
vim.wo.colorcolumn = '120'

-- highlight matching braces
vim.o.showmatch = true

-- highlight cursor's line and column
vim.wo.cursorline = true
vim.wo.cursorcolumn = true

-- show (row, columnn) in bottom right
vim.o.ruler = true

-- highlight incrementally when searching
vim.o.incsearch = true

-- case insensitive search
vim.o.ignorecase = true

-- ... unless if a capital letter is used in the search
vim.o.smartcase = true

-- set timeouts to a comfy level
vim.o.timeout = true
vim.o.timeoutlen = 500
vim.o.updatecount = 100

-- recommended settings for folds from nvim-ufo
vim.o.foldcolumn = '1'
vim.o.foldlevel = 99
vim.o.foldlevelstart = 99
vim.o.foldenable = true

-- default to 4 spaces for indentation
vim.bo.tabstop = 4
vim.bo.softtabstop = -1
vim.bo.shiftwidth = 4
vim.bo.expandtab = true

-- automatically indent to same level as previous line
vim.bo.autoindent = true

-- when tab is pressed use the level set for tabstops/shiftwidth
vim.o.smarttab = true

-- no beeping
vim.o.visualbell = true

-- enable project specific .nvim.lua settings
vim.o.exrc = true

vim.cmd.colorscheme('gruvbox')

vim.filetype.add({
	extension = {
		gotmpl = 'gotmpl',
		mdx = 'markdown.mdx',
	},
})

local lsps = {
	'dhall_lsp_server',
	'gopls',
	'lua_ls',
	'nixd',
	'pyright',
	'ruff',
	'rust_analyzer',
	'zizmor',
}

for _, server in ipairs(lsps) do
	vim.lsp.enable(server)
end

require('blink.cmp').setup({
	appearance = {
		nerd_font_variant = 'normal',
	},
	cmdline = {
		keymap = { preset = 'inherit' },
		completion = { menu = { auto_show = true } },
	},
	completion = {
		documentation = {
			auto_show = true,
			auto_show_delay_ms = 200,
		},
		menu = {
			draw = {
				columns = {
					{ 'label', 'label_description', gap = 1 },
					{ 'kind_icon', 'kind', gap = 1 },
					{ 'source_name' },
				},
			},
		},
	},
	keymap = { preset = 'super-tab' },
	signature = { enabled = true },
	snippets = {
		preset = 'luasnip',
	},
	sources = {
		default = function()
			if vim.bo.filetype == 'dhall' then
				return { 'lsp', 'buffer', 'snippets', 'latex_symbols' }
			end
			return { 'lsp', 'buffer', 'snippets', 'path', 'latex_symbols' }
		end,
		providers = {
			latex_symbols = {
				name = 'latex_symbols',
				module = 'blink.compat.source',
				score_offet = -1,
			},
		},
	},
})

require('conform').setup({
	formatters = {
		prettier = {
			prepend_args = { '--print-width', '120', '--prose-wrap', 'always' },
		},
	},
	formatters_by_ft = {
		lua = { 'stylua' },
		python = { 'ruff_format' },
		rust = { 'rustfmt' },
		nix = { 'nixfmt' },
		markdown = { 'prettier' },
	},
	format_on_save = {
		timeout_ms = 500,
		lsp_format = 'fallback',
	},
})

require('ibl').setup()

require('nvim-treesitter').setup({
	ensure_installed = {},
	auto_install = false,
})

require('render-markdown').setup({
	completions = { lsp = { enabled = true } },
	render_modes = true,
})

require('telescope').setup({})

require('ufo').setup({
	provider_selector = function(_, _, _)
		return { 'treesitter', 'indent' }
	end,
})

local telescope_builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader>ff', telescope_builtin.find_files, { desc = 'Find files' })
vim.keymap.set('n', '<leader>fg', telescope_builtin.live_grep, { desc = 'Live grep' })
vim.keymap.set('n', '<leader>fb', telescope_builtin.buffers, { desc = 'Find buffers' })
vim.keymap.set('n', '<leader>fh', telescope_builtin.help_tags, { desc = 'Find help tags' })

vim.keymap.set('n', ']b', '<cmd>bnext<cr>', { desc = 'Next buffer' })
vim.keymap.set('n', '[b', '<cmd>bprev<cr>', { desc = 'Previous buffer' })
vim.keymap.set('n', '<leader>bd', '<cmd>bdelete<cr>', { desc = 'Delete buffer' })

vim.keymap.set('n', 'zR', require('ufo').openAllFolds, { desc = 'Open all folds' })
vim.keymap.set('n', 'zM', require('ufo').closeAllFolds, { desc = 'Close all folds' })
vim.keymap.set('n', '<leader>?', function()
	require('which-key').show({ global = false })
end, { desc = 'Display Buffer Local Keymaps' })

-- keymaps for copying to from system clipboard
vim.keymap.set({ 'n', 'v' }, '<leader>y', '"+y', { desc = 'Copy to system clipboard' })
vim.keymap.set('n', '<leader>Y', '"+y$', { desc = 'Copy line to system clipboard' })
-- keymaps for pasting from system clipboard
vim.keymap.set({ 'n', 'v' }, '<leader>p', '"+p', { desc = 'Paste from system clipboard AFTER cursor' })
vim.keymap.set({ 'n', 'v' }, '<leader>P', '"+P', { desc = 'Paste from system clipboard BEFORE cursor' })
