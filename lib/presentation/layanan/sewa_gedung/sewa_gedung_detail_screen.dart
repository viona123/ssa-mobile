import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import 'sewa_gedung_data.dart';

// ================================================================
// DETAIL GEDUNG / AREA TERBUKA
// Desain mengikuti context/detailsewa.png.
// ================================================================

class SewaGedungDetailScreen extends StatelessWidget {
  final Gedung gedung;

  const SewaGedungDetailScreen({super.key, required this.gedung});

  static const Color _primary = Color(0xFF075681);
  static const Color _cyan = Color(0xFF29C4F2);
  static const Color _ink = Color(0xFF062837);
  static const Color _smoke = Color(0xFF4F5963);
  static const Color _pageBackground = Color(0xFFF0F7FC);
  static const Color _softBlue = Color(0xFFDDF2FC);
  static const Color _softCard = Color(0xFFF5FAFE);
  static const Color _border = Color(0xFFDCE8F0);
  static const Color _green = Color(0xFF10B981);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _pageBackground,
      body: SafeArea(
        bottom: false,
        child: Column(
          children: [
            _buildHeader(context),
            Expanded(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Column(
                  children: [
                    _buildHero(),
                    Transform.translate(
                      offset: const Offset(0, -24),
                      child: _buildContent(context),
                    ),
                  ],
                ),
              ),
            ),
            _buildActionBar(context),
          ],
        ),
      ),
    );
  }

  // ============================================================
  // HEADER
  // ============================================================
  Widget _buildHeader(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 60,
      padding: const EdgeInsets.symmetric(horizontal: 20),
      decoration: const BoxDecoration(
        color: Colors.white,
        border: Border(bottom: BorderSide(color: _border)),
      ),
      child: Row(
        children: [
          InkWell(
            onTap: () => Navigator.pop(context),
            borderRadius: BorderRadius.circular(20),
            child: const Padding(
              padding: EdgeInsets.all(4),
              child: Icon(Icons.arrow_back_rounded, size: 27, color: _primary),
            ),
          ),
          const SizedBox(width: 18),
          Expanded(
            child: Text(
              'Detail ${gedung.nama}',
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                fontSize: 21,
                fontWeight: FontWeight.w700,
                color: _primary,
              ),
            ),
          ),
          const SizedBox(width: 12),
          const Icon(Icons.search_rounded, size: 27, color: _primary),
        ],
      ),
    );
  }

  // ============================================================
  // HERO
  // ============================================================
  Widget _buildHero() {
    return SizedBox(
      width: double.infinity,
      height: 275,
      child: Stack(
        fit: StackFit.expand,
        children: [
          _buildHeroImage(),
          const DecoratedBox(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [Colors.transparent, Color(0x33000000)],
              ),
            ),
          ),
          Positioned(
            top: 18,
            right: 20,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 9),
              decoration: BoxDecoration(
                color: const Color(0xFFF4FAFD).withValues(alpha: 0.94),
                borderRadius: BorderRadius.circular(24),
                border: Border.all(color: const Color(0xFFB7D9EA)),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.08),
                    blurRadius: 6,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    width: 9,
                    height: 9,
                    decoration: BoxDecoration(
                      color: gedung.tersedia ? _green : Colors.orange,
                      shape: BoxShape.circle,
                    ),
                  ),
                  const SizedBox(width: 9),
                  Text(
                    gedung.tersedia
                        ? 'STATUS: TERSEDIA UNTUK DISEWA'
                        : 'STATUS: TIDAK TERSEDIA',
                    style: const TextStyle(
                      fontSize: 11.5,
                      fontWeight: FontWeight.w800,
                      color: _ink,
                      letterSpacing: 0.25,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeroImage() {
    if (gedung.foto.isNotEmpty) {
      return Image.asset(
        gedung.foto.first,
        fit: BoxFit.cover,
        errorBuilder: (_, __, ___) => _buildHeroPlaceholder(),
      );
    }
    return _buildHeroPlaceholder();
  }

  Widget _buildHeroPlaceholder() {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [Color(0xFF8AD6F4), Color(0xFF3795C7)],
        ),
      ),
      child: const Stack(
        alignment: Alignment.center,
        children: [
          Positioned(
            top: 34,
            left: 28,
            child: Icon(Icons.cloud_rounded, color: Colors.white54, size: 70),
          ),
          Positioned(
            right: 30,
            bottom: 40,
            child: Icon(Icons.park_rounded, color: Color(0x9961A775), size: 88),
          ),
          Icon(Icons.location_city_rounded, color: Colors.white70, size: 92),
        ],
      ),
    );
  }

  // ============================================================
  // CONTENT PANEL
  // ============================================================
  Widget _buildContent(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.symmetric(horizontal: 16),
      padding: const EdgeInsets.fromLTRB(22, 24, 22, 30),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.08),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            gedung.nama,
            style: const TextStyle(
              fontSize: 25,
              height: 1.25,
              fontWeight: FontWeight.w800,
              color: _ink,
            ),
          ),
          const SizedBox(height: 14),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Icon(Icons.location_on_outlined, size: 23, color: _primary),
              const SizedBox(width: 9),
              Expanded(
                child: Text(
                  gedung.alamat,
                  style: const TextStyle(
                    fontSize: 14,
                    height: 1.5,
                    color: _smoke,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),
          _buildSpecifications(),
          const SizedBox(height: 16),
          _buildPriceCard(),
          const SizedBox(height: 30),
          _buildSectionTitle('Deskripsi Lengkap', withBar: true),
          const SizedBox(height: 14),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(18),
            decoration: BoxDecoration(
              color: const Color(0xFFE6F4FC),
              borderRadius: BorderRadius.circular(18),
            ),
            child: Text(
              gedung.deskripsi,
              style: const TextStyle(fontSize: 14, height: 1.65, color: _smoke),
            ),
          ),
          const SizedBox(height: 30),
          _buildSectionTitle('Fasilitas Tersedia'),
          const SizedBox(height: 16),
          _buildFacilities(),
          const SizedBox(height: 28),
          _buildSectionTitle('Informasi Kontak Gedung'),
          const SizedBox(height: 16),
          _buildContactCard(context),
          const SizedBox(height: 30),
          const Center(
            child: Text(
              'Informasi resmi pemerintah daerah Kabupaten\nSragen',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 12,
                height: 1.45,
                fontWeight: FontWeight.w600,
                color: Color(0xFF939BA3),
                letterSpacing: 0.2,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSpecifications() {
    // Tinggi dibuat eksplisit agar kedua kartu sama tinggi tanpa memakai
    // stretch pada Row di dalam SingleChildScrollView.
    return SizedBox(
      height: 150,
      child: Row(
        children: [
          Expanded(
            child: _buildSpecCard(
              icon: Icons.groups_rounded,
              label: 'Kapasitas Maksimal',
              value: gedung.kapasitas,
            ),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: _buildSpecCard(
              icon: Icons.square_foot_rounded,
              label: 'Luas Bangunan',
              value: gedung.luas,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSpecCard({
    required IconData icon,
    required String label,
    required String value,
  }) {
    return Container(
      height: double.infinity,
      padding: const EdgeInsets.all(17),
      decoration: BoxDecoration(
        color: _softBlue,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: const Color(0xFFC7E6F6)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, size: 27, color: _primary),
          const Spacer(),
          Text(
            label,
            style: const TextStyle(fontSize: 12, color: _smoke, height: 1.2),
          ),
          const SizedBox(height: 4),
          Text(
            value,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              fontSize: 22,
              height: 1.2,
              fontWeight: FontWeight.w500,
              color: _ink,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPriceCard() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 18),
      decoration: BoxDecoration(
        color: const Color(0xFFD7F3FC),
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: _cyan, width: 1.2),
      ),
      child: Row(
        children: [
          const Icon(Icons.payments_outlined, size: 31, color: _primary),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Tarif Sewa',
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                    color: _primary,
                  ),
                ),
                const SizedBox(height: 3),
                Text(
                  gedung.tarif,
                  style: const TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.w500,
                    color: _ink,
                  ),
                ),
              ],
            ),
          ),
          const Icon(Icons.info_outline_rounded, size: 25, color: _primary),
        ],
      ),
    );
  }

  Widget _buildSectionTitle(String title, {bool withBar = false}) {
    return Row(
      children: [
        if (withBar) ...[
          Container(
            width: 5,
            height: 27,
            decoration: BoxDecoration(
              color: _primary,
              borderRadius: BorderRadius.circular(4),
            ),
          ),
          const SizedBox(width: 10),
        ],
        Expanded(
          child: Text(
            title,
            style: const TextStyle(
              fontSize: 21,
              fontWeight: FontWeight.w700,
              color: _ink,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildFacilities() {
    if (gedung.fasilitas.isEmpty) {
      return const Text(
        'Belum ada data fasilitas.',
        style: TextStyle(fontSize: 14, color: _smoke),
      );
    }

    return Column(
      children: gedung.fasilitas.map((facility) {
        return Container(
          width: double.infinity,
          margin: const EdgeInsets.only(bottom: 10),
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 14),
          decoration: BoxDecoration(
            color: _softCard,
            borderRadius: BorderRadius.circular(14),
            border: Border.all(color: _border),
          ),
          child: Row(
            children: [
              Container(
                width: 28,
                height: 28,
                decoration: const BoxDecoration(
                  color: Color(0xFFD2F8E8),
                  shape: BoxShape.circle,
                ),
                child: const Icon(Icons.check_rounded, size: 17, color: _green),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Text(
                  facility,
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w500,
                    color: _ink,
                  ),
                ),
              ),
            ],
          ),
        );
      }).toList(),
    );
  }

  Widget _buildContactCard(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(17),
      decoration: BoxDecoration(
        color: _softBlue,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: const Color(0xFFC6E6F6)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.06),
            blurRadius: 5,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            width: 44,
            height: 44,
            decoration: const BoxDecoration(
              color: Color(0xFF0878B4),
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.person_outline_rounded,
              size: 25,
              color: Colors.white,
            ),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'PENGELOLA',
                  style: TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.w600,
                    color: _smoke,
                    letterSpacing: 1,
                  ),
                ),
                const SizedBox(height: 3),
                Text(
                  gedung.pengelola,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.w800,
                    color: _ink,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 10),
          _buildCallButton(context),
        ],
      ),
    );
  }

  Widget _buildCallButton(BuildContext context) {
    return Material(
      color: _green,
      borderRadius: BorderRadius.circular(13),
      child: InkWell(
        onTap: () => _call(context),
        borderRadius: BorderRadius.circular(13),
        child: const Padding(
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.call_rounded, size: 18, color: Colors.white),
              SizedBox(width: 8),
              Text(
                'Hubungi',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // ============================================================
  // ACTION BAR
  // ============================================================
  Widget _buildActionBar(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(18, 12, 18, 12),
      decoration: BoxDecoration(
        color: Colors.white,
        border: const Border(top: BorderSide(color: _border)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.08),
            blurRadius: 12,
            offset: const Offset(0, -3),
          ),
        ],
      ),
      child: SafeArea(
        top: false,
        child: Row(
          children: [
            Expanded(
              flex: 4,
              child: OutlinedButton(
                onPressed: () => Navigator.pop(context),
                style: OutlinedButton.styleFrom(
                  minimumSize: const Size.fromHeight(52),
                  side: const BorderSide(color: _primary, width: 1.6),
                  foregroundColor: _primary,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
                child: const Text(
                  'Tutup',
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.w700),
                ),
              ),
            ),
            const SizedBox(width: 14),
            Expanded(
              flex: 7,
              child: FilledButton.icon(
                onPressed: () => _call(context),
                style: FilledButton.styleFrom(
                  minimumSize: const Size.fromHeight(52),
                  backgroundColor: _primary,
                  foregroundColor: Colors.white,
                  elevation: 3,
                  shadowColor: _primary.withValues(alpha: 0.35),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
                icon: const Icon(Icons.chat_rounded, size: 20),
                label: const Text(
                  'Hubungi Pengelola',
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.w700),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _call(BuildContext context) async {
    final phoneNumber = gedung.telepon.replaceAll(RegExp(r'[^0-9+]'), '');
    final uri = Uri(scheme: 'tel', path: phoneNumber);
    final launched = await launchUrl(uri, mode: LaunchMode.externalApplication);

    if (!launched && context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Hubungi pengelola: ${gedung.telepon}'),
          behavior: SnackBarBehavior.floating,
        ),
      );
    }
  }
}
