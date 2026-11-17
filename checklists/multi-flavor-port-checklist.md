# Multi-Flavor Port Checklist

Porting an addon between Retail, Classic Era, the progression Classic
clients, and WoW Forever. Background: docs/04.

## Before writing code

- [ ] Target flavor named, with its current interface number from
      [`../reference/interface-numbers.md`](../reference/interface-numbers.md)
      (verified in-game with `GetBuildInfo()` on the target client).
- [ ] The matching `Gethe/wow-ui-source` branch identified
      (`live` / `classic_era` / `classic` / `forever`) and used as
      the API reference for the port — not the source flavor's docs.
- [ ] Every API function, event, and widget the addon uses checked
      for existence **on the target flavor** (wiki flavor pages +
      target branch). Make a list of the ones that don't exist —
      that list is the port.

## The usual gaps

- [ ] `C_*` namespaces: several Retail namespaces don't exist on
      Classic-family clients, and vice versa. Each call needs a
      target-side answer or a guard.
- [ ] Templates: the XML templates the UI uses (including backdrop
      behavior) differ per flavor — confirm each template exists in
      the target branch's FrameXML.
- [ ] Settings/options: Retail's modern Settings API has no direct
      equivalent on 1.12-lineage clients (Era/Forever) — plan an
      AceConfig or custom panel there.
- [ ] Events: names and payloads differ (combat log especially).
      Re-check every registered event on the target's Events page.
- [ ] Client detection at runtime uses the interface number
      (`select(4, GetBuildInfo())`), not addon-name or version-string
      hacks.

## Packaging the port

- [ ] Per-flavor `.toc` files, or one master `.toc` with
      `## Interface-[Type]:` lines for packager generation (docs/09).
- [ ] Flavor-specific code paths are guarded or branched — one tree,
      no copy-pasted sibling addons to drift apart.
- [ ] The port is loaded and exercised **on the target client** (or
      in wowless with the matching product). A green run on the
      source flavor proves nothing about the target; anything not run
      is recorded as Unverified.
