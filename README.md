# WowDev — World of Warcraft Addon Development Knowledge Base

## TL;DR

A complete, self-contained knowledge base for developing World of
Warcraft addons, written for AI agents and humans. It covers the WoW
API and WoW's Lua 5.1 dialect, the client flavors and their interface
numbers (Retail, Classic Era, the progression Classic clients, and WoW
Forever), libraries and frameworks, editors and tools, testing,
packaging and distribution, and the communities where addon developers
actually get help — plus the working material itself: copy-and-start
**templates**, three complete **example addons**, a scaffolder and a
static validator in **tools**, and quick **reference** tables. Every
external resource named here was verified against its live source on
2026-11-17; anything that could not be verified is marked
**Unverified** rather than repeated as fact.

## The ground-truth hierarchy

When sources disagree, this order wins:

1. **The client itself** — Blizzard's own UI source for the exact
   client you target (`Gethe/wow-ui-source`, one branch per flavor)
   and the in-game `/api` documentation (`Blizzard_APIDocumentation`).
2. **Warcraft Wiki** (warcraft.wiki.gg) — the living community wiki,
   including its per-patch "API changes" pages.
3. **This repo** — a distillation of 1 and 2 plus verified third-party
   material.
4. **Everything else** — Wowpedia's Fandom copy (frozen in 2023),
   wowprogramming.com (frozen around Warlords of Draenor), forum posts,
   and model memory. Useful for history and fundamentals, never as
   proof that an API exists in a current client.

## The flavors at a glance

| Flavor | Interface (checked 2026-11-17) | wow-ui-source branch |
|---|---|---|
| Retail | 120100–120107 range | `live` |
| Classic Era | 11508 / 11509 | `classic_era` |
| WoW Forever | **16001** | `forever` |
| TBC Classic | 20505 / 20506 | `classic` (progression) |
| Wrath Classic | 30405 | `classic` |
| Cata Classic | 40402 | `classic` |
| MoP Classic | 50503 / 50504 | `classic` |
| Classic 3.80.x ("Timewalking") | 38002 | `classic` |

Interface numbers are how the client decides whether an addon loads at
all: a `.toc` whose `## Interface:` does not match the client is marked
out of date and never loads — no error, no warning in-game, just a dead
addon. Full treatment: [`docs/04-flavors-and-interface-numbers.md`](docs/04-flavors-and-interface-numbers.md).

## How an AI should use this repo

1. Read [`AGENTS.md`](AGENTS.md) — the non-negotiable rules (never
   invent an API, flavor first, Lua 5.1 subset only).
2. Identify the **target flavor and interface number** before writing
   any code ([`docs/04`](docs/04-flavors-and-interface-numbers.md)).
3. Start from [`docs/01-addon-anatomy.md`](docs/01-addon-anatomy.md)
   (.toc, load order, SavedVariables) and
   [`docs/02-lua-in-wow.md`](docs/02-lua-in-wow.md).
4. Check every API function, event, and widget method against
   [`docs/03-api-events-and-widgets.md`](docs/03-api-events-and-widgets.md)'s
   sources — Warcraft Wiki for the flavor, or the matching
   wow-ui-source branch.
5. Prefer a library over hand-rolling
   ([`docs/05-libraries-and-frameworks.md`](docs/05-libraries-and-frameworks.md)).
6. Start from a template or example instead of a blank page:
   [`templates/`](templates/) (minimal + Ace3 skeletons, release
   workflows), [`examples/`](examples/) (three complete addons), and
   the scaffolder in [`tools/`](tools/).
7. Test per [`docs/08-testing-and-debugging.md`](docs/08-testing-and-debugging.md);
   package and release per
   [`docs/09-packaging-and-distribution.md`](docs/09-packaging-and-distribution.md)
   and [`checklists/addon-checklist.md`](checklists/addon-checklist.md).

## Contents

