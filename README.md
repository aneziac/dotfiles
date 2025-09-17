# Dotfiles

Current machines:
- Early 2020 Macbook Air
- 2022 HP Omen (dual booting Mint and Arch)

To do
- Include p10k in nix

Build steps on new machine:
- Install git, nix, chezmoi
- Clone dotfiles
- chezmoi apply
- Nix home manager switch

```zsh
nix run home-manager/master -- switch --flake .#linux
```

afterwards
```zsh
home-manager switch --flake .#linux
```
NIX_CONFIG="experimental-features = nix-command flakes" nix run home-manager/master -- switch --flake .#linux
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ~/.local/share/powerlevel10k

