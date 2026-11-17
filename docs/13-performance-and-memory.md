# 13 — Performance and Memory

An addon runs inside the game's frame loop, on the player's machine,
next to every other addon they own. Being a good citizen is a feature.

## The frame budget

Every frame, the client runs all UI code and still has to render.
Work you do in an event handler or `OnUpdate` is time taken from that
frame. The practical rules:

- **Events over polling.** Register for the event that announces the
  change instead of checking for it every frame. `OnUpdate` is the
  last resort, always throttled (pattern in
  [`12-patterns-cookbook.md`](12-patterns-cookbook.md)).
- **High-frequency events are a cost center.** Unit events
  (`UNIT_HEALTH` family) and combat-log events can fire hundreds of
  times a second in a raid. Register narrowly (`RegisterUnitEvent`
  for the units you need), keep handlers allocation-free, and
  consider **AceBucket-3.0** (docs/05), which coalesces bursts of the
  same event into one call at an interval you choose.
- **Split big jobs across frames.** Indexing, scanning bags/banks,
  and rebuilding large lists must be sliced (docs/12) — a 200 ms
  hitch is a visible freeze and it is yours.
- **Cache in locals.** Global lookups and repeated table indexing in
  hot paths add up; hoist `pairs`, `math.floor`, and your own hot
  functions to file-scope locals.
- **Don't create garbage in hot paths.** Throwaway tables and string
  concatenation in per-frame code feed the garbage collector, which
  bills everyone. Reuse scratch tables; build strings once.

## Measuring

- **Memory:** `UpdateAddOnMemoryUsage()` then
  `GetAddOnMemoryUsage("AddonName")` (KB) — long-standing API
  functions, also what most in-game performance panels display.
- **CPU:** enable the script profile CVar (`/console scriptProfile 1`,
  then `/reload`) and read `GetAddOnCPUUsage("AddonName")` /
  `UpdateAddOnCPUUsage()`. Profiling changes timings; measure with it
  on to *compare*, not to quote absolute numbers.
- **In practice:** test in the busiest environment your users will
  hit (a full raid, a capital city), with the popular addons they run
  alongside yours — your addon never runs alone in the real world.

## SavedVariables hygiene

SavedVariables are loaded at login and written at logout, whole-table.
A database that grows forever (full history logs, per-item caches)
slows every login/logout for that player and bloats the file on disk.
Store what the features need, prune on a schedule (e.g. at
`ADDON_LOADED`, drop entries older than X), and keep transient state
in plain Lua tables that die with the session (example 02 shows the
split).

## The standing checks

- No unthrottled `OnUpdate` doing real work.
- No event registered "just in case".
- No string building or table creation inside combat-log or
  unit-event handlers on the hot path.
- Large scans are sliced across frames and cancellable.
- SavedVariables have a pruning story.
