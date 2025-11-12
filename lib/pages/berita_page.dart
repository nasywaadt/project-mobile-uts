import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

// Model ini tetap CONST (Sudah benar)
class NewsArticle {
  final String title;
  final String author;
  final String category;
  final String timeAgo;
  final String imageUrl;

  const NewsArticle({
    required this.title,
    required this.author,
    required this.category,
    required this.timeAgo,
    required this.imageUrl,
  });
}

// Halaman Berita
class BeritaPage extends StatelessWidget {
  const BeritaPage({super.key});

  // Properti warna
  final Color primaryBrown = const Color(0xFF6B4F4F);
  final Color lightBrown = const Color(0xFFF8EDE3);
  final Color accentBrown = const Color(0xFFDCC7AA);

  // Daftar statis yang diperbarui (Total 14 berita)
  final List<NewsArticle> staticNews = const [
    NewsArticle(
      title: 'Album Baru SEVENTEEN Pecahkan Rekor Penjualan di Minggu Pertama',
      author: 'By Kim Minji',
      category: 'K-Pop',
      timeAgo: '1m ago',
      imageUrl: 'images/seventeen_album.jpg',
    ),
    NewsArticle(
      title: 'Review Drama Terbaru "Love in the Moonlight": Akting Memukau dari Lee Minho',
      author: 'By Park Seo-joon',
      category: 'K-Drama',
      timeAgo: '5m ago',
      imageUrl: 'images/kdrama_scene.jpg',
    ),
    NewsArticle(
      title: 'Sehun Telah Kembali dari wajib militer. EXO-L Menyambut Bahagia Sang Maknae',
      author: 'By Anna Choi',
      category: 'K-Pop',
      timeAgo: '20m ago',
      imageUrl: 'images/sehun_doc.jpeg',
    ),
    NewsArticle(
      title: 'Song Hye Kyo Dikonfirmasi Membintangi Serial Thriller Sejarah Baru',
      author: 'By Max Thompson',
      category: 'K-Drama',
      timeAgo: '1h ago',
      imageUrl: 'images/songhyekyo.jpg',
    ),
    
    NewsArticle(
      title: 'NewJeans Dominasi Chart Global dengan Single Pra-Rilis "Bubble Gum"',
      author: 'By Hanni Ph',
      category: 'K-Pop',
      timeAgo: '2h ago',
      imageUrl: 'images/newjeans_bubblegum.jpg',
    ),
    NewsArticle(
      title: 'Teaser Drama "The Atypical Family" Menjanjikan Kisah Fantasi yang Mendalam',
      author: 'By Ji-soo K',
      category: 'K-Drama',
      timeAgo: '3h ago',
      imageUrl: 'images/atypical_family.jpg',
    ),
    NewsArticle(
      title: 'TREASURE Mengumumkan Tur Konser Dunia Terbesar Mereka Tahun Ini',
      author: 'By Jaehyuk P',
      category: 'K-Pop',
      timeAgo: '5h ago',
      imageUrl: 'images/treasure_tour.jpg',
    ),
    NewsArticle(
      title: 'IU Dikabarkan Berkolaborasi dengan Aktor Hollywood untuk Proyek Film Pendek',
      author: 'By Eun-ji L',
      category: 'K-Pop',
      timeAgo: '1d ago',
      imageUrl: 'images/iu_collab.jpg',
    ),
    NewsArticle(
      title: 'Ending Plot Twist di "Queen of Tears" Membuat Penonton Terbagi',
      author: 'By Baek Hyun-woo',
      category: 'K-Drama',
      timeAgo: '1d ago',
      imageUrl: 'images/queen_of_tears.jpg',
    ),
    NewsArticle(
      title: 'Stray Kids Siapkan Comeback dengan Konsep "Dark Fantasy"',
      author: 'By Chan Bang',
      category: 'K-Pop',
      timeAgo: '2d ago',
      imageUrl: 'images/straykids_teaser.jpg',
    ),
    NewsArticle(
      title: 'Park Seo Joon dan Han So Hee Diincar Membintangi Drama Romansa Sejarah',
      author: 'By Kim H',
      category: 'K-Drama',
      timeAgo: '3d ago',
      imageUrl: 'images/parkseo_han.jpg',
    ),
    NewsArticle(
      title: 'BABYMONSTER Rilis Koreografi Penuh untuk "SHEESH" yang Energi',
      author: 'By Ruka A',
      category: 'K-Pop',
      timeAgo: '4d ago',
      imageUrl: 'images/babymonster_sheesh.jpg',
    ),
    NewsArticle(
      title: 'Drama "Moving" Raih Penghargaan Tertinggi di Ajang Asia Contents Awards',
      author: 'By Jo In-sung',
      category: 'K-Drama',
      timeAgo: '5d ago',
      imageUrl: 'images/moving_award.jpg',
    ),
    NewsArticle(
      title: 'Fakta Menarik di Balik Layar Syuting Variety Show "Running Man"',
      author: 'By Yoo Jaesuk',
      category: 'K-Drama',
      timeAgo: '1w ago',
      imageUrl: 'images/running_man.jpg',
    ),
  ];

