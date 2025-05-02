# Встановлення програм
winget install Git.Git --accept-package-agreements --accept-source-agreements
winget install voidtools.Everything --accept-package-agreements --accept-source-agreements
winget install Flow-Launcher.Flow-Launcher --accept-package-agreements --accept-source-agreements
winget install Rainmeter.Rainmeter --accept-package-agreements --accept-source-agreements
winget install CharlesMilette.TransparentTB --accept-package-agreements --accept-source-agreements

# Клонування репозиторію з налаштуваннями Rainmeter
$repoUrl = "https://github.com/your-username/your-repo.git"
$tempPath = "$env:TEMP\rainmeter-setup"

if (Test-Path $tempPath) {
    Remove-Item $tempPath -Recurse -Force
}

git clone $repoUrl $tempPath

# Копіювання Skins до Documents\Rainmeter
$skinsSource = Join-Path $tempPath "Skins"
$skinsDest = Join-Path $env:USERPROFILE "Documents\Rainmeter\Skins"
Copy-Item $skinsSource\* -Destination $skinsDest -Recurse -Force

# Копіювання Rainmeter (Layouts + ini) до AppData\Roaming\Rainmeter
$rainmeterSource = Join-Path $tempPath "Rainmeter"
$rainmeterDest = Join-Path $env:APPDATA "Rainmeter"
Copy-Item $rainmeterSource\* -Destination $rainmeterDest -Recurse -Force

Write-Host "`n✅ Rainmeter скіни та налаштування встановлено." -ForegroundColor Green
Write-Host "Перезавантаж Rainmeter або відкрий Rainmeter → Layouts і вибери потрібний макет."
