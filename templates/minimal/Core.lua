-- {{ADDON_NAME}} — minimal addon skeleton.
-- Patterns used here are the documented basics: the addon namespace,
-- ADDON_LOADED initialization, SavedVariables with defaults, and a
-- slash command. See docs/01-addon-anatomy.md and docs/12-patterns-cookbook.md.

local addonName, addon = ...

-- Defaults for the SavedVariables table declared in the .toc.
-- Keys present here are filled in when missing; user changes persist.
local defaults = {
    enabled = true,
    counter = 0,
}

local function ApplyDefaults(db, defs)
    for k, v in pairs(defs) do
        if db[k] == nil then
            db[k] = v
        end
    end
    return db
end

local frame = CreateFrame("Frame")
frame:RegisterEvent("ADDON_LOADED")
frame:SetScript("OnEvent", function(self, event, name)
    if name ~= addonName then
        return
    end

    -- The SavedVariables global exists by now (it may be nil on the
    -- very first run). Name it exactly as declared in the .toc.
    _G[addonName .. "DB"] = ApplyDefaults(_G[addonName .. "DB"] or {}, defaults)
    addon.db = _G[addonName .. "DB"]

    self:UnregisterEvent("ADDON_LOADED")
    print(addonName .. " loaded. Type /" .. addonName:lower() .. " for options.")
end)

-- Slash command: /{{ADDON_NAME_LOWER}} and /{{ADDON_NAME_LOWER}} count
SLASH_{{ADDON_NAME_UPPER}}1 = "/" .. addonName:lower()
SlashCmdList[addonName:upper()] = function(msg)
    msg = (msg or ""):lower()
    if msg == "count" then
        addon.db.counter = addon.db.counter + 1
        print(addonName .. ": counter is now " .. addon.db.counter)
    else
        print(addonName .. ": enabled=" .. tostring(addon.db.enabled)
            .. ", counter=" .. addon.db.counter)
    end
end
