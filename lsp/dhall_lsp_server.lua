return {
	cmd = { 'dhall-lsp-server' },
	filetypes = { 'dhall' },
	root_markers = { '.git' },
	on_init = function(client, _)
		client.server_capabilities.semanticTokensProvider = nil
	end,
}
