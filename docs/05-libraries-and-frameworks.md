# 05 — Libraries and Frameworks

## LibStub — the mechanism underneath most of them

LibStub is a small versioning registry: libraries register themselves
by name (`LibStub("AceAddon-3.0")`), and every addon on a machine
shares the newest loaded copy. Two distribution models exist:

- **Embedded** — the addon carries its own copy of the library files
  (usually under `Libs/`), pulled in at packaging time by `.pkgmeta`
  externals ([`09`](09-packaging-and-distribution.md)). This is the
  Ace3 and LibMasterAddons model.
- **Standalone dependency addon** — the library is its own addon and
  consumers declare it in `## Dependencies:`. This is the RGX and
  Foundry model; the user must have it installed.

## Ace3 — the standard framework

- **Home:** https://github.com/WoWUIDev/Ace3 (development mirror).
  **Packaging authority:** Ace3's own README states the WoWAce SVN —
  `https://repos.wowace.com/wow/ace3/trunk` — is the primary source and
  what `.pkgmeta` externals should reference.
- **What it is:** 14 small, independently usable modules, each a
  LibStub library. Embed only the ones you use:
  AceAddon-3.0 (lifecycle), AceEvent-3.0, AceBucket-3.0 (event
  batching), AceTimer-3.0, AceHook-3.0, AceDB-3.0 (SavedVariables +
  profiles), AceDBOptions-3.0, AceConfig-3.0 + AceGUI-3.0 (options
  UI), AceConsole-3.0 (slash commands/chat), AceComm-3.0 +
  AceSerializer-3.0 (addon comms), AceLocale-3.0, AceTab-3.0 — plus
  the shared CallbackHandler-1.0 and LibStub, which ship in-tree.
- **Flavor support is real and current:** Ace3's own `.toc` declares
  Era 11508/11509, Forever 16001, TBC 20505/20506, Wrath 30405,
  Timewalking 38002, Cata 40402, MoP 50503/50504, and Retail
  120100–120107. One codebase spans every flavor in
  [`04`](04-flavors-and-interface-numbers.md).
- **Use it when:** almost always, for a new addon of any size. It is
  the ecosystem's default answer for lifecycle, events, DB/profiles,
  and options.

## RGX-Framework — the standalone alternative

- **Home:** https://github.com/RGXMods/RGX-Framework (also on
  WoWInterface and CurseForge).
- **What it is:** a modern, self-contained framework shipped as **one
  shared dependency addon** — events, timers, hooks, slash commands,
  minimap buttons, options panels, database profiles, DataBroker,
  media, dropdowns, UI controls, and a visual design system. Consumers
  declare `## RequiredDeps: RGX-Framework` and define the addon with a
  single declarative `RGXAddon "MyAddon" { ... }` call; deliberately
  **not** LibStub ("no LibStub bloat, no fallbacks" is their pitch).
  Advertises Retail, Classic Era, TBC, Wrath/Titan, Cata, MoP Classic,
  and WoW Forever (beta).
- **Status caveat:** actively developed (v2.18.3, Nov 2026) but very
  young and small — 1 GitHub star, and its WoWInterface page lags its
  GitHub releases. MIT per its WoWInterface page.

## LibMasterAddons — Classic-focused, single file

- **Home:** CurseForge only —
  https://www.curseforge.com/wow/addons/lib-master-addons. There is
  **no GitHub repository**; do not go looking for one.
- **What it is:** a lightweight framework for Classic-family addons: an
  addon container with **dependency injection** (Services/Views/Models
  by name — `CreateService`/`GetService` etc.), client detection
  (per-flavor flags including `isForever`, plus a `compat` shim mapping
  missing Classic globals to modern replacements), built-in services
  for logging, locales, timers, player names, chat output, and version
  checks, and a full UI toolkit rendered in Flat and Classic styles.
  Supports Era, Season of Discovery, Anniversary, Forever, TBC, Wrath,
  Titan Reforged, Cata, and MoP Classic.
- **Distribution quirk:** it **is** a LibStub library
  (`LibStub("LibMasterAddons-1.0")`) but ships as **one compiled .lua
  file** (currently `LibMasterAddons-1.1.17.lua`) that each addon
  embeds in its own `libs` folder. Updating = new file + one `.toc`
  line. Players never install it standalone.

## Foundry — the native-first newcomer

- **Home:** https://github.com/Royaleint/Foundry; CurseForge project
  "Foundry: Modern Addon Library and Ace3 Alternative".
- **What it is:** a small library that wraps Blizzard's *modern*
  toolkit instead of recreating it — the Settings API, the new menu
  system (Blizzard_Menu), ScrollBox, modern tooltip hooks
  (TooltipDataProcessor). Nine modules: Commands, Events, Lifecycle,
  DB (profiles — and it reads existing AceDB save files unchanged),
  List, Settings, Tooltip, Menu, Window, each mapped to an Ace3
  equivalent where one exists, designed for incremental adoption
  alongside Ace3. Distributed as a standalone library addon
  (`Foundry-1.0`); declare `## Dependencies: Foundry-1.0`. Supports
  Retail, Classic Era, TBC Anniversary, MoP Classic, and WoW Forever.
- **Status caveat:** brand new and tiny (repo created 2026-05-30,
  0 stars, actively pushed). "Ace3 alternative" is its own tagline,
  not an established position. MIT.

## WeakAuras — a reference, not a framework

WeakAuras2 (https://github.com/WeakAuras/WeakAuras2) is a standalone
end-user addon for customizable on-screen displays — **not** an
embeddable library; other addons do not build on it the way they build
on Ace3. It is actively maintained (5.22.1, Oct 2026; repo pushed
2026-11-16 — claims that it is archived are wrong). Its value to
authors is as a large, mature codebase to *read* for advanced
UI/trigger engineering, and as an integration surface from inside
WeakAuras itself (custom triggers).

## Choosing

| Need | Default answer |
|---|---|
| General-purpose framework, any flavor | Ace3 (embedded modules) |
| Classic-family app with DI structure and a bundled UI toolkit | LibMasterAddons (embed the single file) |
| Declarative all-in-one with a design system, users accept a dependency addon | RGX-Framework |
| Retail-modern Settings/menus with minimal surface | Foundry (watch its maturity) |
| Aura/trigger displays | WeakAuras (as a user) — not a dependency |
