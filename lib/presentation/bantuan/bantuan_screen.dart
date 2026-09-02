import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';

import '../agenda/agenda_screen.dart';

class BantuanScreen extends StatefulWidget {
  const BantuanScreen({super.key});

  @override
  State<BantuanScreen> createState() => _BantuanScreenState();
}

class _BantuanScreenState extends State<BantuanScreen> {
  int? expandedIndex;

  final Color primaryBlue = const Color(0xFF0066B3);
  final Color darkText = const Color(0xFF202020);
  final Color greyText = const Color(0xFF6D7680);
  final Color background = const Color(0xFFF8FAFC);

  final List<Map<String, String>> faqList = [
    {
      'question': 'Bagaimana cara cetak E-Tiket?',
      'answer':
          'Buka menu Agenda, pilih agenda yang ingin diikuti, kemudian lakukan reservasi. E-Tiket dapat dilihat setelah reservasi berhasil.',
    },
    {
      'question': 'Bagaimana jika NIK tidak terverifikasi?',
      'answer':
          'Pastikan NIK yang dimasukkan sudah benar dan sesuai dengan data kependudukan. Jika masih mengalami kendala, silakan hubungi pusat bantuan.',
    },
    {
      'question': 'Bagaimana cara menggunakan layanan?',
      'answer':
          'Pilih menu Layanan pada navigasi bagian bawah, kemudian pilih layanan yang ingin digunakan.',
    },
    {
      'question': 'Bagaimana cara melihat agenda kota?',
      'answer':
          'Pilih menu Agenda atau geser bagian Agenda Kota pada halaman Beranda.',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: background,
      body: SafeArea(
        child: Column(
          children: [
            _buildHeader(),

            Expanded(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                padding: const EdgeInsets.fromLTRB(
                  24,
                  22,
                  24,
                  110,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildHelpBanner(),

                    const SizedBox(height: 36),

                    _buildContactSection(),

                    const SizedBox(height: 36),

                    _buildFaqSection(),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),

      bottomNavigationBar: _buildBottomNavigation(),
    );
  }

  // ============================================================
  // HEADER
  // ============================================================

  Widget _buildHeader() {
    return Container(
      height: 72,
      decoration: BoxDecoration(
        color: background,
        border: Border(
          bottom: BorderSide(
            color: Colors.grey.shade300,
            width: 1,
          ),
        ),
      ),
      child: Row(
        children: [
          const SizedBox(width: 16),

          // Tombol back dalam kotak lembut
          GestureDetector(
            onTap: () => Navigator.pop(context),
            child: Container(
              width: 42,
              height: 42,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(13),
                border: Border.all(color: const Color(0xFFE1E8F0)),
              ),
              child: Icon(
                Icons.arrow_back_ios_new_rounded,
                size: 18,
                color: primaryBlue,
              ),
            ),
          ),

          const SizedBox(width: 14),

          Text(
            'Pusat Bantuan',
            style: GoogleFonts.poppins(
              fontSize: 22,
              fontWeight: FontWeight.w700,
              color: primaryBlue,
            ),
          ),
        ],
      ),
    );
  }

  // ============================================================
  // BANNER BANTUAN
  // ============================================================

  Widget _buildHelpBanner() {
    return ClipRRect(
      borderRadius: BorderRadius.circular(22),
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color(0xFF0788BE),
              Color(0xFF12A3C9),
              Color(0xFF168CC2),
            ],
          ),
          borderRadius: BorderRadius.circular(22),
          boxShadow: [
            BoxShadow(
              color: primaryBlue.withValues(alpha: 0.28),
              blurRadius: 18,
              offset: const Offset(0, 10),
            ),
          ],
        ),
        child: Stack(
          children: [
            // Gelombang dekoratif membentang penuh dari ujung ke ujung,
            // dengan lengkung kiri & kanan yang berbeda bentuk.
            Positioned(
              left: 0,
              right: 0,
              bottom: 0,
              child: CustomPaint(
                size: const Size(double.infinity, 48),
                painter: _WavePainter(),
              ),
            ),

            Padding(
              padding: const EdgeInsets.fromLTRB(20, 20, 20, 20),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // Teks (tanpa tombol Hubungi PPID)
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Butuh Bantuan?',
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          softWrap: false,
                          style: GoogleFonts.poppins(
                            fontSize: 20,
                            fontWeight: FontWeight.w700,
                            color: Colors.white,
                          ),
                        ),

                        const SizedBox(height: 10),

                        Text(
                          'Kami siap membantu Anda mendapatkan '
                          'informasi dan solusi terbaik.',
                          maxLines: 3,
                          overflow: TextOverflow.ellipsis,
                          style: GoogleFonts.poppins(
                            fontSize: 12.5,
                            height: 1.45,
                            color: Colors.white.withValues(alpha: 0.92),
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(width: 10),

                  // Logo/ilustrasi bantuan
                  Image.asset(
                    'assets/images/pusat_bantuan/logo_bantuan.png',
                    width: 104,
                    height: 104,
                    fit: BoxFit.contain,
                    errorBuilder: (context, error, stackTrace) {
                      return Container(
                        width: 90,
                        height: 90,
                        decoration: BoxDecoration(
                          color: Colors.white.withValues(alpha: 0.22),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: const Icon(
                          Icons.support_agent_rounded,
                          size: 48,
                          color: Colors.white,
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ============================================================
  // HUBUNGI KAMI
  // ============================================================

  Widget _buildContactSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              width: 4,
              height: 18,
              decoration: BoxDecoration(
                color: primaryBlue,
                borderRadius: BorderRadius.circular(3),
              ),
            ),
            const SizedBox(width: 10),
            Text(
              'Hubungi Kami',
              style: GoogleFonts.poppins(
                fontSize: 17,
                fontWeight: FontWeight.w700,
                color: darkText,
              ),
            ),
          ],
        ),

        const SizedBox(height: 18),

        _buildEmailCard(),
      ],
    );
  }

  // ============================================================
  // EMAIL CARD (satu-satunya kontak)
  // ============================================================

  Widget _buildEmailCard() {
    const String email = 'intipkominfo@gmail.com';
    return GestureDetector(
      onTap: () => _openEmail(email),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(18),
          border: Border.all(
            color: const Color(0xFFEAEFF5),
            width: 1,
          ),
          boxShadow: [
            BoxShadow(
              color: const Color(0xFF0788BE).withValues(alpha: 0.05),
              blurRadius: 14,
              offset: const Offset(0, 6),
            ),
          ],
        ),
        child: Row(
          children: [
            // Ikon email dengan lingkaran biru solid
            Container(
              width: 48,
              height: 48,
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [Color(0xFF1093D6), Color(0xFF0A6CB4)],
                ),
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: primaryBlue.withValues(alpha: 0.28),
                    blurRadius: 8,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: const Icon(
                Icons.email_rounded,
                size: 23,
                color: Colors.white,
              ),
            ),

            const SizedBox(width: 14),

            // Label + alamat email
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'Email',
                    style: GoogleFonts.poppins(
                      fontSize: 11.5,
                      fontWeight: FontWeight.w500,
                      color: greyText,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    email,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: GoogleFonts.poppins(
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                      color: darkText,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(width: 10),

            // Tombol panah bulat berlatar biru lembut
            Container(
              width: 38,
              height: 38,
              decoration: const BoxDecoration(
                color: Color(0xFFE8F1FA),
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.arrow_forward_rounded,
                size: 19,
                color: primaryBlue,
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ============================================================
  // FAQ
  // ============================================================

  Widget _buildFaqSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              width: 4,
              height: 18,
              decoration: BoxDecoration(
                color: primaryBlue,
                borderRadius: BorderRadius.circular(3),
              ),
            ),
            const SizedBox(width: 10),
            Text(
              'Tanya Jawab Umum',
              style: GoogleFonts.poppins(
                fontSize: 17,
                fontWeight: FontWeight.w700,
                color: darkText,
              ),
            ),
          ],
        ),

        const SizedBox(height: 18),

        ...List.generate(
          faqList.length,
          (index) {
            final faq = faqList[index];
            final bool isExpanded = expandedIndex == index;

            return Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: GestureDetector(
                onTap: () {
                  setState(() {
                    expandedIndex = isExpanded ? null : index;
                  });
                },
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 16,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(
                      color: isExpanded
                          ? primaryBlue.withValues(alpha: 0.55)
                          : const Color(0xFFE1E8F0),
                      width: 1.3,
                    ),
                    boxShadow: isExpanded
                        ? [
                            BoxShadow(
                              color: primaryBlue.withValues(alpha: 0.10),
                              blurRadius: 12,
                              offset: const Offset(0, 5),
                            ),
                          ]
                        : null,
                  ),
                  child: Column(
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          // Badge nomor
                          Container(
                            width: 30,
                            height: 30,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              color: isExpanded
                                  ? primaryBlue
                                  : const Color(0xFFE8F0F8),
                              borderRadius: BorderRadius.circular(9),
                            ),
                            child: Text(
                              '${index + 1}',
                              style: GoogleFonts.poppins(
                                fontSize: 13,
                                fontWeight: FontWeight.w700,
                                color:
                                    isExpanded ? Colors.white : primaryBlue,
                              ),
                            ),
                          ),

                          const SizedBox(width: 12),

                          Expanded(
                            child: Text(
                              faq['question']!,
                              style: GoogleFonts.poppins(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                color: darkText,
                                height: 1.35,
                              ),
                            ),
                          ),

                          const SizedBox(width: 8),

                          AnimatedRotation(
                            turns: isExpanded ? 0.5 : 0,
                            duration: const Duration(milliseconds: 200),
                            child: Icon(
                              Icons.keyboard_arrow_down_rounded,
                              size: 26,
                              color: isExpanded ? primaryBlue : greyText,
                            ),
                          ),
                        ],
                      ),

                      if (isExpanded) ...[
                        const SizedBox(height: 14),
                        Container(
                          height: 1,
                          color: const Color(0xFFEEF2F6),
                        ),
                        const SizedBox(height: 12),
                        Padding(
                          padding: const EdgeInsets.only(left: 42),
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              faq['answer']!,
                              style: GoogleFonts.poppins(
                                fontSize: 13,
                                height: 1.55,
                                color: greyText,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ],
    );
  }

  // ============================================================
  // BOTTOM NAVIGATION
  // ============================================================

  Widget _buildBottomNavigation() {
    return Container(
      height: 95,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(22)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.07),
            blurRadius: 10,
            offset: const Offset(0, -3),
          ),
        ],
      ),
      child: SafeArea(
        top: false,
        child: Row(
          children: [
            Expanded(
              child: _buildNavItem(
                icon: Icons.home_outlined,
                activeIcon: Icons.home_rounded,
                label: 'Beranda',
                active: false,
                onTap: () {
                  Navigator.of(context).popUntil((r) => r.isFirst);
                },
              ),
            ),
            Expanded(
              child: _buildNavItem(
                icon: Icons.grid_view_rounded,
                activeIcon: Icons.grid_view_rounded,
                label: 'Layanan',
                active: true,
                onTap: () {
                  Navigator.pop(context);
                },
              ),
            ),
            Expanded(
              child: _buildNavItem(
                icon: Icons.calendar_month_outlined,
                activeIcon: Icons.calendar_month_rounded,
                label: 'Agenda',
                active: false,
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => const AgendaScreen(),
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

  // ============================================================
  // NAV ITEM (seragam dengan layanan lain)
  // ============================================================

  Widget _buildNavItem({
    required IconData icon,
    required IconData activeIcon,
    required String label,
    required bool active,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Center(
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          width: 95,
          height: 52,
          decoration: BoxDecoration(
            color: active ? const Color(0xFF58D8EC) : Colors.transparent,
            borderRadius: BorderRadius.circular(27),
          ),
          child: Transform.translate(
            offset: const Offset(0, -1),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  active ? activeIcon : icon,
                  size: 22,
                  color: active
                      ? const Color(0xFF315579)
                      : const Color(0xFF374151),
                ),
                const SizedBox(height: 1),
                Text(
                  label,
                  style: GoogleFonts.poppins(
                    fontSize: 9,
                    fontWeight: active ? FontWeight.w600 : FontWeight.w400,
                    color: active
                        ? const Color(0xFF315579)
                        : const Color(0xFF374151),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // ============================================================
  // BUKA EMAIL (mailto)
  // ============================================================

  Future<void> _openEmail(String email) async {
    final messenger = ScaffoldMessenger.of(context);
    final Uri uri = Uri(
      scheme: 'mailto',
      path: email,
      query: 'subject=${Uri.encodeComponent('Bantuan Aplikasi Sragen Smart')}',
    );

    final bool launched =
        await launchUrl(uri, mode: LaunchMode.externalApplication);

    if (!launched && messenger.mounted) {
      messenger.showSnackBar(
        SnackBar(
          content: Text('Tidak dapat membuka aplikasi email. Email: $email'),
          behavior: SnackBarBehavior.floating,
        ),
      );
    }
  }

  // ============================================================
  // GELOMBANG DEKORATIF UNTUK BANNER BANTUAN
  // ============================================================
}


// ============================================================
// GELOMBANG DEKORATIF UNTUK BANNER BANTUAN
// Dua lapis gelombang putih transparan di bagian bawah banner.
// ============================================================
class _WavePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final double w = size.width;
    final double h = size.height;

    // Lapisan gelombang belakang (lebih samar).
    // Kiri mulai rendah lalu naik, kanan turun tajam -> bentuk asimetris.
    final backPaint = Paint()
      ..color = Colors.white.withValues(alpha: 0.10)
      ..style = PaintingStyle.fill;

    final backPath = Path()
      ..moveTo(0, h * 0.55)
      // sisi kiri: lengkung landai naik
      ..quadraticBezierTo(w * 0.20, h * 0.10, w * 0.42, h * 0.40)
      // tengah ke kanan: lengkung lebih dalam & tajam
      ..cubicTo(w * 0.60, h * 0.62, w * 0.80, h * 0.05, w, h * 0.42)
      ..lineTo(w, h)
      ..lineTo(0, h)
      ..close();
    canvas.drawPath(backPath, backPaint);

    // Lapisan gelombang depan (lebih terang).
    // Bentuk kiri (bulat lembut) berbeda dengan kanan (tarikan tajam).
    final frontPaint = Paint()
      ..color = Colors.white.withValues(alpha: 0.18)
      ..style = PaintingStyle.fill;

    final frontPath = Path()
      ..moveTo(0, h * 0.78)
      // sisi kiri: gundukan bulat
      ..quadraticBezierTo(w * 0.18, h * 0.42, w * 0.40, h * 0.66)
      // sisi kanan: turun-naik lebih tajam
      ..cubicTo(w * 0.62, h * 0.92, w * 0.82, h * 0.30, w, h * 0.70)
      ..lineTo(w, h)
      ..lineTo(0, h)
      ..close();
    canvas.drawPath(frontPath, frontPaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
