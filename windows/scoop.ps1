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
