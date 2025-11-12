import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class BiodataPage extends StatefulWidget {
  const BiodataPage({super.key});

  @override
  State<BiodataPage> createState() => _BiodataPageState();
}

class _BiodataPageState extends State<BiodataPage> {
  // Daftar Program Studi yang tersedia
  final List<String> daftarProdi = const [
    "Informatika",
    "Sistem Informasi",
    "Teknik Elektro",
    "Teknik Industri",
    "Akuntansi",
    "Manajemen",
  ];

  // Data default
  final TextEditingController namaController = TextEditingController(
    text: "Nasywa Adita Zain",
  );
  final TextEditingController nimController = TextEditingController(
    text: "152023006",
  );
  // HAPUS: final TextEditingController prodiController = TextEditingController(text: "Informatika");
  String? selectedProdi = "Informatika"; // Ganti controller dengan String nullable

  final TextEditingController emailController = TextEditingController(
    text: "nasywaadita@gmail.com",
  );
  final TextEditingController noTelpController = TextEditingController(
    text: "081234567890",
  );

  String jenisKelamin = "Perempuan";
  DateTime? tanggalLahir = DateTime(2004, 4, 19);

  @override
  void dispose() {
    namaController.dispose();
    nimController.dispose();
    emailController.dispose();
    noTelpController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Color primaryBrown = const Color(0xFF6B4F4F);
    final Color lightBrown = const Color(0xFFF8EDE3);
    final Color accentBrown = const Color(0xFFDCC7AA);
    final Color fillColor = const Color(0xFFF8F1E7); // Warna latar input

    return Scaffold(
      backgroundColor: lightBrown,
      appBar: AppBar(
        backgroundColor: primaryBrown,
        title: Text(
          "Biodata",
          style: GoogleFonts.poppins(
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: Colors.brown.withOpacity(0.15),
                blurRadius: 10,
                offset: const Offset(0, 5),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Foto profil
              Center(
                child: Column(
                  children: [
                    CircleAvatar(
                      radius: 45,
                      backgroundImage: const AssetImage(
                        'assets/images/photoprofile.png',
                      ),
                      backgroundColor: accentBrown.withOpacity(0.3),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      "Nasy's App",
                      style: GoogleFonts.poppins(
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                        color: primaryBrown,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),

              Text(
                "Informasi Pribadi",
                style: GoogleFonts.poppins(
                  fontWeight: FontWeight.w600,
                  color: primaryBrown,
                ),
              ),

              const SizedBox(height: 8),
              _buildTextField("Nama Lengkap", namaController, fillColor),
              _buildTextField("NIM", nimController, fillColor),

              // GANTI: TextField Program Studi menjadi Dropdown
              _buildProdiDropdown(primaryBrown, accentBrown, fillColor),

              const SizedBox(height: 12),
              Text(
                "Jenis Kelamin",
                style: GoogleFonts.poppins(
                  fontWeight: FontWeight.w600,
                  color: primaryBrown,
                ),
              ),
              Row(
                children: [
                  Expanded(
                    child: RadioListTile(
                      dense: true,
                      contentPadding: EdgeInsets.zero,
                      title: Text(
                        "Laki-laki",
                        style: GoogleFonts.poppins(fontSize: 14),
                      ),
                      value: "Laki-laki",
                      groupValue: jenisKelamin,
                      onChanged: (value) {
                        setState(() {
                          jenisKelamin = value!;
                        });
                      },
                    ),
                  ),
                  Expanded(
                    child: RadioListTile(
                      dense: true,
                      contentPadding: EdgeInsets.zero,
                      title: Text(
                        "Perempuan",
                        style: GoogleFonts.poppins(fontSize: 14),
                      ),
                      value: "Perempuan",
                      groupValue: jenisKelamin,
                      onChanged: (value) {
                        setState(() {
                          jenisKelamin = value!;
                        });
                      },
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 12),
              Text(
                "Informasi Tambahan",
                style: GoogleFonts.poppins(
                  fontWeight: FontWeight.w600,
                  color: primaryBrown,
                ),
              ),
              const SizedBox(height: 8),

              // Tanggal Lahir
              GestureDetector(
                onTap: () async {
                  DateTime? picked = await showDatePicker(
                    context: context,
                    initialDate: tanggalLahir ?? DateTime(2004, 4, 19),
                    firstDate: DateTime(1990),
                    lastDate: DateTime(2025),
                    builder: (context, child) {
                      return Theme(
                        data: Theme.of(context).copyWith(
                          colorScheme: ColorScheme.light(
                            primary: primaryBrown, // Warna utama date picker
                            onPrimary: Colors.white, // Warna teks di header
                            onSurface: primaryBrown, // Warna teks di kalender
                          ),
                          textButtonTheme: TextButtonThemeData(
                            style: TextButton.styleFrom(
                              foregroundColor: primaryBrown, // Warna tombol OK/CANCEL
                            ),
                          ),
                        ),
                        child: child!,
                      );
                    },
                  );
                  if (picked != null) {
                    setState(() {
                      tanggalLahir = picked;
                    });
                  }
                },
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 16,
                  ),
                  decoration: BoxDecoration(
                    color: accentBrown.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Row(
                    children: [
                      const Icon(Icons.calendar_today, size: 18),
                      const SizedBox(width: 10),
                      Text(
                        tanggalLahir != null
                            ? "${tanggalLahir!.day.toString().padLeft(2, '0')}-${tanggalLahir!.month.toString().padLeft(2, '0')}-${tanggalLahir!.year}"
                            : "Pilih Tanggal Lahir",
                        style: GoogleFonts.poppins(fontSize: 15),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 12),

              _buildTextField("Alamat Email", emailController, fillColor),
              _buildTextField("Nomor Telepon", noTelpController, fillColor),

              const SizedBox(height: 20),

              // Tombol
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: accentBrown,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 24,
                        vertical: 12,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    onPressed: () {
                      setState(() {
                        namaController.text = "Nasywa Adita Zain";
                        nimController.text = "152023006";
                        selectedProdi = "Informatika"; // RESET DATA DROPDOWN
                        emailController.text = "nasywaadita@gmail.com";
                        noTelpController.text = "081234567890";
                        jenisKelamin = "Perempuan";
                        tanggalLahir = DateTime(2004, 4, 19);
                      });
                    },
                    child: Text(
                      "Reset Data",
                      style: GoogleFonts.poppins(color: primaryBrown),
                    ),
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: primaryBrown,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 24,
                        vertical: 12,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    onPressed: () {
                      // Ambil data untuk disimpan:
                      // String nama = namaController.text;
                      // String prodi = selectedProdi ?? 'Belum dipilih'; 
                      // ... dan data lainnya

                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text("Data Prodi: $selectedProdi berhasil disimpan!"),
                        ),
                      );
                    },
                    child: Text(
                      "Simpan",
                      style: GoogleFonts.poppins(color: Colors.white),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Widget untuk Dropdown Program Studi
  Widget _buildProdiDropdown(Color primaryBrown, Color accentBrown, Color fillColor) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: DropdownButtonFormField<String>(
        value: selectedProdi,
        decoration: InputDecoration(
          labelText: "Program Studi",
          labelStyle: GoogleFonts.poppins(
            color: Colors.brown[400],
            fontSize: 14,
          ),
          filled: true,
          fillColor: fillColor,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide.none,
          ),
          contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
        ),
        style: GoogleFonts.poppins(
          color: Colors.black87,
          fontSize: 15,
        ),
        icon: Icon(Icons.arrow_drop_down, color: primaryBrown),
        items: daftarProdi.map((String prodi) {
          return DropdownMenuItem<String>(
            value: prodi,
            child: Text(prodi),
          );
        }).toList(),
        onChanged: (String? newValue) {
          setState(() {
            selectedProdi = newValue;
          });
        },
      ),
    );
  }

  // Widget TextField yang sudah ada, ditambahkan parameter fillColor
  Widget _buildTextField(String label, TextEditingController controller, Color fillColor) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          labelText: label,
          labelStyle: GoogleFonts.poppins(
            color: Colors.brown[400],
            fontSize: 14,
          ),
          filled: true,
          fillColor: fillColor,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide.none,
          ),
        ),
      ),
    );
  }
}