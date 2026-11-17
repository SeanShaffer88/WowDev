# 11 — AI-Assisted Addon Development

AI help on WoW code fails in predictable ways, and this repo exists to
counter them. The EsfandTV/ThePrimeagen stream (Oct 2026,
[`10`](10-communities-and-learning.md)) showed a complete beginner
shipping working WoW Forever addons in a day with AI assistance — the
workflow works when the ground truth is enforced.

## The failure modes

- **Invented APIs.** The WoW API is huge, versioned, and flavor-split;
  a model will produce confident, plausible function names that do not
  exist on the target client. Counter: AGENTS.md rule 1 — every call
  traced to the wiki, the matching wow-ui-source branch, or `/api`.
- **Flavor bleed.** Training data mixes 20 years of clients: a Retail
  namespace in an Era addon, an Era interface number in a Forever
  `.toc` (Forever is **16001**), a modern template on a 1.12-lineage
  client. Counter: flavor first, and check the flavor's own sources.
- **Modern Lua.** Models default to current Lua idioms; WoW is a 5.1
  subset ([`02`](02-lua-in-wow.md)).
- **Stale sources quoted as current.** Wowpedia-Fandom (frozen 2023),
  wowprogramming.com (frozen ~2015), awesome-wow (2019), and archived
  editor extensions all rank well in search results. Counter: the
  ground-truth hierarchy in the README.
- **Secure-code guesses.** Taint and protected-function rules are
  unforgiving and under-documented in training data. Counter:
  [`03`](03-api-events-and-widgets.md) + secure templates copied from
  Blizzard's own modules, not invented.

## Existing AI tooling for WoW development

- **Xerrion/wow-addon-skills** — https://github.com/Xerrion/wow-addon-skills —
  an OpenCode configuration pack: an agent definition
  (`agents/wow-addon.md`), a wow-addon skill whose research references
  cover addon design, event handling, the frame API, Lua patterns, and
  a research toolkit, plus a working **MCP server** with tools for WoW
  API lookup, Blizzard source browsing, event info, and wiki fetching.
  Recent and small (pushed Nov 2026). This is AI-workflow tooling —
  nothing in it loads in the game client.
- **liuwu0623/wow-addon-dev** — https://github.com/liuwu0623/wow-addon-dev —
  a single SKILL.md pack for creating, migrating, and fixing addons
  for the **3.80.1 "Timewalking" Classic client** (the April 2026
  client whose API was aligned heavily toward Retail). Its references
  include an API-changes comparison for 3.80.1, an API quick
  reference, events, secure action buttons, and WoW UI source notes,
  plus a complete starter addon template. Repo description is in
  Chinese; small and quiet since Apr 2026.
- **This repo** — point the agent at `AGENTS.md` first, then the doc
  for the task. The rules there (never invent, flavor first, 5.1 only,
  verify or label Unverified) are the contract the resources above
  assume.

## Working rules for AI-assisted sessions

1. State the target flavor and interface number in the first message
   of the work, and keep it in the `.toc` from the first commit.
2. Give the agent the ground-truth sources (wiki flavor page,
   wow-ui-source branch) *in the task*, not just the goal.
3. Verify generated code by loading it in the target client (or
   wowless) before building on it — AI code that has never been loaded
   is a hypothesis.
4. Keep the human's four addon docs (README/FEATURES/DESCRIPTION/
   CHANGELOG) factual; generated marketing copy in public docs is a
   defect.
