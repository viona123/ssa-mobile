import 'package:flutter/material.dart';

import 'puskesmas_shared.dart';
import 'portal_klinisia_screen.dart';
import 'e_dashboard_screen.dart';
import 'daftar_puskesmas_screen.dart';
import 'layanan_medis_screen.dart';
import 'alur_panduan_screen.dart';

// ================================================================
// LAYANAN PUSKESMAS SRAGEN — LANDING
// Desain mengikuti context/puskesmas1.png & context/e-das.png dengan
// nuansa hijau. Menampilkan 5 pilihan navigasi ke sub-halaman:
//   1. Portal Klinisia (Online)
//   2. e-Dashboard Sragen
//   3. Daftar 25 Puskesmas
//   4. Layanan Medis
//   5. Alur & Panduan
// ================================================================

class PuskesmasScreen extends StatelessWidget {
  const PuskesmasScreen({super.key});

  // ---- 4 kartu statistik ----
  static const List<_StatItem> _stats = [
    _StatItem('25', 'Puskesmas Aktif', Icons.add_box_rounded,
        PuskesmasColors.primaryGreen),
    _StatItem('20', 'Kecamatan Terlayani', Icons.apartment_rounded,
        PuskesmasColors.primaryBlue),
    _StatItem('24/7', 'Layanan Darurat & UGD', Icons.emergency_rounded,
        Color(0xFFE0A118)),
    _StatItem('100%', 'Terintegrasi BPJS/JKN', Icons.verified_user_rounded,
        Color(0xFF7B57C7)),
  ];

  // ---- 5 pilihan menu ----
  static const List<_MenuItem> _menus = [
    _MenuItem(
      id: 'portal',
      title: 'Portal Klinisia (Online)',
      subtitle: 'Pendaftaran antrean & rekam medis digital',
      icon: Icons.forum_rounded,
      color: PuskesmasColors.primaryGreen,
    ),
    _MenuItem(
      id: 'edashboard',
      title: 'e-Dashboard Sragen',
      subtitle: 'Monitoring & analitik data kesehatan',
      icon: Icons.show_chart_rounded,
      color: Color(0xFF2F80ED),
      badge: 'Data',
    ),
    _MenuItem(
      id: 'daftar',
      title: 'Daftar 25 Puskesmas',
      subtitle: 'Sebaran Puskesmas se-Kabupaten Sragen',
      icon: Icons.apartment_rounded,
      color: Color(0xFF1B6B45),
    ),
    _MenuItem(
      id: 'medis',
      title: 'Layanan Medis',
      subtitle: 'Poli, imunisasi, laboratorium & lainnya',
      icon: Icons.medical_services_rounded,
      color: Color(0xFF7B57C7),
    ),
    _MenuItem(
      id: 'alur',
      title: 'Alur & Panduan',
      subtitle: 'Cara daftar, syarat & langkah kunjungan',
      icon: Icons.help_outline_rounded,
      color: Color(0xFFE0A118),
    ),
  ];

