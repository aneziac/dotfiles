#!/usr/bin/env bash
set -euo pipefail

# Uninstall system Rust and Cargo to avoid conflicts
echo "Removing system cargo and rustc (if present)..."
sudo apt remove -y cargo rustc || true

# Install rustup (if not already installed)
if ! command -v rustup >/dev/null 2>&1; then
  echo "Installing rustup..."
  curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y
else
  echo "rustup already installed, skipping..."
fi

# Add rustup/cargo to PATH
export PATH="$HOME/.cargo/bin:$PATH"
source "$HOME/.cargo/env"

# Install and activate nightly Rust
if ! rustup show | grep -q 'default.*nightly'; then
  echo "Installing and activating Rust nightly..."
  rustup install nightly
  rustup default nightly
else
  echo "Rust nightly already set as default, skipping..."
fi

# Install dust if not already present
if ! command -v dust >/dev/null 2>&1; then
  echo "Installing dust with cargo..."
  cargo install du-dust
else
  echo "dust already installed, skipping..."
fi

# Install eza if not already present
if ! command -v eza >/dev/null 2>&1; then
  echo "Installing eza with cargo..."
  cargo install eza
else
  echo "eza already installed, skipping..."
fi

# Install NVM and ensure Node.js 20+ is installed
if [[ ! -d "$HOME/.nvm" ]]; then
  echo "Installing nvm..."
  curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.7/install.sh | bash
else
  echo "nvm already installed, skipping..."
fi

# Load NVM for current session
export NVM_DIR="$HOME/.nvm"
# shellcheck disable=SC1091
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"

# Install Node.js 20.x via nvm and set as default
if ! command -v node >/dev/null 2>&1 || [[ "$(node -v | cut -d. -f1 | tr -d 'v')" -lt 20 ]]; then
  echo "Installing Node.js 20 via nvm..."
  nvm install 20
  nvm alias default 20
  nvm use 20
else
  echo "Node.js 20+ already installed via nvm, skipping..."
fi

# Install atuin
if ! command -v atuin >/dev/null 2>&1; then
  echo "Installing atuin..."
  bash <(curl https://raw.githubusercontent.com/atuinsh/atuin/main/install.sh)
else
  echo "atuin already installed, skipping..."
fi

# Install lazygit manually
if ! command -v lazygit >/dev/null 2>&1; then
  echo "Installing lazygit..."
  LAZYGIT_VERSION=$(curl -s https://api.github.com/repos/jesseduffield/lazygit/releases/latest \
      | grep '"tag_name":' | sed -E 's/.*"v([^"]+)".*/\1/')
  curl -Lo lazygit.tar.gz "https://github.com/jesseduffield/lazygit/releases/latest/download/lazygit_${LAZYGIT_VERSION}_Linux_x86_64.tar.gz"
  tar xf lazygit.tar.gz lazygit
  sudo install lazygit /usr/local/bin
  rm lazygit lazygit.tar.gz
else
  echo "lazygit already installed, skipping..."
fi

# Install Docker
if ! command -v docker >/dev/null 2>&1; then
  echo "Installing Docker..."
  curl -fsSL https://get.docker.com -o get-docker.sh
  sudo sh get-docker.sh
  rm get-docker.sh
else
  echo "Docker already installed, skipping..."
fi

# Install Go (latest version)
if ! command -v go >/dev/null 2>&1; then
  echo "Installing latest Go..."
  GO_VERSION=$(curl -s https://go.dev/VERSION?m=text)
  curl -LO "https://go.dev/dl/${GO_VERSION}.linux-amd64.tar.gz"
  sudo rm -rf /usr/local/go
  sudo tar -C /usr/local -xzf "${GO_VERSION}.linux-amd64.tar.gz"
  rm "${GO_VERSION}.linux-amd64.tar.gz"
else
  echo "Go already installed, skipping..."
fi

# Add Go to PATH (for current session; for persistence add to .zshrc or .bashrc)
export PATH=$PATH:/usr/local/go/bin
echo "Go version: $(go version)"

# Install Neovim v0.11.2 AppImage explicitly
if ! command -v nvim >/dev/null 2>&1 || ! nvim --version | grep -q 'NVIM v0\.11\.2'; then
  echo "Installing Neovim v0.11.2 AppImage..."
  mkdir -p ~/.local/bin
  curl -Lo ~/.local/bin/nvim \
    https://github.com/neovim/neovim/releases/download/v0.11.2/nvim-linux-x86_64.appimage
  chmod u+x ~/.local/bin/nvim

  # Verify
  if ~/.local/bin/nvim --version | grep -q 'NVIM v0\.11\.2'; then
    echo "✅ Neovim v0.11.2 installed."
  else
    echo "❌ Failed to install Neovim v0.11.2, please check."
    exit 1
  fi
else
  echo "Neovim v0.11.2 already installed, skipping..."
fi

