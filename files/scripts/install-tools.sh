#!/usr/bin/env bash
set -oue pipefail

echo "=== Installing reproducible third-party tools ==="

TMP_DIR="$(mktemp -d)"
trap 'rm -rf "${TMP_DIR}"' EXIT

mkdir -p /usr/local/bin

# 1. Install lazygit (reproducible with sha256 verification)
LAZYGIT_VERSION="0.65.1"
LAZYGIT_SHA256="02beacbcda0fa342e50ae3480ba8147307353af3fb28e1d5f790e02329c201a6"
LAZYGIT_URL="https://github.com/jesseduffield/lazygit/releases/download/v${LAZYGIT_VERSION}/lazygit_${LAZYGIT_VERSION}_linux_x86_64.tar.gz"

echo "Downloading lazygit v${LAZYGIT_VERSION}..."
curl -sL "${LAZYGIT_URL}" -o "${TMP_DIR}/lazygit.tar.gz"
echo "${LAZYGIT_SHA256}  ${TMP_DIR}/lazygit.tar.gz" | sha256sum -c -
tar -xzf "${TMP_DIR}/lazygit.tar.gz" -C "${TMP_DIR}" lazygit
install -m 755 "${TMP_DIR}/lazygit" /usr/local/bin/lazygit

# 2. Install Bifrost (Samsung Firmware Downloader, reproducible with sha256 verification)
BIFROST_VERSION="2.1.4"
BIFROST_SHA256="c57fe8355b6e6d851900c7fb1487634eed062976c32dc1fe96c2c968765f3905"
BIFROST_URL="https://github.com/zacharee/Bifrost/releases/download/${BIFROST_VERSION}/bifrost-${BIFROST_VERSION}-linux-amd64.tar.gz"

echo "Downloading Bifrost v${BIFROST_VERSION}..."
curl -sL "${BIFROST_URL}" -o "${TMP_DIR}/bifrost.tar.gz"
echo "${BIFROST_SHA256}  ${TMP_DIR}/bifrost.tar.gz" | sha256sum -c -
mkdir -p /usr/lib/bifrost
tar -xzf "${TMP_DIR}/bifrost.tar.gz" -C /usr/lib/bifrost --strip-components=1
ln -sf /usr/lib/bifrost/bin/bifrost /usr/local/bin/bifrost

# 3. Install Odin4 (Samsung Flasher for Linux, reproducible with sha256 verification)
ODIN4_SHA256="ac1cd7fdf5330ab25c052da8646f9cd114fc88a5742cf84f5e960bbffcf106a4"
ODIN4_URL="https://github.com/MizProject/mizrepo/raw/refs/heads/main/aur/amd64/odin4-cli/odin4-cli-1.2.1.dc05e3ea.zip"

echo "Downloading Odin4..."
curl -sL "${ODIN4_URL}" -o "${TMP_DIR}/odin4.zip"
echo "${ODIN4_SHA256}  ${TMP_DIR}/odin4.zip" | sha256sum -c -
python3 -m zipfile -e "${TMP_DIR}/odin4.zip" "${TMP_DIR}"
install -m 755 "${TMP_DIR}/odin4" /usr/local/bin/odin4

echo "=== Successfully installed lazygit, Bifrost, and Odin4 ==="
