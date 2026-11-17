# 04 — Flavors and Interface Numbers

WoW is not one client. An addon targets a **flavor**, the `.toc`'s
`## Interface:` must equal that client's interface version, and the
API differs between flavors in ways that matter. Numbers below were
checked 2026-11-17 against the Ace3 project's own `.toc` (a production
multi-flavor addon) and the `Gethe/wow-ui-source` branch list.

| Flavor | Interface | wow-ui-source branch | Notes |
|---|---|---|---|
| Retail | 120100–120107 | `live` | PTR on `ptr`/`ptr2`, beta on `beta` |
| Classic Era | 11508, 11509 | `classic_era` | Era PTR on `classic_era_ptr` |
| WoW Forever | **16001** | `forever` | Custom 1.12-lineage client (game version 1.60.1) |
| TBC Classic | 20505, 20506 | `classic` | Progression Classic shares the `classic` branch |
| Wrath Classic | 30405 | `classic` | |
| Cata Classic | 40402 | `classic` | |
| MoP Classic | 50503, 50504 | `classic` | |
| Classic "Timewalking" 3.80.x | 38002 | `classic` | 2026 client whose API was aligned heavily toward Retail (see the liuwu0623 pack, docs/11) |

## The interface rule

The client compares `## Interface:` against its own version at load.
A mismatch marks the addon **out of date**; with "load out of date
addons" off (the default for most players), it simply never loads —
no Lua error, no message in the addon itself. Most "my addon does
nothing" reports are this.

- One `.toc` can serve several flavors when the packager generates
  per-flavor TOCs from `## Interface-[Type]:` lines
  ([`09`](09-packaging-and-distribution.md)).
- **Forever is 16001.** Any brief, template, or older addon that puts
  an Era number (11507 and friends) in a Forever `.toc` is wrong; the
  addon will be dead on arrival. This is field-proven, not theoretical.

## Per-flavor traps

- **API surface.** Retail has namespaces and widgets the Classic
  family lacks, and vice versa; Classic Era/Forever are closest to the
  1.12-era API with selective backports. Always check the flavor's own
  wiki pages and source branch ([`03`](03-api-events-and-widgets.md)).
- **Templates differ.** Which XML templates exist (including
  `BackdropTemplate` behavior) is a per-flavor fact — read the target
  branch's FrameXML.
- **Forever specifics.** Forever is a custom client, not a Blizzard
  product: its branch in wow-ui-source is maintained alongside the
  official ones, and major ecosystem projects ship Forever builds
  (EllesmereUI, RGX-Framework in beta, LibMasterAddons' `isForever`
  client flag, Ace3's 16001 interface line). Expect the 1.12-era API
  shape with Forever-specific deltas; verify against the `forever`
  branch, not against Era documentation.
- **The 3.80.x "Timewalking" client** realigned much of the Classic
  API toward Retail in April 2026 — addons ported from older Classic
  need the API-changes comparison, not assumptions (docs/11).

## Working multi-flavor

- Branch or guard flavor-specific code paths; detect the client by
  interface version (`select(4, GetBuildInfo())` is the standard
  runtime check) rather than by addon name hacks.
- Test on each target client (or in wowless with the matching product,
  [`08`](08-testing-and-debugging.md)). A green test on Retail says
  nothing about Era or Forever.
