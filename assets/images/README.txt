Kumpulan gambar yang dipakai aplikasi (logo, ilustrasi, ikon, dll).

CARA MENAMBAH GAMBAR
1. Taruh file gambar (PNG/JPG/SVG* konversi ke PNG) di folder ini: assets/images/
2. Tidak perlu mengubah pubspec.yaml jika sudah mendeklarasikan folder 'assets/images/'.
3. Arahkan widget di kode dengan path relatif, contoh:
     Image.asset('assets/images/nama_gambar.png', fit: BoxFit.cover, width: 64, height: 64)
4. Jalankan ulang aplikasi (flutter run / hot restart R) agar aset baru ikut ter-bundle.

CATATAN
- Celah keamanan: jangan masukkan gambar berisi data pribadi tamu.
- Nama file gunakan snake_case, contoh: logo_findit.png, badge_ditemukan.png.