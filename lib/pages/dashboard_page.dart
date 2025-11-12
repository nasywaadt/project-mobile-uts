import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class DashboardPage extends StatelessWidget {
  const DashboardPage({super.key});

  final Color primaryBrown = const Color(0xFF6B4F4F);
  final Color lightBrown = const Color(0xFFF8EDE3);
  final Color accentBrown = const Color(0xFFDCC7AA);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: lightBrown,
      appBar: _buildAppBar(),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildGreetingCard(),
            const SizedBox(height: 20),
            _buildStatistikSection(context),
            const SizedBox(height: 20),
            _buildAktivitasSection(),
          ],
        ),
      ),
    );
  }

  // 1. AppBar dengan Judul dan Aksi (Contoh: Notifikasi)
  AppBar _buildAppBar() {
    return AppBar(
      backgroundColor: primaryBrown,
        title: Text(
          "Beranda",
          style: GoogleFonts.poppins(
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
        ),
        centerTitle: true,
    );
  }

  // 2. Kartu Ucapan Selamat Datang
  Widget _buildGreetingCard() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: primaryBrown,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: primaryBrown.withOpacity(0.3),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Row(
        children: [
          const CircleAvatar(
            radius: 30,
            backgroundColor: Colors.white70,
            child: Icon(Icons.person, color: Color(0xFF7B4B3A), size: 30),
          ),
          const SizedBox(width: 15),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Selamat Datang!',
                style: GoogleFonts.poppins(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                'Siap kelola datamu hari ini.',
                style: GoogleFonts.poppins(
                  color: Colors.white70,
                  fontSize: 12,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // 3. Bagian Statistik/Angka Penting
  Widget _buildStatistikSection(BuildContext context) {
    // Data Statistik Contoh
    final List<Map<String, dynamic>> stats = [
      {'label': 'Kontak', 'value': '12', 'icon': Icons.phone_rounded, 'color': Colors.redAccent},
      {'label': 'Cuaca Hari Ini', 'value': 'Cerah', 'icon': Icons.wb_sunny_rounded, 'color': Colors.amber},
      {'label': 'Berita Terbaru', 'value': '3', 'icon': Icons.article_outlined, 'color': Colors.blueAccent},
      {'label': 'Kalkulasi', 'value': '20+', 'icon': Icons.calculate_rounded, 'color': Colors.greenAccent},
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Statistik Cepat',
          style: GoogleFonts.poppins(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: primaryBrown,
          ),
        ),
        const SizedBox(height: 10),
        GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 15,
            mainAxisSpacing: 15,
            childAspectRatio: 1.8, // Mengatur rasio agar card tidak terlalu tinggi
          ),
          itemCount: stats.length,
          itemBuilder: (context, index) {
            final stat = stats[index];
            return _buildStatCard(stat['label'], stat['value'], stat['icon'], stat['color']);
          },
        ),
      ],
    );
  }

  // Kartu Tunggal Statistik
  Widget _buildStatCard(String label, String value, IconData icon, Color color) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                label,
                style: GoogleFonts.poppins(
                  fontSize: 12,
                  color: Colors.grey[600],
                ),
              ),
              Icon(icon, color: color, size: 20),
            ],
          ),
          Text(
            value,
            style: GoogleFonts.poppins(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: primaryBrown,
            ),
          ),
        ],
      ),
    );
  }

  // 4. Bagian Aktivitas Terbaru
  Widget _buildAktivitasSection() {
    // Data Aktivitas Contoh
    final List<Map<String, String>> activities = [
      {'title': 'Biodata Diperbarui', 'subtitle': 'Data diri telah disinkronkan.', 'time': '5 mnt lalu'},
      {'title': 'Kontak Baru Ditambahkan', 'subtitle': 'Nama: Budi Santoso', 'time': '1 jam lalu'},
      {'title': 'Kalkulator Digunakan', 'subtitle': 'Perhitungan aljabar kompleks.', 'time': 'Kemarin'},
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Aktivitas Terbaru',
          style: GoogleFonts.poppins(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: primaryBrown,
          ),
        ),
        const SizedBox(height: 10),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(15),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.1),
                blurRadius: 8,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: activities.length,
            itemBuilder: (context, index) {
              final activity = activities[index];
              return ListTile(
                leading: Icon(Icons.history, color: primaryBrown),
                title: Text(
                  activity['title']!,
                  style: GoogleFonts.poppins(
                    fontWeight: FontWeight.w500,
                    color: primaryBrown,
                  ),
                ),
                subtitle: Text(
                  activity['subtitle']!,
                  style: GoogleFonts.poppins(fontSize: 12),
                ),
                trailing: Text(
                  activity['time']!,
                  style: GoogleFonts.poppins(fontSize: 10, color: Colors.grey),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}