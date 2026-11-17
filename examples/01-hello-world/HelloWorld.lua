-- HelloWorld: /hello greets you and remembers how many times it has.
-- Teaches: the addon namespace, ADDON_LOADED init, SavedVariables,
-- and the SlashCmdList pattern. See docs/01 and docs/12.

local addonName, addon = ...

local frame = CreateFrame("Frame")
frame:RegisterEvent("ADDON_LOADED")
frame:SetScript("OnEvent", function(self, event, name)
    if name ~= addonName then
        return
    end
    -- HelloWorldDB is declared under ## SavedVariables in the .toc.
    -- It is nil on the first ever run.
    HelloWorldDB = HelloWorldDB or { greetings = 0 }
    addon.db = HelloWorldDB
    self:UnregisterEvent("ADDON_LOADED")
end)

SLASH_HELLOWORLD1 = "/hello"
SlashCmdList["HELLOWORLD"] = function()
    addon.db.greetings = addon.db.greetings + 1
    print("Hello, world! (greeting #" .. addon.db.greetings .. ")")
end
