# Debugging Checklist

When an addon misbehaves, in this order. Most "mystery" bugs are
steps 1–3.

## It doesn't load at all

- [ ] Folder name = `.toc` name, folder directly under
      `Interface/AddOns/` (not nested one level deeper).
- [ ] `## Interface:` matches the client exactly — check in-game:
      `/run print(select(4, GetBuildInfo()))`. Wrong number = silent
      no-load. Forever is 16001.
- [ ] The addon is enabled in the character-select addon list, and
      "load out of date addons" is not masking a wrong interface.
- [ ] Run [`../tools/check-addon.py`](../tools/) on the folder.

## It loads but errors

- [ ] Script errors are ON (`/console scriptErrors 1`) — with them
      off, failures are invisible.
- [ ] Read the *first* error, not the cascade: fix top-down, `/reload`
      between fixes.
- [ ] Every API call in the failing file verified against the target
      flavor's docs (AGENTS.md rule 1) — an invented or
      wrong-flavor function is the usual cause.
- [ ] No file-scope code reads the world (units, other addons,
      SavedVariables) before `ADDON_LOADED`.

## It works alone, breaks with other addons

- [ ] Global collision: search your code for unlocalized globals
      beyond the namespace pattern.
- [ ] Taint: does it write into Blizzard frames, hook secure
      functions insecurely, or touch action buttons outside secure
      templates? (docs/03, docs/08)
- [ ] Load order: a dependency you assumed is `OptionalDeps` but not
      guaranteed — guard or make it a hard dependency.

## It works until combat

- [ ] Protected call from tainted code: casting/moving/targeting and
      secure-frame changes are blocked in combat lockdown. Restructure
      to secure templates; never "fix" by hiding the error.

## Data is lost between sessions

- [ ] The variable is declared under `## SavedVariables` (or
      PerCharacter) in the `.toc` — undeclared means unsaved.
- [ ] You are writing to the *global* of that exact name, not a local
      shadow of it.
- [ ] The write happens before logout completes (writes at
      `PLAYER_LOGOUT` are fine; writes after are not).

## It's slow / causes hitches

- [ ] Unthrottled `OnUpdate` doing real work (docs/13).
- [ ] High-frequency events registered broadly instead of per-unit.
- [ ] A big loop (scan/index/rebuild) running in one call instead of
      sliced across frames.
- [ ] SavedVariables grown unbounded — check the file size on disk.
