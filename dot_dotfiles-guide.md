# Dotfiles Guide

Quick reference for day-to-day dotfiles management.

## Architecture

Three repos, layered:
- **Base** (Chezmoi, `~/.local/share/chezmoi/`) — common config for all machines
- **Profile** (`~/.dotprofile/`) — machine-specific config (work OR personal, never both)
  - Work: `DataDog/fpaulo-dotfiles` on Datadog GitHub
  - Personal: `Kashnaladak/dotfiles-personal` on personal GitHub

## Where does X go?

| What | Where | File |
|------|-------|------|
| New alias (all machines) | Base | `~/.oh-my-zsh/custom/aliases.zsh` |
| New alias (work only) | Work profile | `~/.dotprofile/aliases.zsh` |
| New env var (work only) | Work profile | `~/.dotprofile/exports.zsh` |
| New env var (all machines) | Base | `~/.zshrc` (via Chezmoi template) |
| New Homebrew package (all machines) | Base | `~/.local/share/chezmoi/Brewfile` |
| New Homebrew package (work only) | Work profile | `~/.dotprofile/Brewfile` |
| New SSH host (work) | Work profile | `~/.dotprofile/ssh_config` |
| New Claude Code permission | Live `~/.claude/settings.json` | (see "Updating Claude Code" below) |
| New git config (work) | Work profile | `~/.dotprofile/gitconfig` |

## Common Tasks

### Add a new alias or env var

1. Edit the appropriate file (see table above)
2. If it's in the base repo: `chezmoi re-add <file>` then `cd ~/.local/share/chezmoi && git add -A && git commit -m "description" && git push`
3. If it's in the work profile: `cd ~/.dotprofile && git add -A && git commit -m "description" && git push`

### Add a Homebrew package

1. `brew install <package>` (to install it now)
2. Add `brew "<package>"` or `cask "<package>"` to the appropriate Brewfile
3. Commit and push the repo

### After re-running laptop-setup.sh

DD's `laptop-setup.sh` will clobber your `.zshrc` with the Ansible managed block. Restore immediately:

```bash
chezmoi apply && ~/.dotprofile/install.sh
```

### Updating Claude Code config

Claude Code auto-adds permissions to `~/.claude/settings.json` during sessions. To capture these into the dotfiles:

```bash
# See what changed:
diff ~/.dotprofile/claude/settings.json ~/.claude/settings.json

# If the changes are general-purpose patterns worth keeping:
cp ~/.claude/settings.json ~/.dotprofile/claude/settings.json
cd ~/.dotprofile && git add -A && git commit -m "Update Claude Code permissions" && git push
```

To re-deploy Claude Code config from the repo (e.g., after updating the repo):
```bash
~/.dotprofile/install.sh        # Backs up existing settings.json if newer
~/.dotprofile/install.sh --force  # Overwrites without backup
```

### Recovery

If `.zshrc` is broken:
```bash
# Open a minimal shell:
env -i /bin/zsh --no-rcs

# Restore from Chezmoi:
chezmoi apply ~/.zshrc
```

If everything is broken:
```bash
# Restore from backup (taken during Wave 7 setup):
cp ~/dotfiles-backup/.zshrc ~/dotfiles-backup/.gitconfig ~/
source ~/.zshrc
```

## Chezmoi Cheat Sheet

```bash
chezmoi diff              # Preview what would change
chezmoi apply             # Apply all changes
chezmoi apply ~/.zshrc    # Apply one file
chezmoi cat ~/.zshrc      # Preview rendered template
chezmoi re-add ~/.zshrc   # Update source from live file
chezmoi edit ~/.zshrc     # Edit source, then apply
chezmoi cd                # cd into source directory
```

## Profile Repo Maintenance

```bash
# Work profile:
cd ~/.dotprofile
git add -A && git commit -m "description" && git push

# Base repo:
chezmoi cd
git add -A && git commit -m "description" && git push
```

## GitLab Auth

GitLab PATs are deprecated. Use short-lived OAuth tokens:
```bash
ddtool auth gitlab login        # One-time OAuth login
ddtool auth gitlab token        # Get a 2h token when needed
```

If a tool needs the `GITLAB_TOKEN` env var:
```bash
export GITLAB_TOKEN=$(ddtool auth gitlab token)
# Expires after 2 hours
```

## macOS Preferences Reset

If a macOS update resets your preferences (keyboard speed, Dock, Finder):
```bash
bash ~/.local/share/chezmoi/run_once_macos-defaults.sh
```

Or force Chezmoi to re-run all `run_once_` scripts:
```bash
chezmoi state delete-bucket --bucket=scriptState
chezmoi apply
```
