-- Python LSP + Ruff configuration using Pyrefly
--
-- Install:
--   pip install pyrefly ruff
-- Mason:
--   :MasonInstall pyrefly ruff

---@type vim.lsp.Config
return {
	-- Pyrefly
	pyrefly = {
		cmd = { "pyrefly", "lsp" },

		filetypes = {
			"python",
		},

		root_markers = {
			".git",
			"pyproject.toml",
			"setup.py",
			"setup.cfg",
			"requirements.txt",
			"Pipfile",
			"pyrefly.toml",
			".venv",
			"venv",
		},

		enabled = true,
	},

	-- Ruff
	ruff = {
		cmd = { "ruff", "server" },

		filetypes = {
			"python",
		},

		root_markers = {
			".git",
			"pyproject.toml",
			"ruff.toml",
			".ruff.toml",
		},

		init_options = {
			settings = {
				format = {
					enabled = true,
				},

				organizeImports = true,

				lint = {
					enable = true,
				},
			},
		},

		enabled = true,

		on_attach = function(client)
			-- Avoid duplicate hover/docs
			client.server_capabilities.hoverProvider = false
		end,
	},
}
