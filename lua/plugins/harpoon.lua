return {
	"ThePrimeagen/harpoon",
	branch = "harpoon2",
	lazy = false,
	dependencies = { "nvim-lua/plenary.nvim" },
	config = function()
		local harpoon = require("harpoon")

		harpoon:setup()

		local set = vim.keymap.set

		set("n", "<leader>A", function()
			harpoon:list():prepend()
			print("File prepend to harpoon")
		end)
		set("n", "<leader>a", function()
			harpoon:list():add()
			print("File added to harpoon")
		end)
		set("n", "<C-e>", function()
			harpoon.ui:toggle_quick_menu(harpoon:list())
		end)

		-- switch to harpooned file 1-4
		set("n", "<leader>1", function()
			harpoon:list():select(1)
		end)
		set("n", "<leader>2", function()
			harpoon:list():select(2)
		end)
		set("n", "<leader>3", function()
			harpoon:list():select(3)
		end)
		set("n", "<leader>4", function()
			harpoon:list():select(4)
		end)
		set("n", "<leader>5", function()
			harpoon:list():select(5)
		end)
		set("n", "<leader>6", function()
			harpoon:list():select(6)
		end)
		set("n", "<leader>7", function()
			harpoon:list():select(7)
		end)
		set("n", "<leader>8", function()
			harpoon:list():select(8)
		end)

		-- susbstitute harpoon file 1-4 with new files
		set("n", "<leader><C-q>", function()
			harpoon:list():replace_at(1)
		end)
		set("n", "<leader><C-w>", function()
			harpoon:list():replace_at(2)
		end)
		set("n", "<leader><C-e>", function()
			harpoon:list():replace_at(3)
		end)
		set("n", "<leader><C-r>", function()
			harpoon:list():replace_at(4)
		end)
		set("n", "<leader><C-u>", function()
			harpoon:list():replace_at(5)
		end)
		set("n", "<leader><C-i>", function()
			harpoon:list():replace_at(6)
		end)
		set("n", "<leader><C-o>", function()
			harpoon:list():replace_at(7)
		end)
		set("n", "<leader><C-p>", function()
			harpoon:list():replace_at(8)
		end)

		-- toggle previous & next buffers stored within Harpoon list
		-- set("n", "<C-S-P>", function() harpoon:list():prev() end)
		-- set("n", "<C-S-N>", function() harpoon:list():next() end)
	end,
}
