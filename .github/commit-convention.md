# Conventional Commits for bootnetic

This repository follows [Conventional Commits v1.0.0](https://www.conventionalcommits.org/en/v1.0.0/).

## Commit Message Format

```
<type>(<scope>): <subject>

[optional body]

[optional footer(s)]
```

## Types

- **build**: Changes to the image build process (`recipes/*.yml`, scripts, `flake.nix`)
- **ci**: Changes to GitHub Actions workflows
- **feat**: New packages, flatpaks, or features added to the image
- **fix**: Bug fixes or corrections
- **docs**: Documentation changes only
- **chore**: Maintenance tasks (dependencies, metadata, dotfiles)
- **refactor**: Restructuring without changing behavior

## Scopes

- **recipe**: BlueBuild recipe configuration
- **base**: Base image changes (`base-image` in the recipe)
- **packages**: RPM package installation/removal
- **flatpaks**: Flatpak installation
- **copr**: COPR repositories
- **scripts**: Build-time shell scripts under `files/scripts`
- **nix**: Nix bootstrap / install scripts in the recipe
- **home**: Home Manager configuration (`home.nix`, `dotfiles`)
- **workflow**: GitHub Actions workflows
- **signing**: Cosign key and signing configuration
- **metadata**: Image metadata and branding

## Examples

```
feat(packages): add neovim and zathura
```

```
build(base): switch base to kinoite-main:latest
```

```
fix(scripts): use set -oue pipefail in custom script
```

```
ci(workflow): add validate workflow for PRs
```

## Breaking Changes

If a change is breaking (e.g., removing packages, changing base image), add `!` after the type/scope:

```
build(base)!: migrate from Kinoite 40 to 41

BREAKING CHANGE: requires a clean reinstall for existing users.
```

## Tips

- Keep subject line under 50 characters
- Use imperative mood ("add" not "added")
- Don't end subject line with a period
- Separate subject from body with a blank line
- Reference issues/PRs in footer when applicable
