# Addon Release Checklist

Run against the addon tree and the **target client** before shipping.

## Targeting

- [ ] Target flavor named (Retail / Classic Era / progression Classic /
      WoW Forever) and `## Interface:` matches that client's current
      interface number (`docs/04-flavors-and-interface-numbers.md`).
      Forever is **16001** — never an Era number.
- [ ] Multi-flavor releases: per-flavor `.toc` files (or packager
      `## Interface-[Type]:` generation) each carry the right number.

## Code correctness

- [ ] Every WoW API function, event, and widget method in the code
      traces to Warcraft Wiki (target flavor), the matching
      wow-ui-source branch, or the in-game `/api` docs — no invented
      calls (`AGENTS.md` rule 1).
- [ ] Lua is 5.1-subset only: no `//`, no `goto`, no `table.unpack`,
      no 5.2+ library calls.
- [ ] SavedVariables / SavedVariablesPerCharacter declared in the
      `.toc` for every persisted global.
- [ ] No `SetBackdrop` on a plain frame — `BackdropTemplate` (or the
      mixin) everywhere a backdrop is set.
- [ ] No unlocalized globals beyond the addon namespace pattern.
- [ ] Libraries embedded the standard way (LibStub + `.pkgmeta`
      externals) or declared as dependencies — no pasted library code.

## In-client testing (`docs/08-testing-and-debugging.md`)

- [ ] Loads with script errors enabled and shows none.
- [ ] First run (no SavedVariables), repeat run, and run with the
      previous version's SavedVariables all work.
- [ ] Combat pass: protected-adjacent features exercised in combat
      with no taint errors / blocked actions.
- [ ] `/reload`, logout/login, and character switch behave.
- [ ] Runs alongside a major framework addon / UI suite without
      errors.
- [ ] Anything not actually run in the target client is recorded as
      **Unverified** in the release notes — not silently implied.

## Packaging (`docs/09-packaging-and-distribution.md`)

- [ ] Built with the BigWigs packager from a tagged checkout, or as a
      manual zip with the addon folder at the archive root.
- [ ] Archive named with addon name + version; `SHA256SUMS.txt`
      alongside for GitHub releases.
- [ ] Blizzard policy respected: free, code fully visible (no
      obfuscation), no ads, no in-game donation solicitation.

## Docs and metadata

- [ ] `README.md`, `FEATURES.md`, `DESCRIPTION.md`, `CHANGELOG.md`
      present and current; license file included.
- [ ] Changelog entry states the version's changes factually.
- [ ] Repo description and topics accurate for this release;
      screenshots are real captures from the target client.
