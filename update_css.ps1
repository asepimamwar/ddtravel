$cssFile = "d:\gravity\gotur\gotur-html-main\assets\css\gotur.css"
$cssContent = Get-Content $cssFile -Raw
$cssContent = $cssContent -replace 'filter: brightness\(0\) invert\(1\);', 'filter: brightness(0) invert(1) !important;'
Set-Content -Path $cssFile -Value $cssContent -NoNewline
