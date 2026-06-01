$replacements = [System.Collections.Generic.Dictionary[string, string]]::new([System.StringComparer]::Ordinal)

# Index.html khusus
$replacements.Add('About gotur', 'Tentang DD Travel')
$replacements.Add('About company', 'Tentang Perusahaan')
$replacements.Add('Travel place for Your & your Family', 'Destinasi Wisata Terbaik untuk Anda & Keluarga')
$replacements.Add('Easy & Quick Booking', 'Pemesanan Mudah & Cepat')
$replacements.Add('Best Price Guarantee', 'Garansi Harga Terbaik')
$replacements.Add('Mission & Vision', 'Misi & Visi')
$replacements.Add('Discover More', 'Jelajahi Lebih Lanjut')
$replacements.Add('Call Us Now', 'Hubungi Kami Sekarang')
$replacements.Add('What We’re Offering', 'Apa yang Kami Tawarkan')
$replacements.Add('Get 30% Discount Every Tour', 'Dapatkan Diskon Menarik Setiap Perjalanan')
$replacements.Add('Start Booking', 'Mulai Pemesanan')
$replacements.Add('How It Works Step by Step', 'Cara Kerja Tahap demi Tahap')
$replacements.Add('Select Destination', 'Pilih Destinasi')
$replacements.Add('Make an Appointments', 'Lakukan Pemesanan')
$replacements.Add('Enjoy Our Tour', 'Nikmati Perjalanan Anda')
$replacements.Add('Latest Client Feedback', 'Ulasan Terbaru Pelanggan Kami')
$replacements.Add('Co, Founder', 'Rekan Pendiri')
$replacements.Add('Founder', 'Pendiri')
$replacements.Add('Brands Trust Us', 'Mitra yang Mempercayai Kami')
$replacements.Add('Great Opportunity for Adventure & Travels', 'Kesempatan Emas untuk Petualangan & Perjalanan')
$replacements.Add('Trusted travel guide', 'Pemandu Perjalanan Terpercaya')
$replacements.Add('Tours success', 'Perjalanan Sukses')
$replacements.Add('Of Experience', 'Pengalaman')
$replacements.Add('Years', 'Tahun')
$replacements.Add('Our gallery', 'Galeri Kami')
$replacements.Add('Watch Our Gallery', 'Lihat Galeri Perjalanan Kami')
$replacements.Add('Latest News & Articles', 'Berita & Artikel Terbaru')
$replacements.Add('Our blog', 'Blog Kami')
$replacements.Add('We’re Number One Travel Adventure Company', 'Kami adalah Agen Perjalanan & Umrah Terpercaya')

# Lakukan penggantian khusus di index.html
$file = "d:\gravity\gotur\gotur-html-main\index.html"
$content = Get-Content $file -Raw
$changed = $false

foreach ($key in $replacements.Keys) {
    if ($content.Contains($key)) {
        $content = $content.Replace($key, $replacements[$key])
        $changed = $true
    }
}

if ($changed) {
    Set-Content $file -Value $content -NoNewline
    Write-Host "Updated index.html khusus"
}
