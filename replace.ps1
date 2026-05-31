$filePath = "d:\gravity\gotur\gotur-html-main\index.html"
$content = Get-Content $filePath -Raw

# Menus
$content = $content -replace '>Home<', '>Beranda<'
$content = $content -replace '>Tours<', '>Paket Wisata<'
$content = $content -replace '>Destination<', '>Destinasi<'
$content = $content -replace '>Pages<', '>Halaman<'
$content = $content -replace '>Blog<', '>Artikel<'
$content = $content -replace '>Contact<', '>Kontak<'

# Hero & General Buttons
$content = $content -replace 'Exploring Beautiful <br> Destinations', 'Sahabat Perjalanan <br> Ibadah & Liburan Anda'
$content = $content -replace '>Find Tours<', '>Cari Paket<'
$content = $content -replace '>Book Now<', '>Pesan Sekarang<'
$content = $content -replace '>Discover More<', '>Selengkapnya<'
$content = $content -replace '>get in touch ', '>Hubungi Kami '

# About Section
$content = $content -replace '>About Us<', '>Tentang Kami<'
$content = $content -replace '>about DD Travel<', '>Tentang DD Travel<'
$content = $content -replace 'Get to know us', 'Kenali Kami Lebih Dekat'
$content = $content -replace 'Plan Your Trip with Trevily', 'Rencanakan Ibadah & Liburan Bersama DD Travel'
$content = $content -replace 'There are many variations of passages of available but the majority have suffered alteration in some form, by injected hum randomised words which don''t look even slightly.', 'Kami adalah agen perjalanan yang berdedikasi melayani perjalanan Umrah, Haji, Wisata Halal, dan Wisata Nusantara dengan amanah, nyaman, dan terpercaya.'
$content = $content -replace 'Invest in your simply neighborhood', 'Pembimbing Ibadah Berpengalaman'
$content = $content -replace 'Support people in free text extreme need', 'Fasilitas Nyaman & Harga Terjangkau'
$content = $content -replace 'Largest global industrial business community', 'Destinasi Wisata Halal Terbaik'

# Tours Section
$content = $content -replace 'Featured tours', 'Paket Pilihan Kami'
$content = $content -replace 'Most Popular Tours', 'Paket Umrah & Wisata Terpopuler'

# Let's replace some tour names
$content = $content -replace 'National Park 2 Days Tour', 'Paket Umrah Reguler 9 Hari'
$content = $content -replace 'Dark Forest Adventure', 'Paket Umrah Plus Turki 12 Hari'
$content = $content -replace 'Discover Depth of Beach', 'Paket Haji Khusus (ONH Plus)'
$content = $content -replace 'Moscow Red City Land', 'Wisata Halal Eropa Barat'
$content = $content -replace 'Magic of Italy Tours', 'Pesona Wisata Halal Jepang'
$content = $content -replace 'Discover the new world', 'Eksplorasi Raja Ampat & Bali'
$content = $content -replace 'Discover depth of beach', 'Paket Liburan Nusantara'
$content = $content -replace 'Dark forest adventure', 'Paket Spesial Ramadhan'

# Misc
$content = $content -replace 'Tours & Travel', 'Umrah, Haji & Wisata Halal'
$content = $content -replace 'Subscribe our newsletter', 'Berlangganan Info & Promo'
$content = $content -replace 'Email address', 'Alamat Email'
$content = $content -replace '>subscribe now<', '>Berlangganan<'
$content = $content -replace 'Useful Links', 'Tautan Berguna'
$content = $content -replace 'needhelp@DD Travel.com', 'info@ddtravel.com'

Set-Content -Path $filePath -Value $content -NoNewline
