# 01 — Hello World

**Pattern:** the smallest real addon. **Folder name = .toc name =
`HelloWorld`.**

What it does: type `/hello` and it greets you, counting greetings in
a SavedVariables table so the count survives logout.

Read it in this order:

1. `HelloWorld.toc` — note `## SavedVariables: HelloWorldDB`. Without
   that line, the counter would reset every session
   ([docs/01](../../docs/01-addon-anatomy.md)).
2. `HelloWorld.lua` — the namespace line (`local addonName, addon =
   ...`), the `ADDON_LOADED` init (SavedVariables are only safe to
   touch once your own addon has loaded), and the two-part slash
   command registration (`SLASH_HELLOWORLD1` names the command,
   `SlashCmdList["HELLOWORLD"]` handles it).

Try it: load the game, `/hello` a few times, `/reload`, `/hello`
again — the count continues. Delete the counter by deleting the
`HelloWorldDB` entry from the client's saved-variables file while
logged out, and it starts over.
