import 'package:flutter/material.dart';
import 'inovasi_detail_model.dart';

/// Halaman Detail Inovasi (sesuai desain context/inovasi2.png).
class InovasiDetailScreen extends StatelessWidget {
  final InovasiDetail detail;

  const InovasiDetailScreen({super.key, required this.detail});

  // ============================================================
  // COLORS
  // ============================================================
  static const Color _green = Color(0xFF0B7A4B);
  static const Color _greenDark = Color(0xFF0C5E3C);
  static const Color _tealLight = Color(0xFF58D8EC);
  static const Color _darkBlue = Color(0xFF315579);
  static const Color _darkText = Color(0xFF1A2530);
  static const Color _greyText = Color(0xFF6B7280);
  static const Color _bg = Color(0xFFF5F6FB);

  // ============================================================
  // BUILD
  // ============================================================
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _bg,
      bottomNavigationBar: _buildNavBar(context),
      body: SafeArea(
        child: Column(
          children: [
            _buildHeader(context),
            Expanded(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                padding: const EdgeInsets.fromLTRB(20, 20, 20, 28),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildTitleCard(),
                    const SizedBox(height: 26),
                    _buildSectionTitle('Informasi Umum'),
                    const SizedBox(height: 14),
                    _buildInfoCard(),
                    const SizedBox(height: 26),
                    ...detail.sections.map(_buildSection),
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
  // HEADER — ← Detail Inovasi + ikon akun
  // ============================================================
  Widget _buildHeader(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 66,
      decoration: const BoxDecoration(
        color: _bg,
        border: Border(
          bottom: BorderSide(color: Color(0xFFE5E7EB), width: 0.7),
        ),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        children: [
          GestureDetector(
            onTap: () => Navigator.pop(context),
            child: const Icon(
              Icons.arrow_back_ios_new_rounded,
              size: 22,
              color: _green,
            ),
          ),
          const SizedBox(width: 16),
          const Expanded(
            child: Text(
              'Detail Inovasi',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.w800,
                color: _green,
              ),
            ),
          ),
          Container(
            width: 34,
            height: 34,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: _green, width: 1.5),
            ),
            child: const Icon(Icons.person_outline_rounded,
                size: 20, color: _green),
          ),
        ],
      ),
    );
  }

