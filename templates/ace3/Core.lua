-- {{ADDON_NAME}} — Ace3 addon skeleton.
-- Lifecycle (AceAddon-3.0): NewAddon -> OnInitialize -> OnEnable.
-- Data (AceDB-3.0): profiles backed by the SavedVariables table named
-- in the .toc. Commands (AceConsole-3.0): RegisterChatCommand.
-- See docs/05-libraries-and-frameworks.md and docs/12-patterns-cookbook.md.

local addonName = ...
local AceAddon = LibStub("AceAddon-3.0")

local addon = AceAddon:NewAddon(addonName, "AceConsole-3.0", "AceEvent-3.0")

local defaults = {
    profile = {
        enabled = true,
        counter = 0,
    },
}

function addon:OnInitialize()
    -- "{{ADDON_NAME}}DB" must match ## SavedVariables in the .toc.
    self.db = LibStub("AceDB-3.0"):New(addonName .. "DB", defaults, true)
    self:RegisterChatCommand(addonName:lower(), "OnSlashCommand")
    self:Print("loaded. Type /" .. addonName:lower() .. " for options.")
end

function addon:OnEnable()
    -- Register events here (AceEvent-3.0), e.g.:
    -- self:RegisterEvent("PLAYER_ENTERING_WORLD", "OnEnteringWorld")
end

function addon:OnSlashCommand(msg)
    msg = (msg or ""):lower()
    if msg == "count" then
        self.db.profile.counter = self.db.profile.counter + 1
        self:Print("counter is now " .. self.db.profile.counter)
    else
        self:Print("enabled=" .. tostring(self.db.profile.enabled)
            .. ", counter=" .. self.db.profile.counter)
    end
end
