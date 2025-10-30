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
# Replace "localhost" with your domain for production (example.com)
localhost {
    ########################
    # Core / Basic Options
    ########################
    #root * /var/www/html             # Set root directory (replace /var/www/html with your actual project folder)
    file_server browse                # Serve static files; "browse" enables directory listing
    encode gzip zstd                  # Compression: gzip + zstd
    #encode gzip zstd brotli          # Compression: gzip, zstd, brotli (client support required)
    templates                         # Enable Caddy templates for dynamic HTML rendering

    ########################
    # Logging / Debugging
    ########################
    # Uncomment to enable structured logs to file for debugging/audit
    # log {
    #     output file /var/log/caddy/access.log {
    #         roll_size 10mb
    #         roll_keep 5
    #         roll_keep_for 240h
    #     }
    #     format json
    #     level INFO
    # }

    # Uncomment for verbose logs during development
    log {
        output stdout
        level DEBUG
    }

    # Uncomment for verbose console logs during development
    # debug

    ########################
    # Security Headers (recommended)
    ########################
    # Keep this enabled unless it breaks a specific dev workflow
    header {
        Strict-Transport-Security "max-age=63072000; includeSubDomains; preload"
        X-Content-Type-Options "nosniff"
        X-Frame-Options "DENY"
        Referrer-Policy "no-referrer-when-downgrade"
        Permissions-Policy "geolocation=(), microphone=()"
    }

    ########################
    # Content Security Policy (customize for your site)
    ########################
    # Fine-tune these sources to match your CDNs and inline needs
    # header Content-Security-Policy "default-src 'self'; script-src 'self' 'unsafe-inline' https://cdn.example.com; style-src 'self' 'unsafe-inline' https://fonts.googleapis.com; img-src 'self' data: https:; font-src 'self' https://fonts.gstatic.com; frame-ancestors 'none'; object-src 'none'"

    ########################
    # Static asset caching
    ########################
    @fingerprinted {
        path_regexp fp \.([a-f0-9]{8,})\.(css|js|png|jpg|jpeg|svg|webp|woff2)$
    }
    header @fingerprinted Cache-Control "public, max-age=31536000, immutable"

    @assets {
        path *.css *.js *.png *.jpg *.jpeg *.svg *.webp *.ico *.woff2
    }
    header @assets Cache-Control "public, max-age=86400"

    ########################
    # SPA routing (single-page apps)
    ########################
    # Uncomment if you serve a SPA and want unknown paths to serve index.html
    # handle {
    #     try_files {path} /index.html
    # }

    ########################
    # Reverse proxy examples
    ########################
    # Simple API proxy
    # handle_path /api/* {
    #     reverse_proxy 127.0.0.1:8000
    # }

    # App proxy (e.g., Node/React dev server)
    # handle_path /app/* {
    #     reverse_proxy 127.0.0.1:3000
    # }

    # Load-balanced backends with health checks
    # handle_path /service/* {
    #     reverse_proxy {
    #         to 10.0.0.2:8080 10.0.0.3:8080
    #         lb_policy least_conn
    #         health_uri /health
    #     }
    # }

    ########################
    # Rate limiting (basic)
    ########################
    # Protect endpoints from abuse - tune limits to your needs
    # @all_requests {
    #     remote_ip 0.0.0.0/0
    # }
    # rate_limit @all_requests 60r/m

    ########################
    # Maintenance / Health endpoints
    ########################
    handle_path /health {
        respond "OK" 200
    }

    # Maintenance flag example: set a header "Maintenance: 1" to show a 503
    # @maintenance {
    #     expression `{http.request.header.Maintenance} == "1"`
    # }
    # handle @maintenance {
    #     respond "Site temporarily offline for maintenance" 503
    # }

    ########################
    # Redirects and rewrites
    ########################
    # Redirect http to https when using a real domain and TLS enabled
    # redir http://{host}{uri} https://{host}{uri} 308

    # Example: redirect old-path to new-path
    # redir /old-path /new-path 301

    ########################
    # TLS / HTTPS
    ########################
    # Automatic Let's Encrypt for public domains
    # tls you@example.com

    # Local development self-signed (trust via `caddy trust`)
    # tls internal

    ########################
    # Custom error pages
    ########################
    # Uncomment and point to your custom error pages
    # handle_errors {
    #     @404 {
    #         expression `{http.error.status_code} == 404`
    #     }
    #     handle @404 {
    #         rewrite * /errors/404.html
    #         file_server
    #     }
    #     respond "{http.error.status_code} {http.error}" 500
    # }

    ########################
    # Extra: WebSocket passthrough (example)
    ########################
    # handle_path /ws/* {
    #     reverse_proxy http://127.0.0.1:8081 {
    #         transport http {
    #             versions 1.1
    #         }
    #     }
    # }

}
"@

    Set-Content -Path $FilePath -Value $CaddyConfig
    Write-Host "CaddyFile Created ✅" -ForegroundColor Green
}
Set-Alias ccf Create-CaddyFile
