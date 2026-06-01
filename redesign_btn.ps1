$htmlFiles = Get-ChildItem -Path "d:\gravity\gotur\gotur-html-main" -Filter "*.html" -Recurse

# 1. Update HTML
foreach ($file in $htmlFiles) {
    $content = Get-Content $file.FullName -Raw
    
    # Replace old button content
    if ($content -match '<i class="fas fa-comment-dots"></i>') {
        $content = $content -replace '<i class="fas fa-comment-dots"></i>', '<i class="fas fa-headset"></i> <span>Asisten DD Travel</span>'
        Set-Content -Path $file.FullName -Value $content -NoNewline
        Write-Host "Updated HTML $($file.FullName)"
    }
}

# 2. Update JS
$jsFile = "d:\gravity\gotur\gotur-html-main\assets\js\chatbot.js"
if (Test-Path $jsFile) {
    $jsContent = Get-Content $jsFile -Raw
    
    $jsContent = $jsContent -replace '<i class="fas fa-times"></i>', '<i class="fas fa-times"></i> <span>Tutup</span>'
    $jsContent = $jsContent -replace '<i class="fas fa-comment-dots"></i>', '<i class="fas fa-headset"></i> <span>Asisten DD Travel</span>'
    
    Set-Content -Path $jsFile -Value $jsContent -NoNewline
    Write-Host "Updated JS"
}

# 3. Update CSS
$cssFile = "d:\gravity\gotur\gotur-html-main\assets\css\gotur.css"
if (Test-Path $cssFile) {
    $cssContent = Get-Content $cssFile -Raw
    
    # Replace the #dd-chatbot-button CSS block
    $oldCss = '(?s)#dd-chatbot-button \{.*?\}'
    $newCss = @"
#dd-chatbot-button {
    width: auto;
    height: 50px;
    padding: 0 20px;
    background-color: #056965;
    color: white;
    border-radius: 25px;
    display: flex;
    align-items: center;
    justify-content: center;
    font-size: 15px;
    font-weight: 600;
    cursor: pointer;
    box-shadow: 0 4px 12px rgba(0,0,0,0.2);
    transition: transform 0.3s ease;
    animation: pulse-bot 2s infinite;
    gap: 10px;
}
#dd-chatbot-button i {
    font-size: 20px;
}
"@
    
    $cssContent = $cssContent -replace $oldCss, $newCss
    Set-Content -Path $cssFile -Value $cssContent -NoNewline
    Write-Host "Updated CSS"
}
