$files = Get-ChildItem -Path "d:\gravity\gotur\gotur-html-main" -Filter "*.html" -Recurse
foreach ($file in $files) {
    $content = Get-Content $file.FullName -Raw
    $newContent = $content -replace '<a href="https://www.google.com/maps">Perkantoran Palem Ganda Asri Limo Raya No.02 - Depok</a>', '<a href="https://maps.app.goo.gl/P9o4Mzau3NqQXQFD6">Perkantoran Palem Ganda Asri Limo Raya No.02 - Depok</a>'
    
    # Also update the iframe in contact.html or similar map embeds
    $newContent = $newContent -replace 'q=Perkantoran\+Palem\+Ganda\+Asri\+Limo\+Raya\+No\.02\+-\+Depok', 'q=DD+Travel+(Raudha+Rahma+Abadi)'
    
    if ($content -cne $newContent) {
        Set-Content -Path $file.FullName -Value $newContent -NoNewline
        Write-Host "Updated $($file.FullName)"
    }
}
