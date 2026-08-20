#!/usr/bin/env bash
set -euo pipefail

# Validate that every BlueBuild recipe parses as YAML and contains the
# required top-level keys (name, base-image, modules).
python3 - <<'PY'
import sys, glob, yaml

ok = True
for p in glob.glob("recipes/*.yml"):
    with open(p) as fh:
        data = yaml.safe_load(fh)
    if not isinstance(data, dict):
        print(f"ERROR: {p} is not a mapping")
        ok = False
        continue
    for key in ("name", "base-image", "modules"):
        if key not in data:
            print(f"ERROR: {p} missing required key: {key}")
            ok = False
    if "modules" in data and not isinstance(data["modules"], list):
        print(f"ERROR: {p} 'modules' must be a list")
        ok = False

if not ok:
    sys.exit(1)
print("All recipes valid")
PY
