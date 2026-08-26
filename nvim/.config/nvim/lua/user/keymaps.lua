local map = vim.keymap.set

local function opts(desc)
    return {
        desc = desc,
        silent = true,
    }
end

-- =====================================================================
-- 🗂️ FILE, PLUGIN & CORE SHORTCUTS
-- =====================================================================

map("n", "<leader>m", "<cmd>Mason<CR>", opts("Open Mason"))
map("n", "<leader>l", "<cmd>Lazy<CR>", opts("Open Lazy"))

-- =====================================================================
-- 🔎 DIAGNOSTICS
-- =====================================================================

local diagnostics_active = true

map("n", "<leader>td", function()
    diagnostics_active = not diagnostics_active

    if diagnostics_active then
        vim.diagnostic.show()
        vim.notify("LSP diagnostics enabled")
    else
        vim.diagnostic.hide()
        vim.notify("LSP diagnostics disabled")
    end
end, opts("Toggle Diagnostics Visibility"))

map("n", "<leader>lg", vim.diagnostic.open_float, opts("Open Diagnostic Float Overlay"))

-- =====================================================================
-- 🪟 WINDOW MANAGEMENT
-- =====================================================================

map("n", "vv", "<C-w>v", opts("Vertical Split Window"))
map("n", "ss", "<C-w>s", opts("Horizontal Split Window"))

map("n", "<M-Up>", "<cmd>resize -2<CR>", opts("Decrease Height"))
map("n", "<M-Down>", "<cmd>resize +2<CR>", opts("Increase Height"))
map("n", "<M-Left>", "<cmd>vertical resize +2<CR>", opts("Increase Width"))
map("n", "<M-Right>", "<cmd>vertical resize -2<CR>", opts("Decrease Width"))

-- =====================================================================
-- 📄 BUFFER MANAGEMENT
-- =====================================================================

map("n", "<leader>xc", "<cmd>bd<CR>", opts("Close Current Buffer"))
map("n", "H", "<cmd>bprevious<CR>", opts("Previous Buffer"))
map("n", "L", "<cmd>bnext<CR>", opts("Next Buffer"))

-- =====================================================================
-- 🧭 NAVIGATION
-- =====================================================================

map("n", "J", "mzJ`z", opts("Join Lines Without Moving Cursor"))
map("n", "<C-d>", "<C-d>zz", opts("Half Page Down Centered"))
map("n", "<C-u>", "<C-u>zz", opts("Half Page Up Centered"))
map("n", "n", "nzzzv", opts("Next Search Result Centered"))
map("n", "N", "Nzzzv", opts("Previous Search Result Centered"))

-- =====================================================================
-- ✍️ VISUAL MODE EDITING
-- =====================================================================

map("v", "J", ":m '>+1<CR>gv=gv", opts("Move Selection Down"))
map("v", "K", ":m '<-2<CR>gv=gv", opts("Move Selection Up"))

map("v", "<Tab>", ">gv", opts("Indent Selection"))
map("v", "<S-Tab>", "<gv", opts("Unindent Selection"))

map({ "v", "x" }, "p", '"_dP', opts("Paste Without Overwriting Register"))
map("n", "x", '"_x', opts("Delete Character Without Yanking"))

-- =====================================================================
-- 🔍 SEARCH & REPLACE
-- =====================================================================

map(
    "n",
    "<leader>s",
    [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]],
    { desc = "Replace Word Globally" }
)

map("n", "<leader>sdf", function()
    local current_word = vim.fn.expand("<cword>")
    local replacement_word = vim.fn.input("Replace with: ", current_word)
    local count = vim.v.count1

    local cmd = string.format(
        ".,.+%ds/\\<%s\\>/%s/gcI",
        count - 1,
        current_word,
        replacement_word
    )

    vim.cmd(cmd)
end, opts("Replace Current Word Within Line Count Block"))

-- =====================================================================
-- 💾 SAVE + FORMAT (via conform.nvim)
-- =====================================================================

