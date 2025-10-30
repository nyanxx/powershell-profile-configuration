Function Dirfzf {
    param(
        [ValidateSet("d", "f")]
        [String]$Type = "d"
    )

    $Selected = fzf
    if (-not $Selected) {
        Write-Host "No selection made."
        return
    }

    $FullPath = "$(pwd)\$Selected"
    #$FullPath = Join-Path (Get-Location) $Selected

    if ($Type -eq "f") {
        if (Test-Path $FullPath -PathType Leaf) {
            Invoke-Item $FullPath
        } else {
            Write-Host "Selected item is not a file: $fullPath"
        }
    } else {
        $Dir = [System.IO.Path]::GetDirectoryName($FullPath)
        if (Test-Path $Dir -PathType Container) {
            Set-Location $Dir
        } else {
            Write-Host "Directory not found: $Dir"
        }
    }
}
Set-Alias dff Dirfzf
