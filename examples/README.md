# Worked Examples

Complete, loadable addons that each teach one pattern end to end.
Copy an example into `Interface/AddOns/` **and rename the folder to
the addon's name** (`HelloWorld`, `SessionTracker`, `MovableFrame` —
the folder name must match the `.toc` inside it), fix the
`## Interface:` line for your client ([`../docs/04-flavors-and-interface-numbers.md`](../docs/04-flavors-and-interface-numbers.md)),
and load it. The examples ship with `## Interface: 16001` (WoW
Forever) as written. Run [`../tools/check-addon.py`](../tools/) on the
renamed folder to sanity-check it.

| Example | Pattern it teaches |
|---|---|
| [`01-hello-world/`](01-hello-world/) | The smallest real addon: `.toc`, namespace, slash command, a SavedVariables counter |
| [`02-session-tracker/`](02-session-tracker/) | The event-frame pattern: several events, per-character SavedVariables, session vs lifetime stats |
| [`03-movable-frame/`](03-movable-frame/) | A visible frame done right: `BackdropTemplate`, drag to move, position saved and restored |

Each example is deliberately small enough to read in one sitting.
Production addons combine all three patterns (plus a library —
[`../docs/05-libraries-and-frameworks.md`](../docs/05-libraries-and-frameworks.md)).
