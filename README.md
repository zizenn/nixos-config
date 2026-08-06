<div align="center">
  <h1>zizenn dotfiles</h1>
  <p><i>NixOS · Niri · Material You</i></p>
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

- [Features](#-features)
- [Stack](#-stack)
- [Keybindings](#-keybindings)
- [Theming](#-theming)
- [Package Management](#-package-management)
- [Email](#-email)
- [Private Config](#-private-config)
- [Performance](#-performance)
- [Installation](#-installation)
- [Directory Structure](#-directory-structure)
- [Credits](#-credits)

---

## ✨ Features

- **Dynamic theming** — Material You colors extracted from the wallpaper via `matugen`, applied across the desktop in real-time
- **Kanagawa Dragon fallback** — Static theme via `theme-kanagawa`, works over SSH (no display needed)
- **Scrollable tiling** — Niri's column-based layout with horizontal scrolling between workspaces
- **AI-native** — Ollama serves local models (qwen3-coder) at startup; Opencode, Gemini CLI, and Neovim Copilot pre-configured
- **Auto-lock on sleep** — `swayidle` + `swaylock` locks the screen before suspend/hibernate, so you always wake to a locked session
- **Hibernation swapfile** — 16 GiB `/swapfile` managed declaratively; `systemctl hibernate` just works
- **Interactive package management** — `pkgadd` / `pkgdel` search nixpkgs through `fzf`, edit `modules/*.nix`, and rebuild with a git commit
- **Self-contained neovim** — LSPs, formatters, and DAP are wrapped into neovim's runtime only, not on global PATH
- **Performance-tuned kernel** — `linuxPackages_zen` with mitigations off, BBR congestion control, tuned page cache
- **USB input fix** — systemd service re-probes USB input devices after resume
- **BFQ scheduler** — external USB SSDs get BFQ I/O scheduling
- **No sudo** — `doas` exclusively
- **6-space indentation** — enforced everywhere by formatters and editor configs
- **Lightweight display manager** — Ly TUI greeter

---

## 🧰 Stack

### System

| Component | Choice |
|---|---|
| **Distribution** | [NixOS](https://nixos.org) (nixos-unstable) |
| **State Version** | 26.05 |
| **Hostname** | `zizenn-hack` |
| **Bootloader** | systemd-boot (limit 10 entries) |
| **Init** | systemd (systemd initrd) |
| **Display Manager** | [Ly](https://github.com/fairyglade/ly) (TUI) |
| **Kernel** | [linuxPackages_zen](https://github.com/zen-kernel/zen-kernel) |
| **GPU Driver** | amdgpu + mesa (open-source) |

### Desktop

| Component | Choice |
|---|---|
| **Compositor** | [Niri](https://github.com/YaLTeR/niri) (scrollable-tiling) |
| **Bar** | [Waybar](https://github.com/Alexays/Waybar) |
| **Launcher** | [Rofi](https://github.com/davatorium/rofi) (drun + clipboard + wallpaper) |
| **Notifications** | [Mako](https://github.com/emersion/mako) |
| **Lock Screen** | [Swaylock](https://github.com/swaywm/swaylock) |
| **Idle** | [Swayidle](https://github.com/swaywm/swayidle) (lock before sleep, DPMS on resume) |
| **Power Menu** | [Wleave](https://github.com/AMNatty/wleave) |
| **Wallpaper** | Awww daemon + `wallpaper-pick` script |
| **Clipboard** | [Cliphist](https://github.com/sentriz/cliphist) with rofi image preview |
| **Terminal** | [Kitty](https://github.com/kovidgoyal/kitty) (JetBrainsMono Nerd Font) |

### Shell

| Component | Choice |
|---|---|
| **Shell** | [Fish](https://fishshell.com) |
| **Prompt** | [Starship](https://starship.rs) (transient, vi-mode) |
| **Multiplexer** | [Herdr](https://github.com/quantonganh/herdr) |
| **File Manager** | [Yazi](https://yazi-rs.github.io) (terminal) |
| **CLI tools** | bat, eza, fd, ripgrep, fzf, zoxide, btop, ncdu, cava |

### Development

| Category | Tools |
|---|---|
| **Editor** | [Neovim](https://neovim.io) (lazy.nvim) wrapped with isolated LSP/formatter/DAP runtime + [Zed](https://zed.dev) |
| **AI** | [Ollama](https://ollama.com) (qwen3-coder), [Opencode](https://opencode.ai), Gemini CLI, GitHub Copilot |
| **Languages** | Node.js 26, Python 3, Rust (cargo), Java 21 |
| **C++** | Managed exclusively via `devenv` shells — no global gcc/cmake/gdb/lldb |
| **LSPs** | clangd, lua-language-server, typescript-language-server, pyright, nixd (neovim-only) |
| **Formatters** | stylua, prettier, autopep8, clang-format, nixfmt (neovim-only) |
| **Version Control** | Git + Jujutsu (lazygit / lazyjj) |
| **Nix** | nix-search-cli, `nh`, `devenv` |

### Applications

| Category | Apps |
|---|---|
| **Browser** | Zen Browser, Firefox |
| **Email** | [Aerc](https://aerc-mail.org) (terminal) + Gmail (IMAP/SMTP) |
| **Notes** | Obsidian |
| **Chat** | Vesktop (Discord) |
| **VPN** | Tailscale, Cloudflare WARP |
| **Media** | OBS Studio (VA-API), VLC, Kdenlive, Glaxnimate, Cava |
| **Productivity** | Pandoc, Zathura (PDF), Proton Mail/Pass |
| **Gaming** | Steam (gamescope session), Prism Launcher |
| **Other** | LocalSend, pavucontrol |

---

## ⌨ Keybindings

### Launch

| Keybind | Action |
|---|---|
| `SUPER + T` / `SUPER + Return` | Terminal (Kitty) |
| `ALT + Space` | App launcher (Rofi drun) |
| `SUPER + W` | Wallpaper picker |
| `SUPER + V` | Clipboard history (Cliphist + Rofi) |
| `SUPER + O` | Obsidian |
| `SUPER + P` | Power menu (wleave) |
| `SUPER + E` | File manager (Yazi in Kitty) |
| `SUPER + A` | Email (Aerc in Kitty) |
| `SUPER + U` | Toggle overview |
| `SUPER + ALT + L` | Lock (swaylock) |

### Windows

| Keybind | Action |
|---|---|
| `SUPER + Q` | Close window |
| `SUPER + G` | Toggle float |
| `SUPER + F` | Fullscreen |
| `SUPER + H / L` or `Left / Right` | Focus column left / right |
| `SUPER + K / J` | Focus window up / down |
| `SUPER + SHIFT + H / L` or `SUPER + CTRL + H / L` | Move column left / right |
| `SUPER + CTRL / SHIFT + Up / Down` | Move window up / down |
| `SUPER + SHIFT + K / J` or `SUPER + CTRL + K / J` | Move column to workspace |
| `SUPER + [ / ]` | Consume / expel window left / right |
| `SUPER + , / .` | Consume / expel from column |
| `SUPER + R` | Switch preset column width |
| `SUPER + MINUS / EQUAL` | Column width − / + |
| `SUPER + SHIFT + MINUS / EQUAL` | Window height − / + |
| `SUPER + C` | Center column |
| `SUPER + SHIFT + V` | Switch floating / tiling |
| `SUPER + 1–9` | Switch to workspace |
| `SUPER + SHIFT + 1–9` | Move window to workspace |
| `SUPER + ;` | Focus next monitor |

### System

| Keybind | Action |
|---|---|
| `SUPER + SHIFT + P` | Power off monitors |
| `SUPER + M` | Quit session |
| `SUPER + ESC` | Toggle keyboard-shortcuts inhibit |
| `SUPER + SHIFT + S` | Screenshot |
| `PRINT` | Screenshot |
| `CTRL / ALT + PRINT` | Screenshot screen / window |
| `XF86` media keys | Volume, mute, media playback, brightness (work while locked) |

---

## 🎨 Theming

### Dynamic (Material You)

Colors are extracted from the current wallpaper via [`matugen`](https://github.com/InioX/matugen). Templates generate themed files for:

- Kitty, Neovim, Zed
- Waybar, Mako, Wleave
- Rofi
- GTK3/4, Kvantum (Qt)
- Obsidian, Vesktop (Discord)
- Starship

Run `theme-wallpaper` → pick a wallpaper → everything updates instantly.

### Static (Kanagawa Dragon)

For SSH sessions or a fixed palette, run `theme-kanagawa` to apply pre-generated Kanagawa Dragon colors to all components.

### GTK / QT

| Component | Theme |
|---|---|
| **GTK** | Colloid-Dark (black, rimless) |
| **Icons** | Papirus-Dark |
| **Cursor** | Rose Pine |
| **QT** | Kvantum with matugen stylesheet |
| **Font** | JetBrainsMono Nerd Font (system-wide) |

---

## 📦 Package Management

```
pkgadd   # search nixpkgs → fzf pick → add to a module → commit → rebuild
pkgdel   # list current packages → fzf pick → remove → commit → rebuild
```

Both handle git commits and trigger a rebuild automatically. Put personal/private packages in `modules/_personal/` (gitignored) and public ones in the regular modules.

> **Note:** LSPs, formatters, and DAP debuggers are wrapped into neovim's runtime (not installed globally). C++ toolchains are managed through `devenv` shells.

---

## 📬 Email

Aerc is configured for Gmail over IMAP/SMTP using an app password (no OAuth, no age). This part of the config is private (in `modules/_personal/`):

1. Create a [Gmail app password](https://myaccount.google.com/apppasswords)
2. Store it in `modules/_personal/aerc/app-password` (one line, `chmod 600`) — read at runtime, never pushed
3. Aerc reads it via `source-cred-cmd = cat ~/nixos/modules/_personal/aerc/app-password`

Launch with `SUPER + A`.

---

## 🔒 Private Config

This repo is public, but parts of it are personal. Anything under `modules/_personal/` is **gitignored** — it lives only on this machine, is never pushed to GitHub, and is invisible to anyone cloning the repo. It's still auto-imported locally like any other module, so private apps and secrets work exactly like the public ones.

### What lives there

| Thing | Where |
|---|---|
| Personal apps (steam, droidcam, localsend, prismlauncher, kdenlive, obs, ...) | `modules/_personal/apps.nix`, `modules/_personal/programs.nix` |
| Email (aerc config + app password) | `modules/_personal/mail.nix`, `modules/_personal/aerc/` |
| Wallpapers (used by `wallpaper-pick`) | `modules/_personal/wallpapers/` |

### Adding your own private stuff

Drop any `.nix` file into `modules/_personal/` — same module syntax as everywhere else (`nixos.modules.base` for system options, `homeManager.modules.base` for user options). To add a secret, place the file in `_personal/` and read it **at runtime** (e.g. `cat ~/nixos/modules/_personal/aerc/app-password`). Never embed credentials in public modules — that's what `_personal/` is for.

### Why rebuilds need `path:`

`os` rebuilds the whole system (NixOS + home-manager, which runs as a NixOS module) with:

```fish
nh os switch path:/home/zizenn/nixos
```

The `path:` prefix tells Nix to include gitignored files. A bare path like `/home/zizenn/nixos` (or a stale `NH_FLAKE` env var) makes Nix filter the flake through git and **silently drop `_personal/`**. Fresh logins get the right value automatically from `programs.nh.flake`; if personal apps ever go missing after a rebuild, run the command above explicitly — it's the same alias `os`, just guaranteed to use `path:`.

> Verify what GitHub sees: `nix flake check .` evaluates the repo exactly as a fresh clone would — without `_personal/`.

---

## ⚡ Performance

| Tuning | Detail |
|---|---|
| **Kernel** | `linuxPackages_zen` — desktop-optimized scheduling |
| **Mitigations** | `mitigations=off` — disables CPU vulnerability mitigations |
| **Watchdog** | `nowatchdog` — frees a CPU core from NMI watchdog |
| **C-states** | `processor.max_cstate=1` — lower wake latency |
| **Network** | BBR congestion control + `fq` qdisc |
| **vm.swappiness** | 1 — only swap under extreme pressure |
| **vm.vfs_cache_pressure** | 50 — retain dentry/inode cache |
| **vm.dirty_ratio** | 10 — larger writeback buffer |
| **nix.max-jobs** | auto — all cores for builds |
| **nix.sandbox** | disabled — removes build overhead on personal machine |
| **nix.auto-optimise-store** | enabled — deduplicates store paths |
| **nix GC** | weekly, >7d — automatic garbage collection |
| **Boot entries** | 10 — limits systemd-boot menu clutter |

---

## 🚀 Installation

On a fresh NixOS:

```bash
# Clone the flake
git clone git@github.com:zizenn/nixos-config.git ~/nixos
cd ~/nixos

# Generate hardware config (adjust for your machine)
nixos-generate-config --show-hardware-config > modules/_hardware-configuration.nix

# Rebuild (system + home-manager, wired into the NixOS module)
nixos-rebuild switch --flake ~/nixos#zizenn-hack
# run as root (this setup uses doas; `sudo` is aliased to it in fish)
```

> **Note:** This config is a single-user setup (user `zizenn`, hostname `zizenn-hack`). Adjust `_hardware-configuration.nix` for your hardware.

> **Private modules:** `modules/_personal/` is gitignored, so a fresh clone has none of it. To use your own personal modules/secrets/wallpapers, recreate that folder locally (see [Private Config](#-private-config)) and rebuild with `nh os switch path:~/nixos`.

---

## 📁 Directory Structure

Every `.nix` file under `modules/` is a top-level flake-parts module, auto-imported by `outputs.nix`, contributing to `nixos.modules.base` (NixOS) and/or `homeManager.modules.base` (home-manager). Modules in `_personal/` are gitignored and only exist on your machine — clone this repo anywhere and it evaluates fine without them. Rebuilds use the `path:` flake ref (`programs.nh.flake`) so those private modules are included locally.

```
/
├── flake.nix                     # Flake entrypoint
├── outputs.nix                   # flake-parts evaluation, auto-imports modules/*.nix
├── AGENTS.md                     # Agent instructions
├── modules/
│   ├── _hardware-configuration.nix  # auto-generated (excluded from auto-import)
│   ├── nix-port.nix              # Host wiring: nixos.modules.base + homeManager.modules.base → lib.nixosSystem
│   ├── boot.nix                  # systemd-boot, zen kernel, sysctl tuning
│   ├── locale.nix                # Timezone, state version
│   ├── networking.nix            # Hostname, NetworkManager, firewall
│   ├── nix.nix                   # GC, optimise, parallel builds, caches
│   ├── security.nix              # doas, allowUnfree
│   ├── programs.nix              # fish, firefox, nh, fonts, system packages, user
│   ├── editors.nix               # Neovim (+ wrapped LSP/formatter/DAP), Zed, Opencode
│   ├── dev.nix                   # Git, Jujutsu, gh, lazygit, devenv, cargo
│   ├── shell.nix                 # Fish aliases, Starship, fzf, zoxide, CLI tools
│   ├── apps.nix                  # Yazi, obsidian, ollama, vlc, vesktop, zen-browser, ...
│   ├── misc.nix                  # Env vars, MIME defaults, pkgadd/pkgdel
│   ├── swap.nix                  # 16 GiB swapfile + hibernation
│   ├── _personal/                # 🔒 private modules (gitignored, not pushed)
│   │   ├── apps.nix              #   personal apps: steam, kdenlive, obs, prismlauncher, ...
│   │   ├── programs.nix          #   droidcam, localsend, steam (system modules)
│   │   ├── mail.nix + aerc/      #   aerc config + app password (mode 600)
│   │   └── wallpapers/           #   wallpaper images (wallpaper-pick reads from here)
│   ├── infra/                    # flake-parts infrastructure (option declarations)
│   ├── audio/                    # PipeWire
│   ├── hardware/                 # amdgpu, Bluetooth
│   ├── services/                 # SSH, logind, udev, USB-resume, Tailscale, misc
│   ├── desktop/                  # Niri (config.kdl), portals, kitty, mako, waybar, rofi, wleave, wallpaper
│   └── theme/                    # GTK, Qt/Kvantum, matugen, kanagawa-dragon, fastfetch
```

---

## 🙏 Credits

- [Niri](https://github.com/YaLTeR/niri) — the scrollable-tiling Wayland compositor
- [Matugen](https://github.com/InioX/matugen) — Material You color extraction
- [Nixpkgs](https://github.com/NixOS/nixpkgs) — the package set
- [Home Manager](https://github.com/nix-community/home-manager) — declarative user config
- [Zen Kernel](https://github.com/zen-kernel/zen-kernel) — desktop-optimized Linux kernel
- All the maintainers of the tools and packages I use daily
