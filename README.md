# Dotfiles

Current machines:

- Early 2020 Macbook Air
- 2022 HP Omen (dual booting Mint and Arch)

Setup steps on new machine:

1. Copy `age` key from existing machine via:
    - `hostname -I` - identify IP address on target machine
    - `mkdir -p ~/.config/chezmoi` on target machine
    - `scp ~/.config/chezmoi/key.txt user@target-machine-ip:~/.config/chezmoi/key.txt`

2. Clone dotfiles with

    ```zsh
    sh -c "$(curl -fsLS get.chezmoi.io)" -- init --apply aneziac
    ```

3. `cd` into `nix-config` and run

    ```zsh
    sh <(curl --proto '=https' --tlsv1.2 -L https://nixos.org/nix/install) --daemon
    ```

    (remove --daemon for MacOS) to install nix, then

    ```zsh
    nix run home-manager/master -- switch --flake .#linux
    ```

    Note after this initial setup, future runs can use just

    ```zsh
    home-manager switch --flake .#linux
    ```

    where in both cases replace `linux` with `macos` as needed.
    This installs all base packages and sets up `zsh`.

4. Now that you can decrypt the `.ssh` GH private key, apply and change the chezmoi remote to use ssh:

    ```zsh
    chezmoi apply
    git remote set-url origin git@github.com:aneziac/dotfiles.git
    ```

TO DO

- View previous revisions of file in nvim
