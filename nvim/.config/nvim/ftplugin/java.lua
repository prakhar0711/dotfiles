local jdtls = require("jdtls")
local jdtls_setup = require("jdtls.setup")

-- 1. Project root detection
local root_markers = {
    "mvnw",
    "gradlew",
    "pom.xml",
    "build.gradle",
    "build.gradle.kts",
    "settings.gradle",
    "settings.gradle.kts",
}

local root_dir = jdtls_setup.find_root(root_markers)
if not root_dir or root_dir == "" then
    local current_file = vim.api.nvim_buf_get_name(0)
    root_dir = (current_file ~= "" and vim.fs.dirname(current_file)) or vim.uv.cwd()
end

-- 2. Workspace directory per project
local project_name = vim.fs.basename(root_dir) or "standalone-workspace"
local workspace_dir = vim.fn.stdpath("cache") .. "/jdtls/workspace/" .. project_name

-- 3. Capabilities
local og_capabilities = vim.lsp.protocol.make_client_capabilities()
local capabilities = require("blink.cmp").get_lsp_capabilities(og_capabilities)

-- 4. JDTLS Configuration
local config = {
    cmd = {
        "jdtls",
        "-data",
        workspace_dir,
    },
    root_dir = root_dir,
    capabilities = capabilities,
    settings = {
        java = {
            eclipse = { downloadSources = true },
            maven = { downloadSources = true },
            references = { includeDecompiledSources = true },
            configuration = { updateBuildConfiguration = "interactive" },
            implementationsCodeLens = { enabled = true },
            referencesCodeLens = { enabled = true },
            format = { enabled = true },
            inlayHints = {
                parameterNames = { enabled = "all" },
            },
        },
    },
    flags = {
        allow_incremental_sync = true,
    },
}

-- 5. Attach Server
jdtls.start_or_attach(config)

-- 6. Java-specific Keymaps (Scoped to current buffer)
local bufnr = vim.api.nvim_get_current_buf()
local map = function(mode, lhs, rhs, desc)
    vim.keymap.set(mode, lhs, rhs, { buffer = bufnr, silent = true, desc = "Java: " .. desc })
end

map("n", "<leader>jo", jdtls.organize_imports, "Organize Imports")
map("n", "<leader>jv", jdtls.extract_variable, "Extract Variable")
map("v", "<leader>jv", function() jdtls.extract_variable(true) end, "Extract Variable")
map("v", "<leader>jm", function() jdtls.extract_method(true) end, "Extract Method")
map("n", "<leader>jt", jdtls.test_nearest_method, "Run Nearest Test")
map("n", "<leader>jT", jdtls.test_class, "Run Test Class")

map("n", "<leader>rj", function()
    vim.cmd.write()
    local java_file = vim.fn.expand("%:p")
    vim.cmd("vsplit | terminal java " .. vim.fn.shellescape(java_file))
    vim.cmd("startinsert")
end, "Run Current File")

-- 7. Format on save for Java buffers
vim.api.nvim_create_autocmd("BufWritePre", {
    buffer = bufnr,
    callback = function()
        vim.lsp.buf.format({ async = false, timeout_ms = 3000 })
    end,
})
