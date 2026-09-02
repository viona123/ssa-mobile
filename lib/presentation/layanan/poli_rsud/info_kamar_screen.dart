import 'package:flutter/material.dart';
import '../../agenda/agenda_screen.dart';

// ================================================================
// INFO KAMAR - RSUD
// Menampilkan ketersediaan kamar rawat inap secara real-time.
// Desain mengikuti context/kamar.png.
// ================================================================

class InfoKamarScreen extends StatefulWidget {
  final String hospitalName;
  final String hospitalLocation;

  /// Data kamar; jika null memakai data default (RSUD Soehadi Prijonegoro).
  final List<KamarInfo>? kamarList;

  /// Item info layanan (ikon + teks); jika null memakai teks default.
  final List<InfoKamarItem>? infoItems;

  /// Tampilkan kartu "Ringkasan Kamar" (Total / Terisi / Tersedia).
  final bool showRingkasan;

  const InfoKamarScreen({
    super.key,
    required this.hospitalName,
    required this.hospitalLocation,
    this.kamarList,
    this.infoItems,
    this.showRingkasan = false,
  });

  @override
  State<InfoKamarScreen> createState() => _InfoKamarScreenState();
}

class _InfoKamarScreenState extends State<InfoKamarScreen> {
  // ============================================================
  // COLORS
  // ============================================================
  static const Color primaryBlue = Color(0xFF007EA7);
  static const Color lightBlue = Color(0xFF58D8EC);
  static const Color darkBlue = Color(0xFF315579);
  static const Color darkText = Color(0xFF202124);
  static const Color greyText = Color(0xFF737B86);
  static const Color pageBackground = Color(0xFFF8FAFC);
  static const Color cardBorder = Color(0xFFE8ECEF);

  static const Color green = Color(0xFF12B76A);
  static const Color amber = Color(0xFFD4770B);
  static const Color danger = Color(0xFFD92D2D);

