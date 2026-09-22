# DOS — Agent Instructions

## Project
Fedora Atomic image built with BlueBuild.

## Desktop
- Umbriel
- Noctalia
- Ghostty

## Input
- Fcitx5
- Mozc
- Do not use IBus unless explicitly required.

## Wayland
- wl-clipboard
- grim
- slurp

## CLI
- git
- curl
- wget
- ripgrep
- fd
- fzf
- jq
- yq
- bat
- btop
- tmux
- zoxide
- mpv

## Development
- Neovim
- lazygit
- Podman
- Distrobox

## Hardware
Target:
Acer Nitro 5 AN517-54

Required:
- brightness
- keyboard backlight
- mute LED
- fan monitoring/control
- battery charge limit 80%
- platform profiles

Investigate kernel/ACPI/acer-wmi support before installing third-party tools.

## Android
- adb
- fastboot
- Bifrost
- Odin4

Prefer reproducible packaging.
Do not use curl | sh.
Do not add secrets.


