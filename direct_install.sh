#!/usr/bin/env bash
set -euo pipefail

# Uninstall system Rust and Cargo to avoid conflicts
echo "Removing system cargo and rustc (if present)..."
sudo apt remove -y cargo rustc || true

# Install rustup (official method)
echo "Installing rustup..."
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y

# Add rustup/cargo to PATH
export PATH="$HOME/.cargo/bin:$PATH"

# Load rustup environment immediately
source "$HOME/.cargo/env"

# Install and activate nightly Rust
echo "Installing Rust nightly..."
rustup install nightly
rustup default nightly

# Install dust with nightly Rust
echo "Installing dust with cargo..."
cargo install du-dust

# Install NVM (Node Version Manager)
echo "Installing nvm..."
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.7/install.sh | bash

# Load NVM immediately for the current session
export NVM_DIR="$HOME/.nvm"
# shellcheck disable=SC1091
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"

# Install atuin
echo "Installing atuin..."
bash <(curl https://raw.githubusercontent.com/atuinsh/atuin/main/install.sh)

# Install lazygit manually
echo "Installing lazygit..."
LAZYGIT_VERSION=$(curl -s https://api.github.com/repos/jesseduffield/lazygit/releases/latest \
    | grep '"tag_name":' | sed -E 's/.*"v([^"]+)".*/\1/')

curl -Lo lazygit.tar.gz "https://github.com/jesseduffield/lazygit/releases/latest/download/lazygit_${LAZYGIT_VERSION}_Linux_x86_64.tar.gz"
tar xf lazygit.tar.gz lazygit
sudo install lazygit /usr/local/bin
rm lazygit lazygit.tar.gz

# Install Docker from official repository
echo "Installing Docker..."
curl -fsSL https://get.docker.com -o get-docker.sh
sudo sh get-docker.sh
rm get-docker.sh

# Install Go (latest version)
echo "Installing latest Go..."
GO_VERSION=$(curl -s https://go.dev/VERSION?m=text)
curl -LO "https://go.dev/dl/${GO_VERSION}.linux-amd64.tar.gz"
sudo rm -rf /usr/local/go
sudo tar -C /usr/local -xzf "${GO_VERSION}.linux-amd64.tar.gz"
rm "${GO_VERSION}.linux-amd64.tar.gz"

# Add Go to PATH (for current session; add to shell config for persistence)
export PATH=$PATH:/usr/local/go/bin
echo "Go version: $(go version)"

echo "✅ All non-apt packages installed or attempted."

