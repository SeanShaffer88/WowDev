# 02 — Lua in WoW

WoW's scripting is **Lua 5.1** — the client was upgraded to Lua 5.1.1
in patch 2.0.1 (2006) — and only a **subset** of the official 5.1
specification is implemented (Warcraft Wiki, Lua page). The Lua 5.1
Reference Manual (https://www.lua.org/manual/5.1/) is the language
ground truth; Warcraft Wiki's Lua pages are the authority on what the
client actually provides.

## What that means in practice

- **5.1 semantics, not modern Lua.** `unpack` is global (there is no
  `table.unpack`); `loadstring` and `setfenv`/`getfenv` exist; string
  patterns are 5.1 patterns; numbers are doubles. Nothing from 5.2+:
  no `goto`, no `//`, no bitwise operators, no `utf8` library, no
  integer subtype.
- **The standard library is trimmed.** File I/O and OS facilities are
  largely absent — an addon cannot read or write arbitrary files; the
  only persistence is SavedVariables ([`01`](01-addon-anatomy.md)).
  The `debug` library is restricted. Verify any standard function
  against the wiki's Lua documentation before using it; the manual
  documents the *full* language, including parts the client omits.
- **WoW adds its own global functions and aliases** on top of Lua
  (string/table helpers and the entire UI API). Those live in the API
  documentation, not the Lua manual — see
  [`03`](03-api-events-and-widgets.md).

## Patterns that matter

- **Everything is a table.** SavedVariables, the addon namespace,
  frame objects, and library registries are all tables. Metatables
  provide the object model; Ace3 and the other frameworks in
  [`05`](05-libraries-and-frameworks.md) are table patterns all the
  way down.
- **Locals are fast and safe; globals are shared with everyone.** An
  unlocalized global is visible to every addon and to taint tracking.
  Cache hot globals as locals (`local pairs = pairs`) in performance-
  sensitive code.
- **Varargs carry the addon namespace**: `local addonName, addon = ...`
  at the top of every file ([`01`](01-addon-anatomy.md)).
- **Events drive everything.** There is no main loop you own; code
  runs at load time, on events, on frame updates (`OnUpdate`), and on
  timers. Long-running work in one call blocks the whole UI — spread
  heavy work across frames (this is the entire reason frame-budgeted
  task libraries exist).
- **Errors are Lua errors.** A runtime error in an event handler stops
  that handler, not the client. Enable script errors while developing
  ([`08`](08-testing-and-debugging.md)) or failures are silent.

## Common AI/author mistakes

- Writing Lua 5.4 idioms from general training data (`//`, `<close>`,
  `table.unpack`) — all invalid here.
- Assuming a standard-library function exists because the manual lists
  it (subset rule above).
- Forgetting that strings are immutable and patterns are not regex —
  WoW string patterns follow Lua pattern syntax, documented in §5.4.1
  of the 5.1 manual.
- Doing heavy work inside `OnUpdate` without throttling — it runs
  every frame.

## Learning Lua for WoW

- *Programming in Lua*, **2nd edition** (Ierusalimschy) — the edition
  that covers Lua 5.1 (the 1st edition covers 5.0 and is free at
  lua.org; the 5.1 manual is free too).
- "Introduction to Lua" — Warcraft Wiki / Wowpedia HOWTOs, a fast
  primer that explicitly targets WoW's 5.1.
- *Beginning Lua with World of Warcraft Add-ons* (Emmerich, 2009) —
  novice-to-advanced, WoW-specific throughout.
