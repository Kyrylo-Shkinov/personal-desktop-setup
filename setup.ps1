[Console]::OutputEncoding = [System.Text.Encoding]::UTF8

# Встановлення програм
winget install Git.Git --accept-package-agreements --accept-source-agreements
winget install voidtools.Everything --accept-package-agreements --accept-source-agreements
winget install Flow-Launcher.Flow-Launcher --accept-package-agreements --accept-source-agreements
winget install Rainmeter.Rainmeter --accept-package-agreements --accept-source-agreements
winget install --id=9PF4KZ2VN4W9 --source=msstore --accept-package-agreements --accept-source-agreements

# Клонування репозиторію з налаштуваннями Rainmeter
$repoUrl = "https://github.com/Kyrylo-Shkinov/personal-desktop-setup.git"
$tempPath = "$env:TEMP\rainmeter-setup"

if (Test-Path $tempPath) {
    Remove-Item $tempPath -Recurse -Force
}

git clone $repoUrl $tempPath

# Копіювання Skins до Documents\Rainmeter
$skinsSource = Join-Path $tempPath "Skins"
$skinsDest = Join-Path $env:USERPROFILE "Documents\Rainmeter\Skins"

# Видаляємо конфліктні файли у Skins (файли, які заважають копіюванню директорій)
Get-ChildItem $skinsSource | ForEach-Object {
    $targetPath = Join-Path $skinsDest $_.Name
    if (Test-Path $targetPath -PathType Leaf) {
        Remove-Item $targetPath -Force
    }
}

Copy-Item "$skinsSource\*" -Destination $skinsDest -Recurse -Force

# Копіювання Rainmeter (Layouts + ini) до AppData\Roaming\Rainmeter
$rainmeterSource = Join-Path $tempPath "Rainmeter"
$rainmeterDest = Join-Path $env:APPDATA "Rainmeter"

# Видаляємо конфліктні файли у Rainmeter
Get-ChildItem $rainmeterSource | ForEach-Object {
    $targetPath = Join-Path $rainmeterDest $_.Name
    if (Test-Path $targetPath -PathType Leaf) {
        Remove-Item $targetPath -Force
    }
}

Copy-Item "$rainmeterSource\*" -Destination $rainmeterDest -Recurse -Force

Write-Host "`n✅ Rainmeter скіни та налаштування встановлено." -ForegroundColor Green
Write-Host "Перезавантаж Rainmeter або відкрий Rainmeter → Layouts і вибери потрібний макет."
