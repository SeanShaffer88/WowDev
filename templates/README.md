# Templates

Copy-and-start starting points. Every template uses only API patterns
documented in this repo's docs — no invented calls.

| Template | Use it when |
|---|---|
| [`minimal/`](minimal/) | You want the smallest loadable addon: namespace pattern, SavedVariables with defaults, one slash command. No dependencies. |
| [`ace3/`](ace3/) | You want the standard framework skeleton: AceAddon lifecycle, AceDB profiles, AceConsole slash commands, libraries pulled by the packager via `.pkgmeta` externals. |
| [`github-workflows/`](github-workflows/) | You are releasing from GitHub: `release.yml` (BigWigs packager) and `luacheck.yml` (Lua lint gate). |

## Placeholders

Templates use `{{ADDON_NAME}}`, `{{INTERFACE}}`, `{{TITLE}}` tokens.
The scaffolder in [`../tools/`](../tools/) (`new-addon.sh` /
`new-addon.ps1`) substitutes them for you, or do a find-replace by
hand. Set `{{INTERFACE}}` to your target flavor's number —
[`../docs/04-flavors-and-interface-numbers.md`](../docs/04-flavors-and-interface-numbers.md);
WoW Forever is always **16001**.

## Notes on the Ace3 template

- `.pkgmeta` externals point at the WoWAce SVN, which Ace3's own
  README names as the primary source (see
  [`../docs/05-libraries-and-frameworks.md`](../docs/05-libraries-and-frameworks.md)).
  LibStub and CallbackHandler-1.0 ship inside the Ace3 tree; the
  `embeds.xml` load order (LibStub first) is the part that must not
  change.
- Delete the modules you do not use from **both** `.pkgmeta` and
  `embeds.xml` — they must stay in sync.
