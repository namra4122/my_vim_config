-- markdown-renderer
return {
	{
		"MeanderingProgrammer/render-markdown.nvim",
		ft = "markdown",
		dependencies = { "nvim-treesitter/nvim-treesitter", "nvim-tree/nvim-web-devicons" },
		---@module 'render-markdown'
		---@type render.md.UserConfig
		opts = {
			anti_conceal = { enabled = false },
			file_types = { "markdown", "opencode_output" },
			link = {
				enabled = false, -- inline link icon rendering
				footnote = {
					enabled = true,
					superscript = true,
				},
			},
			ft = { "markdown", "Avante", "copilot-chat", "opencode_output" },
			keymaps = {
				vim.keymap.set("n", "<leader>Md", function()
					require("render-markdown").buf_toggle()
				end),
			},
		},
	},

	{
		"iamcco/markdown-preview.nvim",
		cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
		build = "cd app && npm install && git restore .",
		init = function()
			vim.g.mkdp_filetypes = { "markdown" }
		end,
		ft = { "markdown" },
		keys = {
			{
				"<leader>Mp",
				ft = "markdown",
				"<cmd>MarkdownPreviewToggle<cr>",
			},
		},
	},
}
