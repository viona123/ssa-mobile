import 'package:flutter/material.dart';
import '../../agenda/agenda_screen.dart';

/// Dashboard Statistik DISDIKBUD (Langit Sukowati).
///
/// Desain sesuai context/disdikbud.png: dua kartu ringkasan besar
/// (Total Ajuan & Total Berkas), grid kartu statistik, dan banner
/// "Data Real-time". Navbar atas & bawah diseragamkan dengan layanan lain.
class DashboardStatistikScreen extends StatelessWidget {
  const DashboardStatistikScreen({super.key});

  // ============================================================
  // COLORS
  // ============================================================
  static const Color _appBlue = Color(0xFF007EA7);
  static const Color _tealLight = Color(0xFF58D8EC);
  static const Color _navyDark = Color(0xFF315579);
  static const Color _bg = Color(0xFFF5F6FB);
  static const Color _numberNavy = Color(0xFF0B2447);
  static const Color _greyText = Color(0xFF6B7280);

  // ============================================================
  // DATA STATISTIK
  // ============================================================
  static const List<_StatItem> _stats = [
    _StatItem(
      label: 'Diterima',
      value: '3.235',
      icon: Icons.check_circle_rounded,
      iconColor: Color(0xFF16A34A),
      iconBg: Color(0xFFDCFCE7),
      borderColor: Color(0xFFBBF7D0),
    ),
    _StatItem(
      label: 'Ajuan Baru',
      value: '0',
      icon: Icons.fiber_new_rounded,
      iconColor: Color(0xFFEA580C),
      iconBg: Color(0xFFFFEDD5),
      borderColor: Color(0xFFFED7AA),
      badge: 'NEW',
    ),
    _StatItem(
      label: 'Moderasi',
      value: '0',
      icon: Icons.forum_rounded,
      iconColor: Color(0xFF9333EA),
      iconBg: Color(0xFFF3E8FF),
      borderColor: Color(0xFFEDE9FE),
    ),
    _StatItem(
      label: 'Disposisi Kepala',
      value: '9',
      icon: Icons.groups_rounded,
      iconColor: Color(0xFFDB2777),
      iconBg: Color(0xFFFCE7F3),
      borderColor: Color(0xFFFBCFE8),
    ),
    _StatItem(
      label: 'Disposisi Bidang',
      value: '57',
      icon: Icons.account_tree_rounded,
      iconColor: Color(0xFF0D9488),
      iconBg: Color(0xFFCCFBF1),
      borderColor: Color(0xFF99F6E4),
    ),
    _StatItem(
      label: 'Dikembalikan',
      value: '421',
      icon: Icons.reply_rounded,
      iconColor: Color(0xFFEA580C),
      iconBg: Color(0xFFFFEDD5),
      borderColor: Color(0xFFFED7AA),
    ),
    _StatItem(
      label: 'Ditolak',
      value: '273',
      icon: Icons.cancel_rounded,
      iconColor: Color(0xFFDC2626),
      iconBg: Color(0xFFFEE2E2),
      borderColor: Color(0xFFFCA5A5),
    ),
  ];

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
                    // Kartu ringkasan besar
                    _buildSummaryCard(
                      icon: Icons.description_outlined,
                      iconColor: _appBlue,
                      iconBg: const Color(0xFFD6EEF7),
                      label: 'Total Ajuan',
                      value: '3.995',
                    ),
                    const SizedBox(height: 16),
                    _buildSummaryCard(
                      icon: Icons.folder_open_rounded,
                      iconColor: _navyDark,
                      iconBg: const Color(0xFFE4EAF3),
                      label: 'Total Berkas',
                      value: '10.442',
                    ),

                    const SizedBox(height: 24),

                    // Grid statistik
                    _buildStatGrid(),

                    const SizedBox(height: 24),

