# 10 — Communities and Learning

## Real-time help

**WoWUIDev Discord** — the central chat for addon developers (it began
as the IRC channel #wowuidev). The invite linked from the Warcraft
Wiki navigation is `discord.gg/txUg39Vhc6` (older invites from
2020/2021 posts are historical). Blizzard developers post upcoming
addon-restriction details there, so it doubles as an early-warning
channel. There is no wowuidev.com website — don't cite one.

## Forums

- **WoWInterface Forums** — https://www.wowinterface.com/forums/ —
  active, author-focused. The **Developer Discussions** category holds
  Tutorials & Other Helpful Info, Dev Tools, General Authoring
  Discussion, Lua/XML Help, Graphics Help, and Wish List; there are
  also PTR API/graphics-changes and Classic AddOn Help areas.
- **Blizzard "UI and Macro" forums** (forums.blizzard.com, US + EU) —
  the official venue; home of the UI Add-On Development Policy
  ([`09`](09-packaging-and-distribution.md)).
- **MMO-Champion "Interface & Macros"** — note the name: it is
  *Interface* & Macros (the "UI & Macros" name belongs to Wowhead's
  forums and the old Blizzard board). Mostly player-facing UI/macro
  discussion rather than deep development talk.

## Reddit and Q&A archives

- **r/wowaddondev** — the developer-focused subreddit; notable for
  full written tutorial series (e.g. Noxxious' multi-part "Creating a
  WoW Addon"). **r/wowaddons** — the general addon subreddit.
  (Member counts/activity: Unverified in this pass.)
- **Stack Overflow**, tag `world-of-warcraft` (plus the general `lua`
  tag) — a searchable archive of specific problems and errors, not a
  learning path.

## Tutorials (start here)

All under the HOWTOs index — prefer the Warcraft Wiki copies
(https://warcraft.wiki.gg/wiki/HOWTOs):

- **Create a WoW AddOn in 15 Minutes** — the canonical first addon:
  folder, `.toc`, slash command, SavedVariables.
- **Introduction to Lua** — a fast Lua primer written for WoW's 5.1.
- The wider HOWTO collection: event handling, saving variables, slash
  commands, key bindings, localization, StaticPopup, UIDropDownMenu,
  draggable frames, Ace3, and the BigWigs packager.

## Video

- **EsfandTV × ThePrimeagen (2026-10-20)** — a one-day Twitch
  live-stream (not a series) in which ThePrimeagen taught Esfand —
  starting from zero coding experience — to "vibe code" custom
  **WoW Forever** addons with AI assistance. YouTube VOD:
  https://www.youtube.com/watch?v=eWcYcMyEsgA. Directly relevant to
  AI-assisted Forever development (see [`11`](11-ai-assisted-development.md)).
- **Mayron, "Creating WoW AddOns"** — an 11-video YouTube playlist
  (2014) teaching Lua + XML addon development
  (https://www.youtube.com/playlist?list=PL3wt7cLYn4N-3D3PTTUZBM2t1exFmoA2G).
  Fundamentals hold; specific APIs are dated.
- **Ellesmere** — author of EllesmereUI, a major UI suite with Retail
  and WoW Forever builds (ellesmereui.com); also co-hosts Raider.IO's
  "Weekly No Leaver" podcast, which discusses addon development. (A
  personal YouTube channel could not be verified — Unverified.)

## Books (with the editions that matter)

- *World of Warcraft Programming: A Guide and Reference for Creating
  WoW Addons* — James Whitehead II & Rick Roe. Latest and final:
  **2nd Edition (Feb 2010, Wiley)**; no 3rd edition exists. Its
  companion site wowprogramming.com is frozen (see SOURCES.md) but
  its fundamentals — widget handlers, secure templates — still teach
  well.
- *Beginning Lua with World of Warcraft Add-ons* — Paul Emmerich
  (Deadly Boss Mods), Apress 2009. Novice-to-advanced, WoW-specific.
- *Programming in Lua* — Roberto Ierusalimschy. Get the **2nd
  edition**: it is the one covering **Lua 5.1** (the 1st edition
  covers 5.0 and is free at lua.org, as is the 5.1 reference manual).

## Reading code

The best teacher is production code: Blizzard's own UI in the matching
`wow-ui-source` branch, Ace3's modules, and large maintained addons.
GitHub discovery: search `topic:world-of-warcraft-addon` (~890 repos;
its topic page resolves) and `topic:wow-addon` (~2,145 repos — use it
as a *search filter*; the topic page itself 404s). Add flavor tags
(`classic`, `classic-era`) to narrow. The awesome-wow list exists but
has been untouched since 2019 — a historical starting point, not a
gateway.
