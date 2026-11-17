#!/usr/bin/env python3
"""check-addon.py — static checks for a WoW addon folder.

Usage: python3 check-addon.py path/to/AddonFolder

Checks (see docs/01, docs/02, docs/04, AGENTS.md):
  1. The folder contains a .toc with the same name as the folder.
  2. The .toc has a numeric ## Interface: line.
  3. Every file listed in the .toc exists on disk.
  4. SavedVariables are declared (lists them; undeclared variables do
     not persist — this tool cannot see your Lua intent, so it only
     reports what IS declared).
  5. Any Lua file calling SetBackdrop also mentions BackdropTemplate
     (AGENTS.md rule 5 — SetBackdrop on a plain frame crashes).
  6. Lua files contain no Lua 5.2+ constructs WoW's 5.1 subset
     rejects: integer division //, goto/labels, table.unpack.

Exit code: 0 = no failures, 1 = at least one FAIL. Warnings do not
fail the run. Python 3, standard library only.
"""

import os
import re
import sys

FAIL = "FAIL"
WARN = "WARN"
OK = "OK  "


def main() -> int:
    if len(sys.argv) != 2:
        print(__doc__)
        return 2
    root = sys.argv[1].rstrip("/\\")
    name = os.path.basename(root)
    failures = 0

    def report(level, msg):
        nonlocal failures
        if level == FAIL:
            failures += 1
        print(f"{level} {msg}")

    if not os.path.isdir(root):
        report(FAIL, f"not a directory: {root}")
        return 1

    # 1. .toc name must match the folder name.
    toc_path = os.path.join(root, name + ".toc")
    tocs = [f for f in os.listdir(root) if f.endswith(".toc")]
    if not os.path.exists(toc_path):
        report(FAIL, f"no {name}.toc in folder (found: {tocs or 'none'}) — "
                     "the .toc name must match the folder name")
        return 1
    report(OK, f"{name}.toc present")

    lines = open(toc_path, encoding="utf-8", errors="replace").read().splitlines()

    # 2. ## Interface: present and numeric.
    iface = None
    saved_vars = []
    listed_files = []
    for line in lines:
        line = line.strip()
        m = re.match(r"##\s*Interface:\s*(\S+)", line)
        if m:
            iface = m.group(1)
        m = re.match(r"##\s*SavedVariables(?:PerCharacter)?:\s*(.+)", line)
        if m:
            saved_vars += [v.strip() for v in m.group(1).split(",")]
        if line and not line.startswith("#"):
            listed_files.append(line)
    if iface is None:
        report(FAIL, "no ## Interface: line — the client will not load this addon")
    elif not re.fullmatch(r"\d+(,\s*\d+)*", iface):
        report(FAIL, f"## Interface: value is not numeric: {iface!r}")
    else:
        report(OK, f"## Interface: {iface} (check it matches your target client — docs/04)")

    # 3. Every listed file exists.
    for rel in listed_files:
        path = os.path.join(root, rel.replace("\\", os.sep))
        if os.path.exists(path):
            report(OK, f"listed file exists: {rel}")
        else:
            report(FAIL, f"listed in .toc but missing on disk: {rel}")

    # 4. SavedVariables report.
    if saved_vars:
        report(OK, "SavedVariables declared: " + ", ".join(saved_vars))
    else:
        report(WARN, "no SavedVariables declared — fine if the addon stores nothing")

    # 5 + 6. Lua source checks.
    lua_files = []
    for dirpath, _dirs, files in os.walk(root):
        for f in files:
            if f.endswith(".lua"):
                lua_files.append(os.path.join(dirpath, f))
    banned = [
        (re.compile(r"//"), "integer division '//' (Lua 5.3+, not in WoW's 5.1)"),
        (re.compile(r"\bgoto\b|::\w+::"), "goto/labels (Lua 5.2+, not in WoW's 5.1)"),
        (re.compile(r"\btable\.unpack\b"), "table.unpack (it is global 'unpack' in 5.1)"),
    ]
    for path in sorted(lua_files):
        src = open(path, encoding="utf-8", errors="replace").read()
        rel = os.path.relpath(path, root)
        if "SetBackdrop(" in src or ":SetBackdrop(" in src:
            if "BackdropTemplate" in src:
                report(OK, f"{rel}: SetBackdrop used with BackdropTemplate")
            else:
                report(FAIL, f"{rel}: calls SetBackdrop but never mentions "
                             "BackdropTemplate — plain frames have no SetBackdrop (AGENTS.md rule 5)")
        for pattern, why in banned:
            for i, line in enumerate(src.splitlines(), 1):
                code = line.split("--", 1)[0]  # ignore comments (naive but effective here)
                if pattern.search(code):
                    report(FAIL, f"{rel}:{i}: {why}")

    print()
    print("RESULT:", "FAIL — fix the FAIL lines above" if failures else "PASS (warnings are advisory)")
    return 1 if failures else 0


if __name__ == "__main__":
    sys.exit(main())
