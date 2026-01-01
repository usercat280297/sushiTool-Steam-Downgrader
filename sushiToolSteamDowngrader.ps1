# ===================================================================
# sushiTool - Steam Version Switcher
# Full PowerShell version with menu
# Usage: irm https://raw.githubusercontent.com/YOUR_USERNAME/YOUR_REPO/main/SteamDeepClean.ps1 | iex
# ===================================================================

# Check Administrator privileges
if (-NOT ([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator")) {
    Write-Host ""
    Write-Host "[ERROR] This script requires Administrator privileges!" -ForegroundColor Red
    Write-Host "Please right-click PowerShell and select 'Run as Administrator'" -ForegroundColor Yellow
    Write-Host ""
    Read-Host "Press Enter to exit"
    exit
}

function Show-Menu {
    Clear-Host
    Write-Host ""
    Write-Host "===============================================================" -ForegroundColor Cyan
    Write-Host ""
    Write-Host "           /`$`$`$`$`$`$                      /`$`$       /`$`$" -ForegroundColor Green
    Write-Host "          /`$`$__  `$`$                    | `$`$      |__/" -ForegroundColor Green
    Write-Host "         | `$`$  \__/ /`$`$   /`$`$  /`$`$`$`$`$`$`$| `$`$`$`$`$`$`$  /`$`$" -ForegroundColor Green
    Write-Host "         |  `$`$`$`$`$`$ | `$`$  | `$`$ /`$`$_____/| `$`$__  `$`$| `$`$" -ForegroundColor Green
    Write-Host "          \____  `$`$| `$`$  | `$`$|  `$`$`$`$`$`$ | `$`$  \ `$`$| `$`$" -ForegroundColor Green
    Write-Host "          /`$`$  \ `$`$| `$`$  | `$`$ \____  `$`$| `$`$  | `$`$| `$`$" -ForegroundColor Green
    Write-Host "         |  `$`$`$`$`$/|  `$`$`$`$`$`$/ /`$`$`$`$`$`$/| `$`$  | `$`$| `$`$" -ForegroundColor Green
    Write-Host "          \______/  \______/ |_______/ |__/  |__/|__/" -ForegroundColor Green
    Write-Host ""
    Write-Host "                Steam Version Switcher" -ForegroundColor White
    Write-Host ""
    Write-Host "          Discord: https://discord.gg/Ks9Ssgem" -ForegroundColor Cyan
    Write-Host ""
    Write-Host "===============================================================" -ForegroundColor Cyan
    Write-Host ""
    Write-Host "  Please select an option:" -ForegroundColor Yellow
    Write-Host ""
    Write-Host "  [0] Download SteamTool Latest (REQUIRED)" -ForegroundColor Red
    Write-Host "  [1] Downgrade to Steam 32-bit (x86)" -ForegroundColor White
    Write-Host "  [2] Upgrade to Steam 64-bit (x64)" -ForegroundColor White
    Write-Host "  [3] Complete Reinstall (Clean Install - Requires Re-login)" -ForegroundColor White
    Write-Host "  [4] Exit" -ForegroundColor White
    Write-Host ""
    Write-Host "===============================================================" -ForegroundColor Cyan
    Write-Host ""
}

function Download-SteamToolLatest {
    Clear-Host
    Write-Host ""
    Write-Host "===============================================================" -ForegroundColor Cyan
    Write-Host "  Download SteamTool Latest" -ForegroundColor Yellow
    Write-Host "===============================================================" -ForegroundColor Cyan
    Write-Host ""
    Write-Host "  [WARNING] YÊU CẦU BẮT BUỘC!" -ForegroundColor Red
    Write-Host "  [WARNING] Nếu không cài đặt, công cụ sẽ KHÔNG hoạt động!" -ForegroundColor Red
    Write-Host ""
    Write-Host "  [INFO] Đang tải SteamTool phiên bản mới nhất..." -ForegroundColor Yellow
    Write-Host ""
    
    $steamToolUrl = "https://github.com/usercat280297/sushiTool-Steam-Downgrader/releases/download/steamtool/st-setup-1.8.20.exe"
    $tempInstaller = "$env:TEMP\st-setup-1.8.20.exe"
    
    try {
        Write-Host "  Đang kết nối đến GitHub..." -ForegroundColor Cyan
        $ProgressPreference = 'SilentlyContinue'
        Invoke-WebRequest -Uri $steamToolUrl -OutFile $tempInstaller -UseBasicParsing
        Write-Host "  [SUCCESS] Tải xuống hoàn tất!" -ForegroundColor Green
        Write-Host ""
        
        Write-Host "  [INFO] Đang khởi chạy trình cài đặt..." -ForegroundColor Yellow
        Write-Host "  Vị trí file: $tempInstaller" -ForegroundColor White
        Write-Host ""
        
        Start-Process -FilePath $tempInstaller -Wait
        
        Write-Host ""
        Write-Host "  [SUCCESS] SteamTool đã được cài đặt!" -ForegroundColor Green
        Write-Host ""
        
        Remove-Item $tempInstaller -Force -ErrorAction SilentlyContinue
        
        Write-Host "===============================================================" -ForegroundColor Cyan
        Write-Host "                  HOÀN THÀNH!" -ForegroundColor Green
        Write-Host "===============================================================" -ForegroundColor Cyan
        Write-Host ""
        Write-Host "  SteamTool Latest đã được cài đặt thành công" -ForegroundColor White
        Write-Host "  Bạn có thể tiếp tục sử dụng các tính năng khác" -ForegroundColor White
        Write-Host ""
        
        Return-ToMenu
        
    } catch {
        Write-Host ""
        Write-Host "  [ERROR] Tải xuống thất bại: $_" -ForegroundColor Red
        Write-Host "  Vui lòng kiểm tra kết nối internet và thử lại" -ForegroundColor Yellow
        Write-Host ""
        
        Return-ToMenu
    }
}

function Return-ToMenu {
    Write-Host ""
    Write-Host "  Đang quay về menu trong 5 giây..." -ForegroundColor Cyan
    
    for ($i = 5; $i -gt 0; $i--) {
        Write-Host "  $i..." -ForegroundColor Yellow -NoNewline
        Start-Sleep -Seconds 1
    }
    
    Write-Host ""
}

function Install-Steam32Bit {
    Clear-Host
    Write-Host ""
    Write-Host "===============================================================" -ForegroundColor Cyan
    Write-Host "  Installing Steam 32-bit" -ForegroundColor Yellow
    Write-Host "===============================================================" -ForegroundColor Cyan
    Write-Host ""
    
    [Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12
    
    $steamUrl = "https://github.com/madoiscool/lt_api_links/releases/download/unsteam/latest32bitsteam.zip"
    $fallbackUrl = "http://files.luatools.work/OneOffFiles/latest32bitsteam.zip"
    
    Write-Host "Step 0: Locating Steam installation..." -ForegroundColor Cyan
    $steamPath = Get-SteamPath
    
    if (-not $steamPath) {
        Write-Host "  [ERROR] Steam installation not found" -ForegroundColor Red
        Read-Host "Press Enter to exit"
        return
    }
    
    Write-Host "  [SUCCESS] Steam found at: $steamPath" -ForegroundColor Green
    Write-Host ""
    
    Write-Host "Step 1: Killing all Steam processes..." -ForegroundColor Cyan
    Stop-SteamProcesses
    Write-Host "  [SUCCESS] All Steam processes terminated" -ForegroundColor Green
    Write-Host ""
    
    Write-Host "Step 2: Downloading Steam 32-bit..." -ForegroundColor Cyan
    $tempZip = "$env:TEMP\latest_steam_32bit.zip"
    
    if (Test-Path $tempZip) {
        Remove-Item $tempZip -Force
    }
    
    $downloadSuccess = $false
    $urls = @($steamUrl, $fallbackUrl)
    
    foreach ($url in $urls) {
        Write-Host "  [INFO] Trying: $url" -ForegroundColor Yellow
        Write-Host ""
        
        try {
            Write-Host "  [METHOD 1] Using BITS Transfer..." -ForegroundColor Cyan
            
            Import-Module BitsTransfer -ErrorAction Stop
            $job = Start-BitsTransfer -Source $url -Destination $tempZip -DisplayName "Steam 32-bit" -Asynchronous
            
            $lastPercent = -1
            $timeout = 300
            $elapsed = 0
            
            while (($job.JobState -eq 'Transferring' -or $job.JobState -eq 'Connecting') -and $elapsed -lt $timeout) {
                $job = Get-BitsTransfer -JobId $job.JobId
                
                if ($job.BytesTotal -gt 0) {
                    $percent = [int](($job.BytesTransferred / $job.BytesTotal) * 100)
                    
                    if ($percent -ne $lastPercent) {
                        $downloaded = [math]::Round($job.BytesTransferred / 1MB, 2)
                        $total = [math]::Round($job.BytesTotal / 1MB, 2)
                        
                        $bar = '█' * [math]::Floor($percent / 2)
                        $space = '░' * (50 - [math]::Floor($percent / 2))
                        
                        Write-Host "`r  [$bar$space] $percent% ($downloaded MB / $total MB)" -NoNewline -ForegroundColor Cyan
                        $lastPercent = $percent
                    }
                }
                
                Start-Sleep -Milliseconds 500
                $elapsed++
            }
            
            Write-Host ""
            
            if ($job.JobState -eq 'Transferred') {
                Complete-BitsTransfer -BitsJob $job
                Write-Host "  [SUCCESS] Download complete!" -ForegroundColor Green
                $downloadSuccess = $true
                break
            } elseif ($job.JobState -eq 'Error') {
                Remove-BitsTransfer -BitsJob $job
                throw "BITS transfer failed"
            }
            
        } catch {
            Write-Host "  [WARNING] BITS method failed: $_" -ForegroundColor Yellow
            Write-Host ""
            
            try {
                Write-Host "  [METHOD 2] Using WebRequest..." -ForegroundColor Cyan
                
                $ProgressPreference = 'SilentlyContinue'
                Invoke-WebRequest -Uri $url -OutFile $tempZip -UseBasicParsing -TimeoutSec 300
                
                if (Test-Path $tempZip) {
                    $fileSize = (Get-Item $tempZip).Length / 1MB
                    Write-Host "  [SUCCESS] Downloaded! Size: $([math]::Round($fileSize, 2)) MB" -ForegroundColor Green
                    $downloadSuccess = $true
                    break
                }
                
            } catch {
                Write-Host "  [ERROR] WebRequest method failed: $_" -ForegroundColor Red
                Write-Host ""
                
                try {
                    Write-Host "  [METHOD 3] Using WebClient..." -ForegroundColor Cyan
                    
                    $webClient = New-Object System.Net.WebClient
                    $webClient.Headers.Add("User-Agent", "Mozilla/5.0")
                    $webClient.DownloadFile($url, $tempZip)
                    $webClient.Dispose()
                    
                    if (Test-Path $tempZip) {
                        $fileSize = (Get-Item $tempZip).Length / 1MB
                        Write-Host "  [SUCCESS] Downloaded! Size: $([math]::Round($fileSize, 2)) MB" -ForegroundColor Green
                        $downloadSuccess = $true
                        break
                    }
                    
                } catch {
                    Write-Host "  [ERROR] WebClient method failed: $_" -ForegroundColor Red
                    Write-Host ""
                }
            }
        }
    }
    
    if (-not $downloadSuccess) {
        Write-Host ""
        Write-Host "  [ERROR] All download attempts failed!" -ForegroundColor Red
        Write-Host "  Please check your internet connection and try again" -ForegroundColor Yellow
        Write-Host ""
        Return-ToMenu
        return
    }
    
    Write-Host ""
    Write-Host "Step 3: Extracting files..." -ForegroundColor Cyan
    Write-Host "  [INFO] Extracting to: $steamPath" -ForegroundColor Yellow
    Write-Host ""
    
    try {
        Add-Type -AssemblyName System.IO.Compression.FileSystem
        
        $zip = [System.IO.Compression.ZipFile]::OpenRead($tempZip)
        $entries = @($zip.Entries | Where-Object { -not $_.FullName.EndsWith('/') })
        $total = $entries.Count
        $count = 0
        $lastPercent = -1
        
        foreach ($entry in $entries) {
            $count++
            $destPath = Join-Path $steamPath $entry.FullName
            $destDir = Split-Path $destPath -Parent
            
            if ($destDir -and !(Test-Path $destDir)) {
                New-Item -ItemType Directory -Path $destDir -Force | Out-Null
            }
            
            try {
                [System.IO.Compression.ZipFileExtensions]::ExtractToFile($entry, $destPath, $true)
            } catch {}
            
            $percent = [int](($count / $total) * 100)
            if ($percent -ne $lastPercent) {
                $bar = '█' * [math]::Floor($percent / 2)
                $space = '░' * (50 - [math]::Floor($percent / 2))
                Write-Host "`r  [$bar$space] $percent% ($count / $total files)" -NoNewline -ForegroundColor Cyan
                $lastPercent = $percent
            }
        }
        
        Write-Host ""
        $zip.Dispose()
        Write-Host "  [SUCCESS] Extraction complete!" -ForegroundColor Green
        
    } catch {
        Write-Host ""
        Write-Host "  [ERROR] Extraction failed: $_" -ForegroundColor Red
        Return-ToMenu
        return
    }
    
    Remove-Item $tempZip -Force -ErrorAction SilentlyContinue
    
    Write-Host ""
    Write-Host "Step 4: Creating steam.cfg..." -ForegroundColor Cyan
    $steamCfg = Join-Path $steamPath "steam.cfg"
    
    @"
BootStrapperInhibitAll=enable
BootStrapperForceSelfUpdate=disable
"@ | Out-File -FilePath $steamCfg -Encoding ASCII
    
    Write-Host "  [SUCCESS] Configuration created!" -ForegroundColor Green
    Write-Host "  Location: $steamCfg" -ForegroundColor White
    Write-Host ""
    
    Write-Host "Step 5: Launching Steam..." -ForegroundColor Cyan
    Start-Process -FilePath "$steamPath\Steam.exe" -ArgumentList "-clearbeta"
    Write-Host "  [SUCCESS] Steam launched!" -ForegroundColor Green
    Write-Host ""
    
    Show-CompletionMessage -InstallType "32-bit"
    Return-ToMenu
}
function Install-Steam64Bit {
    Clear-Host
    Write-Host ""
    Write-Host "===============================================================" -ForegroundColor Cyan
    Write-Host "  Installing Steam 64-bit (PowerShell Method)" -ForegroundColor Yellow
    Write-Host "===============================================================" -ForegroundColor Cyan
    Write-Host ""
    Write-Host "  [INFO] Using PowerShell one-liner for 64-bit installation" -ForegroundColor Yellow
    Write-Host ""
    Start-Sleep -Seconds 2
    
    Write-Host "Step 1: Running PowerShell command..." -ForegroundColor Cyan
    Write-Host "  Command: irm steam.run | iex" -ForegroundColor White
    Write-Host ""
    
    try {
        Invoke-Expression (Invoke-RestMethod -Uri "https://steam.run")
        
        Write-Host ""
        Write-Host "  [SUCCESS] Steam 64-bit installed successfully!" -ForegroundColor Green
        Write-Host ""
        Show-CompletionMessage -InstallType "64-bit"
        Return-ToMenu
    } catch {
        Write-Host ""
        Write-Host "  [WARNING] PowerShell method failed!" -ForegroundColor Yellow
        Write-Host "  [INFO] Falling back to official installer method..." -ForegroundColor Yellow
        Write-Host ""
        Start-Sleep -Seconds 3
        Install-Steam64BitOfficial
    }
}

function Install-Steam64BitOfficial {
    Write-Host "Step 0: Locating Steam installation..." -ForegroundColor Cyan
    $steamPath = Get-SteamPath
    
    if (-not $steamPath) {
        Write-Host "  [ERROR] Steam installation not found" -ForegroundColor Red
        Read-Host "Press Enter to exit"
        exit
    }
    
    Write-Host "  [SUCCESS] Steam found at: $steamPath" -ForegroundColor Green
    Write-Host ""
    
    Write-Host "Step 1: Killing all Steam processes..." -ForegroundColor Cyan
    Stop-SteamProcesses
    Write-Host "  [SUCCESS] All Steam processes terminated" -ForegroundColor Green
    Write-Host ""
    
    Write-Host "Step 2: Downloading official Steam installer..." -ForegroundColor Cyan
    Write-Host "  [INFO] Downloading from cdn.cloudflare.steamstatic.com" -ForegroundColor Yellow
    Write-Host ""
    
    $tempInstaller = "$env:TEMP\SteamSetup.exe"
    
    try {
        $ProgressPreference = 'SilentlyContinue'
        Invoke-WebRequest -Uri 'https://cdn.cloudflare.steamstatic.com/client/installer/SteamSetup.exe' -OutFile $tempInstaller -UseBasicParsing
        Write-Host "  [SUCCESS] Download complete!" -ForegroundColor Green
    } catch {
        Write-Host "  [ERROR] Download failed: $_" -ForegroundColor Red
        Read-Host "Press Enter to exit"
        exit
    }
    
    Write-Host ""
    Write-Host "Step 3: Removing 32-bit restriction from registry..." -ForegroundColor Cyan
    Write-Host "  [INFO] Modifying Steam registry to allow 64-bit..." -ForegroundColor Yellow
    
    Remove-ItemProperty -Path "HKCU:\Software\Valve\Steam" -Name "SteamCmdForceX86" -ErrorAction SilentlyContinue
    Remove-ItemProperty -Path "HKLM:\SOFTWARE\Valve\Steam" -Name "SteamCmdForceX86" -ErrorAction SilentlyContinue
    Remove-ItemProperty -Path "HKLM:\SOFTWARE\WOW6432Node\Valve\Steam" -Name "SteamCmdForceX86" -ErrorAction SilentlyContinue
    
    Write-Host "  [SUCCESS] Registry updated" -ForegroundColor Green
    Write-Host ""
    
    Write-Host "Step 4: Installing Steam with 64-bit support..." -ForegroundColor Cyan
    Write-Host ""
    Write-Host "  IMPORTANT: The Steam installer will now run." -ForegroundColor Yellow
    Write-Host "  Please install to the SAME location: $steamPath" -ForegroundColor Yellow
    Write-Host ""
    Read-Host "Press Enter to start installation"
    
    Start-Process -FilePath $tempInstaller -ArgumentList "/S" -Wait
    Remove-Item $tempInstaller -Force -ErrorAction SilentlyContinue
    
    Write-Host ""
    Write-Host "  [SUCCESS] Installation complete!" -ForegroundColor Green
    Write-Host ""
    
    Write-Host "Step 5: Launching Steam..." -ForegroundColor Cyan
    Write-Host "  Executable: $steamPath\Steam.exe" -ForegroundColor White
    Write-Host ""
    
    Start-Process -FilePath "$steamPath\Steam.exe"
    
    Write-Host "  [SUCCESS] Steam launched successfully!" -ForegroundColor Green
    Write-Host ""
    Write-Host "Steam is now running with 64-bit support." -ForegroundColor White
    Write-Host ""
    
    Show-CompletionMessage -InstallType "64-bit"
    Return-ToMenu
}

function Complete-Reinstall {
    Clear-Host
    Write-Host ""
    Write-Host "===============================================================" -ForegroundColor Cyan
    Write-Host "  COMPLETE STEAM REINSTALL (Deep Clean)" -ForegroundColor Yellow
    Write-Host "===============================================================" -ForegroundColor Cyan
    Write-Host ""
    Write-Host "  [WARNING] This option will:" -ForegroundColor Red
    Write-Host "  - Backup all .lua files from Steam directory" -ForegroundColor White
    Write-Host "  - Kill all Steam processes" -ForegroundColor White
    Write-Host "  - Completely uninstall Steam" -ForegroundColor White
    Write-Host "  - DEEP CLEAN registry (removes ALL Steam traces)" -ForegroundColor White
    Write-Host "  - Remove Steam firewall rules" -ForegroundColor White
    Write-Host "  - Reinstall Steam from official installer" -ForegroundColor White
    Write-Host ""
    Write-Host "  [IMPORTANT] You will need to:" -ForegroundColor Yellow
    Write-Host "  - Re-login to your Steam account" -ForegroundColor White
    Write-Host "  - Re-download games (game files will be kept if possible)" -ForegroundColor White
    Write-Host ""
    Write-Host "===============================================================" -ForegroundColor Cyan
    Write-Host ""
    
    $confirm = Read-Host "Type YES to continue, or anything else to cancel"
    
    if ($confirm -ne "YES") {
        Write-Host ""
        Write-Host "  [INFO] Operation cancelled" -ForegroundColor Yellow
        Start-Sleep -Seconds 2
        return
    }
    
    Clear-Host
    Write-Host ""
    Write-Host "===============================================================" -ForegroundColor Cyan
    Write-Host "  Starting Deep Clean Reinstall Process" -ForegroundColor Yellow
    Write-Host "===============================================================" -ForegroundColor Cyan
    Write-Host ""
    
    # Step 1: Find Steam
    Write-Host "Step 1: Locating Steam installation..." -ForegroundColor Cyan
    $steamPath = Get-SteamPath
    
    if (-not $steamPath) {
        Write-Host "  [ERROR] Steam installation not found" -ForegroundColor Red
        Read-Host "Press Enter to exit"
        exit
    }
    
    Write-Host "  [SUCCESS] Steam found at: $steamPath" -ForegroundColor Green
    Write-Host ""
    
    # Step 2: Backup .lua files
    Write-Host "Step 2: Backing up .lua files..." -ForegroundColor Cyan
    $timestamp = Get-Date -Format "yyyyMMdd_HHmmss"
    $backupPath = "$env:USERPROFILE\Desktop\SteamBackup_Lua_$timestamp"
    New-Item -ItemType Directory -Path $backupPath -Force | Out-Null
    
    Write-Host "  [INFO] Searching for .lua files in: $steamPath" -ForegroundColor Yellow
    Write-Host ""
    
    $luaFiles = Get-ChildItem -Path $steamPath -Filter *.lua -Recurse -ErrorAction SilentlyContinue
    $count = 0
    
    foreach ($file in $luaFiles) {
        try {
            $relativePath = $file.FullName.Substring($steamPath.Length).TrimStart('\')
            $destFile = Join-Path $backupPath $relativePath
            $destDir = Split-Path $destFile -Parent
            
            if (!(Test-Path $destDir)) {
                New-Item -ItemType Directory -Path $destDir -Force | Out-Null
                Start-Sleep -Milliseconds 50
            }
            
            Copy-Item -Path $file.FullName -Destination $destFile -Force
            $count++
            Write-Host "  Backed up: $($file.Name)" -ForegroundColor Cyan
        } catch {
            Write-Host "  [WARNING] Failed to backup $($file.Name)" -ForegroundColor Yellow
        }
    }
    
    Write-Host ""
    if ($count -gt 0) {
        Write-Host "  [SUCCESS] Backed up $count .lua files to:" -ForegroundColor Green
        Write-Host "  $backupPath" -ForegroundColor White
    } else {
        Write-Host "  [INFO] No .lua files found to backup" -ForegroundColor Yellow
    }
    Write-Host ""
    Start-Sleep -Seconds 2
    
    # Step 3: Kill Steam processes
    Write-Host "Step 3: Stopping all Steam processes..." -ForegroundColor Cyan
    Stop-SteamProcesses
    Write-Host "  [SUCCESS] All Steam processes terminated" -ForegroundColor Green
    Write-Host ""
    
    # Step 4: Uninstall Steam
    Write-Host "Step 4: Uninstalling Steam completely..." -ForegroundColor Cyan
    Write-Host "  [INFO] Running Steam uninstaller..." -ForegroundColor Yellow
    
    $uninstaller = Join-Path $steamPath "uninstall.exe"
    if (Test-Path $uninstaller) {
        Start-Process -FilePath $uninstaller -ArgumentList "/S" -Wait -NoNewWindow
        Start-Sleep -Seconds 3
    }
    
    Write-Host ""
    Write-Host "Step 5: DEEP CLEANING Registry (removing ALL Steam traces)..." -ForegroundColor Cyan
    Write-Host "  [INFO] This will remove ALL Steam registry entries..." -ForegroundColor Yellow
    Write-Host ""
    
    Deep-CleanRegistry
    
    Write-Host ""
    Start-Sleep -Seconds 2
    
    # Step 6: Remove firewall rules
    Write-Host "Step 6: Removing Steam firewall rules..." -ForegroundColor Cyan
    netsh advfirewall firewall delete rule name=all program="$steamPath\steam.exe" 2>$null | Out-Null
    netsh advfirewall firewall delete rule name=all program="$steamPath\steamwebhelper.exe" 2>$null | Out-Null
    Write-Host "  [SUCCESS] Firewall rules removed" -ForegroundColor Green
    Write-Host ""
    
    # Step 7: Download fresh Steam
    Write-Host "Step 7: Downloading fresh Steam installer..." -ForegroundColor Cyan
    $tempInstaller = "$env:TEMP\SteamSetup_Fresh.exe"
    
    try {
        $ProgressPreference = 'SilentlyContinue'
        Invoke-WebRequest -Uri 'https://cdn.fastly.steamstatic.com/client/installer/SteamSetup.exe' -OutFile $tempInstaller -UseBasicParsing
        Write-Host "  [SUCCESS] Download complete!" -ForegroundColor Green
    } catch {
        Write-Host "  [ERROR] Download failed: $_" -ForegroundColor Red
        Read-Host "Press Enter to exit"
        exit
    }
    
    Write-Host ""
    Write-Host "Step 8: Installing fresh Steam..." -ForegroundColor Cyan
    Write-Host ""
    Write-Host "  [INFO] Steam installer will now run" -ForegroundColor Yellow
    Write-Host "  [INFO] Please follow the installation wizard" -ForegroundColor Yellow
    Write-Host ""
    Read-Host "Press Enter to start installation"
    
    Start-Process -FilePath $tempInstaller -Wait
    Remove-Item $tempInstaller -Force -ErrorAction SilentlyContinue
    
    Write-Host ""
    Write-Host "===============================================================" -ForegroundColor Cyan
    Write-Host "                     ALL DONE!" -ForegroundColor Green
    Write-Host "===============================================================" -ForegroundColor Cyan
    Write-Host ""
    Write-Host "                   _______________" -ForegroundColor Yellow
    Write-Host "                  /               \" -ForegroundColor Yellow
    Write-Host "                 /   ~~~~~~~~~~~   \" -ForegroundColor Yellow
    Write-Host "                |  ~~~~~~~~~~~~~~~  |" -ForegroundColor Yellow
    Write-Host "                |  ~~~~~~~~~~~~~~~  |" -ForegroundColor Yellow
    Write-Host "                 \   ~~~~~~~~~~~   /" -ForegroundColor Yellow
    Write-Host "                  \_______________/" -ForegroundColor Yellow
    Write-Host "                  |||||||||||||||" -ForegroundColor Yellow
    Write-Host "                 /                 \" -ForegroundColor Yellow
    Write-Host "                | o  o  o  o  o  o  |" -ForegroundColor Yellow
    Write-Host "                |  o  o  o  o  o  o |" -ForegroundColor Yellow
    Write-Host "                 \                 /" -ForegroundColor Yellow
    Write-Host "                  \_______________ /" -ForegroundColor Yellow
    Write-Host ""
    Write-Host "         Sushi says: Steam is COMPLETELY clean!" -ForegroundColor Cyan
    Write-Host ""
    Write-Host "  [SUCCESS] Deep clean reinstall finished!" -ForegroundColor Green
    Write-Host ""
    Write-Host "  Registry has been completely wiped clean" -ForegroundColor White
    Write-Host "  All Steam traces have been removed" -ForegroundColor White
    Write-Host ""
    Write-Host "  Your .lua files backup location:" -ForegroundColor Yellow
    Write-Host "  $backupPath" -ForegroundColor White
    Write-Host ""
    Write-Host "  Next steps:" -ForegroundColor Yellow
    Write-Host "  1. Launch Steam" -ForegroundColor White
    Write-Host "  2. Login to your account" -ForegroundColor White
    Write-Host "  3. Your games should be detected automatically" -ForegroundColor White
    Write-Host ""
    Write-Host "  Discord: https://discord.gg/Ks9Ssgem" -ForegroundColor Cyan
    Write-Host ""
    Write-Host "         Thank you for using sushiTool!" -ForegroundColor Green
    Write-Host ""
    Write-Host "===============================================================" -ForegroundColor Cyan
    Write-Host ""
    
    Return-ToMenu
}

function Install-SteamVersion {
    param(
        [string]$InstallType,
        [string]$SteamUrl,
        [string]$FallbackUrl
    )
    
    Write-Host "Step 0: Locating Steam installation..." -ForegroundColor Cyan
    $steamPath = Get-SteamPath
    
    if (-not $steamPath) {
        Write-Host "  [ERROR] Steam installation not found" -ForegroundColor Red
        Write-Host "  Please ensure Steam is installed on your system." -ForegroundColor Yellow
        Read-Host "Press Enter to exit"
        exit
    }
    
    Write-Host "  [SUCCESS] Steam found at: $steamPath" -ForegroundColor Green
    Write-Host ""
    Start-Sleep -Seconds 1
    
    Write-Host "Step 1: Killing all Steam processes..." -ForegroundColor Cyan
    Stop-SteamProcesses
    Write-Host "  [SUCCESS] All Steam processes terminated" -ForegroundColor Green
    Write-Host ""
    Start-Sleep -Seconds 1
    
    Write-Host "Step 2: Downloading Steam $InstallType..." -ForegroundColor Cyan
    Write-Host "  [INFO] Connecting to server..." -ForegroundColor Yellow
    Write-Host ""
    
    $tempZip = "$env:TEMP\latest_steam.zip"
    
    try {
        $ProgressPreference = 'SilentlyContinue'
        Invoke-WebRequest -Uri $SteamUrl -OutFile $tempZip -UseBasicParsing
        Write-Host "  [SUCCESS] Download complete!" -ForegroundColor Green
    } catch {
        Write-Host "  [WARNING] Primary download failed, trying fallback..." -ForegroundColor Yellow
        try {
            Invoke-WebRequest -Uri $FallbackUrl -OutFile $tempZip -UseBasicParsing
            Write-Host "  [SUCCESS] Download complete (fallback)!" -ForegroundColor Green
        } catch {
            Write-Host "  [ERROR] All downloads failed!" -ForegroundColor Red
            Read-Host "Press Enter to exit"
            exit
        }
    }
    
    Write-Host ""
    Write-Host "  [INFO] Extracting files to Steam directory..." -ForegroundColor Yellow
    Write-Host ""
    
    try {
        Add-Type -AssemblyName System.IO.Compression.FileSystem
        $zip = [System.IO.Compression.ZipFile]::OpenRead($tempZip)
        $entries = $zip.Entries | Where-Object { -not $_.FullName.EndsWith('/') }
        $total = $entries.Count
        $count = 0
        
        foreach ($entry in $entries) {
            $count++
            $dest = Join-Path $steamPath $entry.FullName
            $dir = Split-Path $dest -Parent
            
            if ($dir -and !(Test-Path $dir)) {
                New-Item -ItemType Directory -Path $dir -Force | Out-Null
            }
            
            try {
                [System.IO.Compression.ZipFileExtensions]::ExtractToFile($entry, $dest, $true)
            } catch {}
            
            $percent = [int](($count / $total) * 100)
            Write-Progress -Activity "Extracting Steam files" -Status "$percent% Complete" -PercentComplete $percent
        }
        
        $zip.Dispose()
        Write-Host "  [SUCCESS] Extraction complete!" -ForegroundColor Green
    } catch {
        Write-Host "  [ERROR] Extraction failed!" -ForegroundColor Red
        Read-Host "Press Enter to exit"
        exit
    }
    
    Remove-Item $tempZip -Force -ErrorAction SilentlyContinue
    
    Write-Host ""
    Start-Sleep -Seconds 1
    
    Write-Host "Step 3: Creating steam.cfg file..." -ForegroundColor Cyan
    $steamCfg = Join-Path $steamPath "steam.cfg"
    
    @"
BootStrapperInhibitAll=enable
BootStrapperForceSelfUpdate=disable
"@ | Out-File -FilePath $steamCfg -Encoding ASCII
    
    Write-Host "  [SUCCESS] steam.cfg created!" -ForegroundColor Green
    Write-Host "  Location: $steamCfg" -ForegroundColor White
    Write-Host ""
    Start-Sleep -Seconds 1
    
    Write-Host "Step 4: Launching Steam..." -ForegroundColor Cyan
    Write-Host "  Executable: $steamPath\Steam.exe" -ForegroundColor White
    Write-Host "  Arguments: -clearbeta" -ForegroundColor White
    Write-Host ""
    
    Start-Process -FilePath "$steamPath\Steam.exe" -ArgumentList "-clearbeta"
    
    Write-Host "  [SUCCESS] Steam launched successfully!" -ForegroundColor Green
    Write-Host ""
    Write-Host "Steam is now running with $InstallType version." -ForegroundColor White
    Write-Host ""
    
    Show-CompletionMessage -InstallType $InstallType
    Return-ToMenu
}

function Get-SteamPath {
    $steamPath = $null
    
    try {
        $steamPath = (Get-ItemProperty -Path "HKCU:\Software\Valve\Steam" -Name "SteamPath" -ErrorAction Stop).SteamPath
    } catch {
        try {
            $steamPath = (Get-ItemProperty -Path "HKLM:\SOFTWARE\Valve\Steam" -Name "InstallPath" -ErrorAction Stop).InstallPath
        } catch {
            try {
                $steamPath = (Get-ItemProperty -Path "HKLM:\SOFTWARE\WOW6432Node\Valve\Steam" -Name "InstallPath" -ErrorAction Stop).InstallPath
            } catch {}
        }
    }
    
    if (-not $steamPath) {
        $possiblePaths = @(
            "C:\Program Files (x86)\Steam",
            "C:\Program Files\Steam",
            "D:\Steam",
            "E:\Steam"
        )
        
        foreach ($path in $possiblePaths) {
            if (Test-Path "$path\steam.exe") {
                $steamPath = $path
                break
            }
        }
    }
    
    if ($steamPath) {
        $steamPath = $steamPath.Replace('/', '\')
    }
    
    return $steamPath
}

function Stop-SteamProcesses {
    $processes = @('steam', 'steamservice', 'steamwebhelper', 'steamerrorreporter', 'streaming_client', 'steamtool', 'gameoverlayui', 'SteamHelper')
    
    foreach ($proc in $processes) {
        Get-Process -Name $proc -ErrorAction SilentlyContinue | Stop-Process -Force -ErrorAction SilentlyContinue
    }
    
    Start-Sleep -Seconds 2
    
    try {
        Stop-Service -Name "Steam Client Service" -Force -ErrorAction SilentlyContinue
        sc.exe delete "Steam Client Service" 2>$null | Out-Null
    } catch {}
}

function Deep-CleanRegistry {
    Write-Host "  [INFO] Starting deep registry cleanup..." -ForegroundColor Yellow
    
    $registryPaths = @(
        'HKCU:\Software\Valve',
        'HKCU:\Software\Classes\steam',
        'HKCU:\Software\Classes\steamlink',
        'HKCU:\Software\Microsoft\Windows\CurrentVersion\Uninstall\Steam',
        'HKLM:\SOFTWARE\Valve',
        'HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\Steam',
        'HKLM:\SOFTWARE\Classes\steam',
        'HKLM:\SOFTWARE\Classes\steamlink',
        'HKLM:\SOFTWARE\WOW6432Node\Valve',
        'HKLM:\SOFTWARE\WOW6432Node\Microsoft\Windows\CurrentVersion\Uninstall\Steam',
        'HKCR:\steam',
        'HKCR:\steamlink',
        'HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\FileExts\.steam'
    )
    
    $cleanedCount = 0
    
    foreach ($path in $registryPaths) {
        if (Test-Path $path) {
            try {
                Remove-Item -Path $path -Recurse -Force -ErrorAction Stop
                Write-Host "    [DELETED] $path" -ForegroundColor Green
                $cleanedCount++
            } catch {
                Write-Host "    [FAILED] $path" -ForegroundColor Red
            }
        }
    }
    
    Write-Host ""
    Write-Host "  [INFO] Cleaning startup entries..." -ForegroundColor Yellow
    
    $runPaths = @(
        'HKCU:\Software\Microsoft\Windows\CurrentVersion\Run',
        'HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Run',
        'HKLM:\SOFTWARE\WOW6432Node\Microsoft\Windows\CurrentVersion\Run'
    )
    
    foreach ($runPath in $runPaths) {
        if (Test-Path $runPath) {
            try {
                Remove-ItemProperty -Path $runPath -Name 'Steam' -ErrorAction SilentlyContinue
            } catch {}
        }
    }
    
    Write-Host ""
    Write-Host "  [INFO] Searching for remaining Steam entries..." -ForegroundColor Yellow
    
    $searchPaths = @('HKCU:\Software', 'HKLM:\SOFTWARE', 'HKLM:\SOFTWARE\WOW6432Node')
    
    foreach ($searchPath in $searchPaths) {
        if (Test-Path $searchPath) {
            Get-ChildItem -Path $searchPath -ErrorAction SilentlyContinue | ForEach-Object {
                if ($_.PSChildName -match 'steam' -or $_.PSChildName -match 'valve') {
                    try {
                        Remove-Item -Path $_.PSPath -Recurse -Force -ErrorAction Stop
                        Write-Host "    [DELETED] $($_.PSPath)" -ForegroundColor Green
                        $cleanedCount++
                    } catch {}
                }
            }
        }
    }
    
    Write-Host ""
    Write-Host "  [SUCCESS] Registry deep clean complete! Removed $cleanedCount entries" -ForegroundColor Green
}

function Show-CompletionMessage {
    param([string]$InstallType)
    
    Write-Host ""
    Write-Host "===============================================================" -ForegroundColor Cyan
    Write-Host "                     ALL DONE!" -ForegroundColor Green
    Write-Host "===============================================================" -ForegroundColor Cyan
    Write-Host ""
    Write-Host "                   _______________" -ForegroundColor Yellow
    Write-Host "                  /               \" -ForegroundColor Yellow
    Write-Host "                 /   ~~~~~~~~~~~   \" -ForegroundColor Yellow
    Write-Host "                |  ~~~~~~~~~~~~~~~  |" -ForegroundColor Yellow
    Write-Host "                |  ~~~~~~~~~~~~~~~  |" -ForegroundColor Yellow
    Write-Host "                 \   ~~~~~~~~~~~   /" -ForegroundColor Yellow
    Write-Host "                  \_______________/" -ForegroundColor Yellow
    Write-Host "                  |||||||||||||||" -ForegroundColor Yellow
    Write-Host "                 /                 \" -ForegroundColor Yellow
    Write-Host "                | o  o  o  o  o  o  |" -ForegroundColor Yellow
    Write-Host "                |  o  o  o  o  o  o |" -ForegroundColor Yellow
    Write-Host "                 \                 /" -ForegroundColor Yellow
    Write-Host "                  \_______________ /" -ForegroundColor Yellow
    Write-Host ""
    Write-Host "         Sushi says: Enjoy your Steam $InstallType!" -ForegroundColor Cyan
    Write-Host ""
    Write-Host "       Steam has been switched to $InstallType" -ForegroundColor White
    Write-Host "       Configuration file has been created" -ForegroundColor White
    Write-Host "       Steam is now launching..." -ForegroundColor White
    Write-Host ""
    Write-Host "       Discord: https://discord.gg/Ks9Ssgem" -ForegroundColor Cyan
    Write-Host ""
    Write-Host "            Thank you for using sushiTool!" -ForegroundColor Green
    Write-Host ""
    Write-Host "===============================================================" -ForegroundColor Cyan
    Write-Host ""
}

# ===================================================================
# MAIN EXECUTION
# ===================================================================

while ($true) {
    Show-Menu
    $choice = Read-Host "  Enter your choice (0/1/2/3/4)"
    
    switch ($choice) {
        "0" {
            Download-SteamToolLatest
        }
        "1" {
            Install-Steam32Bit
        }
        "2" {
            Install-Steam64Bit
        }
        "3" {
            Complete-Reinstall
        }
        "4" {
            Write-Host ""
            Write-Host "  Exiting... Goodbye! 🍣" -ForegroundColor Cyan
            Write-Host ""
            Start-Sleep -Seconds 1
            exit
        }
        default {
            Write-Host ""
            Write-Host "  [ERROR] Invalid choice! Please enter 0, 1, 2, 3, or 4." -ForegroundColor Red
            Start-Sleep -Seconds 2
        }
    }
}
