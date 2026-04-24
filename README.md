# dotfiles

Base configuration managed by [Chezmoi](https://www.chezmoi.io/). Common config for all machines (work and personal).

## Setup

```bash
sh -c "$(curl -fsLS get.chezmoi.io)" -- init --apply Kashnaladak/dotfiles
```

Chezmoi will prompt for:
- **Profile**: `work` or `personal`
- **Name**: your full name

The profile selection auto-clones the correct profile repo to `~/.dotprofile/`.

## What's included

- Shell config (`.zshrc`, `.zshenv`, `.zprofile`, `.bash_profile`, `.bashrc`)
- Git config (`.gitconfig` with profile include)
- SSH config (with profile include)
- Starship prompt config
- Oh-My-Zsh base aliases
- Karabiner keyboard remaps
- Rectangle window management
- Warp terminal keybindings
- VS Code settings + keybindings
- Fonts (Berkeley Mono, Fira Code Nerd Font)
- macOS preferences (keyboard speed, Dock, Finder, screenshots)
- Desktop wallpaper
- Base Brewfile

## Profile repos

- **Work**: `DataDog/fpaulo-dotfiles` (Datadog GitHub)
- **Personal**: `Kashnaladak/dotfiles-personal` (private)

See `~/dotfiles-guide.md` (deployed by Chezmoi) for day-to-day usage.
