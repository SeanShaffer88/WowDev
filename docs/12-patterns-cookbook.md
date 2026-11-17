# 12 — Patterns Cookbook

The recurring shapes of addon code, each small enough to copy and
adapt. All of these appear in the [`../templates/`](../templates/)
and [`../examples/`](../examples/) — this doc explains them.

## The namespace header

Every Lua file starts with the same line. The client passes the addon
name and one shared table to every file in the addon:

```lua
local addonName, addon = ...
```

State shared between files lives on `addon`. Nothing else needs to be
a global.

## The event frame

One hidden frame receives events; its `OnEvent` branches by name:

```lua
local frame = CreateFrame("Frame")
frame:RegisterEvent("PLAYER_ENTERING_WORLD")
frame:SetScript("OnEvent", function(self, event, ...)
    -- branch on `event`; payload rides in `...`
end)
```

Rules: register only what you handle; `ADDON_LOADED` fires for every
addon, so filter its first payload value against your own name;
unregister one-shot events after use.

## SavedVariables init with defaults

SavedVariables exist (possibly as `nil`) by the time your
`ADDON_LOADED` fires. Merge defaults *by missing key only*, so user
changes are never overwritten on upgrade:

```lua
local defaults = { enabled = true, counter = 0 }

local function ApplyDefaults(db, defs)
    for k, v in pairs(defs) do
        if db[k] == nil then db[k] = v end
    end
    return db
end

-- inside the ADDON_LOADED handler:
MyAddonDB = ApplyDefaults(MyAddonDB or {}, defaults)
```

(Nested tables need a recursive merge; AceDB — docs/05 — does this
for you, which is one reason it is the default.)

## Slash commands

Two globals register a command; keep the handler thin:

```lua
SLASH_MYADDON1 = "/myaddon"
SLASH_MYADDON2 = "/ma"
SlashCmdList["MYADDON"] = function(msg)
    -- parse msg, call into your addon's functions
end
```

The `SLASH_<KEY>n` names and the `SlashCmdList` key must use the same
KEY. AceConsole (docs/05) wraps this with argument parsing.

## Throttled OnUpdate

`OnUpdate` runs **every frame**. Never do real work in it directly —
accumulate elapsed time and work at an interval:

```lua
local elapsed = 0
frame:SetScript("OnUpdate", function(self, dt)
    elapsed = elapsed + dt
    if elapsed < 0.2 then return end
    elapsed = 0
    -- periodic work here, at most 5x per second
end)
```

Better still: prefer events over polling (docs/13). `OnUpdate` is the
last resort, for things no event announces.

## Splitting work across frames

A loop over thousands of items in one call freezes the UI. Process a
slice per frame and resume next frame until done — the pattern every
scanner/indexer addon uses. Keep the per-frame slice small and the
state (cursor position) on the addon table so the work is resumable
and cancellable.

## The localization table

One table, one file per locale, English as the fallback (full
treatment in [`14-localization.md`](14-localization.md)):

```lua
local _, addon = ...
addon.L = addon.L or {}
local L = addon.L
L["Reset position"] = "Reset position"  -- enUS defaults
```

Code always looks text up in `L`; it never hard-codes display strings.

## Reading state safely at load

Do not touch other addons' frames, the player's unit data, or
SavedVariables at file scope (top level) — at file-execution time
almost nothing exists yet. File scope is for definitions; everything
that reads the world waits for `ADDON_LOADED` / `PLAYER_LOGIN`.
