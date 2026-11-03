# 以 PowerShell 執行；已安裝的會略過。安裝後請重開終端機讓 PATH 生效。
$ErrorActionPreference = 'Continue'

function Ensure-UserPath([string]$PathToAdd) {
    if (-not (Test-Path -LiteralPath $PathToAdd)) { return }
    $parts = [Environment]::GetEnvironmentVariable('PATH', 'User') -split ';' | Where-Object { $_ -ne '' }
    if ($parts -notcontains $PathToAdd) {
        [Environment]::SetEnvironmentVariable('PATH', (($parts + $PathToAdd) -join ';'), 'User')
        Write-Host "已加入使用者 PATH：$PathToAdd"
    }
    if (($env:PATH -split ';') -notcontains $PathToAdd) { $env:PATH = "$($env:PATH);$PathToAdd" }
}

# 核心三件
if (-not (Get-Command blender -ErrorAction SilentlyContinue)) { winget install --id BlenderFoundation.Blender -e --accept-package-agreements --accept-source-agreements }
if (-not (Get-Command ffmpeg  -ErrorAction SilentlyContinue)) { winget install --id Gyan.FFmpeg -e --accept-package-agreements --accept-source-agreements }
if (-not (Get-Command node    -ErrorAction SilentlyContinue)) { winget install --id OpenJS.NodeJS.LTS -e --accept-package-agreements --accept-source-agreements }

# Blender 的安裝程式不會自動寫入 PATH，這裡補上（取版本號最大的資料夾）
$blenderRoot = 'C:\Program Files\Blender Foundation'
if (Test-Path -LiteralPath $blenderRoot) {
    $blenderDir = Get-ChildItem -LiteralPath $blenderRoot -Directory -ErrorAction SilentlyContinue |
        Sort-Object Name -Descending | Select-Object -First 1
    if ($blenderDir) { Ensure-UserPath $blenderDir.FullName }
}

# 選用工具
if (-not (Get-Command gifsicle -ErrorAction SilentlyContinue)) {
    winget install --id Gifsicle.Gifsicle -e --accept-package-agreements --accept-source-agreements
    if (-not (Get-Command gifsicle -ErrorAction SilentlyContinue)) {
        Write-Host 'winget 找不到 gifsicle，改用 scoop。'
        if (-not (Get-Command scoop -ErrorAction SilentlyContinue)) {
            Invoke-RestMethod -Uri 'https://get.scoop.sh' | Invoke-Expression
            $env:PATH = "$($env:PATH);$HOME\scoop\shims"
        }
        scoop install gifsicle
    }
}
if (-not (Get-Command sox -ErrorAction SilentlyContinue)) { winget install --id ChrisBagwell.SoX -e --accept-package-agreements --accept-source-agreements }

# 驗證（找不到通常是 PATH 還沒進到這個終端機，重開即可）
Write-Host '--- 驗證 ---'
foreach ($c in @(
        @('blender', @('-b', '--version')),
        @('ffmpeg', @('-version')),
        @('node', @('-v')),
        @('gifsicle', @('--version')),
        @('sox', @('--version'))
    )) {
    $name = $c[0]
    if (Get-Command $name -ErrorAction SilentlyContinue) {
        $out = & $name @($c[1]) 2>&1 | Select-Object -First 1
        Write-Host ("{0,-9} {1}" -f $name, $out)
    } else {
        Write-Host ("{0,-9} 未找到，請重開終端機後再驗證" -f $name)
    }
}
