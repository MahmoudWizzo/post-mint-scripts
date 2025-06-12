# post-mint-scripts

Created for **ScreenShare UK** ([screen-share.co.uk](https://www.screen-share.co.uk/)) and maintained by [MW](mailto:Mahmoud.Wizzo@gmail.com), this repository provides essential post-installation scripts to enhance Linux Mint on **Apple MacBook Intel devices**.

These scripts are designed to **fix common hardware issues** and ensure **reliable system updates** — all with friendly prompts, backups, and automatic rollback if anything goes wrong.

---

## 📜 Available Scripts (more to be added)

### 1. `update_sources_safe.sh`  
Safely replaces your system's APT sources with official, up-to-date mirrors for Linux Mint and Ubuntu.

#### ✅ What it does:
- Backs up your current sources
- Replaces them with official mirrors
- Runs `sudo apt update` and checks for errors
- Automatically restores the backup if it fails

#### ▶️ One-line command to run:
```bash
bash <(curl -s https://raw.githubusercontent.com/MahmoudWizzo/post-mint-scripts/main/update_sources_safe.sh)
```

### 2. `update_sources_safe.sh`  

Automatically installs and activates the FaceTimeHD camera (used in MacBooks) on Linux Mint.

#### ✅ What it does:
 - Downloads & installs required firmware

 - Builds and installs kernel modules

 - Loads the camera driver immediately

 - Enables it to load on every boot

#### ▶️ One-line command to run:
```bash
bash <(curl -s https://raw.githubusercontent.com/MahmoudWizzo/post-mint-scripts/main/fix_apple_camera.sh)

```

### ✅ Requirements
- You are using ***Linux Mint*** on an ***Intel-based Apple MacBook***

- You have an ***internet connection***

- The script may prompt for your password (for sudo commands)


### 🙌 Credits
## Scripts created  with ❤️ for the ScreenShare Community .

### ⚠️ Disclaimer
#### These scripts are provided as-is. Always review the code before running it.