  // ============================================================
  // TITLE CARD
  // ============================================================
  Widget _buildTitleCard() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFE6E9F0)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.03),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            detail.kategoriLabel,
            style: const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w800,
              color: _green,
              letterSpacing: 0.5,
            ),
          ),
          const SizedBox(height: 10),
          Text(
            detail.judul,
            style: const TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.w800,
              color: _darkText,
              height: 1.3,
            ),
          ),
          const SizedBox(height: 14),
          Wrap(
            spacing: 10,
            runSpacing: 8,
            children: [
              _buildBadge('Status: ${detail.tahapan}',
                  bg: const Color(0xFFDFF5E7), fg: _green),
              _buildBadge('Jenis: ${detail.jenis}',
                  bg: const Color(0xFFEDEFF2), fg: _greyText),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildBadge(String text, {required Color bg, required Color fg}) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        text,
        style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: fg),
      ),
    );
  }

  // ============================================================
  // SECTION TITLE (bar hijau kiri + judul)
  // ============================================================
  Widget _buildSectionTitle(String title) {
    return Row(
      children: [
        Container(
          width: 5,
          height: 24,
          decoration: BoxDecoration(
            color: _green,
            borderRadius: BorderRadius.circular(3),
          ),
        ),
        const SizedBox(width: 12),
        Text(
          title,
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w800,
            color: _darkText,
          ),
        ),
      ],
    );
  }

  // ============================================================
  // INFO CARD (Informasi Umum)
  // ============================================================
  Widget _buildInfoCard() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFE6E9F0)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildInfoItem('INISIATOR', detail.inisiator),
          _buildInfoItem('JENIS', detail.jenis),
          _buildInfoItem('TAHAPAN', detail.tahapan),
          _buildInfoItem('WAKTU UJI COBA', detail.waktuUjiCoba),
          _buildInfoItem('WAKTU PENERAPAN', detail.waktuPenerapan),
          _buildInfoItem('URUSAN PEMERINTAHAN', detail.urusanPemerintahan,
              last: true),
        ],
      ),
    );
  }

  Widget _buildInfoItem(String label, String value, {bool last = false}) {
    return Padding(
      padding: EdgeInsets.only(bottom: last ? 0 : 18),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: _greyText,
              letterSpacing: 0.4,
            ),
          ),
          const SizedBox(height: 5),
          Text(
            value,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w800,
              color: _darkText,
              height: 1.3,
            ),
          ),
        ],
      ),
    );
  }

  // ============================================================
  // SECTION (Rancang Bangun / Tujuan / Manfaat / Hasil)
  // ============================================================
  Widget _buildSection(InovasiSection section) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSectionTitle(section.title),
        const SizedBox(height: 14),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(18),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: const Color(0xFFE6E9F0)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              for (int i = 0; i < section.blocks.length; i++) ...[
                _buildBlock(section.blocks[i]),
                if (i != section.blocks.length - 1)
                  const SizedBox(height: 14),
              ],
            ],
          ),
        ),
        const SizedBox(height: 26),
      ],
    );
  }

  // ============================================================
  // BLOCK RENDERER
  // ============================================================
  Widget _buildBlock(InovasiBlock block) {
    switch (block.type) {
      case BlockType.heading:
        return Text(
          block.text!,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w800,
            color: _darkText,
            height: 1.3,
          ),
        );

      case BlockType.banner:
        return Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          decoration: BoxDecoration(
            color: _greenDark,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Text(
            block.text!,
            style: const TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w800,
              color: Colors.white,
              letterSpacing: 0.3,
            ),
          ),
        );

      case BlockType.paragraph:
        return Text(
          block.text!,
          style: const TextStyle(
            fontSize: 14,
            color: Color(0xFF3A4250),
            height: 1.6,
          ),
        );

      case BlockType.bullets:
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: block.items!
              .map((e) => _buildBullet(e))
              .toList(),
        );

      case BlockType.numbered:
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            for (int i = 0; i < block.items!.length; i++)
              _buildNumbered(i + 1, block.items![i]),
          ],
        );

      case BlockType.bulletTitled:
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: block.titledItems!
              .map((e) => _buildBulletTitled(e))
              .toList(),
        );
    }
  }

  Widget _buildBullet(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: const EdgeInsets.only(top: 7),
            width: 7,
            height: 7,
            decoration: const BoxDecoration(
              color: _green,
              shape: BoxShape.circle,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              text,
              style: const TextStyle(
                fontSize: 14,
                color: Color(0xFF3A4250),
                height: 1.55,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNumbered(int number, String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 26,
            height: 26,
            decoration: BoxDecoration(
              color: const Color(0xFFDFF5E7),
              shape: BoxShape.circle,
            ),
            child: Center(
              child: Text(
                '$number',
                style: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w800,
                  color: _green,
                ),
              ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(top: 3),
              child: Text(
                text,
                style: const TextStyle(
                  fontSize: 14,
                  color: Color(0xFF3A4250),
                  height: 1.55,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBulletTitled(TitledItem item) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 14),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: const EdgeInsets.only(top: 6),
            width: 8,
            height: 8,
            decoration: const BoxDecoration(
              color: _green,
              shape: BoxShape.circle,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item.title,
                  style: const TextStyle(
                    fontSize: 14.5,
                    fontWeight: FontWeight.w800,
                    color: _darkText,
                  ),
                ),
                const SizedBox(height: 3),
                Text(
                  item.description,
                  style: const TextStyle(
                    fontSize: 14,
                    color: Color(0xFF3A4250),
                    height: 1.55,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // ============================================================
  // BOTTOM NAVIGATION (Beranda / Layanan / Tutup)
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
                Icons.home_outlined,
                'Beranda',
                active: false,
                onTap: () =>
                    Navigator.of(context).popUntil((r) => r.isFirst),
              ),
            ),
            Expanded(
              child: _navItem(
                Icons.grid_view_rounded,
                'Layanan',
                active: true,
                onTap: () =>
                    Navigator.of(context).popUntil((r) => r.isFirst),
              ),
            ),
            Expanded(
              child: _navItem(
                Icons.close_rounded,
                'Tutup',
                active: false,
                isClose: true,
                onTap: () => Navigator.pop(context),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _navItem(
    IconData icon,
    String label, {
    required bool active,
    required VoidCallback onTap,
    bool isClose = false,
  }) {
    if (isClose) {
      return GestureDetector(
        onTap: onTap,
        child: Center(
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 12),
            decoration: BoxDecoration(
              color: _green,
              borderRadius: BorderRadius.circular(24),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: const [
                Icon(Icons.close_rounded, size: 18, color: Colors.white),
                SizedBox(width: 6),
                Text(
                  'Tutup',
                  style: TextStyle(
                    fontSize: 13,
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

    return GestureDetector(
      onTap: onTap,
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
                  icon,
                  size: 22,
                  color: active ? _darkBlue : const Color(0xFF374151),
                ),
                const SizedBox(height: 1),
                Text(
                  label,
                  style: TextStyle(
                    fontSize: 9,
                    fontWeight: active ? FontWeight.w600 : FontWeight.w400,
                    color: active ? _darkBlue : const Color(0xFF374151),
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
