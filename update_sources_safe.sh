#!/bin/bash

# === Mahmoud's Linux Mint Source Fixer ===
# Author: Mahmoud.Wizzo@gmail.com

SOURCE_FILE="/etc/apt/sources.list.d/official-package-repositories.list"
BACKUP_FILE="${SOURCE_FILE}.bak"
LOG_FILE="/tmp/apt-update.log"

print_header() {
  echo
  echo "=============================="
  echo "  Linux Mint Source Updater"
  echo "=============================="
  echo
}

print_success() {
  echo
  echo "✅ All done!"
  echo "Your sources have been successfully updated and 'apt update' ran without connection issues."
  echo
  echo "Thanks for using this script."
  echo "Credits: Mahmoud.Wizzo@gmail.com"
  echo "Goodbye! 👋"
}

print_failure() {
  echo
  echo "❌ Something went wrong!"
  echo "Restoring your original sources..."
  sudo cp "$BACKUP_FILE" "$SOURCE_FILE"
  echo "✅ Backup restored."
  echo
  echo "Please check your network or sources."
  echo "If the problem persists, contact Mahmoud.Wizzo@gmail.com for help."
  exit 1
}

print_header

# Check if source file exists
if [ ! -f "$SOURCE_FILE" ]; then
  echo "❌ Error: Source file '$SOURCE_FILE' does not exist."
  echo "Aborting..."
  exit 1
fi

# Create a backup
echo "📦 Creating backup of the original source list..."
if ! sudo cp "$SOURCE_FILE" "$BACKUP_FILE"; then
  echo "❌ Failed to create backup. Aborting."
  exit 1
fi
echo "✅ Backup saved to $BACKUP_FILE"

# Overwrite the file
echo "🛠️  Updating the source list with new values..."
if ! sudo bash -c "cat > $SOURCE_FILE" <<EOF
deb https://mirror.server.net/linuxmint/packages xia main upstream import backport 

deb https://archive.ubuntu.com/ubuntu noble main restricted universe multiverse
deb https://archive.ubuntu.com/ubuntu noble-updates main restricted universe multiverse
deb https://archive.ubuntu.com/ubuntu noble-backports main restricted universe multiverse

deb http://security.ubuntu.com/ubuntu/ noble-security main restricted universe multiverse
EOF
then
  print_failure
fi
echo "✅ Source list updated."

# Run apt update and log output
echo "🌐 Running 'sudo apt update'..."
if ! sudo apt update | tee "$LOG_FILE"; then
  echo "❌ 'apt update' failed to run properly."
  print_failure
fi

# Check for connection errors in log
if grep -Ei "failed|temporary failure|could not resolve|error" "$LOG_FILE" > /dev/null; then
  echo "⚠️  Connection issues detected in apt output."
  print_failure
fi

print_success
