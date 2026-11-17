# Tools

Standalone utilities that speed up addon development. None of them
need the game client.

| Tool | What it does |
|---|---|
| [`new-addon.sh`](new-addon.sh) / [`new-addon.ps1`](new-addon.ps1) | Scaffolds a new addon from the [`../templates/`](../templates/) into a ready-to-load folder: picks the flavor's interface number, substitutes the name tokens, renames the `.toc`. |
| [`check-addon.py`](check-addon.py) | Static validator for an addon folder: `.toc` sanity, listed files exist, interface present, `SetBackdrop` without `BackdropTemplate`, Lua 5.2+ syntax that WoW's 5.1 subset rejects. Python 3, standard library only. |
| [`interface-numbers.json`](interface-numbers.json) | The flavor/interface data from docs/04 in machine-readable form — the same table the scaffolder uses. |
| [`.luacheckrc`](.luacheckrc) | A luacheck configuration for WoW Lua 5.1: the right standard, the bedrock globals, and the warnings that matter. Copy to your addon repo root. |
| [`vscode/`](vscode/) | VS Code recommendations (extensions), settings (Lua 5.1 runtime), and code snippets for the patterns in docs/12. |

Usage examples are in each file's header.