  // ============================================================
  // DATA KAMAR (default: RSUD Soehadi Prijonegoro)
  // ============================================================
  static const List<KamarInfo> _default = [
    KamarInfo('Cempaka - Cempaka A', 'VIP', 1, 0),
    KamarInfo('Cempaka - Cempaka II', 'KL2', 1, 0),
    KamarInfo('Cempaka - Cempaka B', 'KL3', 1, 0),
    KamarInfo('Cempaka - HCU', 'KL3', 4, 0),
    KamarInfo('Tulip - Tulip', 'VIP', 1, 0),
    KamarInfo('Tulip - Tulip 1', 'KL1', 2, 2),
    KamarInfo('Tulip - Tulip II', 'KL2', 8, 0),
    KamarInfo('Tulip - Tulip 3', 'KL3', 4, 4),
    KamarInfo('Tulip - Tulip Isolasi', 'KL3', 4, 2),
    KamarInfo('Anggrek - Anggrek VIP', 'VIP', 2, 0),
    KamarInfo('Anggrek - Anggrek Isolasi', 'KL3', 1, 0),
    KamarInfo('Anggrek - Anggrek I', 'KL1', 2, 0),
    KamarInfo('Anggrek - Anggrek II', 'KL2', 2, 0),
    KamarInfo('Anggrek - Anggrek III', 'KL3', 8, 6),
    KamarInfo('Anggrek - Anggrek PICU', 'ICU', 4, 0),
    KamarInfo('ICU - ICU Isolasi', 'ICU', 1, 0),
    KamarInfo('ICU - ICU Intensif', 'ICU', 7, 5),
    KamarInfo('Teratai - Kamar Teratai I', 'KL1', 4, 4),
    KamarInfo('Teratai - Teratai Isolasi', 'KL3', 1, 1),
    KamarInfo('Teratai - Teratai III', 'KL3', 13, 13),
    KamarInfo('Vanda - Vanda A', 'VIP', 1, 0),
    KamarInfo('Vanda - Vanda B', 'KL1', 1, 0),
    KamarInfo('Vanda - Vanda C', 'KL3', 3, 0),
    KamarInfo('Vanda - Vanda D', 'KL3', 1, 0),
    KamarInfo('Lily - Lily A', 'KL1', 1, 0),
    KamarInfo('Lily - Lily B', 'KL2', 2, 0),
    KamarInfo('Lily - Lily C', 'KL3', 8, 4),
    KamarInfo('Lily - Lily NICU', 'ICU', 3, 0),
    KamarInfo('Lily - PERINATOLOGI C', 'KL3', 2, 0),
    KamarInfo('Tulip - Tulip 2', 'KL1', 2, 0),
    KamarInfo('Tulip - Tulip 4', 'KL3', 4, 3),
    KamarInfo('Cempaka - HCU', 'ICU', 3, 3),
    KamarInfo('Tulip - Tulip 2', 'KL2', 2, 2),
    KamarInfo('Tulip - Tulip 5', 'KL3', 1, 1),
    KamarInfo('Vanda - Vanda 1', 'KL1', 2, 2),
    KamarInfo('Vanda - Vanda 2', 'KL1', 2, 2),
    KamarInfo('Vanda - Vanda 3', 'KL3', 4, 4),
    KamarInfo('Vanda - Vanda 4', 'KL3', 4, 4),
    KamarInfo('Vanda - Vanda 5', 'KL3', 4, 4),
    KamarInfo('Vanda - Vanda 6', 'KL3', 4, 3),
    KamarInfo('Vanda - Vanda 7', 'KL3', 4, 4),
    KamarInfo('Vanda - Vanda Isolasi', 'KL3', 1, 1),
    KamarInfo('Vanda - Vanda VIP', 'VIP', 3, 1),
    KamarInfo('Cempaka - Cempaka VIP', 'VIP', 1, 1),
    KamarInfo('Cempaka - Cempaka 1', 'KL3', 4, 4),
    KamarInfo('Cempaka - Cempaka 2', 'KL3', 4, 4),
    KamarInfo('Cempaka - Cempaka 4', 'KL3', 4, 4),
    KamarInfo('Cempaka - Cempaka 5', 'KL3', 4, 4),
    KamarInfo('Anggrek - Anggrek 2', 'KL1', 1, 0),
    KamarInfo('Anggrek - Anggrek 3', 'KL2', 2, 1),
    KamarInfo('Anggrek - Anggrek 1', 'KL1', 1, 0),
    KamarInfo('Anggrek - Anggrek 6', 'KL3', 2, 1),
    KamarInfo('Anggrek - Anggrek 4', 'KL2', 2, 2),
    KamarInfo('Anggrek - Anggrek 5', 'KL3', 1, 1),
    KamarInfo('Anggrek - Anggrek 7', 'KL3', 1, 1),
    KamarInfo('Teratai - Teratai 3', 'KL3', 1, 1),
    KamarInfo('Teratai - Teratai 4', 'KL3', 1, 1),
    KamarInfo('Teratai - Teratai 6', 'KL3', 1, 1),
  ];

  List<KamarInfo> get _all => widget.kamarList ?? _default;

  int get _totalKapasitas => _all.fold(0, (s, k) => s + k.kapasitas);
  int get _totalTerisi => _all.fold(0, (s, k) => s + k.terisi);
  int get _totalTersedia => _totalKapasitas - _totalTerisi;

