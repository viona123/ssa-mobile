import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../app/routes.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  Timer? _timer;

  @override
  void initState() {
    super.initState();

    _timer = Timer(
      const Duration(seconds: 3),
      () {
        if (!mounted) return;

        Navigator.pushReplacementNamed(
          context,
          AppRoutes.home,
        );
      },
    );
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark,
        systemNavigationBarColor: Color(0xFFF4F7F8),
        systemNavigationBarIconBrightness: Brightness.dark,
      ),
      child: Scaffold(
        backgroundColor: const Color(0xFFF4F7F8),
        body: SafeArea(
          child: LayoutBuilder(
            builder: (context, constraints) {
              final height = constraints.maxHeight;
              final width = constraints.maxWidth;

              return Stack(
                children: [
                  // ==========================
                  // LOGO KABUPATEN SRAGEN
                  // ==========================
                  Positioned(
                    top: height * 0.27,
                    left: 0,
                    right: 0,
                    child: Center(
                      child: Image.asset(
                        'assets/images/splash/logo_kabupaten_sragen.png',
                        width: width * 0.30,
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),

                  // ==========================
                  // JUDUL
                  // ==========================
                  Positioned(
                    top: height * 0.605,
                    left: 20,
                    right: 20,
                    child: Text(
                      'Sragen Smart City',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: width * 0.067,
                        fontWeight: FontWeight.w700,
                        color: const Color(0xFF006B92),
                        letterSpacing: -0.8,
                      ),
                    ),
                  ),

                  // ==========================
                  // SUBTITLE
                  // ==========================
                  Positioned(
                    top: height * 0.665,
                    left: 35,
                    right: 35,
                    child: Text(
                      'Layanan Digital Terintegrasi\nKabupaten Sragen',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: width * 0.040,
                        height: 1.5,
                        color: const Color(0xFF68747B),
                      ),
                    ),
                  ),

                  // ==========================
                  // PROGRESS BAR
                  // ==========================
                  Positioned(
                    bottom: height * 0.115,
                    left: 0,
                    right: 0,
                    child: Center(
                      child: Container(
                        width: width * 0.36,
                        height: 7,
                        decoration: BoxDecoration(
                          color: const Color(0xFFD5E3E8),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Container(
                            width: width * 0.16,
                            decoration: BoxDecoration(
                              color: const Color(0xFF006B92),
                              borderRadius: BorderRadius.circular(20),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),

                  // ==========================
                  // PEMERINTAH KABUPATEN SRAGEN
                  // ==========================
                  Positioned(
                    bottom: height * 0.065,
                    left: 20,
                    right: 20,
                    child: Text(
                      'Pemerintah Kabupaten Sragen',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: width * 0.032,
                        fontWeight: FontWeight.w700,
                        color: const Color(0xFF6D7980),
                      ),
                    ),
                  ),

                  // ==========================
                  // COPYRIGHT
                  // ==========================
                  Positioned(
                    bottom: height * 0.025,
                    left: 20,
                    right: 20,
                    child: Text(
                      '© 2024 • Civic Horizon UI',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: width * 0.027,
                        color: const Color(0xFFA1ADB3),
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}