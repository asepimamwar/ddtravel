$htmlFiles = Get-ChildItem -Path "d:\gravity\gotur\gotur-html-main" -Filter "*.html" -Recurse

$waHtml = @"
    <!-- WhatsApp Floating Button -->
    <a href="https://wa.me/62811133446?text=Halo%20DD%20Travel,%20saya%20ingin%20bertanya%20seputar%20paket%20travel..." class="floating-wa" target="_blank" aria-label="WhatsApp Us">
        <i class="fab fa-whatsapp"></i>
    </a>
</body>
"@

foreach ($file in $htmlFiles) {
    $content = Get-Content $file.FullName -Raw
    
    # Check if not already injected
    if ($content -notmatch 'class="floating-wa"') {
        # Inject before </body>
        $newContent = $content -replace '</body>', $waHtml
        Set-Content -Path $file.FullName -Value $newContent -NoNewline
        Write-Host "Injected WA into $($file.FullName)"
    }
}

$cssFile = "d:\gravity\gotur\gotur-html-main\assets\css\gotur.css"
if (Test-Path $cssFile) {
    $cssContent = Get-Content $cssFile -Raw
    $cssWa = @"

/* WhatsApp Floating Assistant */
.floating-wa {
    position: fixed;
    width: 60px;
    height: 60px;
    bottom: 30px;
    left: 30px;
    background-color: #25d366;
    color: #FFF;
    border-radius: 50px;
    text-align: center;
    font-size: 35px;
    box-shadow: 2px 2px 10px rgba(0, 0, 0, 0.2);
    z-index: 1000;
    display: flex;
    align-items: center;
    justify-content: center;
    transition: all 0.3s ease;
    animation: pulse-wa 2s infinite;
}
.floating-wa:hover {
    background-color: #128C7E;
    color: #fff;
    transform: scale(1.1);
}
.floating-wa i {
    margin-top: 2px;
}
@keyframes pulse-wa {
    0% { box-shadow: 0 0 0 0 rgba(37, 211, 102, 0.5); }
    70% { box-shadow: 0 0 0 15px rgba(37, 211, 102, 0); }
    100% { box-shadow: 0 0 0 0 rgba(37, 211, 102, 0); }
}
"@
    if ($cssContent -notmatch '\.floating-wa\s*\{') {
        Add-Content -Path $cssFile -Value $cssWa
        Write-Host "Injected CSS into $cssFile"
    }
}
