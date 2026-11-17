# 03 — Movable Frame

**Pattern:** a visible, draggable frame with a saved position.

What it does: shows a small panel in the center of the screen. Drag
it anywhere; on the next login it is where you left it. `/mframe`
resets it to the center.

Things to notice:

- **`"BackdropTemplate"` is passed to `CreateFrame`.** That is what
  makes `SetBackdrop` legal. Calling `SetBackdrop` on a plain frame
  is the classic crash this repo's AGENTS.md rule 5 exists to prevent
  ([docs/03](../../docs/03-api-events-and-widgets.md)).
- **The backdrop uses Blizzard's own textures** (`Interface\DialogFrame\…`)
  — no art files needed. Custom textures are covered in
  [docs/07](../../docs/07-textures-and-art.md).
- **Position is saved as an anchor** (point, relative point, x, y from
  `GetPoint()`), not as absolute screen coordinates — so it survives
  resolution and UI-scale changes.
- Dragging uses the frame's own scripts (`OnDragStart` /
  `OnDragStop`) plus `SetMovable` + `RegisterForDrag` — no polling,
  no `OnUpdate`.
