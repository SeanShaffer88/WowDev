# SOURCES.md — The seed list, verified

This repo was built from a resource list supplied on 2026-11-17. The
list is preserved here in full, entry by entry, with the verification
status of each item checked against its live source the same day.
Statuses: **Verified** (exists as described) · **Corrected** (exists,
but the description needed fixing — see the note) · **Stale** (exists,
no longer current) · **Dead** (gone) · **Unverified** (could not be
confirmed with the tools available).

## API documentation & reference

| Resource | Status | Note |
|---|---|---|
| Warcraft Wiki (UI API) — https://warcraft.wiki.gg/wiki/UI_API | Corrected | The wiki is the living home of the API docs (community fork from Wowpedia, Oct 2023). The verifiable API hub is https://warcraft.wiki.gg/wiki/World_of_Warcraft_API, with Classic on its `/Classic` subpage. The `UI_API` page's own contents were Unverified in this pass (transient fetch failure, not a 404). |
| Gethe/wow-ui-source — https://github.com/Gethe/wow-ui-source | Corrected | Exists and is automated/current. The branch layout is a whole family — `live`, `ptr`, `ptr2`, `beta`, `classic`, `classic_era`, `classic_anniversary`, `classic_titan`, `classic_ptr`, `classic_era_ptr`, `classic_beta`, **`forever`**, `automation` — not just a `classic` branch. No LICENSE file in the repo root; treat as a read-only reference. |
| Wowpedia (Fandom) — https://wowpedia.fandom.com/wiki/World_of_Warcraft_API | Stale | The pre-fork copy. Its API page states automated updates ceased from patch 10.1.7 (2023). Useful as a frozen historical snapshot only. |
| Wowpedia HOWTOs — https://wowpedia.fandom.com/wiki/HOWTOs | Verified | The tutorial index; the same collection lives on Warcraft Wiki (prefer those copies). |
| wowprogramming.com — http://wowprogramming.com/ | Stale | Companion site to the book. Its API reference froze around Warlords of Draenor (no `C_AddOns`/`C_AuctionHouse`/`C_Container`); still useful for widget script handlers, the secure template attribute reference, and CVar defaults. |
| Wowpedia UI FAQ / AddOn Author Resources | Stale | A historical link hub: its pointers to the Lua 5.1 manual and BLP tools are still right; its editor recommendations are mid-2000s artifacts. |
| Lua 5.1 Reference Manual — https://www.lua.org/manual/5.1/ | Verified | The language ground truth. WoW implements a *subset* of 5.1 (client on 5.1.1 since patch 2.0.1) — the manual documents the full language, so pair it with Warcraft Wiki's Lua pages. |

## Tutorials, guides & learning paths

| Resource | Status | Note |
|---|---|---|
| Create a WoW AddOn in 15 Minutes | Verified | Exists on both wikis; listed under Getting Started on the HOWTOs index. Fandom copy tracks the current interface number; prefer the wiki.gg HOWTOs index. |
| Introduction to Lua | Verified | Exists on both wikis; explicitly notes WoW uses Lua 5.1. |
| WoWInterface "How do I get started in Addon programming?" | Unverified | The forum and its Developer Discussions area are verified active; this specific thread was not individually fetched. |
| Reddit r/wowaddondev | Verified | Exists; known for multi-part written tutorial series. Size/activity Unverified. |
| Wowhead "How to make addons" forum post | Unverified | Not individually fetched in this pass. Note the related verified fact: Wowhead's forums board is named "UI & Macros" (see Communities). |
| DevHQ "How to Create a WoW Addon" | Unverified | Not individually fetched in this pass. |

## Development tools & IDEs

