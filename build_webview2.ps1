# ========================================================
# Semantic Table Harmonizer - WebView2 极简一键打包脚本
# ========================================================
$ErrorActionPreference = "Stop"
$ScriptDir = Split-Path -Parent $MyInvocation.MyCommand.Definition
$DistDir = Join-Path (Split-Path -Parent $ScriptDir) "Semantic_Table_Harmonizer_v0.99a_WebView2"
$ZipOut = Join-Path (Split-Path -Parent $ScriptDir) "Semantic_Table_Harmonizer_v0.99a_WebView2_win-x64.zip"

Write-Host "开始打包 WebView2 极简绿色版..." -ForegroundColor Cyan

if (Test-Path $DistDir) { Remove-Item $DistDir -Recurse -Force }
New-Item -ItemType Directory -Path $DistDir | Out-Null

# 拷贝核心文件
Copy-Item (Join-Path $ScriptDir "Semantic_Table_Harmonizer.exe") $DistDir -Force
Copy-Item (Join-Path $ScriptDir "Semantic_Table_Harmonizer_v0.99a.html") $DistDir -Force
Copy-Item (Join-Path $ScriptDir "Semantic_Table_Harmonizer_dictionary_v0.99a.js") $DistDir -Force
Copy-Item (Join-Path $ScriptDir "icon") $DistDir -Recurse -Force

# 打包为 zip
if (Test-Path "D:\SOFTWARE\7-Zip\7z.exe") {
    if (Test-Path $ZipOut) { Remove-Item $ZipOut -Force }
    & "D:\SOFTWARE\7-Zip\7z.exe" a -tzip $ZipOut "$DistDir\*" -mx=9 | Out-Null
    Write-Host "成功生成发布压缩包: $ZipOut (大小约 $((Get-Item $ZipOut).Length / 1KB) KB)" -ForegroundColor Green
}
Write-Host "打包完成！产物位于: $DistDir" -ForegroundColor Green