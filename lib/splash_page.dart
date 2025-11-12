import 'package:flutter/material.dart';
import 'dart:async';

import 'package:google_fonts/google_fonts.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 5), () {
      Navigator.pushReplacementNamed(context, '/home');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFEADBC8),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Judul aplikasi
            Text(
              "Nasy's App",
              style: GoogleFonts.poppins(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: const Color(0xff3C3C3C),
                letterSpacing: 1.2,
              ),
            ),

            const SizedBox(height: 24),

            // Foto profil
            ClipRRect(
              borderRadius: BorderRadius.circular(100),
              child: Image.asset(
                'assets/images/photoprofile.png',
                width: 350,
                height: 350,
                fit: BoxFit.cover,
              ),
            ),

            const SizedBox(height: 50),

            // Nama
            Text(
              'Nasywa Adita Zain',
              style: GoogleFonts.poppins(
                fontSize: 20,
                fontWeight: FontWeight.w600,
                color: const Color(0xff3C3C3C),
              ),
            ),

            const SizedBox(height: 4),

            // NRP
            Text(
              '152023006',
              style: GoogleFonts.poppins(
                fontSize: 16,
                color: const Color(0xff6B6B6B),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
