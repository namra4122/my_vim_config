local map = vim.keymap.set

-- open the current file directory
map("n", "<leader>pv", vim.cmd.Ex)

-- yank/copy text in the global buffer
map({ "n", "v" }, "Y", '"+y')

-- Esc also clears search highlighting
map({ "n", "i", "s", "v" }, "<esc>", "<cmd>noh<cr><esc>")

-- open Lazy.nvim plugin manager
map("n", "<leader>L", "<cmd>Lazy<cr>")

-- open Mason
map("n", "<leader>Ma", "<cmd>Mason<cr>")

-- write buffer in normal
map("n", "<leader>w", function()
	vim.api.nvim_command("write")
	vim.notify("File saved")
end)
-- and in insert mode
map({ "i", "x" }, "<leader>w", "<esc>:w<cr>")

-- source buffer
map("n", "<leader>S", "<cmd>source % | lua print('buffer sourced')<cr>")

-- quit window
map("n", "<leader>q", "<cmd>q<cr>")

-- quit nvim
map("n", "<leader>Q", "<cmd>wqa!<cr>")

-- restart nvim, incl. write current buffer
map("n", "<leader>R", "<cmd>w | restart<cr>")

-- open new buffer
map("n", "<leader>n", "<cmd>enew<cr>")

-- delete buffer
map("n", "<leader>DB", "<cmd>bdelete<cr>")

-- jump up and down a page and center cursor
map("n", "<C-d>", "<C-d>zz")
map("n", "<C-u>", "<C-u>zz")

-- center next and previous search results
map("n", "n", "nzzzv")
map("n", "N", "Nzzzv")

-- switch between windows
map("n", "<C-h>", "<C-w>h")
map("n", "<C-j>", "<C-w>j")
map("n", "<C-k>", "<C-w>k")
map("n", "<C-l>", "<C-w>l")

-- move lines up or down in normal, insert, and visual modes
map("n", "<A-j>", ":m .+1<cr>==")
map("n", "<A-k>", ":m .-2<cr>==")
map("i", "<A-j>", "<esc>:m .+1<cr>==gi")
map("i", "<A-k>", "<esc>:m .-2<cr>==gi")
map("v", "<A-j>", ":m '>+1<cr>gv=gv")
map("v", "<A-k>", ":m '<-2<cr>gv=gv")

-- helps you change all occurrences of the word the cursor is on in a file
map("n", "<leader>ss", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]])

-- enable and disable cloak plugin
map("n", "<leader>cd", "<cmd>CloakDisable<cr>")
map("n", "<C-e>", "<cmd>CloakEnable<cr>")
