#!/usr/bin/env bash
# new-addon.sh — scaffold a new WoW addon from the WowDev templates.
#
# Usage:
#   ./new-addon.sh <AddonName> <flavor> [destination-dir] [--ace3]
#
# Flavors: retail, era, forever, tbc, wrath, cata, mop, timewalking
# Interface numbers come from tools/interface-numbers.json (checked
# 2026-11-17). WoW Forever is 16001 — never an Era number.
#
# Example:
#   ./new-addon.sh MyAddon forever ~/Games/WoW/Interface/AddOns
#   ./new-addon.sh MyAddon retail ./AddOns --ace3
set -euo pipefail

NAME="${1:-}"
FLAVOR="${2:-}"
DEST="${3:-.}"
TEMPLATE="minimal"
for arg in "$@"; do
    if [ "$arg" = "--ace3" ]; then TEMPLATE="ace3"; fi
done

if [ -z "$NAME" ] || [ -z "$FLAVOR" ]; then
    echo "Usage: $0 <AddonName> <flavor> [destination-dir] [--ace3]" >&2
    exit 2
fi

case "$FLAVOR" in
    retail)      INTERFACE=120107 ;;
    era)         INTERFACE=11509 ;;
    forever)     INTERFACE=16001 ;;
    tbc)         INTERFACE=20506 ;;
    wrath)       INTERFACE=30405 ;;
    cata)        INTERFACE=40402 ;;
    mop)         INTERFACE=50504 ;;
    timewalking) INTERFACE=38002 ;;
    *) echo "Unknown flavor: $FLAVOR" >&2; exit 2 ;;
esac

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
SRC="$SCRIPT_DIR/../templates/$TEMPLATE"
OUT="$DEST/$NAME"

if [ -e "$OUT" ]; then
    echo "Refusing to overwrite existing folder: $OUT" >&2
    exit 1
fi

mkdir -p "$OUT"
cp -R "$SRC"/. "$OUT"/

# Rename the template .toc to <AddonName>.toc (the client requires the
# .toc name to match the folder name).
for toc in "$OUT"/*.toc; do
    [ -e "$toc" ] && mv "$toc" "$OUT/$NAME.toc"
done

UPPER="$(printf '%s' "$NAME" | tr '[:lower:]' '[:upper:]')"
LOWER="$(printf '%s' "$NAME" | tr '[:upper:]' '[:lower:]')"

# Substitute tokens in every text file. Order matters: the longer
# tokens (with _UPPER/_LOWER suffixes) must go before {{ADDON_NAME}}.
find "$OUT" -type f \( -name '*.lua' -o -name '*.toc' -o -name '*.xml' -o -name '.pkgmeta' \) -print0 |
while IFS= read -r -d '' f; do
    sed -i \
        -e "s/{{ADDON_NAME_UPPER}}/$UPPER/g" \
        -e "s/{{ADDON_NAME_LOWER}}/$LOWER/g" \
        -e "s/{{ADDON_NAME}}/$NAME/g" \
        -e "s/{{INTERFACE}}/$INTERFACE/g" \
        -e "s/{{TITLE}}/$NAME/g" \
        "$f"
done

echo "Created $OUT (flavor: $FLAVOR, interface: $INTERFACE, template: $TEMPLATE)"
echo "Verify the interface number against your actual client before shipping:"
echo "  in-game: /run print(select(4, GetBuildInfo()))"
