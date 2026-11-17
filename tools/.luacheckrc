-- .luacheckrc for WoW addon development (luacheck, Lua 5.1).
-- Copy to your addon repo root and adjust. Pair with the luacheck
-- workflow in templates/github-workflows/luacheck.yml.
-- Full API knowledge for your editor comes from Ketho's WoW API
-- annotations (docs/06); this file only covers the bedrock globals so
-- lint stays quiet on correct code and loud on real mistakes.

std = "lua51"

-- WoW's dialect notes (docs/02): no 5.2+ features. luacheck's lua51
-- std already rejects most of them; check-addon.py covers the rest.

globals = {
    -- Slash command registration writes these (docs/12).
    "SlashCmdList",
}

read_globals = {
    -- FrameXML bedrock.
    "CreateFrame",
    "UIParent",
    "LibStub",
    "GetBuildInfo",
    "ReloadUI",
}

-- Addon code should not create other globals. The patterns below are
-- the sanctioned exceptions most addons need:
--   * SavedVariables tables declared in the .toc (add yours here,
--     e.g. globals = { "MyAddonDB" }).
--   * SLASH_<NAME>n globals: luacheck cannot pattern-match global
--     names, so declare each one, e.g. globals = { "SLASH_MYADDON1" }.

-- SavedVariables are written by the client and read by the addon:
-- declare them writable, e.g.
-- globals = { "MyAddonDB" }

max_line_length = false
