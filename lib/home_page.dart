import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:uts_pemmob/pages/berita_page.dart';
import 'package:uts_pemmob/pages/biodata_page.dart';
import 'package:uts_pemmob/pages/cuaca_page.dart';
import 'package:uts_pemmob/pages/dashboard_page.dart';
import 'package:uts_pemmob/pages/kalkulator_page.dart';
import 'package:uts_pemmob/pages/kontak_page.dart';


class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}



class _HomePageState extends State<HomePage> {
  int selectedIndex = 0;

  // daftar halaman sesuai menu, Dashboard dipindahkan ke index 0
  final List<Widget> _pages = [
    const DashboardPage(), 
    const BiodataPage(),
    const KontakPage(),
    const KalkulatorPage(),
    const CuacaPage(),
    const BeritaPage(),
  ];

  // daftar icon (tambahkan icon dashboard di index 0)
  final List<IconData> _icons = [
    Icons.dashboard_rounded, // Icon untuk Dashboard
    Icons.person_rounded, // Ganti icons.home_rounded dengan icons.person_rounded untuk Biodata
    Icons.phone_rounded,
    Icons.calculate_rounded,
    Icons.cloud_rounded,
    Icons.article_outlined,
  ];

  // daftar label (tambahkan label dashboard di index 0)
  final List<String> _labels = [
    'Beranda',
    'Biodata',
    'Kontak',
    'Kalkulator',
    'Cuaca',
    'Berita',
  ];

  @override
  Widget build(BuildContext context) {
    final Color primaryBrown = const Color(0xFF7B4B3A); // coklat utama
    final Color lightBrown = const Color(0xFFEADBC8); // latar terpilih
    final Color background = const Color(0xFFF9F5F0); // warna dasar layar

    return Scaffold(
      backgroundColor: background,
      body: _pages[selectedIndex],

      // Bottom Navigation
      bottomNavigationBar: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12), // Mengurangi padding horizontal container utama
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(24),
            topRight: Radius.circular(24),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.brown.withOpacity(0.15),
              blurRadius: 12,
              offset: const Offset(0, -2),
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly, // Menggunakan spaceEvenly untuk distribusi ruang yang lebih merata
          children: List.generate(_icons.length, (index) {
            final bool isSelected = selectedIndex == index;
            return GestureDetector(
              onTap: () {
                setState(() {
                  selectedIndex = index;
                });
              },
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 250),
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8), // Mengurangi padding horizontal
                decoration: BoxDecoration(
                  color: isSelected ? lightBrown : Colors.transparent,
                  borderRadius: BorderRadius.circular(30),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min, // Penting agar Row tidak memakan ruang lebih dari yang dibutuhkan
                  children: [
                    Icon(
                      _icons[index],
                      color: isSelected ? primaryBrown : Colors.grey[600],
                    ),
                    if (isSelected) ...[
                      const SizedBox(width: 6), // Mengurangi sedikit jarak antara ikon dan teks
                      Text(
                        _labels[index],
                        style: GoogleFonts.poppins(
                          color: primaryBrown,
                          fontWeight: FontWeight.w600,
                          fontSize: 12, // Mengurangi ukuran font agar tidak terlalu lebar
                        ),
                      ),
                    ]
                  ],
                ),
              ),
            );
          }),
        ),
      ),
    );
  }
}