| Resource | Status | Note |
|---|---|---|
| VS Code + WoW Bundle extension | Corrected | WoW Bundle is by **Septh** (`Septh.wow-bundle`), not Ketho — and its repo is archived, last release 2018, API data targets WoW 8.0.1. Ketho's separate **WoW API** extension (`ketho.wow-api`, for LuaLS) is actively maintained. EmmyLua is by Tangzx (`tangzx.emmylua`). |
| AddOn Studio — https://addonstudio.org/ | Verified | Full IDE on the Visual Studio Shell: visual FrameXML designer, IntelliSense, TOC management, deployment. Editions are named by shell year (2022/2015/2010); supports Retail and Classic. |
| ZeroBrane Studio | Verified | Lightweight cross-platform Lua IDE (current, v2.01). A *general* Lua IDE — no built-in WoW API knowledge. |
| WoW Lua API (IntelliJ IDEA) | Corrected | The canonical stubs are Ellypse/IntelliJ-IDEA-Lua-IDE-WoW-API, used with the EmmyLua plugin (ID 9768). Stale — last pushed 2024-01-24. |
| DevTool (brittyazel/DevTool) | Corrected | An **in-game runtime inspection/debugging addon** (tables, events, function-call log) — it does **not** do packaging or zip generation; that description belongs to BigWigsMods/packager. GitHub repo now archived; latest release 1.3.0. |
| WowLua | Verified | In-game Lua interpreter + script editor by James Whitehead II; maintained (CurseForge update 2026-04). A 1.12 fork (laytya/WowLuaVanilla) exists. |
| Lua Browser | Stale | In-game environment browser; dormant — last updated 2020-10-31. |

## Libraries & frameworks

| Resource | Status | Note |
|---|---|---|
| Ace3 — https://github.com/WoWUIDev/Ace3 | Corrected | Verified, maintained, 14 modules (see docs/05). One emphasis fix: the GitHub repo is the development mirror — Ace3's README names the WoWAce SVN (`https://repos.wowace.com/wow/ace3/trunk`) as the primary authority and what `.pkgmeta` should reference. Its .toc spans Era 11508/11509, Forever 16001, and Retail 120100–120107. |
| RGX-Framework | Verified | Real: RGXMods/RGX-Framework. A standalone dependency addon (deliberately not LibStub) with events, timers, options, DB profiles, and a design system; advertises Retail, Classic Era, and WoW Forever (beta). Very young and small (v2.18.3, Nov 2026; 1 GitHub star) — claims check out, maturity is the caveat. |
| LibMasterAddons | Corrected | Real, and the feature claims (dependency injection, locales, timers, Classic focus) check out — but it is **CurseForge-only**; no GitHub repo exists. A single-file LibStub library (`LibMasterAddons-1.0`) each addon embeds; its client detection even has an `isForever` flag. |
| WeakAuras2 | Corrected | **Not archived** — release 5.22.1 (2026-10-10), repo pushed 2026-11-16. But it is a standalone end-user addon, not an embeddable framework: read its code to learn, don't build on it. |
| Foundry | Verified | Real: Royaleint/Foundry — a small native-first library wrapping the modern Settings API/menus, explicitly positioned as an Ace3 alternative with incremental adoption. Brand new (repo created 2026-05-30, 0 stars); the description is its own tagline, not an established position. |

## Communities, forums & Discord

