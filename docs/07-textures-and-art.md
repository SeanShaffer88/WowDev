# 07 — Textures and Art

## The BLP format

Custom addon textures ship as **BLP** (Blizzard's texture format;
TGA is also accepted by the client for addon textures). BLP comes in
variants (BLP1/BLP2; paletted, raw, DXT-compressed, and JPEG-encoded),
and the client is particular about which variants it accepts — which
is why conversion tooling matters and why "it converted" is not the
same as "it loads".

## The three tools named "BLPConverter" — disambiguation

"BLPConverter" is the name of at least **three unrelated tools**.
Always say which one you mean:

| Tool | Where | What | Status |
|---|---|---|---|
| BLPConverter.exe (classic) | WoWInterface info14110 | Windows CLI converter (BLP↔PNG) focused on precise control of the exact BLP format produced; built for batch scripts | Old; download page live, no current maintenance signal (**Unverified** beyond the page being up) |
| Kanma/BLPConverter | github.com/Kanma/BLPConverter | C++ CLI (BLP→PNG/TGA), BLP1 + BLP2 incl. RAW3, macOS/Linux, MIT | Stale (bundles old libsquish/FreeImage) |
| Kkthnx/BLPConverter | github.com/Kkthnx/BLPConverter | Modern desktop app (Tauri 2, Win/Linux/macOS): two-panel drag-and-drop BLP↔PNG, batch/folder conversion, PNG→BLP with RAW/DXT1/DXT3/DXT5, mipmaps, power-of-two validation | Current (2026) |

**Blpc** (WoWInterface info18810) is a separate tool: a graphical
Blp2 viewer/converter in C# with source included, batch conversion,
automatic power-of-two resizing, and a reusable `cBlp2` class for
other projects. Legacy (.NET Framework 4.0 era). Known gap:
**JPEG-encoded BLP textures are not implemented** in Blpc.

## Practical rules

- Textures referenced from Lua/XML use paths relative to the game's
  `Interface\` root (e.g. `Interface\AddOns\MyAddon\Media\icon`) —
  historically **without the file extension** in texture strings.
- Dimensions must be powers of two per side for classic-era clients;
  the modern converters validate this — use that check.
- Blizzard's own artwork can be browsed in the exported client files
  (`wow-ui-source`, and the game-data tools in
  [`06`](06-tools-and-editors.md)). The old **WoW Programming Art
  Browser** at wowprogramming.com/utils/artbrowser is **dead** (404);
  do not link it.
- Icon and texture IDs for spells/items come from the game-data tools
  (wago.tools / wow.tools.local), not from guessing.
