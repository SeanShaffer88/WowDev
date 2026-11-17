# 03 — The API, Events, and Widgets

## Where the API is documented (in trust order)

1. **In the client itself.** Blizzard ships `Blizzard_APIDocumentation`
   — the official, generated documentation for the C++-backed API —
   accessible in-game via the `/api` command, and mirrored inside
   `Gethe/wow-ui-source` as `Blizzard_APIDocumentationGenerated`.
2. **Warcraft Wiki** — https://warcraft.wiki.gg/wiki/World_of_Warcraft_API
   is the maintained community reference, organized by `C_*` namespace
   with signatures like
   `C_AddOns.GetAddOnInfo(name) : name, title, notes, loadable, reason, security, ...`.
   Classic flavors have a dedicated subpage (`World of Warcraft
   API/Classic`). Per-patch **API changes** pages are the migration
   source when a client version moves.
3. **Blizzard's own UI code** in wow-ui-source — when the wiki is
   ambiguous, how FrameXML actually calls the function is the answer.

The wiki's nav splits the surface into: WoW API, Lua API, FrameXML,
Widget API, Widget scripts, XML schema, Events, CVars, Macro commands,
Combat Log, Escape sequences, and Hyperlinks.

## Restriction tags — read them

Wiki listings tag functions with machine-readable restrictions:

- `#hwevent` — requires a hardware event (a real key press / click) to
  do its protected action.
- `#noscript` — not callable from addon scripts in the way the listing
  context implies.
- `#framexml` — implemented in FrameXML Lua rather than in C++.

Treating every listed function as freely callable is how addons end up
"blocked" in combat. Protected functions and actions (casting, moving,
targeting, action buttons) are governed by the **secure execution**
model: in combat lockdown, protected calls from tainted code fail.

## Taint in one paragraph

Code that originates from addons is *tainted*; when tainted code
touches secure objects or execution paths, the taint spreads, and the
client then refuses protected actions along that path ("Interface
action failed because of an AddOn"). The practical rules: don't modify
Blizzard objects' secure properties from addon code, don't store
values into secure frames' fields, use secure templates
(`SecureActionButtonTemplate` and friends) for anything clickable in
combat, and debug taint with the tools in
[`08`](08-testing-and-debugging.md). The secure template attribute
reference on wowprogramming.com is old but still the reference for
attribute semantics (the mechanism has not changed).

## Events

The event system is the addon's nervous system: frames register for
named events (`RegisterEvent`, `RegisterUnitEvent`) and receive them
in their `OnEvent` script handler. Key facts:

- Event names, payloads, and availability differ **per flavor and per
  patch** — check the wiki's Events page for the target client, and
  the API changes pages when porting.
- `ADDON_LOADED` and `PLAYER_LOGIN` structure most addon startup
  ([`01`](01-addon-anatomy.md)).
- Unit events only fire for units that exist; registering for a unit
  event with an invalid unit is a classic silent failure.

## Widgets (frames)

Frames and their subclasses (buttons, status bars, edit boxes,
scroll frames, cooldowns…) are created with `CreateFrame` in Lua or
declared in XML, and driven through widget methods and script handlers
(`OnEvent`, `OnUpdate`, `OnClick`, …). The Widget API and Widget
scripts pages on Warcraft Wiki are the reference. Two standing traps:

- **Backdrop:** never call `SetBackdrop` on a plain frame — create the
  frame with the `BackdropTemplate` template (or mix in
  `BackdropTemplateMixin`) first. Plain frames do not have the method
  on clients that enforce the split.
- **Scale/anchoring across flavors:** widget behavior details (e.g.
  which templates exist) differ between Retail and the Classic-family
  clients; the matching wow-ui-source branch shows what the target
  client's FrameXML actually ships.

## CVars, macros, combat log

- **CVars** (console variables) are documented on the wiki with
  defaults; addons read/write them via the CVar API, but many are
  protected or account-wide — check before touching.
- **Macro commands** and **secure conditionals** are their own
  documented surface on the wiki; addons generate macros but cannot
  execute protected actions outside the secure rules above.
- **Combat Log** events arrive as one high-volume event with sub-event
  payloads; parse defensively — the format is flavor-sensitive.
