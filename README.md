<div align="center">
  <picture>
    <source media="(prefers-color-scheme: dark)" srcset="">
    <img alt="preview" src="" width="100%">
  </picture>
</div>

<div align="center">
  <h1> nix-port dotfiles</h1>
  <p><i>NixOS · Hyprland · Material You</i></p>
  <p>
    <img src="https://img.shields.io/badge/NixOS-26.05-5277C3?style=flat-square&logo=nixos&logoColor=white" />
    <img src="https://img.shields.io/badge/WM-Hyprland-58A6FF?style=flat-square" />
    <img src="https://img.shields.io/badge/Shell-Fish-7C3AED?style=flat-square&logo=fish&logoColor=white" />
    <img src="https://img.shields.io/badge/Editor-Neovim-6AD08B?style=flat-square&logo=neovim&logoColor=white" />
    <img src="https://img.shields.io/badge/Bar-Waybar-F5A97F?style=flat-square" />
    <img src="https://img.shields.io/badge/Launcher-Rofi-89B4FA?style=flat-square" />
    <img src="https://img.shields.io/badge/Theming-Matugen-1E1E2E?style=flat-square" />
    <img src="https://img.shields.io/badge/Color-Kanagawa%20Dragon-C695C6?style=flat-square" />
  </p>
</div>

---

## 📋 Table of Contents

