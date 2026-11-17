-- MovableFrame: a small panel you can drag anywhere; its position is
-- saved and restored next login.
-- Teaches: creating a frame with BackdropTemplate (never SetBackdrop
-- on a plain frame), drag handling, and anchor persistence.
-- See docs/03, docs/07, docs/12.

local addonName, addon = ...

local frame = CreateFrame("Frame", addonName .. "Panel", UIParent, "BackdropTemplate")
frame:SetSize(220, 90)
frame:SetBackdrop({
    bgFile = "Interface\\DialogFrame\\UI-DialogBox-Background",
    edgeFile = "Interface\\DialogFrame\\UI-DialogBox-Border",
    tile = true, tileSize = 32, edgeSize = 32,
    insets = { left = 8, right = 8, top = 8, bottom = 8 },
})
frame:SetMovable(true)
frame:EnableMouse(true)
frame:RegisterForDrag("LeftButton")
frame:SetScript("OnDragStart", function(self) self:StartMoving() end)
frame:SetScript("OnDragStop", function(self)
    self:StopMovingOrSizing()
    -- Save the anchor: point, relative point, and offsets.
    local point, _, relativePoint, x, y = self:GetPoint()
    MovableFrameDB.point = point
    MovableFrameDB.relativePoint = relativePoint
    MovableFrameDB.x = x
    MovableFrameDB.y = y
end)

local label = frame:CreateFontString(nil, "OVERLAY", "GameFontNormal")
label:SetPoint("CENTER")
label:SetText("Drag me!")

local events = CreateFrame("Frame")
events:RegisterEvent("ADDON_LOADED")
events:SetScript("OnEvent", function(self, event, name)
    if name ~= addonName then
        return
    end
    MovableFrameDB = MovableFrameDB or {}
    if MovableFrameDB.point then
        frame:ClearAllPoints()
        frame:SetPoint(MovableFrameDB.point, UIParent,
            MovableFrameDB.relativePoint, MovableFrameDB.x, MovableFrameDB.y)
    else
        frame:SetPoint("CENTER")
    end
    self:UnregisterEvent("ADDON_LOADED")
end)

SLASH_MOVABLEFRAME1 = "/mframe"
SlashCmdList["MOVABLEFRAME"] = function()
    -- Reset to the center: clear the saved anchor and re-anchor.
    MovableFrameDB.point = nil
    frame:ClearAllPoints()
    frame:SetPoint("CENTER")
end
