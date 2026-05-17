#!/usr/bin/env bash
set -euo pipefail

DOTFILES_REPO="https://github.com/EthanMarx/dotfiles.git"
DOTFILES_DIR="$HOME/dotfiles"

# --- helpers ---

info() { echo "[setup] $*"; }
warn() { echo "[setup] WARNING: $*" >&2; }

check_internet() {
    if ! ping -c1 -W3 archlinux.org &>/dev/null; then
        echo "[setup] ERROR: no internet connection" >&2
        exit 1
    fi
}

# --- guards ---

if [[ $EUID -eq 0 ]]; then
    echo "[setup] ERROR: do not run as root" >&2
    exit 1
fi

check_internet

# --- 1. bootstrap yay ---

if ! command -v yay &>/dev/null; then
    info "bootstrapping yay..."
    sudo pacman -S --needed --noconfirm base-devel git
    tmpdir=$(mktemp -d)
    git clone https://aur.archlinux.org/yay.git "$tmpdir/yay"
    (cd "$tmpdir/yay" && makepkg -si --noconfirm)
    rm -rf "$tmpdir"
    info "yay installed"
else
    info "yay already installed, skipping"
fi

# --- 2. clone dotfiles ---

if [[ ! -d "$DOTFILES_DIR" ]]; then
    info "cloning dotfiles..."
    git clone "$DOTFILES_REPO" "$DOTFILES_DIR"
else
    info "dotfiles already cloned, skipping"
fi

# --- 3. install packages ---

info "installing packages..."
yay -S --needed --noconfirm - < "$DOTFILES_DIR/packages.txt"

# --- 4. stow configs ---

info "stowing user configs..."
cd "$DOTFILES_DIR"

USER_CONFIGS=(fish nvim hypr waybar ghostty starship tmux opencode clang-format editorconfig gtk)
for pkg in "${USER_CONFIGS[@]}"; do
    stow --restow --target="$HOME" "$pkg"
    info "stowed $pkg"
done

info "stowing system configs..."
sudo stow --restow --target=/ system

# --- 5. enable systemd services ---

info "enabling system services..."
SYSTEM_SERVICES=(NetworkManager bluetooth greetd firewalld keyd cups reflector.timer)
for svc in "${SYSTEM_SERVICES[@]}"; do
    sudo systemctl enable --now "$svc" || warn "failed to enable $svc"
done

info "enabling user services..."
USER_SERVICES=(pipewire pipewire-pulse wireplumber)
for svc in "${USER_SERVICES[@]}"; do
    systemctl --user enable --now "$svc" || warn "failed to enable $svc"
done

# --- 6. set default shell ---

if [[ "$SHELL" != "/usr/bin/fish" ]]; then
    info "setting fish as default shell..."
    chsh -s /usr/bin/fish
else
    info "fish already default shell, skipping"
fi

info "setup complete. log out and back in for shell change to take effect."
