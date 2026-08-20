# Agent Instructions for bootnetic

This repository builds a custom Fedora Kinoite (rpm-ostree/bootc) image with
[BlueBuild](https://blue-build.org/), layered with a single-user Nix + Home
Manager bootstrap. Configuration lives in `recipes/recipe.yml`, build-time
scripts live in `files/scripts/`, and user environment config lives in
`home.nix` + `dotfiles/`.

## Start here

- All commits MUST follow [Conventional Commits](.github/commit-convention.md).
- Before committing, run `just check` (or `pre-commit run --all-files` + shellcheck).
- The local validation entrypoint is the `validate` job in
  `.github/workflows/validate.yml`; it must pass before merging.

## Branch Strategy

- `main` is the primary branch. Pushes to `main` publish images via
  `.github/workflows/build.yml`.
- All changes should land via pull requests so `validate` and `build` run first.
- Never push directly to `main` with unvalidated changes.

## CRITICAL: Pre-Commit Checklist

Execute before EVERY commit:

1. **Conventional Commits** — all commits use the format in
   `.github/commit-convention.md`.
2. **Shellcheck** — `shellcheck files/**/*.sh` on all modified shell scripts.
3. **YAML/JSON validation** — `pre-commit run --all-files` (covers
   `recipes/*.yml`, `flake.*`, `*.toml`).
4. **Recipe validation** — `just check` verifies `recipes/*.yml` parses and has
   required keys (`name`, `base-image`, `modules`).
5. **Confirm with user** — always confirm before committing and pushing.

Never commit files with syntax errors.

## PR Comment Policy

- **One comment per PR event, max.** Combine all findings into a single comment.
- Never duplicate GitHub UI state (approval counts, merge queue, CI pass/fail
  summaries) — GitHub already surfaces these.
- Test reports: minimal — what ran, pass/fail, and blockers only.
- Only `@`-mention someone when asking them to do something specific.
- When in doubt, don't post. If the only thing to report is "checks pass",
  post nothing.

## Critical Rules (Enforced)

1. **ALWAYS** use Conventional Commits format for ALL commits.
2. **NEVER** commit `cosign.key` / `cosign.private` (already git-ignored).
3. **ALWAYS** start custom shell scripts with `set -oue pipefail`.
4. **ALWAYS** run shellcheck and recipe validation before committing.
5. **NEVER** push directly to `main` without passing `validate`.
6. **ALWAYS** verify a new Flatpak ID exists on Flathub before adding it.
7. **NEVER** modify the `build` workflow or `recipes/recipe.yml` signing module
   without understanding the impact on published images.
8. **ALWAYS** keep `home.nix` and `dotfiles/` in sync with what the recipe
   expects (paths, usernames).

## Analysis vs Implementation

Answer first, implement when asked. Provide analysis before making changes;
don't implement unless explicitly requested.

## Attribution

AI agents should disclose the tool and model used in an `Assisted-by` footer:

```text
Assisted-by: [Model Name] via [Tool Name]
```

**Last Updated**: 2026-08-20
**Maintainer**: bootnetic contributors
