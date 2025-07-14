Function Create-CaddyFile {
    $FilePath = "CaddyFile"
    
    if (Test-Path $FilePath) {
        $Response = Read-Host "'$FilePath' already exists. Overwrite it? (y/n)"
        if ($Response -ne "y") {
            Write-Host "Aborting..." -ForegroundColor Red
            return
        }
    }


    $CaddyConfig = @"
localhost {
    encode gzip          # Enable GZIP compression
    templates            # Allow dynamic templates
    file_server browse   # Serve files with directory browsing

    # encode zstd gzip             # Enable Zstandard compression alongside GZIP
    # reverse_proxy localhost:3000 # Forward requests to a backend service
    # header {                     # Add security headers
    #     Strict-Transport-Security "max-age=31536000;"
    #     X-Content-Type-Options "nosniff"
    #     Referrer-Policy "no-referrer-when-downgrade"
    # }
    # @static {                    # Match static asset requests
    #     file
    #     path *.css *.js *.png *.jpg *.svg
    # }
    # header @static Cache-Control "max-age=5184000" # Cache static assets
    # {
    #     debug                    # Enable verbose logging for troubleshooting
    # }
}
"@

    Set-Content -Path $FilePath -Value $CaddyConfig
    Write-Host "CaddyFile Created ✅" -ForegroundColor Green
}
Set-Alias ccf Create-CaddyFile
