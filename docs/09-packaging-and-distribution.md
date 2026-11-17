# 09 — Packaging and Distribution

## Blizzard's UI Add-On Development Policy (the rules that bind everyone)

Canonical home: the Blizzard forum thread "UI Add-On Development
Policy" (US: https://us.forums.blizzard.com/en/wow/t/ui-add-on-development-policy/24534/1;
EU equivalent exists). Originally released 2009-03-20; still the
posted policy. Its 8 rules, in substance:

1. Add-ons must be **free of charge** — no charging, no premium
   versions.
2. Add-on code must be **completely visible** — no hiding or
   obfuscation.
3. Add-ons must not negatively impact realms or other players.
4. Add-ons may not include **advertisements**.
5. Add-ons may not **solicit donations** in-game.
6. Add-ons must not contain offensive or objectionable material.
7. Add-ons must abide by the WoW Terms of Use and EULA.
8. Blizzard may disable add-on functionality as it sees fit.

Developer contact named in the policy: WoWUI@blizzard.com. (Custom
clients such as WoW Forever are outside Blizzard's policy scope, but
rules 1–2 and 4–5 are also this repo's house style for every flavor.)

## The BigWigs packager — the standard release route

- **Repo:** https://github.com/BigWigsMods/packager — actively
  maintained (v2.7.0, Nov 2026).
- **What it does:** `release.sh` builds a distributable addon zip from
  a Git/SVN/Hg checkout and can upload it to **CurseForge,
  WoWInterface, Wago, and GitHub (as a release)** in one run. Version
  comes from the VCS tag on HEAD; the changelog is generated from
  commits since the previous tag; files are staged into `.release/`;
  externals are fetched; keyword and localization substitutions are
  applied.
- **Invocation:** run `release.sh` in the checkout, or use the GitHub
  Action `BigWigsMods/packager@v2`.
- **Project IDs:** flags `-p` (CurseForge), `-w` (WoWInterface), `-a`
  (Wago) — or declare them in the `.toc` as `## X-Curse-Project-ID:`,
  `## X-WoWI-ID:`, `## X-Wago-ID:`. The package name comes from the
  `.toc` file name.
- **`.pkgmeta` directives** (the ones that matter): `externals` (pull
  libraries like Ace3 from their repos at build time — for Ace3,
  reference the WoWAce SVN per [`05`](05-libraries-and-frameworks.md)),
  `ignore`, `plain-copy`, `license-output`, `manual-changelog`,
  `move-folders`, `package-as`, `enable-nolib-creation` (nolib builds
  upload only to GitHub releases), `enable-toc-creation`,
  `required-dependencies`, `optional-dependencies`, and the
  WoWInterface options (`wowi-archive-previous`, `wowi-create-changelog`,
  `wowi-convert-changelog`).
- **Multi-flavor TOCs:** the packager supports multiple `## Interface:`
  values and per-flavor `.toc` files, and with `-S` (or
  `enable-toc-creation: yes`) it *generates* per-game-type TOCs from
  `## Interface-[Type]:` lines in one master `.toc` — the clean way to
  ship Retail + Era + Forever from one tree
  ([`04`](04-flavors-and-interface-numbers.md)).
- **Substitutions:** `@project-version@`, `@file-hash@`, localization
  blocks `@localization(...)@`, and build-type comment keywords
  (`@alpha@`, `@debug@`, `@do-not-package@`, `@version-retail@`,
  `@version-classic@`, …) that include/strip code per build.

## Manual packaging (when the packager doesn't fit)

Zip the addon folder itself (folder name = addon name, `.toc` inside
at the folder root — not nested one level deeper; the classic broken
release). Name the archive with the addon name and version. This is
also the shape used for direct GitHub-release distribution of
single-flavor addons.

## Where addons are distributed

- **CurseForge** — the largest addon host; packager uploads natively.
- **Wago** (wago.io addons) — packager uploads natively.
- **WoWInterface** — the oldest author community + host; packager
  uploads natively.
- **GitHub Releases** — direct distribution; the packager can publish
  there too. House standard for releases here: the addon zip plus
  `SHA256SUMS.txt`, with README/description/topics kept current and
  screenshots from real runs.

## Release discipline

- Tag the release in git; the tag *is* the version the packager ships.
- Changelog entries are factual product documentation only.
- Every release re-checks: `.toc` interface numbers for every flavor
  shipped, the four addon docs (README/FEATURES/DESCRIPTION/CHANGELOG),
  and that embedded libraries are the versions `.pkgmeta` declares.