  // ============================================================
  // BUILD
  // ============================================================
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: pageBackground,
      bottomNavigationBar: _buildBottomNavigation(context),
      body: SafeArea(
        child: Column(
          children: [
            _buildHeader(context),
            Expanded(
              child: CustomScrollView(
                physics: const BouncingScrollPhysics(),
                slivers: [
                  SliverToBoxAdapter(
                    child: Column(
                      children: [
                        const SizedBox(height: 16),
                        _buildSummary(),
                        const SizedBox(height: 16),
                      ],
                    ),
                  ),
                  SliverPadding(
                    padding: const EdgeInsets.fromLTRB(20, 8, 20, 12),
                    sliver: SliverList(
                      delegate: SliverChildBuilderDelegate(
                        (context, index) => Padding(
                          padding: const EdgeInsets.only(bottom: 12),
                          child: _buildKamarCard(_all[index]),
                        ),
                        childCount: _all.length,
                      ),
                    ),
                  ),
                  SliverToBoxAdapter(
                    child: Column(
                      children: [
                        if (widget.showRingkasan) ...[
                          _buildRingkasan(),
                          const SizedBox(height: 16),
                        ],
                        _buildInfoLayanan(),
                        const SizedBox(height: 24),
                      ],
                    ),
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
  // HEADER
  // ============================================================
  Widget _buildHeader(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 66,
      decoration: const BoxDecoration(
        color: pageBackground,
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
              color: primaryBlue,
            ),
          ),
          const SizedBox(width: 16),
          const Text(
            'Info Kamar',
            style: TextStyle(
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
  // SUMMARY CARD (gradient)
  // ============================================================
  Widget _buildSummary() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color(0xFF1F7A68), Color(0xFF145047)],
        ),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF1B6B5B).withValues(alpha: 0.28),
            blurRadius: 16,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            width: 44,
            height: 44,
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.2),
              borderRadius: BorderRadius.circular(13),
            ),
            child: const Icon(Icons.bed_rounded,
                size: 24, color: Colors.white),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.hospitalName,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w800,
                    color: Colors.white,
                    height: 1.2,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  'Ketersediaan Kamar Rawat Inap',
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.white.withValues(alpha: 0.9),
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
  // KAMAR CARD
  // ============================================================
  Widget _buildKamarCard(KamarInfo k) {
    final double persen = k.kapasitas == 0 ? 0 : k.terisi / k.kapasitas;
    final int persenInt = (persen * 100).round();

    Color statusColor;
    if (k.tersedia == 0) {
      statusColor = danger;
    } else if (persen >= 0.7) {
      statusColor = amber;
    } else {
      statusColor = green;
    }

    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: cardBorder),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.03),
            blurRadius: 6,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header: ikon bed + nama + badge kelas
          Row(
            children: [
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: primaryBlue.withValues(alpha: 0.10),
                  borderRadius: BorderRadius.circular(11),
                ),
                child: const Icon(Icons.bed_rounded,
                    size: 21, color: primaryBlue),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  k.nama,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                    color: darkText,
                    height: 1.25,
                  ),
                ),
              ),
              const SizedBox(width: 8),
              _kelasBadge(k.kelas),
            ],
          ),
          const SizedBox(height: 14),
          // Statistik
          Row(
            children: [
              _stat('Kapasitas', '${k.kapasitas}', darkBlue),
              _statDivider(),
              _stat('Terisi', '${k.terisi}', amber),
              _statDivider(),
              _stat('Tersedia', '${k.tersedia}',
                  k.tersedia == 0 ? danger : green),
            ],
          ),
          const SizedBox(height: 14),
          // Progress bar
          ClipRRect(
            borderRadius: BorderRadius.circular(6),
            child: LinearProgressIndicator(
              value: persen,
              minHeight: 8,
              backgroundColor: const Color(0xFFEFF2F6),
              valueColor: AlwaysStoppedAnimation<Color>(statusColor),
            ),
          ),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '$persenInt% terisi',
                style: TextStyle(
                  fontSize: 11.5,
                  fontWeight: FontWeight.w600,
                  color: statusColor,
                ),
              ),
              Text(
                k.tersedia == 0 ? 'Penuh' : '${k.tersedia} bed tersedia',
                style: TextStyle(
                  fontSize: 11.5,
                  fontWeight: FontWeight.w700,
                  color: k.tersedia == 0 ? danger : green,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _stat(String label, String value, Color color) {
    return Expanded(
      child: Column(
        children: [
          Text(
            value,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w800,
              color: color,
            ),
          ),
          const SizedBox(height: 2),
          Text(
            label,
            style: const TextStyle(fontSize: 11, color: greyText),
          ),
        ],
      ),
    );
  }

  Widget _statDivider() {
    return Container(
      width: 1,
      height: 30,
      color: cardBorder,
    );
  }

  Widget _kelasBadge(String kelas) {
    final String k = kelas.toLowerCase();
    Color c;
    if (k.contains('vvip') || k.contains('vip')) {
      c = const Color(0xFF7B57C7);
    } else if (k.contains('utama') || k.contains('icu')) {
      c = danger;
    } else if (k.contains('1') || k.contains('kl1')) {
      c = const Color(0xFF2F80ED);
    } else if (k.contains('2') || k.contains('kl2')) {
      c = green;
    } else {
      c = const Color(0xFFD4770B);
    }
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        color: c.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        kelas,
        style: TextStyle(
          fontSize: 11,
          fontWeight: FontWeight.w800,
          color: c,
        ),
      ),
    );
  }

  // ============================================================
  // INFORMASI LAYANAN
  // ============================================================
  static const Color _green = Color(0xFF1B6B5B);
  static const Color _infoBg = Color(0xFFF0FAF7);
  static const Color _infoBorder = Color(0xFFB8E0D6);

  Widget _buildInfoLayanan() {
    final items = widget.infoItems ??
        const [
          InfoKamarItem(Icons.update_rounded,
              'Data ketersediaan kamar diperbarui secara berkala dan dapat berubah sewaktu-waktu.'),
          InfoKamarItem(Icons.meeting_room_outlined,
              'Kamar dengan status "Penuh" tidak dapat menerima pasien baru untuk sementara waktu.'),
          InfoKamarItem(Icons.phone_in_talk_outlined,
              'Untuk konfirmasi ketersediaan kamar, silakan hubungi bagian pendaftaran rumah sakit.'),
        ];

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: _infoBg,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: _infoBorder),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Row(
            children: [
              Icon(Icons.info_rounded, size: 20, color: _green),
              SizedBox(width: 8),
              Text(
                'Informasi Layanan',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                  color: _green,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          for (int i = 0; i < items.length; i++) ...[
            if (i > 0) const SizedBox(height: 12),
            _buildInfoItem(items[i].icon, items[i].text),
          ],
        ],
      ),
    );
  }

  // ============================================================
  // RINGKASAN KAMAR
  // ============================================================
  Widget _buildRingkasan() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: cardBorder),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.03),
            blurRadius: 6,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Row(
            children: [
              Icon(Icons.summarize_rounded, size: 20, color: _green),
              SizedBox(width: 8),
              Text(
                'Ringkasan Kamar',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                  color: darkText,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              _ringkasanStat('Total', '$_totalKapasitas', darkBlue),
              _statDivider(),
              _ringkasanStat('Terisi', '$_totalTerisi', amber),
              _statDivider(),
              _ringkasanStat('Tersedia', '$_totalTersedia', green),
            ],
          ),
        ],
      ),
    );
  }

  Widget _ringkasanStat(String label, String value, Color color) {
    return Expanded(
      child: Column(
        children: [
          Text(
            value,
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.w900,
              color: color,
            ),
          ),
          const SizedBox(height: 2),
          Text(
            label,
            style: const TextStyle(fontSize: 12, color: greyText),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoItem(IconData icon, String text) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, size: 18, color: _green),
        const SizedBox(width: 10),
        Expanded(
          child: Text(
            text,
            style: const TextStyle(
              fontSize: 13,
              color: darkText,
              height: 1.4,
            ),
          ),
        ),
      ],
    );
  }

  // ============================================================
  // BOTTOM NAVIGATION (identik layanan lain)
  // ============================================================
  Widget _buildBottomNavigation(BuildContext context) {
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
              child: _navItem(context, Icons.home_outlined, Icons.home_rounded,
                  'Beranda', false, () {
                Navigator.popUntil(context, (route) => route.isFirst);
              }),
            ),
            Expanded(
              child: _navItem(context, Icons.grid_view_rounded,
                  Icons.grid_view_rounded, 'Layanan', true, () {
                Navigator.pop(context);
              }),
            ),
            Expanded(
              child: _navItem(context, Icons.calendar_month_outlined,
                  Icons.calendar_month_rounded, 'Agenda', false, () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const AgendaScreen()),
                );
              }),
            ),
          ],
        ),
      ),
    );
  }

  Widget _navItem(
    BuildContext context,
    IconData offIcon,
    IconData onIcon,
    String label,
    bool active,
    VoidCallback onTap,
  ) {
    return GestureDetector(
      onTap: onTap,
      child: Center(
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          width: 95,
          height: 52,
          decoration: BoxDecoration(
            color: active ? lightBlue : Colors.transparent,
            borderRadius: BorderRadius.circular(27),
          ),
          child: Transform.translate(
            offset: const Offset(0, -1),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  active ? onIcon : offIcon,
                  size: 22,
                  color: active ? darkBlue : const Color(0xFF374151),
                ),
                const SizedBox(height: 1),
                Text(
                  label,
                  style: TextStyle(
                    fontSize: 9,
                    fontWeight: active ? FontWeight.w600 : FontWeight.w400,
                    color: active ? darkBlue : const Color(0xFF374151),
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
// MODEL KAMAR
// ================================================================
class KamarInfo {
  final String nama;
  final String kelas;
  final int kapasitas;
  final int terisi;

  const KamarInfo(this.nama, this.kelas, this.kapasitas, this.terisi);

  int get tersedia => kapasitas - terisi;
}

// ================================================================
// MODEL ITEM INFO LAYANAN
// ================================================================
class InfoKamarItem {
  final IconData icon;
  final String text;
  const InfoKamarItem(this.icon, this.text);
}
