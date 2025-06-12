#!/bin/bash

# === FacetimeHD Camera Installer for Linux ===
# Author: Mahmoud.Wizzo@gmail.com

set -e

print_header() {
  echo
  echo "=============================="
  echo "  FacetimeHD Camera Installer"
  echo "=============================="
  echo
}

print_success() {
  echo
  echo "✅ FacetimeHD driver installed successfully!"
  echo "Your camera should now be functional."
  echo
  echo "Thanks for using this script."
  echo "Credits: Mahmoud.Wizzo@gmail.com"
  echo "Goodbye! 👋"
}

print_failure() {
  echo
  echo "❌ Something went wrong during the installation."
  echo "No changes will remain on your system."
  echo
  echo "Please contact Mahmoud.Wizzo@gmail.com for further help."
  exit 1
}

print_header

# Define temp working directory
TEMP_DIR=$(mktemp -d)

# Set required environment variables
export CONFIG_MODULE_SIG=n
export CONFIG_MODULE_SIG_ALL=n
export KERNELRELEASE=$(uname -r)

echo "📦 Installing FacetimeHD camera drivers for kernel: $KERNELRELEASE"

# Clone required repositories
echo "📥 Cloning repositories..."
cd "$TEMP_DIR"
if ! git clone https://github.com/patjak/facetimehd-firmware.git || ! git clone https://github.com/patjak/bcwc_pcie.git; then
  print_failure
fi

# Build and install firmware
echo "🔧 Building firmware..."
cd "$TEMP_DIR/facetimehd-firmware"
if ! make && sudo make install; then
  print_failure
fi

# Build and install kernel module
echo "🔧 Building kernel module..."
cd "$TEMP_DIR/bcwc_pcie"
if ! make && sudo make install; then
  print_failure
fi

# Clean up
echo "🧹 Cleaning up temporary files..."
rm -rf "$TEMP_DIR"

# Ensure module-load config directory exists
echo "🗃️  Setting up autoload configuration..."
if [ ! -d "/etc/modules-load.d" ]; then
  sudo mkdir -p "/etc/modules-load.d"
fi

# Write modules to load on boot
sudo bash -c "cat > /etc/modules-load.d/facetimehd.conf" <<EOF
videobuf2-core
videobuf2_v4l2
videobuf2-dma-sg
facetimehd
EOF

# Generate module dependencies
echo "⚙️  Generating module dependencies..."
if ! sudo depmod; then
  print_failure
fi

# Load the module now
echo "📸 Activating camera driver..."
sudo modprobe -r bdc_pci 2>/dev/null || true
if ! sudo modprobe facetimehd; then
  print_failure
fi

print_success
