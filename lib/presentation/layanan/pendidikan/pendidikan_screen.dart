import 'package:flutter/material.dart';
import '../../agenda/agenda_screen.dart';
import '../../bantuan/bantuan_screen.dart';
import 'cek_kip_screen.dart';
import 'daftar_layanan_screen.dart';
import 'dashboard_statistik_screen.dart';

// ================================================================
// LAYANAN PENDIDIKAN SCREEN
// Desain 1:1 sesuai context/gambar4.png
// ================================================================

class PendidikanScreen extends StatelessWidget {
  const PendidikanScreen({super.key});

  // ============================================================
  // COLORS
  // ============================================================

  static const Color _appBlue = Color(0xFF007EA7);
  static const Color _tealLight = Color(0xFF58D8EC);
  static const Color _navyDark = Color(0xFF315579);
  static const Color _bg = Color(0xFFF8FAFC);
  static const Color _smoke = Color(0xFF6B7280);
  static const Color _titleBlue = Color(0xFF003D6B);
  static const Color _linkBlue = Color(0xFF0077B6);
  static const Color _cardBg = Color(0xFFF4F7FA);
  static const Color _iconBg = Color(0xFFEDF1F5);

  // Gradient untuk judul — sesuai gambar4.png
  static const Color _gradStart = Color(0xFF003366);
  static const Color _gradEnd = Color(0xFF0056B3);

