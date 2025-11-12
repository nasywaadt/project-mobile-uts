# 🚀 UTS PEMROGRAMAN MOBILE

**NAMA:** Nasywa Adita Zain
**NIM:** 152023006
**Program Studi:** Informatika
**Dosen:** Galih Ashari R., S.Si., MT

---

## 🎯 Tujuan Proyek (Jawaban Soal No. 1)

Proyek ini dikembangkan sebagai **Ujian Tengah Semester (UTS)** mata kuliah Pemrograman Mobile ITENAS. [cite_start]Aplikasi ini bertujuan utama untuk mengimplementasikan **SubCPMK 2**: Mahasiswa mampu menerapkan berbagai jenis *layout* serta *widget* yang biasa digunakan pada aplikasi mobile terkait dengan **User Interface (UI)** dan **User Experience (UX)**. [cite: 13]

[cite_start]Aplikasi dibangun menggunakan **Flutter** dengan navigasi utama berupa **Bottom Navigation Bar** (Konsep Fragment/Page) yang mengarahkan ke 6 menu utama: **Dashboard**, **Biodata**, **Kontak**, **Kalkulator**, **Cuaca**, dan **Berita**. [cite: 15, 16]

---

## 📋 Daftar Halaman dan Implementasi Fungsional

### 1. Splash Screen ✨
* [cite_start]**Deskripsi**: Halaman awal aplikasi selama **5 detik** sebelum masuk ke menu utama. [cite: 14]
* [cite_start]**Implementasi**: Menampilkan **judul aplikasi**, **foto profil** pengembang, **NIM**, dan **nama lengkap**. [cite: 14]

### 2. Dashboard (Halaman Utama) 🏠
* **Deskripsi**: Halaman *overview* dan pusat navigasi.
* [cite_start]**Implementasi**: Menggunakan **Bottom Navigation Bar** sebagai menu navigasi utama. [cite: 15]

### 3. Halaman Biodata 👤
* [cite_start]**Deskripsi**: Halaman untuk menampilkan dan menginput data diri statis dengan desain menarik. [cite: 18]
* **Implementasi**: 
    * **Input Fields**: Digunakan untuk Nama, NIM, Email, dan Nomor Telepon.
    * [cite_start]**Dropdown Button 🔽**: Digunakan untuk pemilihan **Program Studi** (telah dimodifikasi). [cite: 18]
    * [cite_start]**Radio Button ⚪**: Digunakan untuk pemilihan **Jenis Kelamin**. [cite: 18]
    * [cite_start]**Calendar Picker 📅**: Digunakan untuk input **Tanggal Lahir**. [cite: 18]
    * [cite_start]Data yang diinput **tidak perlu disimpan ke database**. [cite: 19]

### 4. Halaman Kontak 📞
* [cite_start]**Deskripsi**: Halaman daftar kontak telepon statis yang memiliki pola tampilan berulang. [cite: 20]
* **Implementasi**: 
    * [cite_start]Menampilkan daftar kontak dalam *List View* yang terdiri dari **teks** dan **circle image**. [cite: 20]
    * [cite_start]Data kontak bersifat **statis** (berasal dari variabel) dengan minimal **15 kontak telepon**. [cite: 21]
    * Terdapat fitur *filtering* berdasarkan kategori (`Pribadi`, `Kerja`, `Kuliah`).

### 5. Halaman Kalkulator 🧮
* [cite_start]**Deskripsi**: Halaman untuk melakukan perhitungan matematika sederhana. [cite: 32]
* **Implementasi**: 
    * [cite_start]Mode kalkulator sederhana yang sudah dapat melakukan operasi: **tambah**, **kurang**, **kali**, **bagi**, **kuadrat** ($x^2$), dan **akar kuadrat** ($\sqrt{}$). [cite: 32]
    * [cite_start]Dilengkapi tombol hapus. [cite: 32]

### 6. Halaman Cuaca ☁️
* [cite_start]**Deskripsi**: Halaman informasi cuaca. [cite: 33]
* **Implementasi**: 
    * **Peningkatan**: Implementasi menggunakan **API BMKG** untuk mendapatkan data **dinamis** (melebihi persyaratan UTS yang hanya meminta statis).
    * [cite_start]Menampilkan informasi visual kondisi cuaca (`HUJAN`), **Suhu** (`20°C`), **Kelembapan** (`83%`), dan **Angin** (`1 km/j`). [cite: 33]
    * [cite_start]Tampilan dilengkapi dengan **gambar animasi kondisi cuaca yang cakep**. [cite: 33]

### 7. Halaman Berita 📰
* [cite_start]**Deskripsi**: Halaman untuk menampilkan daftar berita statis dengan pola tampilan berulang. [cite: 38]
* **Implementasi**: 
    * [cite_start]Daftar berita disajikan dalam pola tampilan berulang (*List View*) yang mirip dengan halaman kontak. [cite: 38]
    * Terdapat elemen *image* (thumbnail), judul, penulis, kategori, dan waktu.
    * Terdapat fitur *filtering* berdasarkan kategori (`Top`, `K-Pop`, `K-Drama`, `Idol News`). Data berita masih statis.

---

## 📸 Paparan Screenshots

