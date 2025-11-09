$scoopBuckets = @(
  "extras"
  "versions"
  "php"
  "nerd-fonts"
)

$scoopPackages = @(
  "winscp"
  "wireshark"
  "vagrant"
  "msys2"
  "jmeter"
  "Hack-NF"
  "Hack-NF-Mono"
)

$wingetPackages = @(
  "AgileBits.1Password"
  "Microsoft.VisualStudio.2019.Community"
  "CPUID.CPU-Z"
  "CrystalDewWorld.CrystalDiskInfo"
  "Discord.Discord"
  "Docker.DockerDesktop"
  "Mozilla.Firefox.DeveloperEdition"
  "Git.Git"
  "Google.Chrome"
  "Brave.Brave"
  "HandBrake.HandBrake"
  "Logitech.Options"
  "Microsoft.DevHome"
  "Enterbrain.RGSS-RTPStandard"
  "Valve.Steam"
  "JetBrains.Toolbox"
  "TablePlus.TablePlus"
  "UnityTechnologies.UnityHub"
  "VideoLAN.VLC"
  "SlackTechnologies.Slack"
  "Microsoft.WindowsInstallationAssistant"
  "Microsoft.WingetCreate"
  "Logitech.GHUB"
  "BlenderFoundation.Blender"
  "Microsoft.AzureCLI"
  "Elgato.4KCaptureUtility"
  "Microsoft.dotnetRuntime.5-x64"
  "Elgato.StreamDeck"
  "Streamlabs.Streamlabs"
  "Google.Drive"
  "Google.ChromeRemoteDesktop"
  "Microsoft.dotnet"
  "Elgato.GameCapture.HD"
  "Mojang.MinecraftLauncher"
  "Microsoft.PowerToys"
  "TechPowerUp.GPU-Z"
  "Microsoft.dotnet"
  "GitHub.cli"
  "Microsoft.WindowsPCHealthCheck"
  "EpicGames.EpicGamesLauncher"
  "Microsoft.VisualStudioCode"
  "GoLang.Go"
  "WinMerge.WinMerge"
  "Neovim.Neovim"
  "sharkdp.bat"
  "Zeit.Hyper"
  "MAMP.MAMP" # Install Fails
  "Alacritty.Alacritty"
  "wez.wezterm"
  "tailscale.tailscale"
  "Cloudflare.Warp"
  "Cloudflare.cloudflared"
  "Readdle.Spark"
  "OBSProject.OBSStudio"
  "Rclone.Rclone"
  "LGUG2Z.komorebi"
  "LGUG2Z.whkd"
  # "Microsoft.VC++2015-2019Redist-x86"
  # "Microsoft.VC++2008Redist-x86"
  # "Microsoft.VC++2013Redist-x86"
  # "Microsoft.VC++2010Redist-x86"
  # "Microsoft.dotnetRuntime.5-x86"
  # "Microsoft.VC++2005Redist-x64"
  # "Microsoft.dotnetRuntime.3-x86"
  # "Microsoft.VC++2012Redist-x64"
  # "Microsoft.VC++2013Redist-x86"
  # "Microsoft.VC++2013Redist-x64"
  # "Microsoft.VC++2013Redist-x64"
  # "Microsoft.VC++2010Redist-x64"
  # "Microsoft.VC++2015-2019Redist-x64"
  # "Microsoft.VC++2012Redist-x86"
  # "Microsoft.VC++2008Redist-x64"
)

# --- Scoop ---
$ErrorActionPreference = "silentlycontinue"

if (Get-Command scoop) {
  Write-Host "Scoop is already installed. `r`n" -ForegroundColor Green

  $ErrorActionPreference = "continue"
}
else {
  Write-Host "Scoop is not installed." -ForegroundColor Red
  Write-Host "Installing Scoop... `r`n"

  $ErrorActionPreference = "continue"

  Set-ExecutionPolicy RemoteSigned -Scope CurrentUser
  Invoke-RestMethod get.scoop.sh | Invoke-Expression
  Write-Host "Scoop is successfully installed! `r`n" -ForegroundColor Green
}

Write-Host ("Adding scoop buckets...`r`n")
foreach ($bucket in $scoopBuckets) {
  scoop bucket add $bucket
}

Write-Host ("Installing scoop packages...`r`n")
foreach ($package in $scoopPackages) {
  scoop install $package
}

Write-Host "`r`nScoop installation is successfully completed." -ForegroundColor Green

# --- Windows Package Manager ---
Write-Host ("Installing winget packages...`r`n")
foreach ($package in $wingetPackages) {
  winget install -e --id $package
}

Write-Host "`r`nInstallation is successfully completed." -ForegroundColor Green
