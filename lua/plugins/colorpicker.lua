-- local pickState = 0
--
-- local paths = vim.api.nvim_list_runtime_paths()
-- local optsPath = string.format("%s/after/coloroptions.txt", paths[1])
--
-- local setColor = function(win, buf, colors)
-- 	return function()
-- 		local cursor = vim.api.nvim_win_get_cursor(win)
--
-- 		local mode = "w+"
-- 		if pickState == 1 then
-- 			mode = "a+"
-- 		end
--
-- 		local file = io.open(optsPath, mode)
--
-- 		if file then
-- 			if pickState == 0 then
-- 				vim.cmd(string.format("colorscheme %s", colors[cursor[1]]))
-- 				file:write(colors[cursor[1]], "\n")
-- 				vim.api.nvim_buf_set_lines(buf, 0, -1, false, { "enable transparency", "disable transparency" })
-- 				pickState = 1
-- 			else
-- 				pickState = 0
--
-- 				if cursor[1] == 1 then
-- 					vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
-- 					vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
-- 					vim.api.nvim_set_hl(0, "NormalNC", { bg = "none" })
-- 					vim.api.nvim_set_hl(0, "Pmenu", { bg = "none" })
-- 					file:write("en\n")
-- 				else
-- 					file:write("dis\n")
-- 				end
--
-- 				vim.api.nvim_win_close(win, true)
-- 				vim.api.nvim_buf_delete(buf, { force = true })
-- 			end
--
-- 			file:close()
-- 		end
-- 	end
-- end
--
-- local startPreview = function(win, colors)
-- 	local timer = vim.uv.new_timer()
-- 	local prevColor = ""
--
-- 	local file = io.open(optsPath, "r")
-- 	local opts = {}
--
-- 	if file then
-- 		for i in file:lines() do
-- 			table.insert(opts, i)
-- 		end
-- 		file:close()
-- 	end
--
-- 	local initialColor = opts[1]
--
-- 	timer:start(
-- 		0,
-- 		250,
-- 		vim.schedule_wrap(function()
-- 			if pickState == 1 then
-- 				timer:close()
-- 				return
-- 			end
--
-- 			-- reset to initial color if user exits before selecting
-- 			if not vim.api.nvim_win_is_valid(win) then
-- 				vim.cmd(string.format("colorscheme %s", initialColor))
-- 				timer:close()
-- 				return
-- 			end
-- 			--
--
-- 			local cursor = vim.api.nvim_win_get_cursor(win)
-- 			if not (prevColor == colors[cursor[1]]) then
-- 				prevColor = colors[cursor[1]]
-- 				vim.cmd(string.format("colorscheme %s", colors[cursor[1]]))
-- 			end
-- 		end)
-- 	)
-- end
--
-- local ColorPicker = function()
-- 	local ui = vim.api.nvim_list_uis()[1]
-- 	pickState = 0
--
-- 	local opts = {
-- 		relative = "editor",
-- 		width = 30,
-- 		height = 30,
-- 		col = (ui.width / 2) - 15,
-- 		row = (ui.height / 2) - 15,
-- 		anchor = "NW",
-- 		style = "minimal",
-- 		border = "rounded",
-- 	}
--
-- 	local buf = vim.api.nvim_create_buf(false, true)
-- 	local win = vim.api.nvim_open_win(buf, true, opts)
--
-- 	local color_files = vim.api.nvim_get_runtime_file("colors/*.vim", true)
-- 	local lua_color_files = vim.api.nvim_get_runtime_file("colors/*.lua", true)
-- 	local colors = {}
--
-- 	table.move(lua_color_files, 1, #lua_color_files, #color_files + 1, color_files)
--
-- 	for _, v in ipairs(color_files) do
-- 		local j = 0
-- 		if not string.match(v, "runtime") then -- exclude default
-- 			for i = string.len(v), 1, -1 do
-- 				if string.char(v:byte(i)) == "/" then
-- 					j = i + 1
-- 					goto continue
-- 				end
-- 			end
-- 			::continue::
-- 			table.insert(colors, string.sub(v, j, string.len(v) - 4))
-- 		end
-- 	end
--
-- 	vim.api.nvim_buf_set_lines(buf, 0, #colors + 1, false, colors)
-- 	startPreview(win, colors)
--
-- 	vim.api.nvim_buf_set_keymap(buf, "n", "<CR>", "", { callback = setColor(win, buf, colors) })
-- end
--
-- vim.keymap.set("n", "<C-c>", ColorPicker, {})
--
-- return {
-- 	{ "mtendekuyokwa/stoics.nvim" },
-- 	{ "catppuccin/nvim" },
-- 	{ "folke/tokyonight.nvim" },
-- 	{ "rebelot/kanagawa.nvim" },
-- 	{ "nyoom-engineering/nyoom.nvim" },
-- 	{ "saeeedhany/parchment.nvim" },
-- 	{ "stefanvanburen/usgc-nvim" },
-- 	{ "wesgibbs/vim-irblack" },
-- }

local M = {}

-- =========================================================
-- CONFIG
-- =========================================================

local state = {
	picking_transparency = false,
}

local config_path = vim.fn.stdpath("config")
local options_file = config_path .. "/after/coloroptions.txt"

local transparency_groups = {
	"Normal",
	"NormalFloat",
	"NormalNC",
	"Pmenu",
}

-- =========================================================
-- UTILITIES
-- =========================================================

local function file_exists(path)
	local stat = vim.uv.fs_stat(path)
	return stat ~= nil
end

local function ensure_after_dir()
	local after_dir = config_path .. "/after"

	if not file_exists(after_dir) then
		vim.fn.mkdir(after_dir, "p")
	end
end

local function write_options(colorscheme, transparency)
	ensure_after_dir()

	local file = io.open(options_file, "w")

	if not file then
		vim.notify("Failed to save color options", vim.log.levels.ERROR)
		return
	end

	file:write(colorscheme or "", "\n")
	file:write(transparency and "en" or "dis", "\n")

	file:close()
end

local function read_options()
	if not file_exists(options_file) then
		return nil, false
	end

	local file = io.open(options_file, "r")

	if not file then
		return nil, false
	end

	local lines = {}

	for line in file:lines() do
		table.insert(lines, line)
	end

	file:close()

	return lines[1], lines[2] == "en"
end

-- =========================================================
-- TRANSPARENCY
-- =========================================================

local function set_transparency(enabled)
	for _, group in ipairs(transparency_groups) do
		if enabled then
			vim.api.nvim_set_hl(0, group, { bg = "none" })
		else
			vim.api.nvim_set_hl(0, group, {})
		end
	end
end

-- =========================================================
-- APPLY SAVED SETTINGS
-- =========================================================

function M.load_saved()
	local colorscheme, transparency = read_options()

	if colorscheme and colorscheme ~= "" then
		pcall(vim.cmd, "colorscheme " .. colorscheme)
	end

	if transparency then
		vim.schedule(function()
			set_transparency(true)
		end)
	end
end

-- =========================================================
-- GET AVAILABLE COLORSCHEMES
-- =========================================================

local function get_colorschemes()
	local vim_files = vim.api.nvim_get_runtime_file("colors/*.vim", true)
	local lua_files = vim.api.nvim_get_runtime_file("colors/*.lua", true)

	local all_files = {}

	vim.list_extend(all_files, vim_files)
	vim.list_extend(all_files, lua_files)

	local colors = {}
	local seen = {}

	for _, file in ipairs(all_files) do
		if not file:match("/runtime/") then
			local name = vim.fn.fnamemodify(file, ":t:r")

			if not seen[name] then
				seen[name] = true
				table.insert(colors, name)
			end
		end
	end

	table.sort(colors)

	return colors
end

-- =========================================================
-- PREVIEW
-- =========================================================

local function start_preview(win, colors, initial_color)
	local timer = vim.uv.new_timer()
	local previous = ""

	timer:start(
		0,
		200,
		vim.schedule_wrap(function()
			if state.picking_transparency then
				timer:stop()
				timer:close()
				return
			end

			if not vim.api.nvim_win_is_valid(win) then
				if initial_color then
					pcall(vim.cmd, "colorscheme " .. initial_color)
				end

				timer:stop()
				timer:close()
				return
			end

			local cursor = vim.api.nvim_win_get_cursor(win)
			local current = colors[cursor[1]]

			if current and current ~= previous then
				previous = current
				pcall(vim.cmd, "colorscheme " .. current)
			end
		end)
	)
end

-- =========================================================
-- PICKER
-- =========================================================

function M.open_picker()
	state.picking_transparency = false

	local current_scheme = vim.g.colors_name

	local ui = vim.api.nvim_list_uis()[1]

	local width = 40
	local height = 30

	local buf = vim.api.nvim_create_buf(false, true)

	local win = vim.api.nvim_open_win(buf, true, {
		relative = "editor",
		width = width,
		height = height,
		col = math.floor((ui.width - width) / 2),
		row = math.floor((ui.height - height) / 2),
		style = "minimal",
		border = "rounded",
	})

	local colors = get_colorschemes()

	vim.api.nvim_buf_set_lines(buf, 0, -1, false, colors)

	start_preview(win, colors, current_scheme)

	local function close_picker()
		if vim.api.nvim_win_is_valid(win) then
			vim.api.nvim_win_close(win, true)
		end

		if vim.api.nvim_buf_is_valid(buf) then
			vim.api.nvim_buf_delete(buf, { force = true })
		end
	end

	local function confirm_selection()
		local cursor = vim.api.nvim_win_get_cursor(win)

		if not state.picking_transparency then
			local selected = colors[cursor[1]]

			if not selected then
				return
			end

			pcall(vim.cmd, "colorscheme " .. selected)

			state.picking_transparency = true

			vim.api.nvim_buf_set_lines(buf, 0, -1, false, {
				"Enable Transparency",
				"Disable Transparency",
			})

			vim.api.nvim_win_set_cursor(win, { 1, 0 })

			vim.b.selected_colorscheme = selected

			return
		end

		local transparency = cursor[1] == 1
		local selected = vim.b.selected_colorscheme

		set_transparency(transparency)

		write_options(selected, transparency)

		close_picker()
	end

	local function cancel_picker()
		if current_scheme then
			pcall(vim.cmd, "colorscheme " .. current_scheme)
		end

		close_picker()
	end

	vim.keymap.set("n", "<CR>", confirm_selection, {
		buffer = buf,
		nowait = true,
		silent = true,
	})

	vim.keymap.set("n", "q", cancel_picker, {
		buffer = buf,
		nowait = true,
		silent = true,
	})

	vim.keymap.set("n", "<Esc>", cancel_picker, {
		buffer = buf,
		nowait = true,
		silent = true,
	})
end

-- =========================================================
-- LOAD SAVED SETTINGS ON STARTUP
-- =========================================================

M.load_saved()

-- =========================================================
-- KEYMAP
-- =========================================================

vim.keymap.set("n", "<C-c>", M.open_picker, {
	desc = "Open Colorscheme Picker",
})

-- =========================================================
-- PLUGINS
-- =========================================================

return {
	{
		"catppuccin/nvim",
		name = "catppuccin",
	},

	{
		"folke/tokyonight.nvim",
	},

	{
		"rebelot/kanagawa.nvim",
	},

	{
		"nyoom-engineering/nyoom.nvim",
	},

	{
		"saeeedhany/parchment.nvim",
	},

	{
		"stefanvanburen/usgc-nvim",
	},

	{
		"wesgibbs/vim-irblack",
	},

	{
		dir = vim.fn.stdpath("config"),
		config = function()
			M.load_saved()
		end,
	},
}
