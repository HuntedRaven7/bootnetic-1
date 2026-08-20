export IMAGE_NAME := env("IMAGE_NAME", "bootnetic")
export RECIPE := env("RECIPE", "recipes/recipe.yml")

# Default recipe: run all local checks
default:
    @just --list

# ---------------------------------------------------------------------------
# Local validation (the same checks CI runs in .github/workflows/validate.yml)
# ---------------------------------------------------------------------------

# Run every local check
[group("CI")]
check:
    #!/usr/bin/env bash
    set -euo pipefail
    just lint-shell
    just lint-files
    just validate-recipe

# Install git pre-commit hooks so checks run automatically on commit
[group("Utility")]
hooks:
    #!/usr/bin/env bash
    set -euo pipefail
    if command -v pre-commit >/dev/null 2>&1; then
        pre-commit install
    else
        echo "pre-commit not installed; run: pip install pre-commit"
    fi

# Run pre-commit on all files (YAML/JSON/TOML/whitespace)
[group("Lint")]
lint-files:
    #!/usr/bin/env bash
    set -euo pipefail
    if command -v pre-commit >/dev/null 2>&1; then
        pre-commit run --all-files
    else
        echo "pre-commit not installed; run: pip install pre-commit"
    fi

# Shellcheck all custom shell scripts
[group("Lint")]
lint-shell:
    #!/usr/bin/env bash
    set -euo pipefail
    if ! command -v shellcheck >/dev/null 2>&1; then
        echo "shellcheck not installed; skipping"
        exit 0
    fi
    find files -iname '*.sh' -type f -print0 | xargs -0 -r shellcheck

# Validate BlueBuild recipes parse and have required keys
[group("CI")]
validate-recipe:
    bash ci/validate-recipes.sh

# Validate that every Flatpak ID in the recipe exists on Flathub
[group("CI")]
validate-flatpaks:
    bash ci/validate-flatpaks.sh

# Format all shell scripts with shfmt (if available)
[group("Lint")]
format:
    #!/usr/bin/env bash
    set -euo pipefail
    if ! command -v shfmt >/dev/null 2>&1; then
        echo "shfmt not installed; skipping"
        exit 0
    fi
    find files -iname '*.sh' -type f -print0 | xargs -0 -r shfmt --write
