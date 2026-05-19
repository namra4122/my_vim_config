-- Formatting
return {
    'stevearc/conform.nvim',
    dependencies = { 'mason.nvim' },
    event = { 'BufReadPre', 'BufNewFile' },
    opts = {
        formatters_by_ft = {
            css = { 'prettier' },
            html = { 'prettier' },
            json = { 'prettier' },
            jsonc = { 'prettier' },
            javascript = { 'prettier' },
            javascriptreact = { 'prettier' },
            less = { 'prettier' },
            lua = { 'stylua' },
            markdown = { 'prettier' },
            scss = { 'prettier' },
            sh = { 'shfmt' },
            typescript = { 'prettier' },
            typescriptreact = { 'prettier' },
            yaml = { 'prettier' },
            python =  { 'ruff' },
            go = { 'goimports' },
        },
        formatters = {
            ['clangd'] = {
                prepend_args = { '-style=file', '-fallback-style=LLVM' },
            },
        },
        format_on_save = {
            timeout_ms = 1000,
            lsp_fallback = true,
            lsp_format = 'fallback',
            async = false,
        },
    },
}
