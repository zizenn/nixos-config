# zizenn dotfiles

NixOS · Niri · Material You

My NixOS + home-manager config. Every `.nix` file in `modules/` is auto-imported — system stuff in `nixos.modules.base`, user stuff in `homeManager.modules.base`.

## What you get

- **Desktop** — Niri (scrollable tiling), Ly login, Waybar, Rofi, Mako, Kitty, Fish, Starship
- **Theming** — Material You colors from your wallpaper via `theme-wallpaper` (matugen), or static Kanagawa Dragon via `theme-kanagawa`
- **Editor** — Neovim with wrapped LSPs/formatters/DAP, plus Zed and Opencode
- **Dev** — git, jujutsu, lazygit, gh, cargo, devenv (C++ lives in devenv shells only)
- **Apps** — zen browser, firefox, obsidian, ollama, vesktop, vlc, yazi, zathura, ...
- **Extras** — zen kernel, `doas` (no sudo), auto-lock on sleep, USB-input resume fix

## Rebuild

```fish
os   # = nh os switch path:/home/zizenn/nixos  (system + home-manager)
```

The `path:` ref is important — it includes your gitignored `_personal/` modules. A bare path silently drops them.

## Install

```bash
git clone git@github.com:zizenn/nixos-config.git ~/nixos
cd ~/nixos
nixos-generate-config --show-hardware-config > modules/_hardware-configuration.nix
nixos-rebuild switch --flake ~/nixos#zizenn-hack
```

## Private stuff (`modules/_personal/`)

Anything in `modules/_personal/` is **gitignored** — local only, never pushed, but auto-imported like any other module. Perfect for personal apps (steam, kdenlive, obs, prismlauncher), secrets (aerc app password), and wallpapers. Just drop a `.nix` file in there. Run `nix flake check .` to see exactly what the repo looks like publicly.

## Packages

```fish
pkgadd   # search nixpkgs → fzf pick → add to a module → rebuild
pkgdel   # list installed → fzf pick → remove → rebuild
```

## Structure

```
modules/
├── *.nix            # one flake-parts module each (auto-imported)
├── _personal/       # 🔒 private — gitignored, never pushed
└── desktop/ theme/ services/ hardware/ audio/ infra/
```

## Keys

`SUPER+T` kitty · `ALT+Space` rofi · `SUPER+W` wallpaper · `SUPER+V` clipboard · `SUPER+O` obsidian · `SUPER+P` power menu · `SUPER+E` yazi · `SUPER+A` aerc · `SUPER+Q` close window · `SUPER+U` overview · `SUPER+SHIFT+S` screenshot
