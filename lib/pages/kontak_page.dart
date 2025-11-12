import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class KontakPage extends StatefulWidget {
  const KontakPage({super.key});

  @override
  State<KontakPage> createState() => _KontakPageState();
}

class _KontakPageState extends State<KontakPage> {
  final Color primaryBrown = const Color(0xFF6B4F4F);
  final Color lightBrown = const Color(0xFFF8EDE3);
  final Color accentBrown = const Color(0xFFDCC7AA);

  final List<Map<String, String>> _allContacts = [
    {"name": "Adit Ahmad", "phone": "0812-1111-2222", "tag": "Pribadi"},
    {"name": "Budi Santoso", "phone": "0812-2222-3333", "tag": "Kerja"},
    {"name": "Citra Mahesa", "phone": "0812-3333-4444", "tag": "Pribadi"},
    {"name": "Dewi Lestari", "phone": "0812-4444-5555", "tag": "Kuliah"},
    {"name": "Eka Putri", "phone": "0812-5555-6666", "tag": "Kerja"},
    {"name": "Fani Oktaviani", "phone": "0812-6666-7777", "tag": "Pribadi"},
    {"name": "Gilang Ramadhan", "phone": "0812-7777-8888", "tag": "Kerja"},
    {"name": "Hana Nur", "phone": "0812-8888-9999", "tag": "Kuliah"},
    {"name": "Indra Pratama", "phone": "0812-9999-0000", "tag": "Pribadi"},
    {"name": "Joko Widodo", "phone": "0813-1111-2222", "tag": "Kerja"},
    {"name": "Kiki Amelia", "phone": "0813-2222-3333", "tag": "Pribadi"},
    {"name": "Lina Marlina", "phone": "0813-3333-4444", "tag": "Kerja"},
    {"name": "Mira Salma", "phone": "0813-4444-5555", "tag": "Pribadi"},
    {"name": "Niko Firmansyah", "phone": "0813-5555-6666", "tag": "Kerja"},
    {"name": "Ovi Wulandari", "phone": "0813-6666-7777", "tag": "Pribadi"},
  ];

  String _selectedTag = 'Semua';
  String _searchQuery = '';
  final TextEditingController _searchController = TextEditingController();

  List<Map<String, String>> get _filteredContacts {
    return _allContacts.where((c) {
      final matchesTag = _selectedTag == 'Semua' || c['tag'] == _selectedTag;
      final q = _searchQuery.toLowerCase();
      final matchesQuery = q.isEmpty || c['name']!.toLowerCase().contains(q);
      return matchesTag && matchesQuery;
    }).toList();
  }

  void _onTagSelected(String tag) {
    setState(() => _selectedTag = tag);
  }

  void _onSearchChanged(String q) {
    setState(() => _searchQuery = q);
  }

  Widget _buildTagChips() {
    final tags = ['Semua', 'Pribadi', 'Kerja', 'Kuliah'];
    return SizedBox(
      height: 44,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 12),
        itemCount: tags.length,
        itemBuilder: (context, index) {
          final tag = tags[index];
          final selected = tag == _selectedTag;
          return Padding(
            padding: const EdgeInsets.only(right: 8),
            child: ChoiceChip(
              label: Text(
                tag,
                style: TextStyle(
                  color: selected ? Colors.white : primaryBrown,
                  fontWeight: FontWeight.w600,
                ),
              ),
              selected: selected,
              onSelected: (_) => _onTagSelected(tag),
              selectedColor: primaryBrown,
              backgroundColor: accentBrown,
              padding:
                  const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            ),
          );
        },
      ),
    );
  }

  Widget _buildSearchField() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12.0),
      child: TextField(
        controller: _searchController,
        onChanged: _onSearchChanged,
        decoration: InputDecoration(
          hintText: 'Cari Kontak...',
          prefixIcon: Icon(Icons.search, color: primaryBrown),
          suffixIcon: _searchQuery.isNotEmpty
              ? IconButton(
                  icon: const Icon(Icons.clear, size: 20),
                  onPressed: () {
                    _searchController.clear();
                    _onSearchChanged('');
                  },
                )
              : null,
          filled: true,
          fillColor: Colors.white,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide.none,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: lightBrown,
      appBar: AppBar(
        backgroundColor: primaryBrown,
        title: Text(
          "Kontak",
          style: GoogleFonts.poppins(
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 12),
            _buildSearchField(),
            const SizedBox(height: 10),
            _buildTagChips(),
            const SizedBox(height: 12),
            Expanded(
              child: _filteredContacts.isEmpty
                  ? Center(
                      child: Text(
                        'Kontak Tidak Ditemukan',
                        style: TextStyle(
                          color: Colors.grey[600],
                          fontSize: 16,
                        ),
                      ),
                    )
                  : ListView.builder(
                      padding: const EdgeInsets.only(bottom: 20),
                      itemCount: _filteredContacts.length,
                      itemBuilder: (context, index) {
                        final c = _filteredContacts[index];
                        return _ContactCard(
                          name: c['name']!,
                          phone: c['phone']!,
                          tag: c['tag']!,
                          primaryBrown: primaryBrown,
                          accentBrown: accentBrown,
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }
}

// ===== Contact Card Widget =====
class _ContactCard extends StatelessWidget {
  final String name;
  final String phone;
  final String tag;
  final Color primaryBrown;
  final Color accentBrown;

  const _ContactCard({
    required this.name,
    required this.phone,
    required this.tag,
    required this.primaryBrown,
    required this.accentBrown,
  });

  Color _getTagColor() {
    switch (tag) {
      case 'Kerja':
        return Colors.blue[700]!;
      case 'Kuliah':
        return Colors.green[700]!;
      case 'Pribadi':
      default:
        return Colors.orange[700]!;
    }
  }

  @override
  Widget build(BuildContext context) {
    final String letter = name.isNotEmpty ? name[0].toUpperCase() : '?';

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.06),
            blurRadius: 6,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            width: 56,
            height: 56,
            decoration: BoxDecoration(
              color: accentBrown,
              shape: BoxShape.circle,
              border: Border.all(
                color: primaryBrown.withOpacity(0.4),
                width: 2,
              ),
            ),
            child: Center(
              child: Text(
                letter,
                style: TextStyle(
                  color: primaryBrown,
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 16,
                    color: primaryBrown,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  phone,
                  style: const TextStyle(
                    color: Colors.black54,
                    fontSize: 14,
                  ),
                ),
                const SizedBox(height: 4),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                  decoration: BoxDecoration(
                    color: _getTagColor().withOpacity(0.1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    tag,
                    style: TextStyle(
                      color: _getTagColor(),
                      fontSize: 11,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
          ),
          IconButton(
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('Calling $name...'),
                  duration: const Duration(seconds: 1),
                ),
              );
            },
            icon: Icon(Icons.phone, color: primaryBrown),
            tooltip: 'Call',
          ),
        ],
      ),
    );
  }
}
