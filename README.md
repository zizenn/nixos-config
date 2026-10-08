# zizenn dotfiles

NixOS · Hyprland / Niri · Noctalia

My NixOS + home-manager config. Plain flake, plain modules — no frameworks.

## What you get

- **Desktop** — Hyprland + Niri (pick at login), Ly login, Noctalia shell, Kitty, Fish, Starship
- **Theming** — Noctalia owns it all (`theme-wallpaper` from wallpaper, or `theme-kanagawa` for Kanagawa)
- **Editor** — Neovim with wrapped LSPs/formatters/DAP, plus Zed and Opencode
- **Dev** — git, jujutsu, lazygit, gh, cargo, devenv (C++ lives in devenv shells only)
- **Apps** — zen browser, firefox, obsidian, ollama, vesktop, vlc, yazi, zathura, ...
- **Extras** — zen kernel, `doas` (no sudo), USB-input resume fix

## Rebuild

```fish
os   # = nh os switch path:/home/zizenn/nixos  (system + home-manager)
```

The `path:` ref is important — it includes your gitignored `_personal/` modules. A bare path silently drops them.

## Install

```bash
git clone git@github.com:zizenn/nixos-config.git ~/nixos
cd ~/nixos
nixos-generate-config --show-hardware-config > hardware-configuration.nix
nixos-rebuild switch --flake ~/nixos#zizenn-hack
```

## Private stuff (`modules/_personal/`)

Anything in `modules/_personal/` is **gitignored** — local only, never pushed, but imported like any other module. Perfect for personal apps (steam, kdenlive, obs, prismlauncher), secrets (aerc app password), and wallpapers. Just drop a `.nix` file in there and add it to `modules/_personal/default.nix`. Run `nix flake check path:.` to see exactly what the repo looks like publicly.

## Structure

```
flake.nix                  # inputs + nixosConfigurations.zizenn-hack
configuration.nix          # hardware + home-manager + base.nix
base.nix                   # imports every modules/ folder
hardware-configuration.nix # generated, don't edit by hand
modules/
├── apps/apps.nix          # plain NixOS modules — system options at the
├── audio/pipewire.nix     #   top level, user options under
├── boot/boot.nix          #   home-manager.users.zizenn
├── desktop/               #   (hyprland, kitty, niri, noctalia, portals, wallpaper)
├── ...                    #   dev, editors, hardware, locale, misc,
└── _personal/             # 🔒 private — gitignored, never pushed
```

To add a module: write a plain NixOS module under `modules/`, import it in the folder's `default.nix`, rebuild.

## Keys

`SUPER+T` kitty · `ALT+Space` launcher · `SUPER+W` wallpaper · `SUPER+V` clipboard · `SUPER+O` obsidian · `SUPER+P` power menu · `SUPER+E` yazi · `SUPER+A` aerc · `SUPER+Q` close window · `SUPER+U` overview · `SUPER+SHIFT+S` screenshot
