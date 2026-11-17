# Reference — Common Events (starter subset)

The events nearly every addon touches, with their payload shape.
**This is a starter subset, not the full list** — the complete,
per-flavor event list lives on Warcraft Wiki's Events page, and event
availability/payloads change between flavors and patches. Verify
there before relying on any event (AGENTS.md rule 1).

| Event | Payload | Fires when |
|---|---|---|
| `ADDON_LOADED` | addon name | An addon's files finish loading. Fires for *every* addon — filter on the name. The moment to initialize SavedVariables. |
| `PLAYER_LOGIN` | — | The player has logged in and all addons are loaded. |
| `PLAYER_ENTERING_WORLD` | isInitialLogin, isReloadingUi | The player enters the world (login, reload, zoning into an instance). |
| `PLAYER_DEAD` | — | The player dies. |
| `PLAYER_ALIVE` | — | The player is alive again (released or resurrected out of ghost form distinctions apply — check the wiki for your flavor). |
| `PLAYER_LEVEL_UP` | new level, plus stat gains | The player gains a level. |
| `PLAYER_LOGOUT` | — | Logout begins — the last chance to tidy state before SavedVariables are written. |
| `VARIABLES_LOADED` | — | SavedVariables have been loaded (early; per-addon `ADDON_LOADED` is usually the better hook). |
| `UI_ERROR_MESSAGE` | error type, message | The client shows an error message (e.g. "Out of range"). Payload shape varies by client generation — verify per flavor. |
| `CHAT_MSG_ADDON` | prefix, message, channel type, sender | An addon message arrives (registered prefixes only — see the addon comms notes in docs/05, AceComm). |

## Handling rules

- Register only for events you handle; unregister one-shot events
  (`ADDON_LOADED` for your own addon) once consumed — see the pattern
  in [`../docs/12-patterns-cookbook.md`](../docs/12-patterns-cookbook.md).
- Unit events (`UNIT_HEALTH` and family) require a unit token and
  fire at high frequency — register with `RegisterUnitEvent` and read
  [`../docs/13-performance-and-memory.md`](../docs/13-performance-and-memory.md)
  before using them.
- Combat-log data arrives through `COMBAT_LOG_EVENT_UNFILTERED` with
  a large sub-event payload; its exact shape is flavor-sensitive —
  the wiki's Combat Log page is the reference.
