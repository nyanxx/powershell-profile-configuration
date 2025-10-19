param (
    [string]$Path = "."
)

function Get-ReadableSize {
    param ([int64]$bytes)
    switch ($bytes) {
        {$_ -ge 1PB} {"{0:N2} PB" -f ($bytes / 1PB); break}
        {$_ -ge 1TB} {"{0:N2} TB" -f ($bytes / 1TB); break}
        {$_ -ge 1GB} {"{0:N2} GB" -f ($bytes / 1GB); break}
        {$_ -ge 1MB} {"{0:N2} MB" -f ($bytes / 1MB); break}
        {$_ -ge 1KB} {"{0:N2} KB" -f ($bytes / 1KB); break}
        default {"$bytes Bytes"}
    }
}

$ErrorActionPreference = "Stop"
$fullPath = Resolve-Path $Path
$size = Get-ChildItem -Recurse -Force $fullPath | Measure-Object -Property Length -Sum
$readable = Get-ReadableSize $size.Sum

Write-Host "$($fullPath): $readable"

