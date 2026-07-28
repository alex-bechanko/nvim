-- VCS status: jujutsu when a .jj dir is present, else git branch.
-- jj output is cached and refreshed async so lualine redraws stay cheap.
local M = {}

local jj_status = ''

local function jj_root()
	return vim.fs.root(0, '.jj')
end

local function update_jj_status()
	local root = jj_root()
	if not root then
		jj_status = ''
		return
	end
	vim.system({
		'jj',
		'log',
		'--no-graph',
		'--color',
		'never',
		'-r',
		'@',
		'-T',
		'separate(" ", bookmarks.join(","), change_id.shortest(), description.first_line())',
	}, { cwd = root, text = true }, function(obj)
		local out = vim.trim(obj.stdout or '')
		vim.schedule(function()
			jj_status = out
			pcall(require('lualine').refresh)
		end)
	end)
end

local function vcs_component()
	if jj_root() then
		if jj_status == '' then
			return ''
		end
		return '󱗆 ' .. jj_status
	end
	local head = vim.b.gitsigns_head
	if head and head ~= '' then
		return ' ' .. head
	end
	return ''
end

function M.setup()
	vim.api.nvim_create_autocmd({ 'BufEnter', 'FocusGained', 'DirChanged', 'BufWritePost' }, {
		callback = update_jj_status,
	})
	update_jj_status()

	require('lualine').setup({
		options = {
			theme = 'auto', -- picks up gruvbox
			globalstatus = true,
		},
		sections = {
			lualine_a = { 'mode' },
			lualine_b = { vcs_component, 'diff' },
			lualine_c = { { 'filename', path = 1 } },
			lualine_x = { 'diagnostics', 'filetype' },
			lualine_y = { 'progress' },
			lualine_z = { 'location' },
		},
	})
end

return M
