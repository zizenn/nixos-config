# NixOS Config — `zizenn/nixos-config`

## Quick reference

| Context | Value |
|---|---|
| Hostname | `nix-port` |
| User | `zizenn` |
| Git remote | `origin git@github.com:zizenn/nixos-config.git` |
| Git identity | `sakif` <zizenn@proton.me> |
| Default editor | `nvim` (`vi`/`vim` aliased) |
| State version | `26.05` |
| Platform | `x86_64-linux` (AMD, bare metal) |

## Essential commands

```sh
nh os switch             # rebuild everything (system + home-manager) (alias: os)
doas <cmd>               # privilege escalation (sudo is disabled)
conf                     # alias: cd ~/nixos
theme-wallpaper          # matugen from wallpaper (interactive fzf picker)
theme-kanagawa           # apply kanagawa dragon palette (works via SSH)
```

## Structure (dendritic pattern)

Every `.nix` file under `modules/` is a top-level flake-parts module (auto-imported by `outputs.nix`), contributing to `nixos.modules.base` (NixOS) and/or `homeManager.modules.base` (home-manager). The directory tree is purely organizational — each `.nix` file is independent regardless of location.

```
/
├── flake.nix                       # flake entrypoint → outputs.nix
├── outputs.nix                     # flake-parts evaluation, auto-imports all .nix from modules/
├── AGENTS.md
├── modules/
│   ├── _hardware-configuration.nix # auto-generated, excluded from auto-import (_ prefix)
│   ├── nix-port.nix                # host config: wires nixos.modules.base + homeManager.modules.base into lib.nixosSystem
│   │
│   ├── infra/                      # flake-parts infrastructure (option declarations)
│   │   ├── nixos.nix               # declares nixos.modules option (lazyAttrsOf deferredModule)
│   │   └── home-manager.nix        # declares homeManager.modules option + programs.home-manager.enable
│   │
│   ├── boot.nix                    # systemd-boot, zen kernel, sysctl, mitigations=off
│   ├── locale.nix                  # timezone, stateVersion
│   ├── networking.nix              # hostName, networkmanager, firewall
│   ├── nix.nix                     # GC, optimise, experimental-features, max-jobs
│   ├── security.nix                # doas (no sudo), allowUnfree
│   ├── programs.nix                # fish, firefox, nh, fonts, system packages, user definition
│   ├── editors.nix                 # neovim (+runtimePackages), zed, opencode, .clang-format
│   ├── dev.nix                     # git, jujutsu, gh, lazygit, devenv, cargo
│   ├── shell.nix                   # fish aliases, starship, fzf, zoxide, cli tools
│   ├── apps.nix                    # yazi, obsidian, ollama, vlc, vesktop, zen-browser, ...
│   ├── misc.nix                    # env vars, MIME defaults, pkgadd/pkgdel scripts
│   │
│   ├── _personal/                  # 🔒 PRIVATE — gitignored, never pushed to GitHub
│   │   ├── apps.nix                #   prismlauncher, obs-studio, kdenlive, glaxnimate, proton*
│   │   ├── programs.nix            #   steam, droidcam, localsend
│   │   ├── mail.nix                #   aerc config, binds, accounts (mode 600)
│   │   ├── aerc/app-password       #   🔑 aerc credentials (read at runtime, mode 600)
│   │   └── wallpapers/             #   wallpaper images (wallpaper-pick reads from here)
│   │
│   ├── audio/
│   │   └── pipewire.nix            # pipewire, pulse, wireplumber
│   ├── hardware/
│   │   ├── gpu.nix                 # amdgpu, mesa
│   │   └── bluetooth.nix           # bluetooth enable
│   ├── services/
│   │   ├── ssh.nix                 # openssh
│   │   ├── logind.nix              # power/lid switch
│   │   ├── udev.nix                # USB power control, BFQ rules
│   │   ├── usb-resume.nix          # fix USB input after resume
│   │   ├── tailscale.nix           # tailscale
│   │   └── misc.nix                # upower, blueman, udisks2, fstrim, kmscon
│   ├── desktop/
│   │   ├── niri.nix                # Niri compositor (system) + Ly + swayidle/swaylock (HM)
│   │   ├── portals.nix             # xdg-desktop-portal
│   │   ├── kitty.nix               # kitty terminal
│   │   ├── mako.nix                # notifications
│   │   ├── waybar.nix              # waybar bar
│   │   ├── rofi.nix                # rofi launcher
│   │   ├── wleave.nix              # wleave logout
│   │   └── wallpaper.nix           # wallpaper-pick, theme-wallpaper scripts
│   ├── theme/
│   │   ├── gtk.nix                 # GTK theme, icons, cursor
│   │   ├── qt.nix                  # Qt/Kvantum theme
│   │   ├── matugen.nix             # matugen CLI + template symlinks
│   │   ├── kanagawa-dragon.nix     # static kanagawa-dragon palette files
│   │   └── fastfetch.nix           # fastfetch config
│   │
│   └── (supporting files: niri/*.kdl, waybar/*.jsonc, rofi/*.rasi, wleave/*.json,
│        neovim/nvim/, _personal/aerc/*.conf, zed/tasks.json, matugen/templates/,
│        kanagawa-dragon/*, core/scripts/, gtk/*.css, qt/*, fastfetch/*.jsonc)
```

