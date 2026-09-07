local CLOSING_CHARS = {
	[")"] = true,
	["]"] = true,
	["}"] = true,
	['"'] = true,
	["'"] = true,
	["`"] = true,
	[">"] = true,
}

local OPENING_CHARS = {
	["("] = true,
	["["] = true,
	["{"] = true,
	['"'] = true,
	["'"] = true,
	["`"] = true,
	["<"] = true,
}

local function tabout()
	local cursor = vim.api.nvim_win_get_cursor(0)
	local row = cursor[1] - 1
	local col = cursor[2]
	local line = vim.api.nvim_get_current_line()

	-- Check character immediately next to cursor
	local next_char = line:sub(col + 1, col + 1)
	if CLOSING_CHARS[next_char] then
		vim.api.nvim_win_set_cursor(0, { row + 1, col + 1 })
		return true
	end

	-- Check nearest closing character to the right on this line
	local rest_of_line = line:sub(col + 1)
	local min_idx = nil

	for char in pairs(CLOSING_CHARS) do
		local idx = rest_of_line:find(char, 1, true)
		if idx and (not min_idx or idx < min_idx) then
			min_idx = idx
		end
	end

	if min_idx then
		vim.api.nvim_win_set_cursor(0, { row + 1, col + min_idx })
		return true
	end

	return false
end

local function tabout_back()
	local cursor = vim.api.nvim_win_get_cursor(0)
	local row = cursor[1] - 1
	local col = cursor[2]
	local line = vim.api.nvim_get_current_line()

	if col == 0 then
		return false
	end

	local prev_text = line:sub(1, col)
	local max_idx = nil

	for char in pairs(OPENING_CHARS) do
		local last = 0
		while true do
			local idx = prev_text:find(char, last + 1, true)
			if not idx then
				break
			end
			last = idx
		end
		if last > 0 and (not max_idx or last > max_idx) then
			max_idx = last
		end
	end

	if max_idx then
		vim.api.nvim_win_set_cursor(0, { row + 1, max_idx - 1 })
		return true
	end

	return false
end

-- Run keymaps immediately on require
vim.keymap.set("i", "<Tab>", function()
	if not tabout() then
		local tab_key = vim.api.nvim_replace_termcodes("<Tab>", true, true, false)
		vim.api.nvim_feedkeys(tab_key, "n", false)
	end
end, { silent = true, desc = "Tabout forward or indent" })

vim.keymap.set("i", "<S-Tab>", function()
	if not tabout_back() then
		local s_tab_key = vim.api.nvim_replace_termcodes("<S-Tab>", true, true, false)
		vim.api.nvim_feedkeys(s_tab_key, "n", false)
	end
end, { silent = true, desc = "Tabout backward" })