                    // Banner data real-time
                    _buildRealtimeBanner(),
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
  // HEADER — ← Dashboard Statistik (seragam dengan layanan lain)
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
            'Dashboard Statistik',
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
  // SUMMARY CARD (Total Ajuan / Total Berkas)
  // ============================================================
  Widget _buildSummaryCard({
    required IconData icon,
    required Color iconColor,
    required Color iconBg,
    required String label,
    required String value,
  }) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
          colors: [Colors.white, Color(0xFFF3F7FC)],
        ),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFE6EAF2)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.03),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            width: 52,
            height: 52,
            decoration: BoxDecoration(
              color: iconBg,
              borderRadius: BorderRadius.circular(14),
            ),
            child: Icon(icon, size: 26, color: iconColor),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: const TextStyle(fontSize: 13, color: _greyText),
                ),
                const SizedBox(height: 2),
                Text(
                  value,
                  style: const TextStyle(
                    fontSize: 26,
                    fontWeight: FontWeight.w900,
                    color: _numberNavy,
                    height: 1.1,
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
  // STAT GRID (2 kolom)
  // ============================================================
  Widget _buildStatGrid() {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: _stats.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 12,
        crossAxisSpacing: 12,
        childAspectRatio: 1.55,
      ),
      itemBuilder: (context, index) => _buildStatCard(_stats[index]),
    );
  }

  Widget _buildStatCard(_StatItem item) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: item.borderColor),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.02),
            blurRadius: 6,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Icon atau badge
              if (item.badge != null)
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 7, vertical: 3),
                  decoration: BoxDecoration(
                    color: item.iconBg,
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Text(
                    item.badge!,
                    style: TextStyle(
                      fontSize: 9,
                      fontWeight: FontWeight.w800,
                      color: item.iconColor,
                    ),
                  ),
                )
              else
                Container(
                  width: 30,
                  height: 30,
                  decoration: BoxDecoration(
                    color: item.iconBg,
                    borderRadius: BorderRadius.circular(9),
                  ),
                  child: Icon(item.icon, size: 17, color: item.iconColor),
                ),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  item.label,
                  style: const TextStyle(
                    fontSize: 12.5,
                    fontWeight: FontWeight.w500,
                    color: Color(0xFF374151),
                  ),
                ),
              ),
            ],
          ),
          Text(
            item.value,
            style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.w900,
              color: _numberNavy,
            ),
          ),
        ],
      ),
    );
  }

  // ============================================================
  // REALTIME BANNER
  // ============================================================
  Widget _buildRealtimeBanner() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: const Color(0xFFEAF0FB),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFD5E0F3)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: const [
              Icon(Icons.info_outline_rounded, size: 22, color: _navyDark),
              SizedBox(width: 10),
              Text(
                'Data Real-time',
                style: TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.w800,
                  color: _numberNavy,
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          const Text(
            'Statistik diambil secara real-time dari server Langit Sukowati '
            'DISDIKBUD Kabupaten Sragen. Disposisi Kepala: 9 ajuan, '
            'Disposisi Bidang: 57 ajuan.',
            style: TextStyle(
              fontSize: 14,
              color: Color(0xFF4B5563),
              height: 1.55,
            ),
          ),
        ],
      ),
    );
  }

  // ============================================================
  // BOTTOM NAVIGATION BAR (seragam dengan layanan lain)
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
                Icons.home_rounded,
                'Beranda',
                false,
                () => Navigator.of(context).popUntil((r) => r.isFirst),
              ),
            ),
            Expanded(
              child: _navItem(
                Icons.grid_view_rounded,
                Icons.grid_view_rounded,
                'Layanan',
                true,
                () => Navigator.pop(context),
              ),
            ),
            Expanded(
              child: _navItem(
                Icons.calendar_month_outlined,
                Icons.calendar_month_rounded,
                'Agenda',
                false,
                () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => const AgendaScreen()),
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

// ============================================================
// MODEL
// ============================================================
class _StatItem {
  final String label;
  final String value;
  final IconData icon;
  final Color iconColor;
  final Color iconBg;
  final Color borderColor;
  final String? badge;

  const _StatItem({
    required this.label,
    required this.value,
    required this.icon,
    required this.iconColor,
    required this.iconBg,
    required this.borderColor,
    this.badge,
  });
}
