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
    <img src="https://img.shields.io/badge/WM-Niri-58A6FF?style=flat-square" />
    <img src="https://img.shields.io/badge/Shell-Fish-7C3AED?style=flat-square&logo=fish&logoColor=white" />
    <img src="https://img.shields.io/badge/Editor-Neovim-6AD08B?style=flat-square&logo=neovim&logoColor=white" />
    <img src="https://img.shields.io/badge/Bar-Waybar-F5A97F?style=flat-square" />
    <img src="https://img.shields.io/badge/Launcher-Rofi-89B4FA?style=flat-square" />
    <img src="https://img.shields.io/badge/Theming-Matugen-1E1E2E?style=flat-square" />
    <img src="https://img.shields.io/badge/Color-Kanagawa%20Dragon-C695C6?style=flat-square" />
    <img src="https://img.shields.io/badge/Kernel-Zen-FFA500?style=flat-square" />
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
- [Performance](#-performance)
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
- **Scrollable tiling** — Niri's column-based layout with fluid horizontal scrolling between workspaces
- **AI-native** — Ollama serves local models at system start; Opencode, Claude Code, and Neovim Copilot are pre-configured
- **Email → Task pipeline** — Pipe an email from aerc → local LLM summarization → Obsidian task note, all with a single keystroke
- **Interactive package management** — `pkgadd` / `pkgdel` search nixpkgs through `fzf`, auto-edit `packages.nix`, and rebuild (with git commit)
- **Self-contained neovim** — LSPs, formatters, and DAP debuggers are wrapped into neovim's runtime only, not on global PATH
- **Performance-tuned kernel** — `linuxPackages_zen` with mitigations disabled, BBR congestion control, tuned page cache
- **USB input fix** — Systemd service re-probes USB input devices after resume
- **BFQ scheduler** — External USB SSDs get BFQ I/O scheduling for snappier compiles
- **No sudo** — `doas` exclusively, with persistent session caching
- **6-space indentation** — Enforced everywhere by every formatter and editor config
- **Lightweight display manager** — Ly TUI greeter for fast, minimal login

---

## 🧰 Stack

### System

| Component | Choice |
|---|---|
| **Distribution** | [NixOS](https://nixos.org) (unstable channel) |
| **State Version** | 26.05 |
| **Bootloader** | systemd-boot (limit 10 entries) |
| **Init System** | systemd + UWSM |
| **Display Manager** | Ly (TUI) |
| **Kernel** | [linuxPackages_zen](https://github.com/zen-kernel/zen-kernel) (desktop-tuned) |
| **GPU Driver** | amdgpu (open-source) |

### Desktop

| Component | Choice |
|---|---|
| **Compositor** | [Niri](https://github.com/YaLTeR/niri) (scrollable-tiling) |
| **Bar** | [Waybar](https://github.com/Alexays/Waybar) (dual config: main + zen) |
| **Launcher** | [Rofi](https://github.com/davatorium/rofi) (drun + clipboard + wallpaper) |
| **Notifications** | [Mako](https://github.com/emersion/mako) |
| **Lock Screen** | [Hyprlock](https://github.com/hyprwm/hyprlock) |
| **Power Menu** | [Wleave](https://github.com/AMNatty/wleave) |
| **Wallpaper** | Awww daemon + custom `wallpaper-pick` script |
| **Clipboard** | [Cliphist](https://github.com/sentriz/cliphist) with rofi image preview |
| **Session Restore** | Niri native state restore |

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
| **Editor** | [Neovim](https://neovim.io) (40+ plugins via lazy.nvim) wrapped with isolated LSP/formatter/DAP runtime + [Zed](https://zed.dev) |
| **AI** | [Ollama](https://ollama.com) (qwen3-coder), [Opencode](https://opencode.ai), Claude Code, Copilot |
| **Languages** | Node.js 26, Python 3, Rust (via cargo) |
| **C++** | Managed exclusively via `devenv` shells — no global gcc/cmake/gdb/lldb |
| **LSP** | clangd, lua-language-server, typescript-language-server, pyright (neovim-only) |
| **Formatters** | stylua, prettier, autopep8, clang-format (neovim-only) |
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

> **Note:** LSPs, formatters, and DAP debuggers are wrapped into neovim's runtime (not in `packages.nix`). C++ development tools (gcc, cmake, gdb, lldb, make) are managed through `devenv` shells — not installed globally.

---

## 📬 Email Workflow

Aerc is configured with Gmail (IMAP/SMTP) using either age-encrypted app passwords or full OAuth2.

**Magic key:** In aerc, press `<C-t>` on any email → it gets piped to `mail2obsidian.sh` → the local Ollama model summarizes the body → an Obsidian task note is created with a `aerc-todo://` link back to the exact message.

---

## ⚡ Performance

| Tuning | Detail |
|---|---|
| **Kernel** | `linuxPackages_zen` — desktop-optimized scheduling, lower latency |
| **Mitigations** | `mitigations=off` — disables CPU vulnerability mitigations |
| **Watchdog** | `nowatchdog` — frees a CPU core from NMI watchdog |
| **C-states** | `processor.max_cstate=1` — prevents deep idle states (lower wake latency) |
| **Network** | BBR congestion control + fq qdisc |
| **vm.swappiness** | 1 — only swap under extreme pressure |
| **vm.vfs_cache_pressure** | 50 — retain dentry/inode cache longer |
| **vm.dirty_ratio** | 10 — larger writeback buffer |
| **nix.max-jobs** | auto — all CPU cores used for builds |
| **nix.sandbox** | disabled — removes build overhead on personal machine |
| **nix.auto-optimise-store** | enabled — deduplicates store paths automatically |
| **nix GC** | weekly, >7d — automatic garbage collection |
| **Boot entries** | 10 — limits systemd-boot menu clutter |
| **Docs** | NixOS HTML/info docs disabled — man pages kept |

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

## 🏃 Run on Any Distro

All my dotfiles packages are exposed as a Nix flake — you can run them on any
Linux distro with Nix installed (no NixOS required):

```bash
# Run a terminal
nix run github:zizenn/nixos-config#kitty

# Run the compositor
nix run github:zizenn/nixos-config#niri

# Try a shell
nix run github:zizenn/nixos-config#fish

# Or any other tool
nix run github:zizenn/nixos-config#bat
nix run github:zizenn/nixos-config#starship
nix run github:zizenn/nixos-config#neovim
```

Available packages: `bat`, `brightnessctl`, `cliphist`, `eza`, `fastfetch`,
`fd`, `feh`, `firefox`, `fish`, `fzf`, `gh`, `git`, `imv`, `jq`, `jujutsu`,
`kitty`, `lazygit`, `mako`, `neovim`, `niri`, `obs-studio`, `pavucontrol`,
`playerctl`, `ripgrep`, `rofi`, `starship`, `tmux`, `vesktop`, `vlc`,
`waybar`, `wl-clipboard`, `wleave`, `yazi`, `zoxide`.

---

## 📁 Directory Structure

```
/
├── flake.nix                     # Flake entrypoint
├── AGENTS.md                     # Agent instructions
├── modules/
    ├── system/                   # System-scope (NixOS), imported by flake.nix
    ├── system/                   # System-scope
    │   ├── boot.nix              # systemd-boot, zen kernel, sysctl tuning
    │   ├── desktop.nix           # Niri, Ly, portals
    │   ├── hardware.nix          # AMD GPU, Bluetooth
    │   ├── locale.nix            # Timezone, locale
    │   ├── networking.nix        # NetworkManager, firewall
    │   ├── nix.nix               # Auto-optimise, parallel builds, GC, performance tuning
    │   ├── programs.nix          # System packages, fonts, users
    │   ├── security.nix          # doas, unfree
    │   └── services.nix          # PipeWire, SSH, udev, systemd
    │
    └── home/                     # User-scope (home-manager), imported by flake.nix
        ├── default.nix           # Top-level HM config (imports all below)
        ├── packages.nix          # User package list
        ├── core/                 # Env vars, scripts
        ├── shell/                # Fish, Starship
        ├── desktop/
        │   ├── niri/             # Config.kdl, hypridle, window rules
        │   ├── waybar/           # Main + zen config & style
        │   ├── rofi/             # Glass theme, clipboard, wallpaper
        │   ├── wleave/           # Power menu
        │   ├── hyprflow/         # Session restore config
        │   └── wallpaper.nix     # Wallpaper picker scripts
        ├── editors/
        │   ├── neovim/           # Full Lua config + wrapped LSP/formatter/DAP runtime
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

- [Niri](https://github.com/YaLTeR/niri) — the scrollable-tiling Wayland compositor
- [Matugen](https://github.com/InioX/matugen) — Material You color extraction
- [Waybar Themes](https://github.com/HANCORE-linux/waybar-themes) — base waybar styling (tweaked with matugen colors)
- [Catppuccin](https://github.com/catppuccin) — color inspiration for fallback themes
- [Nixpkgs](https://github.com/NixOS/nixpkgs) — the package set that makes this possible
- [Home Manager](https://github.com/nix-community/home-manager) — declarative user config
- [Zen Kernel](https://github.com/zen-kernel/zen-kernel) — desktop-optimized Linux kernel
- All the maintainers of the tools and packages I use daily
