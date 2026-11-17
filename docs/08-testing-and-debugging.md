# 08 — Testing and Debugging

## In the client

- **Turn script errors on.** A Lua error with errors hidden is a
  silent dead feature. `/console scriptErrors 1` (and keep the
  error display enabled while developing).
- **`/dump`** evaluates and pretty-prints a value in chat — the
  zero-install inspection tool.
- **`/reload`** reloads the UI: the basic edit-test loop. Remember
  SavedVariables only persist across a real logout/reload cycle as
  declared in the `.toc`.
- **DevTool** ([`06`](06-tools-and-editors.md)) for structured
  inspection: watch tables live, log events as they fire, trace
  function calls — the debugger-shaped alternative to sprinkling
  `print()`.
- **WowLua** for trying API snippets against the live environment
  before committing them to addon code — the fastest way to check "is
  this function real on *this* client" (AGENTS.md rule 1).

## Headless / CI testing

**wowless** (https://github.com/wowless/wowless) loads an addon in a
simulated client — Lua + FrameXML interpreted, taint/security model
implemented — so load errors, event wiring, and pure-logic behavior
can be tested in CI without a game install, per product/flavor.
Build it from source (Docker/devcontainer), then run with the product
flag and `--addondir path/to/YourAddon`. Its test suite style
(luassert specs) is the model for addon-side tests. What headless
testing cannot prove: real rendering, real performance, and anything
needing the actual game world — label those **Unverified** until run
in the target client.

## Taint hunting

Symptoms: "Interface action failed because of an AddOn", blocked
protected calls in combat, secure frames misbehaving after your addon
loads. Method:

1. Reproduce with **only** your addon enabled.
2. Check the usual sources: writing into Blizzard frames' fields,
   hooking secure functions insecurely, modifying unit frames or
   action buttons outside secure templates, leaking globals
   ([`02`](02-lua-in-wow.md), [`03`](03-api-events-and-widgets.md)).
3. Fix by restructuring (secure templates, `hooksecurefunc` used
   correctly, no mutation of secure state), never by suppressing the
   error display.

## The test matrix that matters

- [ ] Loads clean on the **target flavor's** client, correct
      `## Interface:` ([`04`](04-flavors-and-interface-numbers.md))
- [ ] First run with no SavedVariables; second run with existing ones;
      run with SavedVariables from the *previous addon version*
- [ ] Combat: enter combat and exercise every protected-adjacent
      feature (taint check)
- [ ] `/reload` mid-session; logout/login; character switch
      (per-character variables)
- [ ] With the addons your users will run alongside (a big Ace3 addon,
      a UI suite) — global collisions and load order only show up in
      company
- [ ] Performance sanity: no heavy work in unthrottled `OnUpdate`
      handlers; large SavedVariables stay reasonable
