import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../agenda/agenda_screen.dart';

// ================================================================
// MPP SHARED — warna, header, bottom navigation, & helper URL.
// Dipakai bersama seluruh sub-halaman Layanan MPP.
// ================================================================

class MppColors {
  static const Color primaryBlue = Color(0xFF007EA7);
  static const Color cyan = Color(0xFF11B4D4);
  static const Color lightBlue = Color(0xFF58D8EC);
  static const Color darkBlue = Color(0xFF315579);
  static const Color pageBackground = Color(0xFFF8FAFC);
  static const Color darkText = Color(0xFF202124);
  static const Color greyText = Color(0xFF737B86);
  static const Color cardBorder = Color(0xFFE2E9EF);
}

Future<void> openMppUrl(BuildContext context, Uri uri) async {
  final launched = await launchUrl(uri, mode: LaunchMode.externalApplication);
  if (!launched && context.mounted) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Tidak dapat membuka tautan layanan.'),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }
}

// ================================================================
// HEADER
// ================================================================
class MppHeader extends StatelessWidget {
  final String title;
  const MppHeader({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 66,
      decoration: const BoxDecoration(
        color: MppColors.pageBackground,
        border: Border(bottom: BorderSide(color: Color(0xFFE5E7EB), width: 0.7)),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Row(
        children: [
          GestureDetector(
            onTap: () => Navigator.pop(context),
            child: const Icon(Icons.arrow_back_ios_new_rounded,
                size: 22, color: MppColors.primaryBlue),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Text(
              title,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.w700,
                color: MppColors.primaryBlue,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ================================================================
// BOTTOM NAVIGATION
// ================================================================
class MppBottomNav extends StatelessWidget {
  const MppBottomNav({super.key});

  @override
  Widget build(BuildContext context) {
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
              child: _item(context, Icons.home_outlined, Icons.home_rounded,
                  'Beranda', false, () => Navigator.pop(context)),
            ),
            Expanded(
              child: _item(context, Icons.grid_view_rounded,
                  Icons.grid_view_rounded, 'Layanan', true, () {}),
            ),
            Expanded(
              child: _item(context, Icons.calendar_month_outlined,
                  Icons.calendar_month_rounded, 'Agenda', false, () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const AgendaScreen(showBottomNav: false),
                  ),
                );
              }),
            ),
          ],
        ),
      ),
    );
  }

  Widget _item(BuildContext context, IconData off, IconData on, String label,
      bool active, VoidCallback tap) {
    return GestureDetector(
      onTap: tap,
      child: Center(
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          width: 95,
          height: 52,
          decoration: BoxDecoration(
            color: active ? MppColors.lightBlue : Colors.transparent,
            borderRadius: BorderRadius.circular(27),
          ),
          child: Transform.translate(
            offset: const Offset(0, -1),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(active ? on : off,
                    size: 22,
                    color: active ? MppColors.darkBlue : const Color(0xFF374151)),
                const SizedBox(height: 1),
                Text(
                  label,
                  style: TextStyle(
                    fontSize: 9,
                    fontWeight: active ? FontWeight.w600 : FontWeight.w400,
                    color:
                        active ? MppColors.darkBlue : const Color(0xFF374151),
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

// ================================================================
// HERO (badge + judul + deskripsi) — dipakai di semua sub-halaman
// ================================================================
class MppHero extends StatelessWidget {
  const MppHero({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 7),
            decoration: BoxDecoration(
              color: const Color(0xFFEAF7FC),
              border: Border.all(color: const Color(0xFFC4E4EF)),
              borderRadius: BorderRadius.circular(20),
            ),
            child: const Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.verified_user_outlined, size: 14, color: MppColors.cyan),
                SizedBox(width: 6),
                Text(
                  'PORTAL LAYANAN SRAGEN',
                  style: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.w700,
                    letterSpacing: 0.5,
                    color: MppColors.darkBlue,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          const Text(
            'Layanan Perizinan & Antrean MPP',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 25,
              fontWeight: FontWeight.w800,
              color: MppColors.darkText,
              height: 1.2,
            ),
          ),
          const SizedBox(height: 10),
          const Text(
            'Akses layanan perizinan (SIPIONER) dan fasilitas pengambilan nomor '
            'antrean MPP Kabupaten Sragen secara online.',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 13.5, height: 1.5, color: MppColors.greyText),
          ),
        ],
      ),
    );
  }
}
