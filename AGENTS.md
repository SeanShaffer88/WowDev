# AGENTS.md — Instructions for AI agents writing WoW addons

You are using this repository as your knowledge base for creating World
of Warcraft addons. Follow these rules exactly.

## Non-negotiable rules

1. **Never invent API functions, events, widget methods, or CVars.**
   Every WoW API call you write must be traceable to one of: the
   Warcraft Wiki page for the target flavor, the matching branch of
   `Gethe/wow-ui-source`, or the in-game `/api` documentation
   (`Blizzard_APIDocumentation`). If you cannot trace it, do not write
   it — say it is **Unverified** instead. The WoW API is large,
   flavor-dependent, and changes every patch; a plausible-sounding
   function name is the single most common AI failure on WoW code.
2. **Flavor first.** Before writing code, state the target client and
   its interface number: Retail (1201xx), Classic Era (11508/11509),
   WoW Forever (**16001**), or a progression Classic client
   (`docs/04-flavors-and-interface-numbers.md`). A `.toc` with the
   wrong `## Interface:` never loads. Never write 11507 (or any Era
   number) into a Forever `.toc` — Forever is 16001.
3. **Lua 5.1 subset only.** WoW runs a subset of Lua 5.1 (client on
   5.1.1 since patch 2.0.1). No Lua 5.2+ features: no `goto`, no integer
   division `//`, no bitwise operators, no `table.unpack` (it is
   `unpack`), no UTF-8 library. When in doubt, the Lua 5.1 reference
   manual (https://www.lua.org/manual/5.1/) is the language ground
   truth, and Warcraft Wiki's Lua pages say what the client actually
   provides.
4. **Respect the restriction tags.** Wiki API listings tag functions
   (`#hwevent` = needs a real hardware event, `#noscript`, `#framexml`).
   Protected functions and secure templates have real rules — read
   `docs/03-api-events-and-widgets.md` before writing combat-relevant
   or action-button code. Taint is a correctness bug, not a warning.
5. **Never call `SetBackdrop` on a plain frame.** Plain frames do not
   have that method; use a frame created with the `BackdropTemplate`
   template (or mix `BackdropTemplateMixin` in first). This crashes on
   clients where the method is absent, WoW Forever included.
6. **Declare SavedVariables in the .toc** or they do not persist.
   Nothing outside the declared variables survives a logout.
7. **Start from the closest existing pattern.** An official Blizzard UI
   module in wow-ui-source, an Ace3-based addon, or the examples in
   this repo's docs outrank anything you generate from memory. Borrow
   structure; verify every API call anyway (rule 1).
8. **Prefer a maintained library over hand-rolling** (Ace3 for most
   needs — `docs/05-libraries-and-frameworks.md`), and embed libraries
   the standard way (LibStub + `.pkgmeta` externals at packaging time),
   not by pasting library code into the addon.
9. **Every addon ships four docs**: `README.md`, `FEATURES.md`,
   `DESCRIPTION.md` (store-listing copy), and `CHANGELOG.md`, plus a
   license file. Public docs contain only factual product
   documentation.
10. **Verify before declaring done.** Run
    `checklists/addon-checklist.md`. State plainly which checks ran
    in-game or in wowless and which could not be run — label those
    **Unverified** rather than claiming success. An addon that has
    never been loaded by its target client is not tested.

## Build order (always in this sequence)

1. Name the target flavor + interface number (rule 2).
2. Lay out the addon folder and `.toc` (`docs/01-addon-anatomy.md`).
3. Write the smallest loadable addon; confirm it loads with no errors.
4. Add features one at a time, checking each new API call against the
   ground-truth sources (rule 1) and testing in the target client.
5. Add SavedVariables, options, and localization as needed.
6. Package with the BigWigs packager or a plain zip
   (`docs/09-packaging-and-distribution.md`); run the checklist.

## Things that are always wrong

- An API function, event, or widget method that appears in no source
  for the target flavor.
- Lua 5.2+ syntax or standard-library calls in addon code.
- `## Interface:` copied from a different flavor's addon.
- SavedVariables used without being declared in the `.toc`.
- `SetBackdrop` on a frame not created with `BackdropTemplate`.
- Global-namespace pollution: addon code that creates unlocalized
  globals beyond its one addon table (it collides with other addons
  and spreads taint).
- Treating Wowpedia's Fandom pages or wowprogramming.com as evidence
  an API exists in a current client — both are frozen snapshots.
- Recommending wow.tools (shut down May 2025) or WowBench (defunct).
