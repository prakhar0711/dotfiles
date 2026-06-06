-- ====================================================================
--                      MAIN HYPRLAND LUA INITIALIZER
-- ====================================================================

-- Absolute path to your module directory
local config_dir = os.getenv("HOME") .. "/.config/hypr/lua/"

-- Load modules sequentially
dofile(config_dir .. "env.lua")
dofile(config_dir .. "appearance.lua")
dofile(config_dir .. "autostart.lua")
dofile(config_dir .. "binds.lua")
dofile(config_dir .. "rules.lua")
