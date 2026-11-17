# 14 — Localization

## The shape of it

- All display text goes through one table (`L`), looked up by the
  English source string. Code never hard-codes display strings.
- One file per locale under `Locales/`, loaded from the `.toc` before
  the code that uses the strings; the English (enUS) file loads first
  and defines the fallback for every key.
- The client's locale is `GetLocale()` (e.g. `"enUS"`, `"deDE"`,
  `"frFR"`). Locale files early-exit when they are not the active
  locale:

```lua
local _, addon = ...
if GetLocale() ~= "deDE" then return end
local L = addon.L
L["Reset position"] = "Position zurücksetzen"
```

## With AceLocale-3.0

Ace3's locale module (docs/05) formalizes the same pattern:
`NewLocale(addonName, "deDE")` returns the table to fill (or `nil`
when that locale is inactive, so the file does nothing);
`NewLocale(addonName, "enUS", true)` marks the default locale, and
`GetLocale(addonName)` hands the active table to your code. Its
default-locale fallback means an untranslated key shows the English
string instead of an error — the behavior you want.

## Rules that keep translations working

- **Keys are full sentences, not fragments.** Word order differs by
  language; never assemble a sentence from translated pieces.
- **Placeholders travel with the string.** Use `string.format`
  placeholders (`%s`, `%d`) inside the translated string and format
  after lookup — translators can then reorder them as their grammar
  needs.
- **Don't translate keys that aren't display text** (event names,
  internal IDs, saved-variable keys). Translating a data key breaks
  the data.
- **New strings land in enUS first.** A key missing from enUS is a
  bug; a key missing from deDE is a fallback.
- Keep a note in the repo of which locales are complete, partial, or
  machine-only — translators (often users volunteering on the addon
  host) work from that list.

## Testing a locale you don't read

- Switch the client locale if your installation supports it, or
  temporarily force the locale file to load by removing its
  `GetLocale()` guard in a test build.
- Check the longest strings in your UI: German and Russian routinely
  overflow layouts sized for English. Frames should size to text or
  truncate cleanly (see the layout rules in the checklist).
