import 'package:flutter/material.dart';

import 'mpp_shared.dart';
import 'sistem_perizinan_screen.dart';
import 'antrean_mpp_screen.dart';

// ================================================================
// LAYANAN MPP — LANDING
// Menampilkan 4 pilihan; tap salah satu untuk masuk halamannya:
//   1. Sistem Perizinan Online Sragen  -> halaman internal
//   2. Antrean Layanan MPP             -> halaman internal
//   3. Perizinan (OSS)                 -> buka oss.go.id
//   4. Non-Perizinan                   -> buka SIPIONER
// ================================================================

class LayananMppScreen extends StatelessWidget {
  const LayananMppScreen({super.key});

  static final Uri _ossUri = Uri.parse('https://oss.go.id/id');
  static final Uri _sipionerUri =
      Uri.parse('https://sipioner.sragenkab.go.id/index');

  static const List<_MppMenu> _menus = [
    _MppMenu(
      id: 'perizinan',
      title: 'Sistem Perizinan Online Sragen',
      subtitle: 'Cek NRP & lacak permohonan perizinan',
      icon: Icons.assignment_rounded,
      color: MppColors.primaryBlue,
    ),
    _MppMenu(
      id: 'antrean',
      title: 'Antrean Layanan MPP',
      subtitle: 'Ambil & cek nomor antrean online',
      icon: Icons.confirmation_number_rounded,
      color: Color(0xFF11B4D4),
    ),
    _MppMenu(
      id: 'oss',
      title: 'Perizinan (OSS)',
      subtitle: 'Portal Nasional OSS RBA',
      icon: Icons.business_center_rounded,
      color: Color(0xFFA26B16),
      external: true,
    ),
    _MppMenu(
      id: 'non',
      title: 'Non-Perizinan',
      subtitle: 'Layanan non-perizinan Kabupaten Sragen',
      icon: Icons.gavel_rounded,
      color: Color(0xFF7B57C7),
      external: true,
    ),
  ];

  void _onMenuTap(BuildContext context, _MppMenu m) {
    switch (m.id) {
      case 'perizinan':
        Navigator.push(context,
            MaterialPageRoute(builder: (_) => const SistemPerizinanScreen()));
        break;
      case 'antrean':
        Navigator.push(context,
            MaterialPageRoute(builder: (_) => const AntreanMppScreen()));
        break;
      case 'oss':
        openMppUrl(context, _ossUri);
        break;
      case 'non':
        openMppUrl(context, _sipionerUri);
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MppColors.pageBackground,
      bottomNavigationBar: const MppBottomNav(),
      body: SafeArea(
        child: Column(
          children: [
            const MppHeader(title: 'Layanan MPP'),
            Expanded(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                padding: const EdgeInsets.fromLTRB(20, 18, 20, 32),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const MppHero(),
                    const SizedBox(height: 24),
                    _buildSectionHeader(),
                    const SizedBox(height: 14),
                    ..._menus.map((m) => Padding(
                          padding: const EdgeInsets.only(bottom: 12),
                          child: _buildMenuCard(context, m),
                        )),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionHeader() {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Pilih Layanan',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w800,
            color: MppColors.darkText,
          ),
        ),
        SizedBox(height: 3),
        Text(
          'Tap salah satu untuk masuk ke halamannya.',
          style: TextStyle(fontSize: 12, color: MppColors.greyText),
        ),
      ],
    );
  }

  Widget _buildMenuCard(BuildContext context, _MppMenu m) {
    return GestureDetector(
      onTap: () => _onMenuTap(context, m),
      child: Container(
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: MppColors.cardBorder),
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
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                color: m.color.withValues(alpha: 0.12),
                borderRadius: BorderRadius.circular(14),
              ),
              child: Icon(m.icon, size: 24, color: m.color),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    m.title,
                    style: const TextStyle(
                      fontSize: 14.5,
                      fontWeight: FontWeight.w700,
                      color: MppColors.darkText,
                    ),
                  ),
                  const SizedBox(height: 3),
                  Text(
                    m.subtitle,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                        fontSize: 11.5, color: MppColors.greyText),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 8),
            Container(
              width: 30,
              height: 30,
              decoration: BoxDecoration(
                color: m.external
                    ? const Color(0xFFEAF7FC)
                    : MppColors.primaryBlue.withValues(alpha: 0.08),
                shape: BoxShape.circle,
              ),
              child: Icon(
                m.external
                    ? Icons.open_in_new_rounded
                    : Icons.arrow_forward_ios_rounded,
                size: m.external ? 15 : 13,
                color: MppColors.primaryBlue,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ================================================================
// MODEL
// ================================================================
class _MppMenu {
  final String id;
  final String title;
  final String subtitle;
  final IconData icon;
  final Color color;
  final bool external;

  const _MppMenu({
    required this.id,
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.color,
    this.external = false,
  });
}
