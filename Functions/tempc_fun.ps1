# Check CPU Temperature ( NOTE: Shit code! Maybe Not Accruate! Just use HWiNFO App ) ( NOTE: Requires Admin to run )
Function Check-CpuTemperature {
        $TempKelvin = Get-WmiObject -Namespace "root\wmi" -Class MSAcpi_ThermalZoneTemperature | Select-Object -ExpandProperty CurrentTemperature
        if ($TempKelvin) {
                $TempCelsius = ($TempKelvin - 2732) / 10
                Write-Host ("CPU Temperature: {0}°C" -f $TempCelsius)
        } else {
                Write-Host "Could not retrieve CPU temperature."
        }
}
Set-Alias tempc Check-CpuTemperature
