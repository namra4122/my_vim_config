-- empty setup using defaults
require("nvim-tree").setup()

-- OR setup with some options
require("nvim-tree").setup({
  sort = {
    sorter = "case_sensitive",
  },
  view = {
    width = 30,
    side = 'right',
  },
  renderer = {
    group_empty = true,
  },
})

vim.keymap.set("n", "<C-b>", '<cmd>NvimTreeToggle<CR>')
vim.keymap.set("v", "<C-b>", '<cmd>NvimTreeToggle<CR>')