- [Screenshots](#-screenshots)
- [Features](#-features)
- [Stack](#-stack)
- [Keybindings](#-keybindings)
- [Desktop Overview](#-desktop-overview)
- [Theming](#-theming)
- [Package Management](#-package-management)
- [Email Workflow](#-email-workflow)
- [Installation](#-installation)
- [Directory Structure](#-directory-structure)
- [Credits](#-credits)

---

## 📸 Screenshots

| Desktop | App Launcher | Notification |
|---|---|---|
| ![]() | ![]() | ![]() |
| **Clipboard** | **Power Menu** | **Lock Screen** |
| ![]() | ![]() | ![]() |

---

## ✨ Features

- **Dynamic theming** — Material You colors extracted from wallpaper via `matugen`, applied across the entire desktop in real-time
- **Kanagawa Dragon fallback** — Static theme for SSH sessions or when you just want a consistent palette
- **Zen Mode** — `SUPER + Z` strips the UI bare: reduced gaps, compact bottom bar, minimal distractions
- **Session restore** — `hyprflow` saves and restores window positions, workspaces, and even Kitty CWD across reboots
- **AI-native** — Ollama serves local models at system start; Opencode, Claude Code, and Neovim Copilot are pre-configured
- **Email → Task pipeline** — Pipe an email from aerc → local LLM summarization → Obsidian task note, all with a single keystroke
- **Interactive package management** — `pkgadd` / `pkgdel` search nixpkgs through `fzf`, auto-edit `packages.nix`, and rebuild (with git commit)
- **USB input fix** — Systemd service re-probes USB input devices after resume (fixes a common issue on AMD/Hyper-V)
- **BFQ scheduler** — External USB SSDs get BFQ I/O scheduling for snappier compiles
- **No sudo** — `doas` exclusively, with persistent session caching
- **6-space indentation** — Enforced everywhere by every formatter and editor config
- **Systemd-managed desktop** — UWSM integrates Hyprland with the systemd user session for clean service management

---

## 🧰 Stack

### System

| Component | Choice |
|---|---|
| **Distribution** | [NixOS](https://nixos.org) (unstable channel) |
| **State Version** | 26.05 |
| **Bootloader** | systemd-boot |
| **Init System** | systemd + UWSM |
| **Display Manager** | SDDM (where-is-my-sddm-theme) |
| **Kernel** | Linux latest (default nixpkgs) |
| **GPU Driver** | amdgpu (open-source) |

### Desktop

| Component | Choice |
|---|---|
| **Compositor** | [Hyprland](https://hyprland.org) with UWSM |
| **Bar** | [Waybar](https://github.com/Alexays/Waybar) (dual config: main + zen) |
| **Launcher** | [Rofi](https://github.com/davatorium/rofi) (drun + clipboard + wallpaper) |
| **Notifications** | [Mako](https://github.com/emersion/mako) |
| **Lock Screen** | [Hyprlock](https://github.com/hyprwm/hyprlock) |
| **Power Menu** | [Wleave](https://github.com/AMNatty/wleave) |
| **Wallpaper** | Awww daemon + custom `wallpaper-pick` script |
| **Clipboard** | [Cliphist](https://github.com/sentriz/cliphist) with rofi image preview |
| **Session Restore** | [Hyprflow](https://github.com/isorensen/hyprflow) |

### Terminal & Shell

| Component | Choice |
|---|---|
| **Terminal** | [Kitty](https://github.com/kovidgoyal/kitty) (11pt JetBrainsMono Nerd Font) |
| **Shell** | [Fish](https://fishshell.com) |
| **Prompt** | [Starship](https://starship.rs) (transient, vi-mode) |
| **Multiplexer** | [Herdr](https://github.com/quantonganh/herdr) |
| **File Manager** | [Yazi](https://yazi-rs.github.io) (terminal) |
| **Disk Usage** | [NCDU](https://dev.yorhel.nl/ncdu) |
| **System Monitor** | [Btop](https://github.com/aristocratos/btop) |

### Development

| Category | Tools |
|---|---|
| **Editor** | [Neovim](https://neovim.io) (40+ plugins via lazy.nvim) + [Zed](https://zed.dev) |
| **AI** | [Ollama](https://ollama.com) (qwen3-coder), [Opencode](https://opencode.ai), Claude Code, Copilot |
| **Languages** | Node.js 26, Python 3, GCC, Clang, Rust (via cargo), CMake, Make |
| **Debugging** | GDB, LLDB, DAP integration in Neovim |
| **LSP** | clangd (system), others via Mason |
| **Version Control** | Git + Jujutsu |
| **Container** | Docker |

### Applications

| Category | Apps |
|---|---|
| **Browser** | Zen Browser, Firefox |
| **Email** | Aerc (terminal) + Gmail (IMAP/SMTP) |
| **Notes** | Obsidian |
| **Chat** | Vesktop (Discord) |
| **VPN** | Tailscale, Cloudflare WARP |
| **Media** | OBS Studio (with VA-API), VLC, Kdenlive, Cava |
| **Productivity** | Pandoc, Zathura (PDF), Proton Mail/Pass |

---

## ⌨ Keybindings

### Window Management

| Keybind | Action |
|---|---|
| `SUPER + Q` | Close window |
| `SUPER + G` | Toggle float |
| `SUPER + F` | Fullscreen |
| `SUPER + [` | Toggle layout (dwindle / scrolling) |
| `SUPER + Z` | Toggle Zen Mode |
| `SUPER + h / l` | Focus column left / right |
| `SUPER + Shift + h / l` | Swap column left / right |
| `SUPER + k / j` | Focus prev / next workspace |
| `SUPER + Shift + k / j` | Move window to prev / next workspace |
| `SUPER + 1–0` | Switch to workspace 1–10 |
| `SUPER + Shift + 1–0` | Move window to workspace 1–10 |
| `SUPER + ;` | Focus next monitor |
| `SUPER + Shift + ;` | Move window to next monitor |

### Launch

| Keybind | Action |
|---|---|
| `SUPER + T` | Terminal (Kitty) |
| `SUPER + E` | File manager (Yazi in Kitty) |
| `ALT + Space` | App launcher (Rofi drun) |
| `SUPER + V` | Clipboard history (Cliphist + Rofi) |
| `SUPER + W` | Wallpaper picker |
| `SUPER + S` | Save session (hyprflow) |
| `SUPER + P` | Power menu (wleave) |
| `SUPER + A` | Email (Aerc, floating) |
| `SUPER + O` | Obsidian |
| `SUPER + M` | Exit session (save + stop) |

### Media & Hardware

| Keybind | Action |
|---|---|
| `XF86AudioRaiseLower` | Volume ± 5% |
| `XF86AudioMute` | Toggle mute |
| `XF86MonBrightnessUp/Down` | Brightness ± 5% |
| `XF86AudioPlay/Pause/Next/Prev` | Media playback |
| 3-finger swipe | Workspace gesture |

---

## 🎨 Theming

### Dynamic (Material You)

The entire desktop follows colors extracted from the current wallpaper via [`matugen`](https://github.com/InioX/matugen). Templates generate themed files for:

- Kitty
- Waybar
- Rofi
- Neovim
- Zed
- Mako
- Wleave
- Hyprlock
- GTK3/4
- Kvantum (QT)
- Obsidian
- Vesktop (Discord)
- SDDM

Run `theme-wallpaper` → pick a wallpaper → everything updates instantly.

### Static (Kanagawa Dragon)

For SSH sessions or when you want a fixed palette, run `theme-kanagawa` to apply pre-generated Kanagawa Dragon colors to all components.

### GTK / QT

| Component | Theme |
|---|---|
| **GTK** | Colloid-Dark (custom: dark variant, no border-radius) |
| **Icons** | Papirus-Dark |
| **Cursor** | Rose Pine cursor |
| **QT** | Kvantum with custom Matugen stylesheet |
| **Font** | JetBrainsMono Nerd Font (system-wide) |

---

## 📦 Package Management

Two custom scripts make adding/removing packages a breeze:

```
pkgadd   # search nixpkgs → fzf pick → auto-add to packages.nix → commit → rebuild
pkgdel   # list current packages → fzf pick → remove → commit → rebuild
```

Both handle git commits automatically and trigger `nh home switch`.

---

## 📬 Email Workflow

Aerc is configured with Gmail (IMAP/SMTP) using either age-encrypted app passwords or full OAuth2.

**Magic key:** In aerc, press `<C-t>` on any email → it gets piped to `mail2obsidian.sh` → the local Ollama model summarizes the body → an Obsidian task note is created with a `aerc-todo://` link back to the exact message.

---

## 🚀 Installation

### On a fresh NixOS

```bash
# Clone the flake
git clone https://github.com/zizenn/nixos-config.git ~/nixos

# Generate hardware config
sudo nixos-generate-config --show-hardware-config > ~/nixos/hardware-configuration.nix

# Rebuild
sudo nixos-rebuild switch --flake ~/nixos#nix-port

# Install home-manager
nix run home-manager/master -- init --switch --flake ~/nixos#zizenn@nix-port

# Subsequent updates
nh os switch        # or: os  (alias)
nh home switch      # or: home (alias)
```

> **Note:** This config assumes a single-user setup with hostname `nix-port`. Adjust `hardware-configuration.nix` for your hardware.

---

## 📁 Directory Structure

```
/
├── flake.nix                     # Flake entrypoint
├── configuration.nix             # System config (imports modules/system/*)
├── hardware-configuration.nix    # Auto-generated (do not edit directly)
├── home.nix                      # User config (imports modules/home/*)
├── packages.nix                  # User package list
├── AGENTS.md                     # Agent instructions
└── modules/
    ├── system/                   # System-scope
    │   ├── boot.nix              # systemd-boot, kernel params
    │   ├── desktop.nix           # Hyprland, SDDM, portals
    │   ├── hardware.nix          # AMD GPU, Bluetooth
    │   ├── locale.nix            # Timezone, locale
    │   ├── networking.nix        # NetworkManager, firewall
    │   ├── nix.nix               # Flakes, experimental features
    │   ├── programs.nix          # System packages, fonts, users
    │   ├── security.nix          # doas, unfree
    │   └── services.nix          # PipeWire, SSH, udev, systemd
    │
    └── home/                     # User-scope
        ├── core/                 # Env vars, scripts
        ├── shell/                # Fish, Starship
        ├── desktop/
        │   ├── hyprland/         # Config, animations, bindings, zen
        │   ├── waybar/           # Main + zen config & style
        │   ├── rofi/             # Glass theme, clipboard, wallpaper
        │   ├── wleave/           # Power menu
        │   ├── hyprflow/         # Session restore config
        │   └── wallpaper.nix     # Wallpaper picker scripts
        ├── editors/
        │   ├── neovim/           # Full Lua config (40+ plugins)
        │   ├── zed/              # Themes, tasks
        │   └── opencode.nix      # AI coding assistant config
        ├── theme/
        │   ├── matugen/          # Config, templates, static outputs
        │   ├── gtk/              # GTK3/4 overrides
        │   ├── qt/               # Kvantum stylesheets
        │   └── fastfetch/        # System info display
        ├── mail/                 # Aerc config, OAuth2, obsidian pipeline
        ├── dev/                  # Git, Jujutsu config
        └── apps/                 # Yazi, Obsidian
```

---

## 🙏 Credits

- [Hyprland](https://github.com/hyprwm/Hyprland) — the compositor that makes Wayland beautiful
- [Matugen](https://github.com/InioX/matugen) — Material You color extraction
- [Waybar Themes](https://github.com/HANCORE-linux/waybar-themes) — base waybar styling (tweaked with matugen colors)
- [Catppuccin](https://github.com/catppuccin) — color inspiration for fallback themes
- [Nixpkgs](https://github.com/NixOS/nixpkgs) — the package set that makes this possible
- [Home Manager](https://github.com/nix-community/home-manager) — declarative user config
- All the maintainers of the tools and packages I use daily
