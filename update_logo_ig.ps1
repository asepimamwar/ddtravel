$htmlFiles = Get-ChildItem -Path "d:\gravity\gotur\gotur-html-main" -Filter "*.html" -Recurse

foreach ($file in $htmlFiles) {
    $content = Get-Content $file.FullName -Raw
    
    # Update instagram links
    $newContent = $content -replace 'href="https://(?:www\.)?instagram\.com/?([^"]*)"', 'href="https://www.instagram.com/ddtravell/"'
    
    if ($content -cne $newContent) {
        Set-Content -Path $file.FullName -Value $newContent -NoNewline
        Write-Host "Updated $($file.FullName)"
    }
}

$cssFile = "d:\gravity\gotur\gotur-html-main\assets\css\gotur.css"
if (Test-Path $cssFile) {
    $cssContent = Get-Content $cssFile -Raw
    $cssFix = @"

.header-right-sidebar__logo-box img {
    filter: brightness(0) invert(1);
}
"@
    if ($cssContent -notmatch "\.header-right-sidebar__logo-box\s*img\s*\{") {
        Add-Content -Path $cssFile -Value $cssFix
        Write-Host "Updated $cssFile"
    }
}
