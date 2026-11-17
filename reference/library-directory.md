# Reference — Library Directory

The shared-library ecosystem an addon author actually meets. All of
these are **LibStub** libraries unless noted: they register by name,
and every addon on a machine shares the newest loaded copy
([`../docs/05-libraries-and-frameworks.md`](../docs/05-libraries-and-frameworks.md)).

| Library | What it is for | Where it lives |
|---|---|---|
| **LibStub** | The versioning registry itself. Ships inside the Ace3 tree; also embedded standalone by most library-using addons. | WoWAce SVN / Ace3 tree |
| **CallbackHandler-1.0** | Callback/event dispatch used by AceEvent and friends. Ships inside the Ace3 tree. | WoWAce SVN / Ace3 tree |
| **Ace3 modules** (AceAddon, AceEvent, AceDB, AceConfig, AceGUI, AceConsole, AceComm, AceSerializer, AceLocale, AceTimer, AceBucket, AceHook, AceDBOptions, AceTab — all `-3.0`) | The standard framework; embed only the modules you use. Full treatment in docs/05. | WoWAce SVN is the `.pkgmeta` authority; GitHub WoWUIDev/Ace3 is the dev mirror |
| **LibDataBroker-1.1 (LDB)** | A data-broker spec: addons publish feeds/buttons that display addons (panels, minimap launchers) render. RGX-Framework and many addons expose LDB objects. | CurseForge / WoWInterface library listings |
| **LibDBIcon-1.0** | Puts an LDB object on the minimap as a draggable button — the standard minimap-button mechanism. LibMasterAddons uses it optionally for exactly this. | CurseForge / WoWInterface library listings |
| **LibMasterAddons-1.0** | Classic-family framework (dependency injection, locales, timers, UI toolkit) shipped as one embeddable file. Docs/05. | CurseForge only — no GitHub repo |

## Embedding rules (all libraries)

- Embed at packaging time with `.pkgmeta` externals
  ([`../docs/09-packaging-and-distribution.md`](../docs/09-packaging-and-distribution.md));
  do not paste library source into your repo by hand — it goes stale
  silently.
- Load order in the `.toc`/`embeds.xml`: LibStub, then
  CallbackHandler, then everything else.
- Never ship a *modified* embedded library under its real name —
  LibStub will hand your modified copy to other addons.