map({ "n", "i", "v" }, "<C-s>", function()
    vim.cmd.stopinsert()

    require("conform").format({
        async = false,
        timeout_ms = 1000,
        lsp_format = "fallback",
    })

    vim.cmd.write()
end, opts("Format And Save"))
-- =====================================================================
-- 📋 SYSTEM CLIPBOARD
-- =====================================================================

map({ "n", "v" }, "<leader>y", '"+y', opts("Yank To System Clipboard"))
map("n", "<leader>Y", '"+yy', opts("Yank Line To System Clipboard"))

map({ "n", "v" }, "<leader>p", '"+p', opts("Paste From Clipboard"))
map({ "n", "v" }, "<leader>P", '"+P', opts("Paste Before From Clipboard"))

-- =====================================================================
-- 🖊️ MUSCLE MEMORY TRAINING
-- =====================================================================

for _, key in ipairs({ "<Left>", "<Right>", "<Up>", "<Down>" }) do
    map("n", key, "<Nop>", { noremap = true, silent = true })
end

-- =====================================================================
-- ⌨️ ESCAPE SHORTCUTS
-- =====================================================================

map("i", "jj", "<Esc>", opts("Exit Insert Mode"))
map("i", "jk", "<Esc>", opts("Exit Insert Mode"))

map(
    "t",
    "jj",
    [[<C-\><C-n>]],
    opts("Exit Terminal Mode")
)

-- =====================================================================
-- ✏️ INSERT MODE MOVEMENT
-- =====================================================================

map("i", "<C-h>", "<Left>", opts("Cursor Left"))
map("i", "<C-l>", "<Right>", opts("Cursor Right"))
map("i", "<C-j>", "<Down>", opts("Cursor Down"))
map("i", "<C-k>", "<Up>", opts("Cursor Up"))

-- =====================================================================
-- ⚙️ C/C++ COMPILE + RUN
-- =====================================================================

map("n", "<leader>rc", function()
    vim.cmd.write()

    local file_path = vim.fn.expand("%:p")
    local file_dir = vim.fn.expand("%:p:h")
    local extension = vim.fn.expand("%:e")

    local compiler, bin_name

    local is_windows =
        vim.fn.has("win32") == 1 or vim.fn.has("win64") == 1

    if extension == "cpp" then
        compiler = "g++ -std=c++17"
        bin_name = is_windows and "main.exe" or "a.out"
    elseif extension == "c" then
        compiler = "gcc"
        bin_name = is_windows and "c_bin.exe" or "c_bin"
    else
        vim.notify("Not a C or C++ file", vim.log.levels.WARN)
        return
    end

    local output_bin = file_dir .. "/" .. bin_name

    local compile_cmd =
        compiler
        .. " "
        .. vim.fn.shellescape(file_path)
        .. " -o "
        .. vim.fn.shellescape(output_bin)

    local run_cmd = vim.fn.shellescape(output_bin)
    local full_command = compile_cmd .. " && " .. run_cmd

    vim.cmd.vsplit()
    vim.cmd("terminal " .. full_command)
    vim.cmd.startinsert()
end, opts("C/C++: Compile And Run Next To Source"))

-- =====================================================================
-- 🖥️ TMUX + NEOVIM PANE NAVIGATION
-- =====================================================================

local function tmux_navigate(direction, vim_cmd)
    local current_window = vim.api.nvim_get_current_win()

    vim.cmd(vim_cmd)

    if current_window == vim.api.nvim_get_current_win() then
        vim.system({ "tmux", "select-pane", "-" .. direction })
    end
end

map("n", "<C-h>", function()
    tmux_navigate("L", "wincmd h")
end, opts("Navigate Left"))

map("n", "<C-j>", function()
    tmux_navigate("D", "wincmd j")
end, opts("Navigate Down"))

map("n", "<C-k>", function()
    tmux_navigate("U", "wincmd k")
end, opts("Navigate Up"))

map("n", "<C-l>", function()
    tmux_navigate("R", "wincmd l")
end, opts("Navigate Right"))
