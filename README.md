# 🍣 sushiTool - Steam Version Switcher

![Version](https://img.shields.io/badge/version-2.0-blue.svg)
![Platform](https://img.shields.io/badge/platform-Windows-lightgrey.svg)
![PowerShell](https://img.shields.io/badge/PowerShell-5.1+-green.svg)
![License](https://img.shields.io/badge/license-MIT-orange.svg)

Complete Steam management tool with deep registry cleanup and version switching capabilities. Switch between Steam 32-bit and 64-bit versions seamlessly, or perform a complete deep clean reinstall.

## ⚡ Quick Install (One-Liner)

**Open PowerShell as Administrator and run:**

```powershell
irm https://raw.githubusercontent.com/usercat280297/sushiTool-Steam-Downgrader/main/sushiToolSteamDowngrader.ps1 | iex
```

## ✨ Features

### 🔄 **[1] Downgrade to Steam 32-bit (x86)**
- Install Steam 32-bit for maximum compatibility
- Perfect for older mods, tools, and legacy games
- Automatic backup of existing configuration
- Creates steam.cfg to prevent auto-updates

### ⬆️ **[2] Upgrade to Steam 64-bit (x64)**
- Install latest Steam 64-bit client
- Better performance on modern systems
- Supports newer features and improvements
- Automatic fallback if primary method fails

### 🧹 **[3] Complete Deep Clean Reinstall**
- ✅ **Automatic .lua files backup** to Desktop
- ✅ **Kill all Steam processes** (including services)
- ✅ **Complete Steam uninstall**
- ✅ **DEEP CLEAN registry** (removes ALL Steam traces)
- ✅ **Remove Steam firewall rules**
- ✅ **Fresh Steam installation** from official sources
- ✅ **Game files preserved** (when possible)

## 📸 Screenshots

### Main Menu
```
===============================================================

           /$$$$$$                      /$$       /$$
          /$$__  $$                    | $$      |__/
         | $$  \__/ /$$   /$$  /$$$$$$$$| $$$$$$$$  /$$
         |  $$$$$$ | $$  | $$ /$$_____/| $$__  $$| $$
          \____  $$| $$  | $$|  $$$$$$ | $$  \ $$| $$
          /$$  \ $$| $$  | $$ \____  $$| $$  | $$| $$
         |  $$$$$$/|  $$$$$$/ /$$$$$$$/| $$  | $$| $$
          \______/  \______/ |_______/ |__/  |__/|__/

                Steam Version Switcher

          Discord: https://discord.gg/Ks9Ssgem

===============================================================

  Please select an option:

  [1] Downgrade to Steam 32-bit (x86)
  [2] Upgrade to Steam 64-bit (x64)
  [3] Complete Reinstall (Clean Install - Requires Re-login)
  [4] Exit

===============================================================
```

## 📋 System Requirements

- **OS:** Windows 10/11 (64-bit or 32-bit)
- **PowerShell:** Version 5.1 or higher
- **Privileges:** Administrator rights required
- **Disk Space:** At least 1GB free space
- **Internet:** Active connection for downloads

## 🚀 Installation Methods

### Method 1: One-Liner (Recommended)

1. Right-click **PowerShell** → Select **"Run as Administrator"**
2. Copy and paste this command:
   ```powershell
   irm https://raw.githubusercontent.com/usercat280297/sushiTool-Steam-Downgrader/main/sushiToolSteamDowngrader.ps1 | iex
   ```
3. Press **Enter**
4. Select your desired option

### Method 2: Download and Run

1. Download `sushiToolSteamDowngrader.ps1`
2. Right-click the file → **"Run with PowerShell"**
3. If prompted, click **"Yes"** to run as Administrator

### Method 3: Batch File (Legacy)

1. Download `sushiTool Steam Downgrader.bat`
2. Right-click → **"Run as administrator"**
3. Follow the on-screen menu

## 📖 Detailed Usage Guide

### Option 1: Downgrade to 32-bit

**When to use:**
- Running older mods or tools that require 32-bit
- Experiencing issues with 64-bit version
- Need better compatibility with legacy games

**Process:**
1. Detects your Steam installation
2. Stops all Steam processes
3. Downloads Steam 32-bit package
4. Extracts files to Steam directory
5. Creates steam.cfg to prevent updates
6. Launches Steam with `-clearbeta` flag

**Time Required:** ~2-5 minutes

### Option 2: Upgrade to 64-bit

**When to use:**
- Want better performance
- Need latest Steam features
- Running on modern 64-bit Windows

**Process:**
1. Tries PowerShell one-liner method (`irm steam.run | iex`)
2. If fails, downloads official Steam installer
3. Removes 32-bit registry restrictions
4. Installs Steam with 64-bit support
5. Launches updated Steam client

**Time Required:** ~3-7 minutes

### Option 3: Deep Clean Reinstall

**When to use:**
- Steam is corrupted or won't launch
- Need completely fresh installation
- Registry is cluttered with old entries
- Troubleshooting persistent issues

**⚠️ Important Notes:**
- You'll need to **re-login** to Steam
- Games won't be deleted but may need **verification**
- All .lua files are **automatically backed up**
- This is a **complete wipe** of Steam

**Process:**
1. Locates Steam installation
2. **Backs up all .lua files** to Desktop
3. Stops all Steam processes and services
4. Runs Steam uninstaller
5. **Deep cleans registry** (removes ALL traces)
6. Removes firewall rules
7. Downloads fresh Steam installer
8. Installs clean Steam
9. Shows backup location

**Time Required:** ~5-10 minutes

## 💾 Backup Information

### Automatic .lua Backup
When using Option 3 (Deep Clean), all .lua files are backed up to:

```
Desktop\SteamBackup_Lua_YYYYMMDD_HHMMSS\
```

Example: `Desktop\SteamBackup_Lua_20260101_143022\`

**What's backed up:**
- All .lua script files
- Directory structure preserved
- Relative paths maintained

**To restore:**
1. Navigate to backup folder
2. Copy .lua files
3. Paste into new Steam directory
4. Maintain original folder structure

## 🛠️ Troubleshooting

### "Script requires Administrator privileges"
**Solution:** Right-click PowerShell → "Run as Administrator"

### "Steam installation not found"
**Solution:** 
- Ensure Steam is installed
- Check common locations: `C:\Program Files (x86)\Steam`
- Manually install Steam first

### "Download failed"
**Solution:**
- Check internet connection
- Try again (script has fallback URLs)
- Check firewall settings

### "Cannot execute script"
**Solution:**
```powershell
Set-ExecutionPolicy -ExecutionPolicy Bypass -Scope Process
```

### Steam won't launch after downgrade
**Solution:**
- Delete `steam.cfg` file
- Verify game files in Steam
- Restart computer

### Registry clean didn't remove all entries
**Solution:**
- Run script again
- Manually clean using Registry Editor (regedit)
- Look for: `HKEY_CURRENT_USER\Software\Valve`

## ⚙️ Technical Details

### Registry Paths Cleaned
```
HKCU:\Software\Valve
HKCU:\Software\Classes\steam
HKCU:\Software\Classes\steamlink
HKCU:\Software\Microsoft\Windows\CurrentVersion\Uninstall\Steam
HKLM:\SOFTWARE\Valve
HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\Steam
HKLM:\SOFTWARE\Classes\steam
HKLM:\SOFTWARE\Classes\steamlink
HKLM:\SOFTWARE\WOW6432Node\Valve
HKLM:\SOFTWARE\WOW6432Node\Microsoft\Windows\CurrentVersion\Uninstall\Steam
HKCR:\steam
HKCR:\steamlink
```

### Processes Terminated
- steam.exe
- steamservice.exe
- steamwebhelper.exe
- steamerrorreporter.exe
- streaming_client.exe
- steamtool.exe
- gameoverlayui.exe
- SteamHelper.exe

### Files Modified/Created
- `steam.cfg` - Prevents auto-updates
- Registry entries (32-bit restrictions removed for 64-bit)
- Firewall rules (removed during deep clean)

## 🔒 Security & Safety

✅ **Open Source** - All code is visible and auditable
✅ **No Telemetry** - Doesn't collect any user data
✅ **Official Sources** - Downloads from Steam/GitHub only
✅ **Automatic Backups** - .lua files preserved
✅ **Safe Registry Cleaning** - Only removes Steam-related entries

## 🤝 Support & Community

### Need Help?

- **Discord:** [https://discord.gg/Ks9Ssgem](https://discord.gg/Ks9Ssgem)
- **Issues:** Report bugs in the [Issues](https://github.com/usercat280297/sushiTool-Steam-Downgrader/issues) tab
- **Wiki:** Check our [Wiki](https://github.com/usercat280297/sushiTool-Steam-Downgrader/wiki) for guides

### Contributing

We welcome contributions! Please:
1. Fork the repository
2. Create a feature branch
3. Commit your changes
4. Open a Pull Request

## 📜 License

This project is licensed under the MIT License - see the LICENSE file for details.

## ⚠️ Disclaimer

This tool modifies Steam installation and registry entries. While we've tested it extensively:
- **Use at your own risk**
- **Always backup important data**
- **Not officially affiliated with Valve**
- **We're not responsible for any data loss**

## 🎯 Roadmap

- [ ] GUI version with Windows Forms
- [ ] Support for custom Steam library folders
- [ ] Automatic game backup before reinstall
- [ ] Profile backup/restore functionality
- [ ] Multi-language support
- [ ] Portable version (no installation)

## ⭐ Star This Repo!

If this tool helped you, please give it a ⭐ on GitHub!

It helps others find the tool and motivates us to keep improving it.

## 📊 Stats

![GitHub stars](https://img.shields.io/github/stars/usercat280297/sushiTool-Steam-Downgrader?style=social)
![GitHub forks](https://img.shields.io/github/forks/usercat280297/sushiTool-Steam-Downgrader?style=social)
![GitHub issues](https://img.shields.io/github/issues/usercat280297/sushiTool-Steam-Downgrader)

---

<div align="center">

**Made by cracksteamv.v-sushiTool Team**

[Discord](https://discord.gg/Ks9Ssgem) • [GitHub](https://github.com/usercat280297/sushiTool-Steam-Downgrader) • [Issues](https://github.com/usercat280297/sushiTool-Steam-Downgrader/issues)

</div>