  // ============================================================
  // BUILD
  // ============================================================

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _bg,
      bottomNavigationBar: _buildNavBar(context),
      body: Stack(
        children: [
          SafeArea(
            child: Column(
              children: [
                _buildHeader(context),
                Expanded(
                  child: SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Column(
                      children: [
                        const SizedBox(height: 18),
                        _buildBadge(),
                        const SizedBox(height: 12),
                        _buildGradientTitle(),
                        const SizedBox(height: 16),
                        _buildLogo(),
                        const SizedBox(height: 14),
                        _buildDescription(),
                        const SizedBox(height: 40),
                        _buildMenuCard(
                          icon: Icons.manage_search_rounded,
                          title: 'Cek KIP',
                          subtitle: 'Validasi status penerima program KIP',
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => const CekKipScreen(),
                              ),
                            );
                          },
                        ),
                        const SizedBox(height: 12),
                        _buildMenuCard(
                          icon: Icons.list_alt_rounded,
                          title: 'Daftar Layanan',
                          subtitle: 'Eksplorasi ragam layanan pendidikan',
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => const DaftarLayananScreen(),
                              ),
                            );
                          },
                        ),
                        const SizedBox(height: 12),
                        _buildMenuCard(
                          icon: Icons.insights_rounded,
                          title: 'Dashboard Statistik',
                          subtitle: 'Pantau data pendidikan secara visual',
                          iconColor: const Color(0xFF2DD4BF),
                          iconBgColor: const Color(0xFFE0FAF5),
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => const DashboardStatistikScreen(),
                              ),
                            );
                          },
                        ),
                        const SizedBox(height: 80),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),

          // ====================================================
          // PUSAT BANTUAN — FIXED DI KANAN BAWAH
          // ====================================================
          Positioned(
            right: 26,
            bottom: 14,
            child: _buildHelpButton(context),
          ),
        ],
      ),
    );
  }

  // ============================================================
  // HEADER — ← Layanan Pendidikan (sama style home/agenda)
  // ============================================================

  Widget _buildHeader(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 66,
      decoration: const BoxDecoration(
        color: _bg,
        border: Border(
          bottom: BorderSide(
            color: Color(0xFFE5E7EB),
            width: 0.7,
          ),
        ),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Row(
        children: [
          GestureDetector(
            onTap: () => Navigator.pop(context),
            child: const Icon(
              Icons.arrow_back_ios_new_rounded,
              size: 22,
              color: _appBlue,
            ),
          ),
          const SizedBox(width: 16),
          const Text(
            'Layanan Pendidikan',
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.w700,
              color: _appBlue,
            ),
          ),
        ],
      ),
    );
  }

  // ============================================================
  // BADGE — LANGIT SUKOWATI - DISDIKBUD
  // ============================================================

  Widget _buildBadge() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 7),
      decoration: BoxDecoration(
        color: const Color(0xFFEDF4F8),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: const Color(0xFFD4E6F0)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: const [
          Icon(
            Icons.home_outlined,
            size: 14,
            color: _appBlue,
          ),
          SizedBox(width: 6),
          Text(
            'LANGIT SUKOWATI - DISDIKBUD',
            style: TextStyle(
              fontSize: 10,
              fontWeight: FontWeight.w700,
              color: _appBlue,
              letterSpacing: 0.4,
            ),
          ),
        ],
      ),
    );
  }

  // ============================================================
  // GRADIENT TITLE — Layanan Digital DISDIKBUD
  // Gradasi sesuai gambar4.png: biru medium ke navy gelap
  // ============================================================

  Widget _buildGradientTitle() {
    return ShaderMask(
      shaderCallback: (Rect bounds) {
        return const LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [_gradStart, _gradEnd],
        ).createShader(bounds);
      },
      blendMode: BlendMode.srcIn,
      child: const Text(
        'Layanan Digital\nDISDIKBUD',
        textAlign: TextAlign.center,
        style: TextStyle(
          fontSize: 28,
          fontWeight: FontWeight.w900,
          color: Colors.white,
          height: 1.25,
        ),
      ),
    );
  }

  // ============================================================
  // LOGO — Tut Wuri Handayani dari assets
  // ============================================================

  Widget _buildLogo() {
    return Image.asset(
      'assets/images/pendidikan/tutwuri.png',
      width: 100,
      height: 100,
      fit: BoxFit.contain,
      errorBuilder: (_, __, ___) => Container(
        width: 100,
        height: 100,
        decoration: const BoxDecoration(
          shape: BoxShape.circle,
          color: Color(0xFF2196C9),
        ),
        child: const Icon(
          Icons.school_rounded,
          size: 40,
          color: Colors.white,
        ),
      ),
    );
  }

  // ============================================================
  // DESCRIPTION
  // ============================================================

  Widget _buildDescription() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: RichText(
        textAlign: TextAlign.center,
        text: TextSpan(
          style: const TextStyle(
            fontSize: 12.5,
            color: _smoke,
            height: 1.55,
          ),
          children: [
            const TextSpan(
              text: 'Portal digital Dinas Pendidikan dan Kebudayan Kabupaten Sragen melalui platform ',
            ),
            TextSpan(
              text: 'Langit Sukowati',
              style: const TextStyle(
                color: _linkBlue,
                fontWeight: FontWeight.w600,
              ),
            ),
            const TextSpan(
              text: '. Akses informasi ajuan, layanan, dan bidang secara real-time.',
            ),
          ],
        ),
      ),
    );
  }

  // ============================================================
  // MENU CARD — lebih besar agar pas 1 layar
  // ============================================================

  Widget _buildMenuCard({
    required IconData icon,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
    Color iconColor = _appBlue,
    Color iconBgColor = _iconBg,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 18),
        decoration: BoxDecoration(
          color: _cardBg,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: const Color(0xFFE8ECF0)),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.03),
              blurRadius: 6,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          children: [
            // Icon box
            Container(
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                color: iconBgColor,
                borderRadius: BorderRadius.circular(14),
              ),
              child: Icon(
                icon,
                size: 24,
                color: iconColor,
              ),
            ),
            const SizedBox(width: 14),
            // Text
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w700,
                      color: _titleBlue,
                    ),
                  ),
                  const SizedBox(height: 3),
                  Text(
                    subtitle,
                    style: const TextStyle(
                      fontSize: 12,
                      color: _smoke,
                    ),
                  ),
                ],
              ),
            ),
            // Arrow
            const Icon(
              Icons.chevron_right_rounded,
              size: 22,
              color: Color(0xFFBFC7D2),
            ),
          ],
        ),
      ),
    );
  }

  // ============================================================
  // PUSAT BANTUAN — identik dengan home_screen
  // ============================================================

  Widget _buildHelpButton(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: BorderRadius.circular(16),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const BantuanScreen(),
            ),
          );
        },
        child: Container(
          width: 58,
          height: 58,
          decoration: BoxDecoration(
            color: _appBlue,
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.16),
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: const Icon(
            Icons.support_agent_rounded,
            color: Colors.white,
            size: 29,
          ),
        ),
      ),
    );
  }

  // ============================================================
  // BOTTOM NAVIGATION BAR (identik home & agenda)
  // ============================================================

  Widget _buildNavBar(BuildContext context) {
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
              child: _navItem(
                context,
                Icons.home_outlined,
                Icons.home_rounded,
                'Beranda',
                false,
                () => Navigator.pop(context),
              ),
            ),
            Expanded(
              child: _navItem(
                context,
                Icons.grid_view_rounded,
                Icons.grid_view_rounded,
                'Layanan',
                true,
                () {},
              ),
            ),
            Expanded(
              child: _navItem(
                context,
                Icons.calendar_month_outlined,
                Icons.calendar_month_rounded,
                'Agenda',
                false,
                () {
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

  Widget _navItem(
    BuildContext context,
    IconData off,
    IconData on,
    String label,
    bool active,
    VoidCallback tap,
  ) {
    return GestureDetector(
      onTap: tap,
      child: Center(
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          width: 95,
          height: 52,
          decoration: BoxDecoration(
            color: active ? _tealLight : Colors.transparent,
            borderRadius: BorderRadius.circular(27),
          ),
          child: Transform.translate(
            offset: const Offset(0, -1),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  active ? on : off,
                  size: 22,
                  color: active ? _navyDark : const Color(0xFF374151),
                ),
                const SizedBox(height: 1),
                Text(
                  label,
                  style: TextStyle(
                    fontSize: 9,
                    fontWeight: active ? FontWeight.w600 : FontWeight.w400,
                    color: active ? _navyDark : const Color(0xFF374151),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
