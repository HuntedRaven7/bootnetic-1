#!/usr/bin/env bash
set -euo pipefail

# Validate that every Flatpak ID referenced in the recipes exists on Flathub.
if ! command -v flatpak >/dev/null 2>&1; then
    echo "flatpak not installed; install it to validate flatpak IDs"
    exit 0
fi

flatpak remote-add --user --if-not-exists flathub \
    https://dl.flathub.org/repo/flathub.flatpakrepo || true

# Extract dotted app IDs from recipe module lists (e.g. org.example.App)
ids=$(grep -Eho '^\s*- [a-zA-Z0-9._-]+(\.[a-zA-Z0-9._-]+)+' recipes/*.yml \
    | sed -E 's/.*- //' | sort -u || true)

if [[ -z "${ids}" ]]; then
    echo "No Flatpak IDs found to validate"
    exit 0
fi

while IFS= read -r id; do
    [[ -z "${id}" ]] && continue
    echo ":: checking ${id}"
    if ! flatpak remote-info --user flathub "${id}" >/dev/null 2>&1; then
        echo "MISSING on Flathub: ${id}"
        exit 1
    fi
done <<< "${ids}"

echo "All Flatpak IDs exist on Flathub"