| File | What it covers |
|---|---|
| [01-addon-anatomy.md](docs/01-addon-anatomy.md) | Addon folder layout, the .toc file key by key, load order, SavedVariables, the addon namespace pattern, XML vs Lua |
| [02-lua-in-wow.md](docs/02-lua-in-wow.md) | WoW's Lua 5.1 subset: what exists, what doesn't, patterns, and the mistakes that break addons |
| [03-api-events-and-widgets.md](docs/03-api-events-and-widgets.md) | Where the API lives (C_* namespaces, events, widgets), secure code and taint, hardware-event restrictions, the in-game /api docs |
| [04-flavors-and-interface-numbers.md](docs/04-flavors-and-interface-numbers.md) | Retail / Classic Era / progression Classic / WoW Forever: interface numbers, source branches, per-flavor traps |
| [05-libraries-and-frameworks.md](docs/05-libraries-and-frameworks.md) | LibStub, Ace3 (full module list), RGX-Framework, LibMasterAddons, Foundry, WeakAuras' real role, embedding via .pkgmeta |
| [06-tools-and-editors.md](docs/06-tools-and-editors.md) | VS Code (Septh vs Ketho — read the corrections), AddOn Studio, ZeroBrane, IntelliJ stubs, in-game dev tools, wowless, game-data tools |
| [07-textures-and-art.md](docs/07-textures-and-art.md) | The BLP format and the three different tools named BLPConverter, Blpc, texture paths |
| [08-testing-and-debugging.md](docs/08-testing-and-debugging.md) | /dump, script errors, DevTool, WowLua, headless testing with wowless, taint hunting |
| [09-packaging-and-distribution.md](docs/09-packaging-and-distribution.md) | BigWigs packager (.pkgmeta, release.sh, GitHub Action), distribution sites, Blizzard's 8-rule addon policy |
| [10-communities-and-learning.md](docs/10-communities-and-learning.md) | WoWUIDev Discord, forums (with their correct names), Reddit, tutorials, videos, and the three books with correct editions |
| [11-ai-assisted-development.md](docs/11-ai-assisted-development.md) | AI skill packs (Xerrion, liuwu0623), the ground-truth discipline, and how AI help goes wrong on WoW code |
| [12-patterns-cookbook.md](docs/12-patterns-cookbook.md) | The recurring code shapes: namespace, event frame, SavedVariables defaults merge, slash commands, throttled OnUpdate, frame-sliced work, the localization table |
| [13-performance-and-memory.md](docs/13-performance-and-memory.md) | The frame budget, events over polling, bucket events, measuring memory/CPU, SavedVariables hygiene |
| [14-localization.md](docs/14-localization.md) | The L-table pattern, AceLocale-3.0, locale file layout, rules that keep translations working |
| [SOURCES.md](SOURCES.md) | The original resource list this repo was built from, entry by entry, with verification status and corrections |

## Working material

| Folder | What it holds |
|---|---|
| [templates/](templates/) | Minimal and Ace3 addon skeletons (`.toc`, core Lua, `embeds.xml`, `.pkgmeta`) plus GitHub workflows for the BigWigs packager and luacheck |
| [examples/](examples/) | Three complete, loadable addons: HelloWorld (slash command + SavedVariables), SessionTracker (event frame, per-character data), MovableFrame (BackdropTemplate, drag, saved position) |
| [tools/](tools/) | `new-addon` scaffolder (bash + PowerShell), `check-addon.py` static validator, `interface-numbers.json`, a WoW `.luacheckrc`, and VS Code settings/extensions/snippets |
| [reference/](reference/) | Quick tables: [interface numbers](reference/interface-numbers.md), [common events](reference/common-events.md), [library directory](reference/library-directory.md) |
| [checklists/](checklists/) | [Addon release checklist](checklists/addon-checklist.md), [debugging checklist](checklists/debugging-checklist.md), [multi-flavor port checklist](checklists/multi-flavor-port-checklist.md) |

## Corrections this repo makes to the list it was built from

The seed list (preserved in [`SOURCES.md`](SOURCES.md)) was mostly
sound, but verification on 2026-11-17 found:

- **Wowpedia (Fandom) is the stale copy.** The community forked to
  Warcraft Wiki in October 2023; Fandom's API pages froze at patch
  10.1.7. Use wiki.gg.
- **DevTool is not a packaging tool** — it is an in-game runtime
  inspector. The packager is BigWigsMods/packager.
- **wow.tools shut down in May 2025.** Its successors are wago.tools
  and the local wow.tools.local app.
- **The VS Code "WoW Bundle" is by Septh, not Ketho** — and it is
  archived, with API data from WoW 8.0.1. Ketho's separate WoW API
  extension is the maintained one.
- **wowless lives at `wowless/wowless`**, not `lua-wow/wowless`;
  WowBench is defunct.
- **WeakAuras2 is not archived** (it shipped 5.22.1 in October 2026) —
  but it is a standalone addon to read, not a framework to build on.
- **awesome-wow has not been updated since 2019.**
- **MMO-Champion's board is "Interface & Macros"**, not "UI & Macros".
- The **EsfandTV/ThePrimeagen** WoW Forever addon stream is real
  (2026-10-20, beginner, AI-assisted) — but it was a one-day event,
  not a series.
