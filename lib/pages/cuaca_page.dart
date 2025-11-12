import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';

// Main Weather Page
class CuacaPage extends StatefulWidget {
  const CuacaPage({super.key});

  @override
  State<CuacaPage> createState() => _CuacaPageState();
}

class _CuacaPageState extends State<CuacaPage> {
  final Color primaryBrown = const Color(0xFF6B4F4F);
  final Color lightBrown = const Color(0xFFF8EDE3);
  final Color accentBrown = const Color(0xFFDCC7AA);

  bool isLoading = false;
  Map<String, dynamic>? weatherData;
  String cityName = 'Bandung';
  
  // Data statis untuk hourly forecast
  final List<Map<String, dynamic>> staticHourlyForecast = [
    {'time': '00:00', 'temp': '25', 'weather': 'berawan'},
    {'time': '03:00', 'temp': '24', 'weather': 'berawan'},
    {'time': '06:00', 'temp': '23', 'weather': 'cerah'},
    {'time': '09:00', 'temp': '28', 'weather': 'cerah'},
    {'time': '12:00', 'temp': '31', 'weather': 'cerah'},
    {'time': '15:00', 'temp': '29', 'weather': 'hujan'},
    {'time': '18:00', 'temp': '27', 'weather': 'berawan'},
    {'time': '21:00', 'temp': '26', 'weather': 'berawan'},
  ];
  
  List<Map<String, dynamic>> todayForecast = [];

  String currentWeather = 'Cerah';
  String currentTemp = '28';
  String windSpeed = '8';
  String humidity = '69';
  String currentDate = '';
  String currentTime = '';

  final Map<String, String> provinceCodes = {
    'Tangerang': '36.03.20.2006',
    'Jakarta': '31.71.07.1005',
    'Bandung': '32.73.18.1003',
    'Lampung': '18.72.01.1001',
  };

  @override
  void initState() {
    super.initState();
    _initializeLocale();
    _updateDateTime();
    todayForecast = List.from(staticHourlyForecast);
    fetchWeatherData('Bandung');
  }

  Future<void> _initializeLocale() async {
    await initializeDateFormatting('id_ID', null);
  }

  void _updateDateTime() {
    final now = DateTime.now();
    setState(() {
      // Format tanggal manual tanpa locale untuk menghindari error
      final days = ['Senin', 'Selasa', 'Rabu', 'Kamis', 'Jumat', 'Sabtu', 'Minggu'];
      final months = ['Januari', 'Februari', 'Maret', 'April', 'Mei', 'Juni', 
                      'Juli', 'Agustus', 'September', 'Oktober', 'November', 'Desember'];
      
      final dayName = days[now.weekday - 1];
      final monthName = months[now.month - 1];
      
      currentDate = '$dayName, ${now.day} $monthName ${now.year}';
      currentTime = DateFormat('HH:mm').format(now);
    });
  }

  Future<void> fetchWeatherData(String searchQuery) async {
    setState(() => isLoading = true);

    try {
      String? provinceCode;
      String foundProvince = '';

      provinceCodes.forEach((province, code) {
        if (province.toLowerCase().contains(searchQuery.toLowerCase()) ||
            searchQuery.toLowerCase().contains(province.toLowerCase())) {
          provinceCode = code;
          foundProvince = province;
        }
      });

      if (provinceCode == null) {
        provinceCode = '32.73.18.1003';
        foundProvince = 'Bandung';
      }

      final response = await http.get(
        Uri.parse(
          'https://api.bmkg.go.id/publik/prakiraan-cuaca?adm4=$provinceCode',
        ),
      );

      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body);

        if (jsonData['data'] != null && jsonData['data'].isNotEmpty) {
          final firstData = jsonData['data'][0];
          final cuacaList = firstData['cuaca'] as List<dynamic>?;

          if (cuacaList != null && cuacaList.isNotEmpty) {
            setState(() {
              cityName = foundProvince;
              weatherData = jsonData;

              final currentData = cuacaList[0][0];
              currentWeather = _parseWeatherCode(currentData['weather'] ?? 0);
              currentTemp = _parseTemp(currentData['t']);
              windSpeed = _parseTemp(currentData['ws']);
              humidity = _parseTemp(currentData['hu']);

              isLoading = false;
            });
            return;
          }
        }
      }

