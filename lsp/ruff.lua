---@brief
---
--- https://docs.astral.sh/ruff/editors/
---
--- `ruff`, an extremely fast Python linter and code formatter

---@type vim.lsp.Config
return {
	cmd = { 'ruff', 'server' },
	filetypes = { 'python' },
	root_markers = {
		'pyproject.toml',
		'ruff.toml',
		'.ruff.toml',
		'setup.py',
		'setup.cfg',
		'requirements.txt',
		'.git',
	},
}
