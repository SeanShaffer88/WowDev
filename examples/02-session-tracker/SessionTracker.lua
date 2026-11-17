-- SessionTracker: counts deaths and level-ups, this session and
-- all-time, stored per character.
-- Teaches: the event-frame pattern with several events, and
-- SavedVariablesPerCharacter. See docs/01, docs/03, docs/12.

local addonName, addon = ...

addon.session = { deaths = 0, levelUps = 0 }

local frame = CreateFrame("Frame")
frame:RegisterEvent("ADDON_LOADED")
frame:RegisterEvent("PLAYER_DEAD")
frame:RegisterEvent("PLAYER_LEVEL_UP")
frame:SetScript("OnEvent", function(self, event, ...)
    if event == "ADDON_LOADED" then
        if (...) ~= addonName then
            return
        end
        -- Per-character table: declared as SavedVariablesPerCharacter.
        SessionTrackerDB = SessionTrackerDB or { deaths = 0, levelUps = 0 }
        addon.db = SessionTrackerDB
    elseif event == "PLAYER_DEAD" then
        addon.session.deaths = addon.session.deaths + 1
        addon.db.deaths = addon.db.deaths + 1
    elseif event == "PLAYER_LEVEL_UP" then
        addon.session.levelUps = addon.session.levelUps + 1
        addon.db.levelUps = addon.db.levelUps + 1
        print("Level up! Total level-ups tracked: " .. addon.db.levelUps)
    end
end)

SLASH_SESSIONTRACKER1 = "/strack"
SlashCmdList["SESSIONTRACKER"] = function()
    print("This session: " .. addon.session.deaths .. " deaths, "
        .. addon.session.levelUps .. " level-ups")
    print("All time (this character): " .. addon.db.deaths .. " deaths, "
        .. addon.db.levelUps .. " level-ups")
end
