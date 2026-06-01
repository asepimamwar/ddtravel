$htmlFiles = Get-ChildItem -Path "d:\gravity\gotur\gotur-html-main" -Filter "*.html" -Recurse

foreach ($file in $htmlFiles) {
    $content = Get-Content $file.FullName -Raw
    
    # Remove old wa-float (the one that was originally there)
    $content = $content -replace '(?s)<a href="https://wa\.me/[^>]*class="wa-float"[^>]*>.*?</a>\s*', ''
    
    # Remove the floating-wa I injected
    $content = $content -replace '(?s)<!-- WhatsApp Floating Button -->\s*<a href="https://wa\.me/[^>]*class="floating-wa"[^>]*>.*?</a>\s*', ''
    
    # Inject Tawk.to script placeholder before </body>
    if ($content -notmatch 'tawk\.to') {
        $tawkScript = @"
<!--Start of Tawk.to Script-->
<script type="text/javascript">
var Tawk_API=Tawk_API||{}, Tawk_LoadStart=new Date();
(function(){
var s1=document.createElement("script"),s0=document.getElementsByTagName("script")[0];
s1.async=true;
s1.src='https://embed.tawk.to/1234567890abcdef12345678/1default'; // GANTI DENGAN ID TAWK.TO ANDA
s1.charset='UTF-8';
s1.setAttribute('crossorigin','*');
s0.parentNode.insertBefore(s1,s0);
})();
</script>
<!--End of Tawk.to Script-->
</body>
"@
        $content = $content -replace '</body>', $tawkScript
    }

    Set-Content -Path $file.FullName -Value $content -NoNewline
    Write-Host "Updated $($file.FullName)"
}

$cssFile = "d:\gravity\gotur\gotur-html-main\assets\css\gotur.css"
if (Test-Path $cssFile) {
    $cssContent = Get-Content $cssFile -Raw
    # Remove the injected floating-wa css
    $cssContent = $cssContent -replace '(?s)/\* WhatsApp Floating Assistant \*/.*?@keyframes pulse-wa \{.*?\}', ''
    Set-Content -Path $cssFile -Value $cssContent -NoNewline
}
