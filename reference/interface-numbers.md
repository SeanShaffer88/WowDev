# Reference — Interface Numbers

The quick table. Full discussion:
[`../docs/04-flavors-and-interface-numbers.md`](../docs/04-flavors-and-interface-numbers.md).
Machine-readable form: [`../tools/interface-numbers.json`](../tools/interface-numbers.json).
Checked 2026-11-17 against the Ace3 project's `.toc` and the
`Gethe/wow-ui-source` branch list.

| Flavor | Interface | wow-ui-source branch |
|---|---|---|
| Retail | 120100–120107 | `live` |
| Classic Era | 11508, 11509 | `classic_era` |
| WoW Forever | **16001** | `forever` |
| TBC Classic | 20505, 20506 | `classic` |
| Wrath Classic | 30405 | `classic` |
| Classic "Timewalking" 3.80.x | 38002 | `classic` |
| Cata Classic | 40402 | `classic` |
| MoP Classic | 50503, 50504 | `classic` |

## Find your client's number in-game

```
/run print(select(4, GetBuildInfo()))
```

`GetBuildInfo()` returns version, build, date, and the interface
number — the fourth value is the exact number your `.toc` needs.
Run it on the actual client you target; never copy a number from a
different flavor's addon, a forum post, or this table without
checking, because clients patch and numbers move.

## Rules of thumb

- A `.toc` whose `## Interface:` doesn't match the client = the addon
  is marked out of date and does not load (no error, just silence).
- Forever is **16001**, always. Era numbers in a Forever `.toc` are
  the single most common dead-addon cause on that client.
- One release can serve several flavors: per-flavor `.toc` files, or
  the BigWigs packager generating them from `## Interface-[Type]:`
  lines ([`../docs/09-packaging-and-distribution.md`](../docs/09-packaging-and-distribution.md)).
