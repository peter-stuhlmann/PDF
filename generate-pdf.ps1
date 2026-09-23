<#
.SYNOPSIS
    Erzeugt aus einer HTML-Datei ein DIN-A4-PDF (Standard: ga4_setup_merkblatt.html).

.DESCRIPTION
    Nutzt Google Chrome oder Microsoft Edge im Headless-Modus. Keine weiteren
    Abhaengigkeiten noetig. Hintergrundgrafiken werden ueber das CSS
    (print-color-adjust: exact) mitgedruckt, Kopf-/Fusszeilen des Browsers
    werden unterdrueckt.

.EXAMPLE
    .\generate-pdf.ps1
    .\generate-pdf.ps1 -InputFile .\anderes.html -OutputFile .\out\anderes.pdf
    .\generate-pdf.ps1 -Open
#>
[CmdletBinding()]
param(
    [string]$InputFile,
    [string]$OutputFile,
    [string]$BrowserPath,
    [switch]$Open
)

$ErrorActionPreference = 'Stop'

if (-not $InputFile) {
    $InputFile = Join-Path (Split-Path -Parent $MyInvocation.MyCommand.Path) 'ga4_setup_merkblatt.html'
}

$InputFile = (Resolve-Path -LiteralPath $InputFile).Path
if (-not $OutputFile) {
    $OutputFile = [System.IO.Path]::ChangeExtension($InputFile, '.pdf')
}
$OutputFile = [System.IO.Path]::GetFullPath($OutputFile)
$outDir = Split-Path -Parent $OutputFile
if (-not (Test-Path -LiteralPath $outDir)) {
    New-Item -ItemType Directory -Force -Path $outDir | Out-Null
}

if (-not $BrowserPath) {
    $candidates = @(
        "$env:ProgramFiles\Google\Chrome\Application\chrome.exe",
        "${env:ProgramFiles(x86)}\Google\Chrome\Application\chrome.exe",
        "$env:LOCALAPPDATA\Google\Chrome\Application\chrome.exe",
        "${env:ProgramFiles(x86)}\Microsoft\Edge\Application\msedge.exe",
        "$env:ProgramFiles\Microsoft\Edge\Application\msedge.exe"
    )
    $BrowserPath = $candidates | Where-Object { $_ -and (Test-Path -LiteralPath $_) } | Select-Object -First 1
}
if (-not $BrowserPath) {
    throw 'Weder Chrome noch Edge gefunden. Pfad mit -BrowserPath angeben.'
}

if (Test-Path -LiteralPath $OutputFile) {
    try { Remove-Item -LiteralPath $OutputFile -Force -ErrorAction Stop }
    catch { throw "PDF ist noch geoeffnet (z. B. im PDF-Viewer) - bitte schliessen: $OutputFile" }
}

$fileUrl = ([System.Uri]$InputFile).AbsoluteUri
# Eigenes Profil, damit ein bereits laufender Browser nicht stoert
$profileDir = Join-Path ([System.IO.Path]::GetTempPath()) ("pdfgen-" + [guid]::NewGuid())

$browserArgs = @(
    '--headless=new',
    '--disable-gpu',
    '--no-first-run',
    '--no-default-browser-check',
    "--user-data-dir=`"$profileDir`"",
    '--no-pdf-header-footer',
    '--run-all-compositor-stages-before-draw',
    '--virtual-time-budget=5000',
    "--print-to-pdf=`"$OutputFile`"",
    "`"$fileUrl`""
)

Write-Host "Browser: $BrowserPath"
Write-Host "Eingabe: $InputFile"
$proc = Start-Process -FilePath $BrowserPath -ArgumentList $browserArgs -Wait -PassThru -WindowStyle Hidden
# Browser-Hilfsprozesse halten das Profil evtl. noch kurz gesperrt
for ($i = 0; $i -lt 10 -and (Test-Path -LiteralPath $profileDir); $i++) {
    try { Remove-Item -LiteralPath $profileDir -Recurse -Force -ErrorAction Stop }
    catch { Start-Sleep -Milliseconds 500 }
}

if (-not (Test-Path -LiteralPath $OutputFile)) {
    throw "PDF wurde nicht erzeugt (Exit-Code $($proc.ExitCode))."
}

Write-Host "PDF erstellt: $OutputFile" -ForegroundColor Green
if ($Open) { Invoke-Item -LiteralPath $OutputFile }
