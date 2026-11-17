# 01 — Addon Anatomy

An addon is a folder in `Interface/AddOns/` containing a `.toc` file
with the **same name as the folder**, plus Lua and/or XML files. The
client reads the `.toc` at startup; everything else follows from it.

## The .toc file

The `.toc` (table of contents) is the addon's manifest. Metadata lines
start with `## Key: Value`; file lines list what to load, in order.

Essential keys:

| Key | Meaning |
|---|---|
| `## Interface: 16001` | The client interface version this addon targets. Must match the client or the addon is marked out of date and does not load. One per flavor — see [`04`](04-flavors-and-interface-numbers.md). The packager can generate per-flavor TOCs from `## Interface-[Type]:` lines ([`09`](09-packaging-and-distribution.md)) |
| `## Title: My Addon` | Display name in the addon list |
| `## Notes: ...` | Short description shown in the addon list |
| `## Author: ...`, `## Version: ...` | Shown in the addon list; the packager can substitute `@project-version@` for Version |
| `## SavedVariables: MyAddonDB` | Global variables persisted account-wide between sessions. **Undeclared variables do not persist.** |
| `## SavedVariablesPerCharacter: MyAddonCharDB` | Same, per character |
| `## Dependencies: OtherAddon` | Hard load-order dependency (older spelling `## RequiredDeps:` is also used); the addon will not load without it. Standalone framework addons (RGX-Framework, Foundry-1.0) are consumed this way |
| `## OptionalDeps: Ace3` | Load after these if present |
| `## LoadOnDemand: 1` | Do not load at startup; load via `LoadAddOn()` |
| `## X-Curse-Project-ID:`, `## X-WoWI-ID:`, `## X-Wago-ID:` | Distribution site IDs the BigWigs packager reads ([`09`](09-packaging-and-distribution.md)) |

Below the metadata, list files **one per line, in load order** —
typically libraries first, then core files, then modules, then XML.
Files load in exactly the order listed; a file that uses something
defined in a later file fails.

## Load order and lifecycle (the short version)

1. The client reads all `.toc` files and builds the addon list.
2. At login, each enabled addon's files execute in `.toc` order.
3. `ADDON_LOADED` fires when an addon's files have finished loading —
   the standard moment to initialize SavedVariables (they are loaded
   just before the addon's files run).
4. `PLAYER_LOGIN` fires after the world and all addons are in.
5. SavedVariables are written back at logout/reload.

## The addon namespace pattern

Every Lua file in an addon receives the same varargs: the addon name
and a shared table. The standard pattern, used by virtually every
maintained addon:

```lua
local addonName, addon = ...
addon.events = {}
```

Files share state through that one table instead of globals. Addons
that spray unlocalized globals collide with each other and spread
taint; keep exactly one global at most (usually none — the namespace
table is passed, not global).

## Lua vs XML

- **Lua** defines behavior: events, logic, most frame creation.
- **XML** defines frame structure declaratively (FrameXML style) and
  virtual templates. Blizzard's own UI uses both; most modern addons
  create frames in Lua and use XML rarely, mainly for templates.
- Both are listed in the `.toc`. XML files load their `Script` includes
  relative to the XML file's folder.

## Folder layout conventions

```
MyAddon/
  MyAddon.toc
  Core.lua
  Options.lua
  Modules/
  Libs/            (embedded libraries, usually filled by the packager)
  Locales/
  Media/           (textures must be BLP or TGA — see docs/07)
  README.md  FEATURES.md  DESCRIPTION.md  CHANGELOG.md  LICENSE
```

## Sources

- Warcraft Wiki HOWTOs (Getting Started collection):
  https://warcraft.wiki.gg/wiki/HOWTOs — includes "Create a WoW AddOn
  in 15 Minutes" and the saved-variables and slash-command guides.
- `Gethe/wow-ui-source`, matching branch — read any `Blizzard_*`
  addon's `.toc` for the pattern at production scale.
