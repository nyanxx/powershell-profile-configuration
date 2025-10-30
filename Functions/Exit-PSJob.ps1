Function Exit-PSJob {
    param (
        [Parameter(Mandatory = $true)]
        [int]$JobID
    )

    $Job = Get-Job -Id $JobID -ErrorAction SilentlyContinue

    if (-not $Job) {
        Write-Error "No job found with ID $JobID."
        return
    }

    switch ($Job.State) {
        'Running' {
            Write-Host "Stopping job ID $JobID..."
            #Stop-Job -Id $JobID -Force
            Stop-Job -Id $JobID
        }
        'Stopped' {
            Write-Host "Job ID $JobID is already stopped."
        }
        'Completed' {
            Write-Host "Job ID $JobID has completed."
        }
        'Failed' {
            Write-Host "Job ID $JobID has failed."
        }
        default {
            Write-Host "Job ID $JobID is in state: $($Job.State)"
        }
    }

    Write-Host "Removing job ID $JobID..."
    Remove-Job -Id $JobID 
    # Remove-Job -Id $JobID -Force

    return @{
        JobID = $JobID
        Name = $JobID.Name
        PSJobTypeName = $JobID.PSJobTypeName
        Status = $Job.State
        HasMoreData = $Job.HasMoreData
        Location = $Job.Location
        Command = $Job.Command
    }
}
Set-Alias closejob Exit-PSJob
Set-Alias stopjob Exit-PSJob
Set-Alias exitjob Exit-PSJob