  void _onMenuTap(BuildContext context, String id) {
    final Widget screen;
    switch (id) {
      case 'portal':
        screen = const PortalKlinisiaScreen();
        break;
      case 'edashboard':
        screen = const EDashboardScreen();
        break;
      case 'daftar':
        screen = const DaftarPuskesmasScreen();
        break;
      case 'medis':
        screen = const LayananMedisScreen();
        break;
      case 'alur':
        screen = const AlurPanduanScreen();
        break;
      default:
        return;
    }
    Navigator.push(context, MaterialPageRoute(builder: (_) => screen));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: PuskesmasColors.pageBackground,
      bottomNavigationBar: const PuskesmasBottomNav(),
      body: SafeArea(
        child: Column(
          children: [
            const PuskesmasHeader(title: 'Layanan Puskesmas'),
            Expanded(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                padding: const EdgeInsets.only(bottom: 28),
                child: Column(
                  children: [
                    // GRADIENT HERO
                    Container(
                      width: double.infinity,
                      decoration: const BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            Color(0xFFE6F6ED),
                            Color(0xFFF1FBF5),
                            PuskesmasColors.pageBackground,
                          ],
                          stops: [0.0, 0.55, 1.0],
                        ),
                      ),
                      child: Column(
                        children: [
                          const SizedBox(height: 22),
                          _buildBadge(),
                          const SizedBox(height: 16),
                          _buildTitle(),
                          const SizedBox(height: 12),
                          _buildDescription(),
                          const SizedBox(height: 22),
                          _buildStats(),
                          const SizedBox(height: 22),
                        ],
                      ),
                    ),

                    const SizedBox(height: 4),

                    // SECTION HEADER
                    _buildSectionHeader(),
                    const SizedBox(height: 14),

                    // 5 MENU CARDS
                    ..._menus.map((m) => Padding(
                          padding: const EdgeInsets.fromLTRB(20, 0, 20, 12),
                          child: _buildMenuCard(context, m),
                        )),

                    const SizedBox(height: 6),
                    _buildFooter(),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ============================================================
  // BADGE
  // ============================================================
  Widget _buildBadge() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 7),
      decoration: BoxDecoration(
        color: PuskesmasColors.mintGreen,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: PuskesmasColors.mintGreenBorder, width: 1),
      ),
      child: const Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.add_box_rounded,
              size: 15, color: PuskesmasColors.primaryGreen),
          SizedBox(width: 6),
          Flexible(
            child: Text(
              'FASILITAS KESEHATAN TINGKAT PERTAMA (FKTP)',
              style: TextStyle(
                fontSize: 10,
                fontWeight: FontWeight.w700,
                color: PuskesmasColors.primaryGreen,
                letterSpacing: 0.4,
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ============================================================
  // TITLE
  // ============================================================
  Widget _buildTitle() {
    return const Padding(
      padding: EdgeInsets.symmetric(horizontal: 32),
      child: Text.rich(
        TextSpan(
          children: [
            TextSpan(text: 'Layanan '),
            TextSpan(
              text: 'Puskesmas',
              style: TextStyle(color: PuskesmasColors.primaryGreen),
            ),
            TextSpan(text: ' Sragen'),
          ],
        ),
        textAlign: TextAlign.center,
        style: TextStyle(
          fontSize: 28,
          fontWeight: FontWeight.w800,
          color: PuskesmasColors.darkText,
          height: 1.2,
        ),
      ),
    );
  }

  // ============================================================
  // DESCRIPTION
  // ============================================================
  Widget _buildDescription() {
    return const Padding(
      padding: EdgeInsets.symmetric(horizontal: 34),
      child: Text.rich(
        TextSpan(
          children: [
            TextSpan(
              text: 'Pusat Kesehatan Masyarakat (Puskesmas) di bawah naungan ',
            ),
            TextSpan(
              text: 'Dinas Kesehatan Kabupaten Sragen ',
              style: TextStyle(
                  fontWeight: FontWeight.w700,
                  color: PuskesmasColors.darkText),
            ),
            TextSpan(
              text:
                  'menyediakan layanan kesehatan dasar yang inklusif, prima, dan '
                  'terpadu untuk mewujudkan masyarakat Sragen yang sehat, mandiri, '
                  'dan berkeadilan.',
            ),
          ],
        ),
        textAlign: TextAlign.center,
        style: TextStyle(
            fontSize: 13, color: PuskesmasColors.greyText, height: 1.5),
      ),
    );
  }

  // ============================================================
  // STATS
  // ============================================================
  Widget _buildStats() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: IntrinsicHeight(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: List.generate(_stats.length, (index) {
            return Expanded(
              child: Padding(
                padding: EdgeInsets.only(
                  left: index == 0 ? 0 : 4,
                  right: index == _stats.length - 1 ? 0 : 4,
                ),
                child: _buildStatCard(_stats[index]),
              ),
            );
          }),
        ),
      ),
    );
  }

  Widget _buildStatCard(_StatItem stat) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 6),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: PuskesmasColors.cardBorder),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.03),
            blurRadius: 6,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Icon chip
          Container(
            width: 34,
            height: 34,
            decoration: BoxDecoration(
              color: stat.color.withValues(alpha: 0.12),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(stat.icon, size: 18, color: stat.color),
          ),
          const SizedBox(height: 8),
          Text(
            stat.value,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w800,
              color: PuskesmasColors.darkText,
              height: 1.1,
            ),
          ),
          const SizedBox(height: 3),
          // Selalu sediakan ruang 2 baris agar semua kartu sama tinggi
          SizedBox(
            height: 22,
            child: Text(
              stat.label,
              textAlign: TextAlign.center,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                fontSize: 8.5,
                fontWeight: FontWeight.w500,
                color: PuskesmasColors.greyText,
                height: 1.2,
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ============================================================
  // SECTION HEADER
  // ============================================================
  Widget _buildSectionHeader() {
    return const Padding(
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Pilih Layanan',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w800,
                    color: PuskesmasColors.darkText,
                  ),
                ),
                SizedBox(height: 3),
                Text(
                  'Tap salah satu untuk masuk ke halamannya.',
                  style: TextStyle(
                      fontSize: 12, color: PuskesmasColors.greyText),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // ============================================================
  // MENU CARD — navigasi ke sub-halaman
  // ============================================================
  Widget _buildMenuCard(BuildContext context, _MenuItem m) {
    return GestureDetector(
      onTap: () => _onMenuTap(context, m.id),
      child: Container(
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: PuskesmasColors.cardBorder),
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
            Container(
              width: 48,
              height: 48,
              decoration: BoxDecoration(
                color: m.color.withValues(alpha: 0.12),
                borderRadius: BorderRadius.circular(13),
              ),
              child: Icon(m.icon, size: 23, color: m.color),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Flexible(
                        child: Text(
                          m.title,
                          style: const TextStyle(
                            fontSize: 14.5,
                            fontWeight: FontWeight.w700,
                            color: PuskesmasColors.darkText,
                          ),
                        ),
                      ),
                      if (m.badge != null) ...[
                        const SizedBox(width: 8),
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 7, vertical: 2),
                          decoration: BoxDecoration(
                            color: const Color(0xFFE0A118),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Text(
                            m.badge!,
                            style: const TextStyle(
                              fontSize: 8.5,
                              fontWeight: FontWeight.w700,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    ],
                  ),
                  const SizedBox(height: 3),
                  Text(
                    m.subtitle,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 11.5,
                      color: PuskesmasColors.greyText,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 8),
            Container(
              width: 30,
              height: 30,
              decoration: BoxDecoration(
                color: PuskesmasColors.mintGreen,
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.arrow_forward_ios_rounded,
                size: 14,
                color: PuskesmasColors.primaryGreen,
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ============================================================
  // FOOTER
  // ============================================================
  Widget _buildFooter() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: PuskesmasColors.softGreenBg,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: PuskesmasColors.mintGreenBorder),
      ),
      child: const Row(
        children: [
          Icon(Icons.verified_rounded,
              size: 16, color: PuskesmasColors.primaryGreen),
          SizedBox(width: 8),
          Expanded(
            child: Text(
              'Terhubung dengan ekosistem kesehatan digital Pemerintah Kabupaten Sragen.',
              style: TextStyle(
                  fontSize: 11,
                  color: PuskesmasColors.darkText,
                  height: 1.4),
            ),
          ),
        ],
      ),
    );
  }
}

// ================================================================
// MODELS
// ================================================================
class _MenuItem {
  final String id;
  final String title;
  final String subtitle;
  final IconData icon;
  final Color color;
  final String? badge;

  const _MenuItem({
    required this.id,
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.color,
    this.badge,
  });
}

class _StatItem {
  final String value;
  final String label;
  final IconData icon;
  final Color color;

  const _StatItem(this.value, this.label, this.icon, this.color);
}
