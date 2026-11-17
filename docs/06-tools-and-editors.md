# 06 — Tools and Editors

## Editors and IDEs

### VS Code — the common setup, with a name trap

Two different extensions are constantly conflated:

- **WoW Bundle** (`Septh.wow-bundle`, by **Septh**) — WoW-flavored Lua
  5.1 grammar, `.toc` grammar/colorization, snippets, themes. **Its
  GitHub repo is archived; last release v1.3.0 (2018); its API data
  targets WoW 8.0.1.** Installable from the Marketplace, but treat its
  API knowledge as historical. It is grammar/highlighting only — no
  language server.
- **WoW API** (`ketho.wow-api`, by **Ketho**) — the maintained
  companion for the Lua language server (LuaLS): WoW API annotations
  for completion and diagnostics. Pushed Oct 2026. This, plus a Lua
  language-server extension, is the current VS Code route.
- **EmmyLua** (`tangzx.emmylua`, by Tangzx) — a general Lua language
  extension (completion, debugging, analysis) used in both VS Code and
  JetBrains IDEs. Not WoW-specific; WoW knowledge comes from stub files
  (below).

### AddOn Studio — the dedicated IDE

https://addonstudio.org/ — a full IDE on the Visual Studio Shell
(editions named 2022 / 2015 / 2010; same WoW features in each). Visual
drag-and-drop FrameXML designer, IntelliSense for WoW
functions/events, FrameXML schema validation, cross-file IntelliSense
that respects `.toc` load order, automatic `.toc` generation/metadata
editing, deployment to multiple WoW installs, Git/SVN integration, a
Blizzard resource browser, a built-in Lua console, and WoWBench
support (historical). States support for Retail and Classic. Pick the
2022 edition if unsure; expect it to manage the `.toc` for you.

### ZeroBrane Studio — general Lua IDE

https://studio.zerobrane.com/ — lightweight, cross-platform, written
in Lua; current (v2.01). Completion, live coding, analyzer, remote
debugger for Lua 5.1–5.4/LuaJIT. **No WoW API knowledge built in** —
its WoW value is editing and debugging plain Lua logic outside the
client.

### IntelliJ IDEA — EmmyLua + stubs

The canonical stub project is
**Ellypse/IntelliJ-IDEA-Lua-IDE-WoW-API**: WoW API documentation/stubs
formatted for the EmmyLua plugin (JetBrains plugin ID 9768), partly
generated from Blizzard's own API documentation files. Setup: install
EmmyLua, clone the stubs (often alongside a wow-ui-source checkout),
register the folders as Lua libraries. Caveat: the stubs are **stale**
(last pushed Jan 2024) — completion will lag current patches.
Community guides recommend the original EmmyLua plugin over "EmmyLua2"
for WoW work (proven 5.1 support).

## In-game development tools

- **WowLua** (WoWInterface info7366; also CurseForge) — in-game Lua
  interpreter + multi-page script editor by James Whitehead II (the
  *WoW Programming* author); `print()` goes to its window. `/wowlua`
  or `/lua`, run pages with `/wowluarun`. Maintained (updated Apr
  2026). A 1.12-client fork exists (laytya/WowLuaVanilla).
- **Lua Browser** (CurseForge / WoWInterface, by Aezay) — folder-style
  browser of the live Lua environment (tables, widgets) for
  inspection. **Dormant** — last updated Oct 2020. `/lb`, `/luabrowser`.
- **DevTool** (https://github.com/brittyazel/DevTool) — debugger-like
  in-game inspection of tables, events, and function calls in a
  columnar UI; the richer alternative to `print()`/`/dump`. API:
  `DevTool:AddData(data, "name")`; slash commands `/dev`,
  `/dev eventadd <event> [unit]`, `/dev logfn <fn> <parent>`. Repo is
  **archived** on GitHub (latest release 1.3.0, Jan 2026) — usable,
  unmaintained. It is **not** a packaging tool.

## Headless testing

**wowless** — https://github.com/wowless/wowless (not
`lua-wow/wowless`; that URL does not exist). A headless WoW client Lua
and FrameXML interpreter for testing addons without the game: it
implements WoW's taint/security model via a vendored Lua 5.1 fork
("elune"), with API specs in YAML generated from Blizzard's API
documentation, across multiple game products/flavors. Built from
source (Docker/devcontainer, CMake; no GitHub releases); run an addon
with its `run` command, a product flag, and `--addondir`. Do not point
a stock `lua`/`luajit` at it — its runtime differs on purpose.
Actively maintained (pushed 2026-11-16).

**WowBench** is its defunct 2006-era ancestor (WoWInterface files it
under "Discontinued and Outdated Mods") — historical interest only.

## Game-data tools (finding IDs, files, models)

- **wow.tools is dead** — the site shut down in May 2025 and its front
  page is a retirement notice. Do not cite it as a live resource.
- **wago.tools** — the online successor for part of the former
  wow.tools functionality (DB2/file exploration from the Wago team).
- **wow.tools.local (WTL)** — https://github.com/Marlamin/wow.tools.local —
  the local successor: file browser, DB2 browsing/export, M2 model
  viewer, build diffs, reading your local WoW install. Current
  (v0.9.10, Oct 2026). Close WoW and Battle.net before running it
  (file locks); download `WTL.db` from a release for the File
  History/File Links features.
