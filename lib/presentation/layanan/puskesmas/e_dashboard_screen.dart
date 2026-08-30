import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import 'puskesmas_shared.dart';

// ================================================================
// e-DASHBOARD SRAGEN
// Monitoring Kesehatan Kabupaten Sragen (Kode Wilayah: 3314).
// Buka di Tab Baru -> https://edashboard.infokes.id/login
// Desain mengikuti context/e-das.png dengan nuansa hijau.
// ================================================================

class EDashboardScreen extends StatelessWidget {
  const EDashboardScreen({super.key});

  static final Uri _url = Uri.parse('https://edashboard.infokes.id/login');

  Future<void> _open(BuildContext context) async {
    final bool launched =
        await launchUrl(_url, mode: LaunchMode.externalApplication);
    if (!launched && context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Tidak dapat membuka e-Dashboard Infokes.'),
          behavior: SnackBarBehavior.floating,
        ),
      );
    }
  }

  // ---- Data mock kartu fasilitas ----
  static const List<_Facility> _facilities = [
    _Facility('Puskesmas', '25', Icons.local_hospital_rounded, Color(0xFF1B8A5A)),
    _Facility('Clinic', '17', Icons.medical_services_rounded, Color(0xFF2F80ED)),
    _Facility('Dinkes', '1', Icons.account_balance_rounded, Color(0xFF6B7A72)),
    _Facility('Pustu', '242', Icons.add_box_rounded, Color(0xFF1B8A5A)),
    _Facility('Farmasi', '0', Icons.local_pharmacy_rounded, Color(0xFFE0A118)),
  ];

  // ---- Data mock tile statistik ----
  static const List<_StatTile> _statTiles = [
    _StatTile('1.321.116', 'Jumlah Pasien Terdaftar', Color(0xFF2E3192),
        Icons.groups_rounded),
    _StatTile('10.053', 'Pasien Baru', Color(0xFF2F80ED),
        Icons.person_add_alt_1_rounded),
    _StatTile('103.790', 'Kunjungan Loket', Color(0xFF1B6B45),
        Icons.confirmation_number_rounded),
    _StatTile('71.156', 'Kunjungan BPJS', Color(0xFF2EC76B),
        Icons.favorite_rounded),
    _StatTile('103.790', 'Kunjungan Agustus', Color(0xFFE0A118),
        Icons.calendar_month_rounded),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: PuskesmasColors.pageBackground,
      bottomNavigationBar: const PuskesmasBottomNav(),
      body: SafeArea(
        child: Column(
          children: [
            const PuskesmasHeader(title: 'e-Dashboard Sragen'),
            Expanded(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                padding: const EdgeInsets.only(top: 18, bottom: 28),
                child: Column(
                  children: [
                    // BANNER HIJAU dengan judul + Kode Wilayah
                    PuskesmasBanner(
                      icon: Icons.insights_rounded,
                      title: Wrap(
                        crossAxisAlignment: WrapCrossAlignment.center,
                        spacing: 8,
                        runSpacing: 4,
                        children: [
                          const Text(
                            'e-Dashboard Infokes — Monitoring Kesehatan Kabupaten Sragen',
                            style: TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.w700,
                              color: PuskesmasColors.darkText,
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 8, vertical: 3),
                            decoration: BoxDecoration(
                              color: PuskesmasColors.mintGreen,
                              borderRadius: BorderRadius.circular(6),
                              border: Border.all(
                                  color: PuskesmasColors.mintGreenBorder),
                            ),
                            child: const Text(
                              'Kode Wilayah: 3314',
                              style: TextStyle(
                                fontSize: 10,
                                fontWeight: FontWeight.w700,
                                color: PuskesmasColors.primaryGreen,
                              ),
                            ),
                          ),
                        ],
                      ),
                      description:
                          'Dashboard analitik monitoring data kunjungan pasien, tren '
                          'morbiditas (10 besar penyakit), capaian imunisasi, dan '
                          'rekapitulasi layanan 25 Puskesmas se-Kabupaten Sragen.',
                      onReload: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('e-Dashboard dimuat ulang.'),
                            behavior: SnackBarBehavior.floating,
                            duration: Duration(seconds: 1),
                          ),
                        );
                      },
                      onOpenTab: () => _open(context),
                    ),
                    const SizedBox(height: 16),

                    // KARTU DASHBOARD (embed mock)
                    _buildDashboardCard(context),

                    const SizedBox(height: 18),
                    _buildFooter(context),
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
  // DASHBOARD CARD (embed mock)
  // ============================================================
  Widget _buildDashboardCard(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: PuskesmasColors.cardBorder),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.04),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // BAR ATAS
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
            decoration: const BoxDecoration(
              border: Border(
                  bottom: BorderSide(color: PuskesmasColors.cardBorder)),
            ),
            child: Row(
              children: [
                Container(
                  width: 8,
                  height: 8,
                  decoration: const BoxDecoration(
                    color: Color(0xFF2EC76B),
                    shape: BoxShape.circle,
                  ),
                ),
                const SizedBox(width: 8),
                const Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'e-Dashboard Infokes Kabupaten Sragen (Provinsi Jawa Tengah)',
                        style: TextStyle(
                          fontSize: 11.5,
                          fontWeight: FontWeight.w700,
                          color: PuskesmasColors.darkText,
                        ),
                      ),
                      Text(
                        'edashboard.infokes.id  •  View Kota/Kabupaten Sragen',
                        style: TextStyle(
                            fontSize: 10, color: PuskesmasColors.greyText),
                      ),
                    ],
                  ),
                ),
                GestureDetector(
                  onTap: () => _open(context),
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10, vertical: 6),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: PuskesmasColors.cardBorder),
                    ),
                    child: const Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.open_in_full_rounded,
                            size: 12, color: PuskesmasColors.greyText),
                        SizedBox(width: 5),
                        Text(
                          'Layar Penuh',
                          style: TextStyle(
                            fontSize: 10.5,
                            fontWeight: FontWeight.w600,
                            color: PuskesmasColors.darkText,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),

          // ISI DASHBOARD
          Padding(
            padding: const EdgeInsets.all(14),
            child: Column(
              children: [
                _buildTopTabs(),
                const SizedBox(height: 12),
                _buildSearchBar(),
                const SizedBox(height: 12),
                _buildFacilityCards(),
                const SizedBox(height: 12),
                _buildStatTiles(),
                const SizedBox(height: 14),
                _buildGrowthChart(),
                const SizedBox(height: 12),
                _buildMapPlaceholder(context),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // ---- 3 tab atas ----
  Widget _buildTopTabs() {
    return Row(
      children: [
        Expanded(
          flex: 5,
          child: _topTab(
            'DASHBOARD KESEHATAN DAERAH',
            const Color(0xFF2E3192),
            icon: Icons.public_rounded,
          ),
        ),
        const SizedBox(width: 6),
        Expanded(
          flex: 3,
          child: _topTab('JAWA TENGAH', const Color(0xFFE0A118)),
        ),
        const SizedBox(width: 6),
        Expanded(
          flex: 3,
          child: _topTab('KABUPATEN SRAGEN', const Color(0xFF2F80ED)),
        ),
      ],
    );
  }

  Widget _topTab(String label, Color color, {IconData? icon}) {
    return Container(
      height: 34,
      alignment: Alignment.center,
      padding: const EdgeInsets.symmetric(horizontal: 6),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(7),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (icon != null) ...[
            Icon(icon, size: 12, color: Colors.white),
            const SizedBox(width: 4),
          ],
          Flexible(
            child: Text(
              label,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                fontSize: 9,
                fontWeight: FontWeight.w700,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSearchBar() {
    return Container(
      height: 34,
      padding: const EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
        color: const Color(0xFFF7F8FA),
        borderRadius: BorderRadius.circular(7),
        border: Border.all(color: PuskesmasColors.cardBorder),
      ),
      child: const Row(
        children: [
          Icon(Icons.search_rounded, size: 15, color: PuskesmasColors.greyText),
          SizedBox(width: 6),
          Text(
            'Search',
            style: TextStyle(fontSize: 11.5, color: Color(0xFFB0B7BF)),
          ),
        ],
      ),
    );
  }

  // ---- 5 kartu jumlah fasilitas ----
  Widget _buildFacilityCards() {
    return Row(
      children: List.generate(_facilities.length, (i) {
        final f = _facilities[i];
        return Expanded(
          child: Padding(
            padding: EdgeInsets.only(
              left: i == 0 ? 0 : 3,
              right: i == _facilities.length - 1 ? 0 : 3,
            ),
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 4),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(9),
                border: Border.all(color: PuskesmasColors.cardBorder),
              ),
              child: Column(
                children: [
                  Icon(f.icon, size: 15, color: f.color),
                  const SizedBox(height: 4),
                  Text(
                    f.name,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 8,
                      fontWeight: FontWeight.w700,
                      color: f.color,
                    ),
                  ),
                  const SizedBox(height: 3),
                  Text(
                    f.count,
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w800,
                      color: PuskesmasColors.darkText,
                    ),
                  ),
                  const Text(
                    'TOTAL',
                    style: TextStyle(
                      fontSize: 6,
                      fontWeight: FontWeight.w600,
                      color: PuskesmasColors.greyText,
                      letterSpacing: 0.4,
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      }),
    );
  }

  // ---- 5 tile statistik warna ----
  Widget _buildStatTiles() {
    return Row(
      children: List.generate(_statTiles.length, (i) {
        final s = _statTiles[i];
        return Expanded(
          child: Padding(
            padding: EdgeInsets.only(
              left: i == 0 ? 0 : 3,
              right: i == _statTiles.length - 1 ? 0 : 3,
            ),
            child: Container(
              height: 62,
              padding: const EdgeInsets.all(7),
              decoration: BoxDecoration(
                color: s.color,
                borderRadius: BorderRadius.circular(9),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Flexible(
                        child: Text(
                          s.value,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            fontSize: 11.5,
                            fontWeight: FontWeight.w800,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      Icon(s.icon, size: 12, color: Colors.white70),
                    ],
                  ),
                  Text(
                    s.label,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 7,
                      color: Colors.white,
                      height: 1.2,
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      }),
    );
  }

  // ---- Chart pertumbuhan pengguna (bar mock) ----
  Widget _buildGrowthChart() {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(9),
        border: Border.all(color: PuskesmasColors.cardBorder),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 7),
            decoration: const BoxDecoration(
              color: Color(0xFF2E3192),
              borderRadius: BorderRadius.vertical(top: Radius.circular(8)),
            ),
            child: const Text(
              'PERTUMBUHAN PENGGUNA',
              style: TextStyle(
                fontSize: 9,
                fontWeight: FontWeight.w700,
                color: Colors.white,
                letterSpacing: 0.5,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(10, 12, 10, 10),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _bar(0.35, '2022'),
                _bar(0.55, '2023'),
                _bar(0.75, '2024'),
                _bar(0.95, '2025'),
                _bar(0.25, '2026'),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _bar(double factor, String label) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 20,
          height: 70 * factor,
          decoration: BoxDecoration(
            color: PuskesmasColors.primaryGreen,
            borderRadius: BorderRadius.circular(4),
          ),
        ),
        const SizedBox(height: 5),
        Text(
          label,
          style: const TextStyle(fontSize: 8, color: PuskesmasColors.greyText),
        ),
      ],
    );
  }

  // ---- Peta pengguna (placeholder) ----
  Widget _buildMapPlaceholder(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(9),
        border: Border.all(color: PuskesmasColors.cardBorder),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 7),
            decoration: const BoxDecoration(
              color: Color(0xFF2E3192),
              borderRadius: BorderRadius.vertical(top: Radius.circular(8)),
            ),
            child: const Text(
              'PEMETAAN PENGGUNA',
              style: TextStyle(
                fontSize: 9,
                fontWeight: FontWeight.w700,
                color: Colors.white,
                letterSpacing: 0.5,
              ),
            ),
          ),
          Container(
            height: 130,
            width: double.infinity,
            decoration: const BoxDecoration(
              color: Color(0xFFEDF2EE),
              borderRadius: BorderRadius.vertical(bottom: Radius.circular(8)),
            ),
            child: Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(Icons.map_rounded,
                      size: 30, color: PuskesmasColors.primaryGreen),
                  const SizedBox(height: 8),
                  const Text(
                    'Peta sebaran fasilitas kesehatan',
                    style: TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.w600,
                      color: PuskesmasColors.darkText,
                    ),
                  ),
                  const SizedBox(height: 8),
                  GestureDetector(
                    onTap: () => _open(context),
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 12, vertical: 6),
                      decoration: BoxDecoration(
                        color: PuskesmasColors.primaryGreen,
                        borderRadius: BorderRadius.circular(7),
                      ),
                      child: const Text(
                        'Lihat peta interaktif',
                        style: TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.w700,
                          color: Colors.white,
                        ),
                      ),
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

  Widget _buildFooter(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: PuskesmasColors.softGreenBg,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: PuskesmasColors.mintGreenBorder),
      ),
      child: Row(
        children: [
          const Icon(Icons.insights_rounded,
              size: 16, color: PuskesmasColors.primaryGreen),
          const SizedBox(width: 8),
          const Expanded(
            child: Text(
              'Integrasi data ePuskesmas Dinas Kesehatan Kabupaten Sragen & PT Infokes Indonesia.',
              style: TextStyle(
                  fontSize: 11, color: PuskesmasColors.darkText, height: 1.4),
            ),
          ),
          const SizedBox(width: 8),
          GestureDetector(
            onTap: () => _open(context),
            child: const Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'Buka tautan analitik',
                  style: TextStyle(
                    fontSize: 10.5,
                    fontWeight: FontWeight.w700,
                    color: PuskesmasColors.primaryGreen,
                  ),
                ),
                SizedBox(width: 4),
                Icon(Icons.arrow_forward_rounded,
                    size: 14, color: PuskesmasColors.primaryGreen),
              ],
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
class _Facility {
  final String name;
  final String count;
  final IconData icon;
  final Color color;

  const _Facility(this.name, this.count, this.icon, this.color);
}

class _StatTile {
  final String value;
  final String label;
  final Color color;
  final IconData icon;

  const _StatTile(this.value, this.label, this.color, this.icon);
}
