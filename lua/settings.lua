local o = vim.opt

-- General
o.backup = false
o.writebackup = false
o.swapfile = false
o.undofile = true
o.number = true
o.relativenumber = true
o.termguicolors = true
o.scrolloff = 10
o.guicursor = ""
o.hidden = true
o.linebreak = true
o.mouse = "a"
-- treat '@' as part of filenames (improves gf on paths with '@')
o.isfname:append("@-@")

-- important for performance
o.timeout = false -- no timeout for mappings
o.ttimeoutlen = 10 -- timeout for key codes
o.updatetime = 300

-- Editing
o.autoindent = true
o.smartindent = true
o.expandtab = true
o.hlsearch = true -- search text stayed highlightted
o.incsearch = true -- shows matched as you type
o.ignorecase = true
o.shiftwidth = 4
o.tabstop = 4
o.softtabstop = 4
o.virtualedit = "block"
o.wrap = false

-- UI
o.cursorline = false
o.cmdheight = 1
o.signcolumn = "yes"
o.splitbelow = true
o.splitright = true
o.winborder = "single"