| Resource | Status | Note |
|---|---|---|
| WoWUIDev Discord | Verified | The central dev chat (began as IRC #wowuidev). Invite linked from the Warcraft Wiki navigation: discord.gg/txUg39Vhc6 (invite validity via text fetch Unverified — Discord pages need JavaScript). No wowuidev.com site was found. |
| WoWInterface Forums — https://www.wowinterface.com/forums/ | Verified | Active. Developer Discussions category: Tutorials & Other Helpful Info, Dev Tools, General Authoring Discussion, Lua/XML Help, Graphics Help, Wish List; plus PTR API changes and Classic AddOn Help areas. |
| Blizzard UI & Macro Forums | Corrected | The forum category is "UI and Macro" on forums.blizzard.com. The UI Add-On Development Policy's canonical home is a forum thread (US: us.forums.blizzard.com/en/wow/t/ui-add-on-development-policy/24534), not a support article. Its 8 rules are in docs/09. |
| MMO-Champion forum | Corrected | The board is named **"Interface & Macros"**, not "UI & Macros" (that is the Wowhead board name, and the old Blizzard one). Mostly player-facing discussion. |
| Reddit r/wowaddons | Verified | The general addon subreddit. Size/activity Unverified. |
| Stack Overflow (tags `world-of-warcraft`, `lua`) | Verified | The tag exists. Best used as a searchable archive of specific problems, not a learning path. |
| AddOn Studio Discord | Unverified | Not individually verified in this pass. |

## Code repositories & curated lists

| Resource | Status | Note |
|---|---|---|
| GitHub topic `world-of-warcraft-addon` | Verified | Topic page resolves; ~890 repositories. |
| GitHub topic `wow-addon` | Corrected | ~2,145 repositories carry the tag and it works as a search filter (`topic:wow-addon`), but https://github.com/topics/wow-addon returns 404 — don't link the topic page. |
| JuanjoSalvador/awesome-wow | Stale | Real but untouched since 2019-07-16; a few dozen links, not hundreds; still promotes the discontinued Atom editor. Historical starting point only. |
| Xerrion/wow-addon-skills | Verified | Real: an OpenCode configuration pack — agent definition, a wow-addon skill with five research references, and a working MCP server for API lookup/source browsing. AI-workflow tooling, not in-game code. |
| liuwu0623/wow-addon-dev | Verified | Real: a SKILL.md pack for the 3.80.1 "Timewalking" Classic client, with API-change comparisons and a starter addon template. Repo description is in Chinese. |
| BigWigsMods/packager | Verified | The standard release packager (release.sh + GitHub Action), v2.7.0 (2026-11-05). Full treatment in docs/09. |

## YouTube & video

| Resource | Status | Note |
|---|---|---|
| EsfandTV & ThePrimeagen | Corrected | Real — but a **one-day live-stream event** (2026-10-20, Twitch) plus VODs, not a series. ThePrimeagen taught Esfand (zero coding experience) to "vibe code" custom **WoW Forever** addons with AI assistance. YouTube VOD: youtube.com/watch?v=eWcYcMyEsgA. |
| "Creating WoW AddOns" series | Corrected | This is **Mayron's** 2014 YouTube playlist (11 videos, Lua + XML), not confirmed as an MMO-Champion thread. A different MMO-Champion thread, "Creating Your Own WoW Addon", does exist. Parts are outdated. |
| Ellesmere (YouTube) | Unverified | EllesmereUI itself is verified (full UI suite, Retail + WoW Forever versions, ellesmereui.com). A personal YouTube channel for Ellesmere could not be confirmed with text-fetch tools — do not link one without a live check. |

## Books

| Resource | Status | Note |
|---|---|---|
| World of Warcraft Programming (Whitehead II & Roe) | Verified | Latest and final edition is the **2nd Edition (Feb 2010, Wiley)** — no 3rd edition exists. Companion site wowprogramming.com is frozen (see above). |
| Beginning Lua with World of Warcraft Add-ons (Paul Emmerich) | Verified | Apress, 2009, single edition. Emmerich is a Deadly Boss Mods programmer. |
| Programming in Lua (Ierusalimschy) | Verified | The edition note in the seed list was exactly right: 1st edition covers Lua 5.0; the **2nd edition covers Lua 5.1** — the one relevant to WoW. The 1st edition and the 5.1 manual are free at lua.org. |

## Specialized utilities

| Resource | Status | Note |
|---|---|---|
| WoW.tools — https://wow.tools/ | Dead | Shut down May 2025; the front page is a retirement notice pointing to the successors: **wago.tools** (online) and **Marlamin/wow.tools.local** (local app, current — v0.9.10, Oct 2026). |
| BLPConverter / Blpc | Corrected | "BLPConverter" is **three different tools**: the classic WoWInterface CLI exe (info14110), Kanma's GitHub C++ tool (stale), and Kkthnx's modern Tauri app (current). Blpc (WoWInterface info18810) is a separate graphical converter; JPEG-encoded BLP is not implemented in it. See docs/07. |
| WoW Programming Art Browser — http://wowprogramming.com/utils/artbrowser | Dead | Returns 404 today. It existed historically; where it moved is Unverified. |
| WowBench | Dead | Defunct 2006-era API emulator; WoWInterface files it under "Discontinued and Outdated Mods". |
| wowless | Corrected | The modern headless emulator — but at **https://github.com/wowless/wowless**, not `lua-wow/wowless` (that URL does not exist). Actively maintained. See docs/08. |
