# 以 PowerShell 執行；已安裝的會略過。安裝後請重開終端機讓 PATH 生效。
if (-not (Get-Command blender -ErrorAction SilentlyContinue)) { winget install --id BlenderFoundation.Blender -e }
if (-not (Get-Command ffmpeg  -ErrorAction SilentlyContinue)) { winget install --id Gyan.FFmpeg -e }
if (-not (Get-Command node    -ErrorAction SilentlyContinue)) { winget install --id OpenJS.NodeJS.LTS -e }
blender -b --version
ffmpeg -version | Select-Object -First 1
node -v
