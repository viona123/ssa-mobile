import 'package:flutter/material.dart';
import '../../agenda/agenda_screen.dart';

// ================================================================
// DETAIL RS SCREEN
// Desain sesuai detailrs.png + detailrs2.png
// ================================================================

class DetailRsScreen extends StatelessWidget {
  final String namaRs;
  final String alamat;
  final String telepon;
  final int totalKamar;
  final int terisi;
  final int kosong;
  final List<DetailKamarItem> detailKamar;
  final List<String> layanan;
  final List<DokterItem> dokter;

  const DetailRsScreen({
    super.key,
    required this.namaRs,
    required this.alamat,
    required this.telepon,
    required this.totalKamar,
    required this.terisi,
    required this.kosong,
    required this.detailKamar,
    required this.layanan,
    this.dokter = const [],
  });

  // ============================================================
  // COLORS
  // ============================================================

  static const Color _appBlue = Color(0xFF007EA7);
  static const Color _tealLight = Color(0xFF58D8EC);
  static const Color _navyDark = Color(0xFF315579);
  static const Color _bg = Color(0xFFF8FAFC);
  static const Color _ink = Color(0xFF202124);
  static const Color _smoke = Color(0xFF737B86);
  static const Color _totalBlue = Color(0xFF1565C0);
  static const Color _terisiRed = Color(0xFFD32F2F);
  static const Color _kosongGreen = Color(0xFF2E7D32);
  static const Color _totalBlueBg = Color(0xFFE3F2FD);
  static const Color _terisiBg = Color(0xFFFFEBEE);
  static const Color _kosongBg = Color(0xFFE8F5E9);
  static const Color _isolasiBorder = Color(0xFFEF5350);
  static const Color _isolasiBg = Color(0xFFFFEBEE);
  static const Color _vipBg = Color(0xFFE8F5E9);
  static const Color _vipBorder = Color(0xFF66BB6A);
  static const Color _kelasBg = Color(0xFFF5F5F5);
  static const Color _kelasBorder = Color(0xFFBDBDBD);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _bg,
      bottomNavigationBar: _buildNavBar(context),
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _buildHeader(context),
              const SizedBox(height: 20),
              _buildSummaryCards(),
              const SizedBox(height: 24),
              _buildDetailKamarSection(),
              const SizedBox(height: 24),
              _buildLayananSection(),
              const SizedBox(height: 24),
              _buildDokterSection(),
              const SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }

  // ============================================================
  // HEADER — navy dark, nama RS, alamat, telepon
  // ============================================================

  Widget _buildHeader(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [Color(0xFF0040A1), Color(0xFF002F7A)],
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(20, 16, 20, 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Top bar
            Row(
              children: [
                const Icon(Icons.local_hospital_rounded, size: 16, color: Colors.white70),
                const SizedBox(width: 6),
                const Text('FASILITAS KESEHATAN', style: TextStyle(fontSize: 11, fontWeight: FontWeight.w600, color: Colors.white70, letterSpacing: 0.5)),
                const Spacer(),
                GestureDetector(
                  onTap: () => Navigator.pop(context),
                  child: const Icon(Icons.close_rounded, size: 24, color: Colors.white),
                ),
              ],
            ),
            const SizedBox(height: 14),
            // Nama RS
            Text(
              namaRs.toUpperCase(),
              style: const TextStyle(fontSize: 22, fontWeight: FontWeight.w900, color: Colors.white, height: 1.2),
            ),
            const SizedBox(height: 16),
            // Alamat
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: Colors.white.withValues(alpha: 0.2), width: 1),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Icon(Icons.location_on_outlined, size: 18, color: Color(0xFF9BF6B3)),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      alamat,
                      style: const TextStyle(fontSize: 13, color: Colors.white, height: 1.4),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 10),
            // Telepon
            Container(
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: Colors.white.withValues(alpha: 0.2), width: 1),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(Icons.phone_rounded, size: 18, color: Color(0xFF9BF6B3)),
                  const SizedBox(width: 8),
                  Text(telepon, style: const TextStyle(fontSize: 13, color: Colors.white, fontWeight: FontWeight.w500)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ============================================================
  // SUMMARY CARDS — Total Kamar, Terisi, Kosong
  // ============================================================

  Widget _buildSummaryCards() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: IntrinsicHeight(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(child: _buildSummaryCard(Icons.bed_rounded, '$totalKamar', 'TOTAL\nKAMAR', _totalBlue, _totalBlueBg)),
            const SizedBox(width: 10),
            Expanded(child: _buildSummaryCard(Icons.meeting_room_rounded, '$terisi', 'TERISI', _terisiRed, _terisiBg)),
            const SizedBox(width: 10),
            Expanded(child: _buildSummaryCard(Icons.check_circle_outline_rounded, '$kosong', 'KOSONG', _kosongGreen, _kosongBg)),
          ],
        ),
      ),
    );
  }

  Widget _buildSummaryCard(IconData icon, String value, String label, Color color, Color bgColor) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 8),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: color.withValues(alpha: 0.2), width: 1),
        boxShadow: [
          BoxShadow(color: color.withValues(alpha: 0.15), blurRadius: 8, offset: const Offset(0, 3)),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, size: 22, color: color),
          const SizedBox(height: 8),
          Text(value, style: TextStyle(fontSize: 28, fontWeight: FontWeight.w900, color: color)),
          const SizedBox(height: 4),
          Text(label, textAlign: TextAlign.center, style: TextStyle(fontSize: 10, fontWeight: FontWeight.w700, color: color, letterSpacing: 0.3)),
        ],
      ),
    );
  }

  // ============================================================
  // DETAIL KETERSEDIAAN KAMAR — Table
  // ============================================================

  Widget _buildDetailKamarSection() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Title
          const Row(
            children: [
              Icon(Icons.bed_rounded, size: 20, color: _ink),
              SizedBox(width: 8),
              Text('Detail Ketersediaan Kamar', style: TextStyle(fontSize: 17, fontWeight: FontWeight.w800, color: _ink)),
            ],
          ),
          const SizedBox(height: 14),
          // Table
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: const Color(0xFFE0E0E0), width: 1),
            ),
            clipBehavior: Clip.antiAlias,
            child: Column(
              children: [
                // Header
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
                  decoration: const BoxDecoration(
                    color: Color(0xFFF5F5F5),
                    border: Border(bottom: BorderSide(color: Color(0xFFE0E0E0), width: 1)),
                  ),
                  child: const Row(
                    children: [
                      Expanded(flex: 3, child: Text('NAMA KAMAR', style: TextStyle(fontSize: 10, fontWeight: FontWeight.w700, color: _smoke, letterSpacing: 0.3))),
                      Expanded(flex: 2, child: Text('KELAS', textAlign: TextAlign.center, style: TextStyle(fontSize: 10, fontWeight: FontWeight.w700, color: _smoke, letterSpacing: 0.3))),
                      Expanded(flex: 2, child: Text('KAPASITAS', textAlign: TextAlign.center, style: TextStyle(fontSize: 10, fontWeight: FontWeight.w700, color: _smoke, letterSpacing: 0.3))),
                    ],
                  ),
                ),
                // Rows
                ...List.generate(detailKamar.length, (index) {
                  final item = detailKamar[index];
                  return Container(
                    padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
                    decoration: const BoxDecoration(
                      border: Border(bottom: BorderSide(color: Color(0xFFF0F0F0), width: 1)),
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          flex: 3,
                          child: Text(item.namaKamar, style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: _ink)),
                        ),
                        Expanded(
                          flex: 2,
                          child: Center(child: _buildKelasBadge(item.kelas)),
                        ),
                        Expanded(
                          flex: 2,
                          child: Text('${item.kapasitas}', textAlign: TextAlign.center, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: _ink)),
                        ),
                      ],
                    ),
                  );
                }),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildKelasBadge(String kelas) {
    Color bgColor;
    Color borderColor;
    Color textColor;

    final kelasLower = kelas.toLowerCase();
    if (kelasLower.contains('isolasi')) {
      bgColor = _isolasiBg;
      borderColor = _isolasiBorder;
      textColor = _isolasiBorder;
    } else if (kelasLower.contains('vip') || kelasLower.contains('svvip') || kelasLower.contains('vvip')) {
      bgColor = _vipBg;
      borderColor = _vipBorder;
      textColor = _vipBorder;
    } else {
      bgColor = _kelasBg;
      borderColor = _kelasBorder;
      textColor = _smoke;
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(6),
        border: Border.all(color: borderColor, width: 1),
      ),
      child: Text(
        kelas,
        style: TextStyle(fontSize: 11, fontWeight: FontWeight.w600, color: textColor),
      ),
    );
  }

  // ============================================================
  // LAYANAN MEDIS — sesuai detailrs2.png
  // Title di luar, setiap layanan dalam kotak sendiri-sendiri
  // ============================================================

  Widget _buildLayananSection() {
    if (layanan.isEmpty) return const SizedBox.shrink();

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Title di luar kotak
          const Row(
            children: [
              Icon(Icons.health_and_safety_rounded, size: 20, color: _appBlue),
              SizedBox(width: 8),
              Text('Layanan Medis', style: TextStyle(fontSize: 15, fontWeight: FontWeight.w700, color: _ink)),
            ],
          ),
          const SizedBox(height: 12),
          // Setiap layanan dalam kotak sendiri
          ...List.generate(layanan.length, (index) {
            return Padding(
              padding: const EdgeInsets.only(bottom: 8, left: 8),
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: const Color(0xFFE0E0E0), width: 1),
                  boxShadow: [
                    BoxShadow(color: Colors.black.withValues(alpha: 0.04), blurRadius: 4, offset: const Offset(0, 1)),
                  ],
                ),
                child: Row(
                  children: [
                    Container(
                      width: 32,
                      height: 32,
                      decoration: BoxDecoration(
                        color: _appBlue.withValues(alpha: 0.08),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Icon(_getLayananIcon(layanan[index]), size: 17, color: _appBlue),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Text(layanan[index], style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w500, color: _ink)),
                    ),
                  ],
                ),
              ),
            );
          }),
        ],
      ),
    );
  }

  IconData _getLayananIcon(String nama) {
    final lower = nama.toLowerCase();
    if (lower.contains('igd') || lower.contains('gawat darurat')) return Icons.emergency_rounded;
    if (lower.contains('rawat inap')) return Icons.bed_rounded;
    if (lower.contains('kemo')) return Icons.science_rounded;
    if (lower.contains('rehabilitasi')) return Icons.accessibility_new_rounded;
    if (lower.contains('hemodialisa')) return Icons.water_drop_rounded;
    if (lower.contains('jantung')) return Icons.favorite_rounded;
    if (lower.contains('syaraf')) return Icons.psychology_rounded;
    if (lower.contains('orthopedi')) return Icons.sports_mma_rounded;
    if (lower.contains('paru')) return Icons.air_rounded;
    if (lower.contains('bedah')) return Icons.content_cut_rounded;
    if (lower.contains('urologi')) return Icons.medical_services_rounded;
    if (lower.contains('jiwa')) return Icons.sentiment_satisfied_rounded;
    if (lower.contains('gigi')) return Icons.mood_rounded;
    if (lower.contains('kandungan')) return Icons.pregnant_woman_rounded;
    if (lower.contains('oncologi')) return Icons.biotech_rounded;
    if (lower.contains('kulit')) return Icons.face_rounded;
    if (lower.contains('mata')) return Icons.visibility_rounded;
    if (lower.contains('umum')) return Icons.local_hospital_rounded;
    if (lower.contains('ambulance')) return Icons.airport_shuttle_rounded;
    if (lower.contains('icu') || lower.contains('iccu')) return Icons.monitor_heart_rounded;
    if (lower.contains('picu') || lower.contains('nicu')) return Icons.child_care_rounded;
    if (lower.contains('dalam')) return Icons.medical_information_rounded;
    if (lower.contains('anak')) return Icons.child_friendly_rounded;
    if (lower.contains('farmasi')) return Icons.medication_rounded;
    if (lower.contains('radiologi')) return Icons.radar_rounded;
    if (lower.contains('laboratorium')) return Icons.science_rounded;
    if (lower.contains('physiotherapy') || lower.contains('fisioterapi')) return Icons.self_improvement_rounded;
    if (lower.contains('tht')) return Icons.hearing_rounded;
    if (lower.contains('patologi')) return Icons.biotech_rounded;
    return Icons.check_circle_rounded;
  }

  // ============================================================
  // DOKTER
  // ============================================================

  Widget _buildDokterSection() {
    if (dokter.isEmpty) return const SizedBox.shrink();

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Title
          Row(
            children: [
              const Icon(Icons.medical_services_rounded, size: 20, color: _appBlue),
              const SizedBox(width: 8),
              Text('Dokter (${dokter.length})', style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w700, color: _ink)),
            ],
          ),
          const SizedBox(height: 12),
          // Table dokter
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: const Color(0xFFE0E0E0), width: 1),
              boxShadow: [
                BoxShadow(color: Colors.black.withValues(alpha: 0.04), blurRadius: 4, offset: const Offset(0, 1)),
              ],
            ),
            clipBehavior: Clip.antiAlias,
            child: Column(
              children: [
                // Header
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
                  decoration: const BoxDecoration(
                    color: Color(0xFFF5F5F5),
                    border: Border(bottom: BorderSide(color: Color(0xFFE0E0E0), width: 1)),
                  ),
                  child: const Row(
                    children: [
                      Expanded(flex: 3, child: Text('NAMA DOKTER', style: TextStyle(fontSize: 10, fontWeight: FontWeight.w700, color: _smoke, letterSpacing: 0.3))),
                      Expanded(flex: 2, child: Text('BIDANG / SPESIALISASI', textAlign: TextAlign.center, style: TextStyle(fontSize: 10, fontWeight: FontWeight.w700, color: _smoke, letterSpacing: 0.3))),
                    ],
                  ),
                ),
                // Rows
                ...List.generate(dokter.length, (index) {
                  final item = dokter[index];
                  return Container(
                    padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 13),
                    decoration: const BoxDecoration(
                      border: Border(bottom: BorderSide(color: Color(0xFFF0F0F0), width: 1)),
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          flex: 3,
                          child: Text(item.nama, style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: _ink)),
                        ),
                        Expanded(
                          flex: 2,
                          child: Container(
                            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                            decoration: BoxDecoration(
                              color: _appBlue.withValues(alpha: 0.08),
                              borderRadius: BorderRadius.circular(6),
                            ),
                            child: Text(item.spesialisasi, textAlign: TextAlign.center, style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w600, color: _appBlue)),
                          ),
                        ),
                      ],
                    ),
                  );
                }),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // ============================================================
  // BOTTOM NAVIGATION BAR
  // ============================================================

  Widget _buildNavBar(BuildContext context) {
    return Container(
      height: 95,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(22)),
        boxShadow: [BoxShadow(color: Colors.black.withValues(alpha: 0.07), blurRadius: 10, offset: const Offset(0, -3))],
      ),
      child: SafeArea(
        top: false,
        child: Row(
          children: [
            Expanded(child: _navItem(context, Icons.home_outlined, Icons.home_rounded, 'Beranda', false, () {
              Navigator.popUntil(context, (route) => route.isFirst);
            })),
            Expanded(child: _navItem(context, Icons.grid_view_rounded, Icons.grid_view_rounded, 'Layanan', true, () {})),
            Expanded(child: _navItem(context, Icons.calendar_month_outlined, Icons.calendar_month_rounded, 'Agenda', false, () {
              Navigator.push(context, MaterialPageRoute(builder: (_) => const AgendaScreen()));
            })),
          ],
        ),
      ),
    );
  }

  Widget _navItem(BuildContext context, IconData off, IconData on, String label, bool active, VoidCallback tap) {
    return GestureDetector(
      onTap: tap,
      child: Center(
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          width: 95,
          height: 52,
          decoration: BoxDecoration(color: active ? _tealLight : Colors.transparent, borderRadius: BorderRadius.circular(27)),
          child: Transform.translate(
            offset: const Offset(0, -1),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(active ? on : off, size: 22, color: active ? _navyDark : const Color(0xFF374151)),
                const SizedBox(height: 1),
                Text(label, style: TextStyle(fontSize: 9, fontWeight: active ? FontWeight.w600 : FontWeight.w400, color: active ? _navyDark : const Color(0xFF374151))),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// ================================================================
// MODEL
// ================================================================

class DetailKamarItem {
  final String namaKamar;
  final String kelas;
  final int kapasitas;
  final int isi;
  final int kosong;
  final String update;

  const DetailKamarItem({
    required this.namaKamar,
    required this.kelas,
    required this.kapasitas,
    required this.isi,
    required this.kosong,
    required this.update,
  });
}


class DokterItem {
  final String nama;
  final String spesialisasi;

  const DokterItem({required this.nama, required this.spesialisasi});
}
