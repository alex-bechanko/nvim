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
-- wrap text literally at 120 characters
vim.bo.textwidth = 120
-- show a column right before the 120th character
vim.wo.colorcolumn = '-2'

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

vim.cmd.colorscheme('kanagawa-wave')

vim.lsp.enable('gopls')
vim.lsp.enable('lua_ls')
vim.lsp.enable('nixd')
vim.lsp.enable('rust_analyzer')

require('blink.cmp').setup({
	keymap = { preset = 'super-tab' },
	appearance = {
		nerd_font_variant = 'normal',
	},
	snippets = {
		preset = 'luasnip',
	},
	cmdline = {
		keymap = { preset = 'inherit' },
		completion = { menu = { auto_show = true } },
	},
	signature = { enabled = true },
})

require('conform').setup({
	formatters_by_ft = {
		lua = { 'stylua' },
		rust = { 'rustfmt' },
		nix = { 'nixfmt' },
	},
	format_on_save = {
		timeout_ms = 500,
		lsp_format = 'never',
	},
})

require('ibl').setup()

require('nvim-treesitter.configs').setup({
	ensure_installed = {},
	auto_install = false,
	highlight = {
		enable = true,
	},
})

require('ufo').setup({
	provider_selector = function(_, _, _)
		return { 'treesitter', 'indent' }
	end,
})

vim.keymap.set('n', 'zR', require('ufo').openAllFolds, { desc = 'Open all folds' })
vim.keymap.set('n', 'zM', require('ufo').closeAllFolds, { desc = 'Close all folds' })
vim.keymap.set('n', '<leader>?', function()
	require('which-key').show({ global = false })
end, { desc = 'Display Buffer Local Keymaps' })
