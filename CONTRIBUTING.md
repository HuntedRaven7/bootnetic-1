# Contributing to bootnetic

Thanks for helping improve bootnetic! This is a custom [BlueBuild](https://blue-build.org/)
image based on Fedora Kinoite, with a single-user Nix + Home Manager bootstrap.

## How the image is built

- Image definition lives in `recipes/recipe.yml` (BlueBuild recipe).
- Build-time scripts live in `files/scripts/`.
- User environment config lives in `home.nix` + `dotfiles/`.
- Images are built and published by `.github/workflows/build.yml` on pushes to `main`.

## Branching

- Open all changes as pull requests against `main`.
- The `validate` workflow runs automatically on PRs and must pass before merge.
- Do not push directly to `main` with unvalidated changes.

## Commits

This repo follows [Conventional Commits](.github/commit-convention.md). Every commit
must use the `<type>(<scope>): <subject>` format. Examples:

```
feat(packages): add neovim and zathura
fix(scripts): use set -oue pipefail in custom script
ci(workflow): add validate workflow for PRs
```

## Before you commit

Run the local checks:

```bash
just check          # lint + shellcheck + recipe validation
```

Or the equivalent:

```bash
pre-commit run --all-files
shellcheck files/**/*.sh
```

## Adding packages

- RPM packages: add to the `rpm-ostree` `install`/`remove` list in `recipes/recipe.yml`.
- Flatpaks: add to `default-flatpaks` in `recipes/recipe.yml`. Verify the Flatpak
  ID exists on Flathub (`just validate-flatpaks`).
- COPR repos: add to the `dnf` `repos.copr` list.

## Adding scripts

- Put build-time scripts under `files/scripts/` and start them with
  `set -oue pipefail`.
- Run `shellcheck` on them before committing.

## Signing

- Never commit `cosign.key` or `cosign.private` (they are git-ignored).
- Image signing is handled by the `signing` module in `recipes/recipe.yml`.
