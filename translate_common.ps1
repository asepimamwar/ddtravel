$htmlFiles = Get-ChildItem -Path "d:\gravity\gotur\gotur-html-main" -Filter "*.html" -Recurse

# Daftar terjemahan yang umum untuk menu navigasi di header/footer
$replacements = [System.Collections.Generic.Dictionary[string, string]]::new([System.StringComparer]::Ordinal)
$replacements.Add('about us</a>', 'Tentang Kami</a>')
$replacements.Add('About Us</a>', 'Tentang Kami</a>')
$replacements.Add('tours list</a>', 'Daftar Paket</a>')
$replacements.Add('Tours List</a>', 'Daftar Paket</a>')
$replacements.Add('tour listing', 'Daftar Paket')
$replacements.Add('Tour Listing', 'Daftar Paket')
$replacements.Add('tour grid', 'Paket Grid')
$replacements.Add('Tour Grid', 'Paket Grid')
$replacements.Add('tour Left', 'Paket Kiri')
$replacements.Add('Tour Left', 'Paket Kiri')
$replacements.Add('tour Right', 'Paket Kanan')
$replacements.Add('Tour Right', 'Paket Kanan')
$replacements.Add('tour Carousel', 'Paket Karusel')
$replacements.Add('Tour Carousel', 'Paket Karusel')
$replacements.Add('Listing Details', 'Detail Paket')
$replacements.Add('destination details', 'Detail Destinasi')
$replacements.Add('Destination Details', 'Detail Destinasi')
$replacements.Add('Our Team', 'Tim Kami')
$replacements.Add('Team Details', 'Detail Anggota')
$replacements.Add('Pricing Plan', 'Rencana Harga')
$replacements.Add('news grid', 'Grid Berita')
$replacements.Add('news list', 'Daftar Berita')
$replacements.Add('news details', 'Detail Berita')
$replacements.Add('get in touch <i class="icon-paper-plane"></i>', 'Hubungi Kami <i class="icon-paper-plane"></i>')
$replacements.Add('get in touch', 'Hubungi Kami')
$replacements.Add('send email</span>', 'Kirim Email</span>')
$replacements.Add('call agent</span>', 'Telepon Admin</span>')
$replacements.Add('opening time</span>', 'Waktu Buka</span>')
$replacements.Add('useful links</h2>', 'Tautan Penting</h2>')
$replacements.Add('useful links', 'Tautan Penting')
$replacements.Add('Ready to Get Started?', 'Siap untuk Memulai Perjalanan?')
$replacements.Add('Your Name*', 'Nama Lengkap*')
$replacements.Add('Your Email*', 'Email Anda*')
$replacements.Add('Message*', 'Pesan Anda*')
$replacements.Add('Write Message . . ', 'Tulis pesan Anda di sini...')
$replacements.Add('Your email address', 'Alamat email Anda')
$replacements.Add('subscribe now', 'langganan sekarang')
$replacements.Add('Subscribe Now', 'Langganan Sekarang')
$replacements.Add('I agree to the', 'Saya setuju dengan')
$replacements.Add('Privacy Policy.', 'Kebijakan Privasi.')

foreach ($file in $htmlFiles) {
    $content = Get-Content $file.FullName -Raw
    $changed = $false

    foreach ($key in $replacements.Keys) {
        if ($content.Contains($key)) {
            $content = $content.Replace($key, $replacements[$key])
            $changed = $true
        }
    }

    if ($changed) {
        Set-Content $file.FullName -Value $content -NoNewline
        Write-Host "Updated: $($file.Name)"
    }
}
