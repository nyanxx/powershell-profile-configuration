function Get-TNTStorePath {
    $dir = Join-Path $HOME '.tnt'
    if (-not (Test-Path $dir)) {
        New-Item -ItemType Directory -Path $dir -Force | Out-Null
    }
    Join-Path $dir 'notes.json'
}

function Get-TNTStore {
    $path = Get-TNTStorePath
    if (-not (Test-Path $path)) {
        return [pscustomobject]@{ NextId = 1; Notes = @() }
    }

    $raw = Get-Content -Path $path -Raw -ErrorAction SilentlyContinue
    if ([string]::IsNullOrWhiteSpace($raw)) {
        return [pscustomobject]@{ NextId = 1; Notes = @() }
    }

    $store = $raw | ConvertFrom-Json
    if ($null -eq $store.Notes) {
        $store.Notes = @()
    } else {
        $store.Notes = @($store.Notes)
    }
    return $store
}

function Save-TNTStore {
    param($Store)
    $path = Get-TNTStorePath
    $Store | ConvertTo-Json -Depth 5 | Set-Content -Path $path -Encoding UTF8
}

function Format-TNTNote {
    param($Note, [switch]$Verbose)
    if ($Verbose) {
        $ts = ([datetime]$Note.CreatedAt).ToString('yyyy-MM-dd HH:mm:ss')
        Write-Host "[$($Note.Id)] " -NoNewline -ForegroundColor Cyan
        Write-Host "$($Note.Text)  " -NoNewline
        Write-Host "($ts)" -ForegroundColor DarkGray
    } else {
        Write-Host "[$($Note.Id)] " -NoNewline -ForegroundColor Cyan
        Write-Host $Note.Text
    }
}

function Show-TNTHelp {
    @"
tnt / tnotes - simple persistent terminal notes

Usage:
  tnt                      List all notes
  tnt -v | --verbose       List all notes with timestamps
  tnt add <text>           Save a new note
  tnt <id>                 Show a single note
  tnt <id> -v              Show a single note with timestamp
  tnt del <id>             Delete a note
  tnt prune                Delete ALL notes (asks for confirmation)
  tnt -h | --help          Show this help
"@ | Write-Host
}

function Invoke-TNTNotes {
    $tntArgs = $args

    if ($tntArgs.Count -eq 0) {
        $store = Get-TNTStore
        if ($store.Notes.Count -eq 0) {
            Write-Host 'No notes yet. Use "tnt add <text>" to create one.'
            return
        }
        foreach ($note in $store.Notes) { Format-TNTNote -Note $note }
        return
    }

    $first = $tntArgs[0]

    switch -Regex ($first) {
        '^(-h|--help)$' {
            Show-TNTHelp
            return
        }
        '^(-v|--verbose)$' {
            if ($tntArgs.Count -gt 1) {
                Write-Host "Unrecognized arguments: $($tntArgs[1..($tntArgs.Count-1)] -join ' ')" -ForegroundColor Red
                Show-TNTHelp
                return
            }
            $store = Get-TNTStore
            if ($store.Notes.Count -eq 0) {
                Write-Host 'No notes yet. Use "tnt add <text>" to create one.'
                return
            }
            foreach ($note in $store.Notes) { Format-TNTNote -Note $note -Verbose }
            return
        }
        '^add$' {
            $text = ($tntArgs[1..($tntArgs.Count-1)] -join ' ').Trim()
            if ([string]::IsNullOrWhiteSpace($text)) {
                Write-Host 'Note text is required. Usage: tnt add <text>' -ForegroundColor Red
                return
            }
            $store = Get-TNTStore
            $newNote = [pscustomobject]@{
                Id        = $store.NextId
                Text      = $text
                CreatedAt = (Get-Date).ToString('o')
            }
            $store.Notes = @($store.Notes) + $newNote
            $store.NextId = $store.NextId + 1
            Save-TNTStore -Store $store
            Write-Host "Added note #$($newNote.Id)" -ForegroundColor Green
            return
        }
        '^del$' {
            if ($tntArgs.Count -lt 2 -or -not [int]::TryParse($tntArgs[1], [ref]$null)) {
                Write-Host 'Usage: tnt del <id>' -ForegroundColor Red
                return
            }
            $id = [int]$tntArgs[1]
            $store = Get-TNTStore
            $target = $store.Notes | Where-Object { $_.Id -eq $id }
            if (-not $target) {
                Write-Host "Note $id not found" -ForegroundColor Red
                return
            }
            $store.Notes = @($store.Notes | Where-Object { $_.Id -ne $id })
            Save-TNTStore -Store $store
            Write-Host "Deleted note #$id" -ForegroundColor Green
            return
        }
        '^prune$' {
            $store = Get-TNTStore
            $count = $store.Notes.Count
            if ($count -eq 0) {
                Write-Host 'No notes to delete.'
                return
            }
            $answer = Read-Host "Delete all $count notes? [y/N]"
            if ($answer -match '^(y|yes)$') {
                $store.Notes = @()
                Save-TNTStore -Store $store
                Write-Host 'All notes deleted.' -ForegroundColor Green
            } else {
                Write-Host 'Cancelled.'
            }
            return
        }
        '^-?\d+$' {
            $id = [int]$first
            $verbose = $false
            if ($tntArgs.Count -gt 1) {
                if ($tntArgs[1] -match '^(-v|--verbose)$') {
                    $verbose = $true
                } else {
                    Write-Host "Unrecognized arguments: $($tntArgs[1..($tntArgs.Count-1)] -join ' ')" -ForegroundColor Red
                    Show-TNTHelp
                    return
                }
            }
            $store = Get-TNTStore
            $note = $store.Notes | Where-Object { $_.Id -eq $id }
            if (-not $note) {
                Write-Host "Note $id not found" -ForegroundColor Red
                return
            }
            Format-TNTNote -Note $note -Verbose:$verbose
            return
        }
        default {
            Write-Host "Unrecognized command: $first" -ForegroundColor Red
            Show-TNTHelp
            return
        }
    }
}

Set-Alias -Name tnt -Value Invoke-TNTNotes -Scope Global -Force
Set-Alias -Name tnotes -Value Invoke-TNTNotes -Scope Global -Force