  final List<String> categories = const ['Top', 'K-Pop', 'K-Drama', 'Idol News'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: lightBrown,
      // Menggunakan AppBar untuk Header
      appBar: _buildAppBar(),
      body: Column(
        children: [
          // Tidak perlu SafeArea di sini karena sudah di handle oleh Scaffold/AppBar
          _buildCategoryTabs(),
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              itemCount: staticNews.length,
              itemBuilder: (context, index) {
                return _buildNewsCard(staticNews[index]);
              },
            ),
          ),
        ],
      ),
    );
  }

  // --- Widget AppBar Baru ---
  
  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      backgroundColor: primaryBrown,
        title: Text(
          "Berita",
          style: GoogleFonts.poppins(
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
        ),
        centerTitle: true,
    );
  }

  // --- Widget Pembantu Lainnya ---

  Widget _buildCategoryTabs() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: categories.asMap().entries.map((entry) {
            int index = entry.key;
            String text = entry.value;
            return Padding(
              padding: EdgeInsets.only(right: index == categories.length - 1 ? 0 : 8),
              child: _buildCategoryTab(text, isActive: index == 0),
            );
          }).toList(),
        ),
      ),
    );
  }

  Widget _buildCategoryTab(String text, {required bool isActive}) {
    final bgColor = isActive ? primaryBrown : accentBrown.withOpacity(0.5);
    final textColor = isActive ? Colors.white : primaryBrown;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: isActive ? primaryBrown : accentBrown, width: 1.5),
      ),
      child: Text(
        text,
        style: GoogleFonts.poppins(
          color: textColor,
          fontSize: 14,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }

  Widget _buildNewsCard(NewsArticle article) {
    Color categoryColor;
    if (article.category == 'K-Pop') {
      categoryColor = Colors.purple.shade700;
    } else if (article.category == 'K-Drama') {
      categoryColor = Colors.red.shade700;
    } else {
      categoryColor = primaryBrown.withOpacity(0.7);
    }

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(8.0),
            child: Image.asset(
              article.imageUrl,
              width: 100,
              height: 100,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                return Container(
                  width: 100,
                  height: 100,
                  color: accentBrown.withOpacity(0.5),
                  child: Icon(Icons.photo, color: primaryBrown, size: 40),
                );
              },
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  article.title,
                  style: GoogleFonts.poppins(
                    color: primaryBrown,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    height: 1.3,
                  ),
                  maxLines: 4,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 6),
                Text(
                  article.author,
                  style: GoogleFonts.poppins(
                    color: primaryBrown.withOpacity(0.7),
                    fontSize: 12,
                  ),
                ),
                const SizedBox(height: 6),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Text(
                          article.category,
                          style: GoogleFonts.poppins(
                            color: categoryColor,
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Text(
                          ' • ${article.timeAgo}',
                          style: GoogleFonts.poppins(
                            color: primaryBrown.withOpacity(0.5),
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                    Icon(
                      Icons.more_horiz,
                      color: primaryBrown.withOpacity(0.7),
                      size: 20,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}