      setState(() {
        cityName = searchQuery;
        isLoading = false;
        currentWeather = 'Cerah';
        currentTemp = '28';
        windSpeed = '8';
        humidity = '69';
      });
    } catch (e) {
      setState(() {
        cityName = searchQuery;
        isLoading = false;
        currentWeather = 'Cerah';
        currentTemp = '28';
        windSpeed = '8';
        humidity = '69';
      });
    }
  }

  String _parseTemp(dynamic value) {
    if (value == null) return '0';
    if (value is int) return value.toString();
    if (value is double) return value.round().toString();
    if (value is String) {
      try {
        return double.parse(value).round().toString();
      } catch (e) {
        return '0';
      }
    }
    return '0';
  }

  String _parseWeatherCode(dynamic weatherCode) {
    final code = weatherCode.toString();
    
    if (code == '0' || code == '1' || code == '2') {
      return 'cerah';
    } else if (code == '3' || code == '4') {
      return 'berawan';
    } else if (code == '5' || code == '6' || code == '60' || 
               code == '61' || code == '63' || code == '80') {
      return 'hujan';
    } else if (code == '95' || code == '97') {
      return 'petir';
    }
    return 'cerah';
  }

  String _getWeatherImage(String weather) {
    final w = weather.toLowerCase();
    if (w.contains('cerah') || w.contains('sunny')) {
      return 'assets/images/cerah.png';
    } else if (w.contains('hujan') || w.contains('rain')) {
      return 'assets/images/hujan.png';
    } else if (w.contains('berawan') || w.contains('cloud')) {
      return 'assets/images/berawan.png';
    } else if (w.contains('petir') || w.contains('thunder')) {
      return 'assets/images/petir.png';
    }
    return 'assets/images/cerah.png';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: lightBrown,
      body: SafeArea(
        child: Stack(
          children: [
            Column(
              children: [
                // App Bar dengan gradient
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 16,
                  ),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [primaryBrown, primaryBrown.withOpacity(0.8)],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: primaryBrown.withOpacity(0.3),
                        blurRadius: 10,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Cuaca',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 0.5,
                        ),
                      ),
                      Row(
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.2),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: IconButton(
                              icon: const Icon(
                                Icons.search,
                                color: Colors.white,
                                size: 26,
                              ),
                              onPressed: () async {
                                final result = await Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => SearchLocationPage(
                                      primaryBrown: primaryBrown,
                                      lightBrown: lightBrown,
                                      accentBrown: accentBrown,
                                    ),
                                  ),
                                );
                                if (result != null) {
                                  fetchWeatherData(result);
                                }
                              },
                            ),
                          ),
                          const SizedBox(width: 8),
                          Container(
                            decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.2),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: IconButton(
                              icon: const Icon(
                                Icons.calendar_today,
                                color: Colors.white,
                                size: 24,
                              ),
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => ForecastReportPage(
                                      weatherData: weatherData,
                                      cityName: cityName,
                                      primaryBrown: primaryBrown,
                                      lightBrown: lightBrown,
                                      accentBrown: accentBrown,
                                      getWeatherImage: _getWeatherImage,
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),

                // Content
                Expanded(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const SizedBox(height: 10),

                        // Location dengan icon
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.location_on,
                              color: primaryBrown,
                              size: 32,
                            ),
                            const SizedBox(width: 8),
                            Text(
                              cityName,
                              style: TextStyle(
                                color: primaryBrown,
                                fontSize: 32,
                                fontWeight: FontWeight.bold,
                                letterSpacing: 0.5,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 12),

                        // Date
                        Text(
                          currentDate,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: primaryBrown.withOpacity(0.7),
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const SizedBox(height: 6),

                        // Time dengan styling lebih baik
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 6,
                          ),
                          decoration: BoxDecoration(
                            color: accentBrown.withOpacity(0.3),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Text(
                            currentTime,
                            style: TextStyle(
                              color: primaryBrown,
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                        const SizedBox(height: 20),

                        // Weather Image dengan shadow
                        Container(
                          decoration: BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                color: primaryBrown.withOpacity(0.1),
                                blurRadius: 30,
                                spreadRadius: 10,
                              ),
                            ],
                          ),
                          child: Image.asset(
                            _getWeatherImage(currentWeather),
                            width: 280,
                            height: 280,
                            errorBuilder: (context, error, stackTrace) {
                              return Container(
                                width: 280,
                                height: 280,
                                decoration: BoxDecoration(
                                  color: accentBrown.withOpacity(0.3),
                                  shape: BoxShape.circle,
                                ),
                                child: Icon(
                                  Icons.wb_sunny,
                                  size: 120,
                                  color: primaryBrown,
                                ),
                              );
                            },
                          ),
                        ),
                        const SizedBox(height: 20),

                        // Temperature dengan styling modern
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              currentTemp,
                              style: TextStyle(
                                color: primaryBrown,
                                fontSize: 80,
                                fontWeight: FontWeight.w300,
                                height: 1.0,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 8),
                              child: Text(
                                '°C',
                                style: TextStyle(
                                  color: primaryBrown,
                                  fontSize: 36,
                                  fontWeight: FontWeight.w300,
                                ),
                              ),
                            ),
                          ],
                        ),
                        
                        // Weather condition text
                        Text(
                          currentWeather.toUpperCase(),
                          style: TextStyle(
                            color: primaryBrown.withOpacity(0.8),
                            fontSize: 20,
                            fontWeight: FontWeight.w600,
                            letterSpacing: 2,
                          ),
                        ),
                        const SizedBox(height: 40),

                        // Weather Info Cards dengan gradient
                        Row(
                          children: [
                            Expanded(
                              child: _buildInfoCard(
                                'Angin',
                                '$windSpeed km/j',
                                Icons.air,
                              ),
                            ),
                            const SizedBox(width: 16),
                            Expanded(
                              child: _buildInfoCard(
                                'Kelembapan',
                                '$humidity%',
                                Icons.water_drop,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 40),

                        // Today Section dengan border
                        Container(
                          padding: const EdgeInsets.all(20),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(
                              color: accentBrown.withOpacity(0.5),
                              width: 2,
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: primaryBrown.withOpacity(0.1),
                                blurRadius: 10,
                                offset: const Offset(0, 4),
                              ),
                            ],
                          ),
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'Hari Ini',
                                    style: TextStyle(
                                      color: primaryBrown,
                                      fontSize: 22,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  TextButton.icon(
                                    onPressed: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => ForecastReportPage(
                                            weatherData: weatherData,
                                            cityName: cityName,
                                            primaryBrown: primaryBrown,
                                            lightBrown: lightBrown,
                                            accentBrown: accentBrown,
                                            getWeatherImage: _getWeatherImage,
                                          ),
                                        ),
                                      );
                                    },
                                    icon: Icon(
                                      Icons.arrow_forward,
                                      color: primaryBrown,
                                      size: 18,
                                    ),
                                    label: Text(
                                      'Lihat Selengkapnya',
                                      style: TextStyle(
                                        color: primaryBrown,
                                        fontSize: 14,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 20),

                              // Hourly Forecast
                              SizedBox(
                                height: 150,
                                child: ListView.builder(
                                  scrollDirection: Axis.horizontal,
                                  itemCount: todayForecast.length,
                                  itemBuilder: (context, index) {
                                    final data = todayForecast[index];
                                    return _buildHourlyCard(
                                      data['time']!,
                                      data['temp']!,
                                      data['weather']!,
                                      index == 0,
                                    );
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 30),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            
            // Loading overlay
            if (isLoading)
              Container(
                color: Colors.black54,
                child: Center(
                  child: Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        CircularProgressIndicator(
                          color: primaryBrown,
                          strokeWidth: 3,
                        ),
                        const SizedBox(height: 16),
                        Text(
                          'Memuat data cuaca...',
                          style: TextStyle(
                            color: primaryBrown,
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoCard(String label, String value, IconData icon) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.white, lightBrown.withOpacity(0.3)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: accentBrown.withOpacity(0.5), width: 2),
        boxShadow: [
          BoxShadow(
            color: primaryBrown.withOpacity(0.15),
            blurRadius: 12,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: primaryBrown.withOpacity(0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(icon, color: primaryBrown, size: 32),
          ),
          const SizedBox(height: 12),
          Text(
            label,
            style: TextStyle(
              color: primaryBrown.withOpacity(0.7),
              fontSize: 13,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            value,
            style: TextStyle(
              color: primaryBrown,
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHourlyCard(
    String time,
    String temp,
    String weather,
    bool isActive,
  ) {
    return Container(
      width: 90,
      margin: const EdgeInsets.only(right: 12),
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 8),
      decoration: BoxDecoration(
        gradient: isActive
            ? LinearGradient(
                colors: [primaryBrown, primaryBrown.withOpacity(0.8)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              )
            : null,
        color: isActive ? null : lightBrown,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(
          color: isActive ? primaryBrown : accentBrown.withOpacity(0.5),
          width: 2,
        ),
        boxShadow: [
          BoxShadow(
            color: isActive 
                ? primaryBrown.withOpacity(0.3)
                : Colors.black.withOpacity(0.05),
            blurRadius: isActive ? 12 : 6,
            offset: Offset(0, isActive ? 6 : 3),
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Waktu
          Text(
            time,
            style: TextStyle(
              color: isActive ? Colors.white : primaryBrown,
              fontSize: 14,
              fontWeight: FontWeight.w700,
            ),
          ),

          const SizedBox(height: 12),

          // Gambar Cuaca
          Image.asset(
            _getWeatherImage(weather),
            width: 40,
            height: 40,
            errorBuilder: (context, error, stackTrace) {
              return Icon(
                Icons.wb_sunny,
                color: isActive ? Colors.white : primaryBrown,
                size: 40,
              );
            },
          ),

          const SizedBox(height: 12),

          // Suhu
          Text(
            '$temp°',
            style: TextStyle(
              color: isActive ? Colors.white : primaryBrown,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}

// Search Location Page
class SearchLocationPage extends StatefulWidget {
  final Color primaryBrown;
  final Color lightBrown;
  final Color accentBrown;

  const SearchLocationPage({
    super.key,
    required this.primaryBrown,
    required this.lightBrown,
    required this.accentBrown,
  });

  @override
  State<SearchLocationPage> createState() => _SearchLocationPageState();
}

class _SearchLocationPageState extends State<SearchLocationPage> {
  final TextEditingController searchController = TextEditingController();
  final List<String> cities = ['Bandung', 'Jakarta', 'Tangerang', 'Lampung'];
  List<String> filteredCities = [];

  @override
  void initState() {
    super.initState();
    filteredCities = cities;
  }

  void _filterCities(String query) {
    setState(() {
      if (query.isEmpty) {
        filteredCities = cities;
      } else {
        filteredCities = cities
            .where((city) => city.toLowerCase().contains(query.toLowerCase()))
            .toList();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: widget.lightBrown,
      body: SafeArea(
        child: Column(
          children: [
            // Header dengan gradient
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [widget.primaryBrown, widget.primaryBrown.withOpacity(0.8)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                boxShadow: [
                  BoxShadow(
                    color: widget.primaryBrown.withOpacity(0.3),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Column(
                children: [
                  Row(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.2),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: IconButton(
                          icon: const Icon(Icons.arrow_back, color: Colors.white),
                          onPressed: () => Navigator.pop(context),
                        ),
                      ),
                      const SizedBox(width: 12),
                      const Expanded(
                        child: Text(
                          'Cari Lokasi',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  
                  // Search Box
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(
                        color: widget.accentBrown.withOpacity(0.5),
                        width: 2,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          blurRadius: 8,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: TextField(
                      controller: searchController,
                      style: TextStyle(
                        color: widget.primaryBrown,
                        fontSize: 16,
                      ),
                      decoration: InputDecoration(
                        hintText: 'Ketik nama kota...',
                        hintStyle: TextStyle(
                          color: widget.primaryBrown.withOpacity(0.4),
                        ),
                        border: InputBorder.none,
                        icon: Icon(
                          Icons.search,
                          color: widget.primaryBrown,
                          size: 24,
                        ),
                        suffixIcon: searchController.text.isNotEmpty
                            ? IconButton(
                                icon: Icon(
                                  Icons.clear,
                                  color: widget.primaryBrown,
                                ),
                                onPressed: () {
                                  searchController.clear();
                                  _filterCities('');
                                },
                              )
                            : null,
                      ),
                      onChanged: _filterCities,
                    ),
                  ),
                ],
              ),
            ),

            // Cities List
            Expanded(
              child: filteredCities.isEmpty
                  ? Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.location_off,
                            size: 64,
                            color: widget.primaryBrown.withOpacity(0.3),
                          ),
                          const SizedBox(height: 16),
                          Text(
                            'Kota tidak ditemukan',
                            style: TextStyle(
                              color: widget.primaryBrown.withOpacity(0.6),
                              fontSize: 18,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    )
                  : ListView.builder(
                      padding: const EdgeInsets.all(20),
                      itemCount: filteredCities.length,
                      itemBuilder: (context, index) {
                        return Container(
                          margin: const EdgeInsets.only(bottom: 12),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(16),
                            border: Border.all(
                              color: widget.accentBrown.withOpacity(0.5),
                              width: 2,
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: widget.primaryBrown.withOpacity(0.08),
                                blurRadius: 8,
                                offset: const Offset(0, 4),
                              ),
                            ],
                          ),
                          child: Material(
                            color: Colors.transparent,
                            child: InkWell(
                              onTap: () {
                                Navigator.pop(context, filteredCities[index]);
                              },
                              borderRadius: BorderRadius.circular(16),
                              child: Padding(
                                padding: const EdgeInsets.all(16),
                                child: Row(
                                  children: [
                                    Container(
                                      padding: const EdgeInsets.all(8),
                                      decoration: BoxDecoration(
                                        color: widget.primaryBrown.withOpacity(0.1),
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                      child: Icon(
                                        Icons.location_on,
                                        color: widget.primaryBrown,
                                        size: 24,
                                      ),
                                    ),
                                    const SizedBox(width: 16),
                                    Expanded(
                                      child: Text(
                                        filteredCities[index],
                                        style: TextStyle(
                                          color: widget.primaryBrown,
                                          fontSize: 18,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ),
                                    Icon(
                                      Icons.arrow_forward_ios,
                                      color: widget.primaryBrown.withOpacity(0.4),
                                      size: 18,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
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

// Forecast Report Page
class ForecastReportPage extends StatelessWidget {
  final Map<String, dynamic>? weatherData;
  final String cityName;
  final Color primaryBrown;
  final Color lightBrown;
  final Color accentBrown;
  final Function(String) getWeatherImage;

  const ForecastReportPage({
    super.key,
    this.weatherData,
    required this.cityName,
    required this.primaryBrown,
    required this.lightBrown,
    required this.accentBrown,
    required this.getWeatherImage,
  });

  @override
  Widget build(BuildContext context) {
    List<Map<String, dynamic>> weekForecast = [];

    if (weatherData != null && weatherData!['data'] != null) {
      final cuacaList = weatherData!['data'][0]['cuaca'] as List<dynamic>?;
      if (cuacaList != null && cuacaList.isNotEmpty) {
        for (int i = 0; i < cuacaList.length && i < 7; i++) {
          final cuacaData = cuacaList[i] as List<dynamic>;
          if (cuacaData.isNotEmpty) {
            final item = cuacaData[0];
            weekForecast.add({
              'day': _getDayName(item['local_datetime']?.toString() ?? ''),
              'date': _getDate(item['local_datetime']?.toString() ?? ''),
              'temp': _parseTemp(item['t']),
              'weather': _parseWeatherCode(item['weather'] ?? 0),
            });
          }
        }
      }
    }

    // Fallback data jika tidak ada data dari API
    if (weekForecast.isEmpty) {
      weekForecast = List.generate(7, (index) {
        return {
          'day': _getWeekDay(index),
          'date': _getWeekDate(index),
          'temp': '${28 + (index % 3)}',
          'weather': ['cerah', 'berawan', 'hujan'][index % 3],
        };
      });
    }

    return Scaffold(
      backgroundColor: lightBrown,
      body: SafeArea(
        child: Column(
          children: [
            // Header dengan gradient
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [primaryBrown, primaryBrown.withOpacity(0.8)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                boxShadow: [
                  BoxShadow(
                    color: primaryBrown.withOpacity(0.3),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Row(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: IconButton(
                      icon: const Icon(Icons.arrow_back, color: Colors.white),
                      onPressed: () => Navigator.pop(context),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Laporan Perkiraan',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          cityName,
                          style: TextStyle(
                            color: Colors.white.withOpacity(0.8),
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            // Date Info
            Container(
              margin: const EdgeInsets.all(20),
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                  color: accentBrown.withOpacity(0.5),
                  width: 2,
                ),
                boxShadow: [
                  BoxShadow(
                    color: primaryBrown.withOpacity(0.1),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Icon(
                            Icons.calendar_today,
                            color: primaryBrown,
                            size: 20,
                          ),
                          const SizedBox(width: 8),
                          Text(
                            'Hari Ini',
                            style: TextStyle(
                              color: primaryBrown,
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                      Text(
                        DateFormat('dd MMM yyyy').format(DateTime.now()),
                        style: TextStyle(
                          color: primaryBrown.withOpacity(0.7),
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Container(
                    height: 2,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          accentBrown.withOpacity(0.1),
                          accentBrown.withOpacity(0.5),
                          accentBrown.withOpacity(0.1),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Perkiraan 7 Hari Ke Depan',
                      style: TextStyle(
                        color: primaryBrown,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // Weekly Forecast
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                itemCount: weekForecast.length,
                itemBuilder: (context, index) {
                  final data = weekForecast[index];
                  return _buildForecastCard(
                    data['day'],
                    data['date'],
                    data['temp'],
                    data['weather'],
                    index == 0,
                  );
                },
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget _buildForecastCard(
    String day,
    String date,
    String temp,
    String weather,
    bool isToday,
  ) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: isToday
            ? LinearGradient(
                colors: [
                  primaryBrown.withOpacity(0.1),
                  accentBrown.withOpacity(0.2),
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              )
            : null,
        color: isToday ? null : Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: isToday
              ? primaryBrown.withOpacity(0.4)
              : accentBrown.withOpacity(0.5),
          width: isToday ? 3 : 2,
        ),
        boxShadow: [
          BoxShadow(
            color: primaryBrown.withOpacity(isToday ? 0.15 : 0.08),
            blurRadius: isToday ? 12 : 8,
            offset: Offset(0, isToday ? 6 : 4),
          ),
        ],
      ),
      child: Row(
        children: [
          // Day and Date
          Expanded(
            flex: 2,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      day,
                      style: TextStyle(
                        color: primaryBrown,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    if (isToday) ...[
                      const SizedBox(width: 8),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 2,
                        ),
                        decoration: BoxDecoration(
                          color: primaryBrown,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: const Text(
                          'Hari Ini',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ],
                ),
                const SizedBox(height: 4),
                Text(
                  date,
                  style: TextStyle(
                    color: primaryBrown.withOpacity(0.6),
                    fontSize: 13,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
          
          // Weather Icon
          Expanded(
            child: Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: primaryBrown.withOpacity(0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Image.asset(
                getWeatherImage(weather),
                width: 48,
                height: 48,
                errorBuilder: (context, error, stackTrace) {
                  return Icon(
                    Icons.wb_sunny,
                    color: primaryBrown,
                    size: 48,
                  );
                },
              ),
            ),
          ),
          
          // Temperature
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  '$temp°',
                  style: TextStyle(
                    color: primaryBrown,
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  weather.toUpperCase(),
                  style: TextStyle(
                    color: primaryBrown.withOpacity(0.6),
                    fontSize: 11,
                    fontWeight: FontWeight.w600,
                    letterSpacing: 0.5,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  String _getDayName(String datetime) {
    try {
      final dt = DateTime.parse(datetime);
      final days = ['Senin', 'Selasa', 'Rabu', 'Kamis', 'Jumat', 'Sabtu', 'Minggu'];
      return days[dt.weekday - 1];
    } catch (e) {
      return 'Hari Ini';
    }
  }

  String _getDate(String datetime) {
    try {
      final dt = DateTime.parse(datetime);
      return DateFormat('dd MMM').format(dt);
    } catch (e) {
      return DateFormat('dd MMM').format(DateTime.now());
    }
  }

  String _getWeekDay(int index) {
    final date = DateTime.now().add(Duration(days: index));
    final days = ['Senin', 'Selasa', 'Rabu', 'Kamis', 'Jumat', 'Sabtu', 'Minggu'];
    return days[date.weekday - 1];
  }

  String _getWeekDate(int index) {
    final date = DateTime.now().add(Duration(days: index));
    return DateFormat('dd MMM').format(date);
  }

  String _parseTemp(dynamic value) {
    if (value == null) return '0';
    if (value is int) return value.toString();
    if (value is double) return value.round().toString();
    if (value is String) {
      try {
        return double.parse(value).round().toString();
      } catch (e) {
        return '0';
      }
    }
    return '0';
  }

  String _parseWeatherCode(dynamic weatherCode) {
    final code = weatherCode.toString();
    
    if (code == '0' || code == '1' || code == '2') {
      return 'cerah';
    } else if (code == '3' || code == '4') {
      return 'berawan';
    } else if (code == '5' || code == '6' || code == '60' || 
               code == '61' || code == '63' || code == '80') {
      return 'hujan';
    } else if (code == '95' || code == '97') {
      return 'petir';
    }
    return 'cerah';
  }
}