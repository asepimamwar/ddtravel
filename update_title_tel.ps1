$htmlFiles = Get-ChildItem -Path "d:\gravity\gotur\gotur-html-main" -Filter "*.html" -Recurse

foreach ($file in $htmlFiles) {
    $content = Get-Content $file.FullName -Raw
    
    # Update title
    $newContent = $content -replace '(?i)<title>.*?</title>', '<title>DD Travel</title>'
    
    # Update all tel links to WhatsApp link
    $newContent = $newContent -replace 'href="tel:[^"]+"', 'href="https://wa.me/62811133446"'
    
    if ($content -cne $newContent) {
        Set-Content -Path $file.FullName -Value $newContent -NoNewline
        Write-Host "Updated $($file.FullName)"
    }
}

$cssFile = "d:\gravity\gotur\gotur-html-main\assets\css\gotur.css"
if (Test-Path $cssFile) {
    $cssContent = Get-Content $cssFile -Raw
    $cssFix = @"
.contact-top__item__title {
    word-wrap: break-word;
    word-break: break-word;
    text-align: center;
}
.contact-top__item__title a {
    word-break: break-word;
}
"@
    if ($cssContent -notmatch "\.contact-top__item__title\s*\{") {
        Add-Content -Path $cssFile -Value "`r`n$cssFix"
        Write-Host "Updated $cssFile"
    } else {
        # If it already exists, just append at the end anyway for override
        Add-Content -Path $cssFile -Value "`r`n$cssFix"
        Write-Host "Updated $cssFile"
    }
}
