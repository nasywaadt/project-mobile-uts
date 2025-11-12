# 🚀 UTS PEMROGRAMAN MOBILE

**NAMA:** Nasywa Adita Zain
**NIM:** 152023006
**Program Studi:** Informatika
**Dosen:** Galih Ashari R., S.Si., MT

---

## 🎯 Tujuan Proyek (Jawaban Soal No. 1)

Proyek ini dikembangkan sebagai **Ujian Tengah Semester (UTS)** mata kuliah Pemrograman Mobile ITENAS.Aplikasi ini bertujuan utama untuk mengimplementasikan **SubCPMK 2**: Mahasiswa mampu menerapkan berbagai jenis *layout* serta *widget* yang biasa digunakan pada aplikasi mobile terkait dengan **User Interface (UI)** dan **User Experience (UX)**. 

Aplikasi dibangun menggunakan **Flutter** dengan navigasi utama berupa **Bottom Navigation Bar** (Konsep Fragment/Page) yang mengarahkan ke 6 menu utama: **Dashboard**, **Biodata**, **Kontak**, **Kalkulator**, **Cuaca**, dan **Berita**. 

---

## 📋 Daftar Halaman dan Implementasi Fungsional

### 1. Splash Screen ✨
![Screenshot Splash Screen](screenshoots/splash_page.png?raw=true)

* **Deskripsi**: Halaman awal aplikasi selama **5 detik** sebelum masuk ke menu utama. 
* **Implementasi**: Menampilkan **judul aplikasi** yaitu **Nasy' App**, **foto profil** , **NIM** 152023006, dan **nama lengkap** Nasywa Adita Zain. 

### 2. Dashboard (Halaman Utama) 🏠
![Screenshot Halaman Beranda](screenshoots/beranda_page.png?raw=true)

* **Deskripsi**: Halaman *overview* dan pusat navigasi.
* **Implementasi**: Menggunakan **Bottom Navigation Bar** sebagai menu navigasi utama. 

### 3. Halaman Biodata 👤
![Screenshot Halaman Biodata](screenshoots/biodata_page.png?raw=true)

* **Deskripsi**: Halaman untuk menampilkan dan menginput data diri statis dengan desain menarik. 
* **Implementasi**: 
    * **Input Fields**: Digunakan untuk Nama, NIM, Email, dan Nomor Telepon.
    * **Dropdown Button 🔽**: Digunakan untuk pemilihan **Program Studi**.
    * **Radio Button ⚪**: Digunakan untuk pemilihan **Jenis Kelamin**. 
    * **Calendar Picker 📅**: Digunakan untuk input **Tanggal Lahir**. 
    * Data yang diinput **tidak perlu disimpan ke database**. 

### 4. Halaman Kontak 📞
![Screenshot Halaman Kontak](screenshoots/kontak_page.png?raw=true)

* **Deskripsi**: Halaman daftar kontak telepon statis yang memiliki pola tampilan berulang. 
* **Implementasi**: 
    * Menampilkan daftar kontak dalam *List View* yang terdiri dari **teks** dan **circle image**. 
    * Data kontak bersifat **statis** (berasal dari variabel) dengan minimal **15 kontak telepon**. 
    * Terdapat fitur *filtering* berdasarkan kategori (`Pribadi`, `Kerja`, `Kuliah`).

### 5. Halaman Kalkulator 🧮
![Screenshot Halaman Kalkulator](screenshoots/kalkulator_page.png?raw=true)

* **Deskripsi**: Halaman untuk melakukan perhitungan matematika sederhana. 
* **Implementasi**: 
    * Mode kalkulator sederhana yang sudah dapat melakukan operasi: **tambah**, **kurang**, **kali**, **bagi**, **kuadrat** ($x^2$), dan **akar kuadrat** ($\sqrt{}$). 
    * Dilengkapi tombol hapus. 

### 6. Halaman Cuaca ☁️
![Screenshot Halaman Cuaca](screenshoots/cuaca_page.png?raw=true)

* **Deskripsi**: Halaman informasi cuaca. 
* **Implementasi**: 
    * **Peningkatan**: Implementasi menggunakan **API BMKG** untuk mendapatkan data **dinamis**.
    * Terdapat laporan cuaca untuk hari-hari lain (perkiraan mingguan).
    * Menampilkan informasi visual kondisi cuaca (`HUJAN`), **Suhu** (`20°C`), **Kelembapan** (`83%`), dan **Angin** (`1 km/j`). 
    * Tampilan dilengkapi dengan **gambar animasi kondisi cuaca yang cakep**. 

### 7. Halaman Berita 📰
![Screenshot Halaman Berita](screenshoots/berita_page.png?raw=true)

* **Deskripsi**: Halaman untuk menampilkan daftar berita statis dengan pola tampilan berulang. 
* **Implementasi**: 
    * Daftar berita disajikan dalam pola tampilan berulang (*List View*) yang mirip dengan halaman kontak. 
    * Terdapat elemen *image* (thumbnail), judul, penulis, kategori, dan waktu.
    * Terdapat fitur *filtering* berdasarkan kategori (`Top`, `K-Pop`, `K-Drama`, `Idol News`). Data berita masih statis.


