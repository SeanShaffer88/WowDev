# 02 — Session Tracker

**Pattern:** one event frame, several events, per-character data.

What it does: counts your deaths and level-ups. `/strack` prints the
session totals and the all-time totals for this character.

Things to notice:

- **One frame, one `OnEvent`, a branch per event.** This is the shape
  of nearly every addon's core. (AceEvent, in
  [docs/05](../../docs/05-libraries-and-frameworks.md), exists to make
  this tidier at scale.)
- **`ADDON_LOADED` shares the handler** but must filter on its first
  argument — it fires for *every* addon, not just yours.
- **`SavedVariablesPerCharacter`** in the `.toc` gives each character
  its own `SessionTrackerDB`. Session counts live in a plain Lua
  table (`addon.session`) and are never saved — the difference
  between the two is the whole lesson.
- Event payloads ride in `...`. `PLAYER_LEVEL_UP` carries the new
  level as its first payload value; this example counts instead of
  reading it. Check any event's payload on the wiki's Events page for
  your flavor before using it ([docs/03](../../docs/03-api-events-and-widgets.md)).