## Conventions

- `doas` replaces `sudo` everywhere (`security.nix`)
- `nh` replaces raw `nixos-rebuild` / `home-manager` — flake ref is baked into `programs.nh.flake` as `path:/home/zizenn/nixos` (the `path:` ref makes local builds include gitignored `_personal/` files; a bare `.` ref would exclude them via git filtering)
- **`_personal/` is private**: any `.nix` file under `modules/_personal/` is gitignored (`.gitignore`), never pushed to GitHub, but auto-imported locally like any other module. Never commit secrets or personal apps outside it. To check what the public repo sees, evaluate with a bare ref (`nix flake check .`)
- `hardware-configuration.nix` is regenerated by `nixos-generate-config` — make changes in `configuration.nix` instead
- Nixpkgs tracks `nixos-unstable`; home-manager tracks `master` (stable releases pin-point via flake.lock)
- `system.stateVersion` and `home.stateVersion` remain at `26.05`
- Theme generation: matugen templates live in `modules/theme/matugen/templates/`, static kanagawa-dragon outputs in `modules/theme/kanagawa-dragon/`
- Theme switching: `theme-wallpaper` (runs matugen from wallpaper → Material You) or `theme-kanagawa` (applies static kanagawa-dragon palette)
- Desktop: Niri compositor; login via `services.ly` (TUI display manager)
- `xdg.configFile` is the standard mechanism for symlinking dotfile directories (avoid manual symlinks)
- **neovim is self-contained**: LSPs, formatters, and DAP are wrapped into neovim's runtime environment — they are NOT on the global PATH. Only accessible when `nvim` runs.
- **C++ development uses `devenv`**: gcc, cmake, gdb, lldb, make are NOT in home packages. Use `devenv` shells for C++ projects. ccache is configured via nix.
- Indentation: 6 spaces globally (`shiftwidth=6`, `tabstop=6`, `softtabstop=6`), enforced by formatters (stylua, prettier, autopep8, clang-format with `--indent-width 6` / `--tab-width 6` / etc.)
- clangd is provided by the Nix `clang-tools` package, not Mason.
- `documentation.doc.enable = false` and `documentation.nixos.enable = false` — man pages are kept; HTML/info docs are not built.

## Performance tuning

| Setting | Value | Benefit |
|---|---|---|
| Kernel | `linuxPackages_zen` | Desktop-optimized scheduling and latency |
| Kernel params | `mitigations=off`, `nowatchdog`, `processor.max_cstate=1` | Disables CPU vuln mitigations, watchdog timers, deep C-states |
| TCP congestion | `bbr` + `fq` qdisc | Faster throughput on high-latency links |
| vm.swappiness | 1 | Only swap under extreme memory pressure |
| vm.vfs_cache_pressure | 50 | Keep page cache longer |
| vm.dirty_ratio | 10 | Larger writeback cache for async I/O |
| nix.max-jobs | auto | Use all CPU cores for builds |
| nix.cores | 0 | Each build uses all available cores |
| nix.sandbox | false | Build speed — safe on personal machine |
| nix.auto-optimise-store | true | Deduplicate store paths automatically |
| nix.gc | weekly, >7d | Automatic garbage collection |
| boot.configurationLimit | 10 | Keep only 10 boot entries |

## Key files & locations

| What | Where |
|---|---|
| System packages | `modules/programs.nix` → `environment.systemPackages` |
| User packages | `modules/apps.nix` + `modules/misc.nix` + per-feature modules (e.g. `editors.nix`, `shell.nix`) |
| `allowUnfree` | set in both `modules/security.nix` and `modules/infra/home-manager.nix` |
| Niri config (KDL) | `modules/desktop/niri.nix` → `./niri/*.kdl` → `~/.config/niri/config.kdl` |
| Idle/lock (swayidle) | `modules/desktop/niri/04-main.kdl` → `spawn-at-startup "swayidle" ...` |
| Swaylock config | `modules/desktop/niri.nix` → `programs.swaylock.settings` → `~/.config/swaylock/config` |
| Login manager (Ly) | `modules/desktop/niri.nix` → `services.ly` |
| Neovim | `modules/editors.nix` → `./neovim/nvim/` (symlinked to `~/.config/nvim`) |
| Neovim runtime deps | `modules/editors.nix` → `neovimRuntimePackages` (LSPs, formatters, DAP) |
| udev rules | `modules/services/udev.nix` → `services.udev.extraRules` |
| USB input resume fix | `modules/services/usb-resume.nix` → `systemd.services.fix-usb-input-after-resume` |
| Systemd services | `modules/services/misc.nix` |
| Nix tuning | `modules/nix.nix` — GC, optimise, parallel builds, caches |
| Kernel tuning | `modules/boot.nix` — zen kernel, sysctl, mitigations off |

## Testing / verification

After any `.nix` change, run:

```sh
nh os switch          # rebuilds both NixOS + home-manager (alias: os)
```

There are no CI tests, formatters, or linters configured in this repo. Nix evaluation catches most errors at build time.

## Post

After each block of change, commit to git with a proper description.
