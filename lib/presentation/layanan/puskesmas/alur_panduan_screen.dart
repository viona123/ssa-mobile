import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import 'puskesmas_shared.dart';

// ================================================================
// ALUR & PANDUAN LAYANAN PUSKESMAS
// Desain mengikuti context/alur.png dengan nuansa hijau:
//  - Alur Pasien BPJS Kesehatan / KIS
//  - Alur Pasien Umum
//  - Banner Gawat Darurat PSC 119 Sragen
// ================================================================

class AlurPanduanScreen extends StatelessWidget {
  const AlurPanduanScreen({super.key});

  static const List<_Step> _bpjsSteps = [
    _Step(
      'Pendaftaran & Validasi Kartu',
      'Tunjukkan KTP/KK dan Kartu KIS/BPJS aktif atau daftar antrean online '
          'via Klinisia / Mobile JKN.',
    ),
    _Step(
      'Skrining & Pemeriksaan Awal',
      'Pemeriksaan tanda vital (tensi darah, suhu, berat badan) oleh '
          'perawat/bidan.',
    ),
    _Step(
      'Pemeriksaan Dokter Poli',
      'Konsultasi, diagnosa, tindakan medis dasar, atau rujukan laboratorium '
          'bila diperlukan.',
    ),
    _Step(
      'Pengambilan Obat / Rujukan RSUD',
      'Pengambilan obat di loket farmasi secara GRATIS (ditanggung BPJS) atau '
          'penerbitan surat rujukan online ke RSUD.',
    ),
  ];

  static const List<_Step> _umumSteps = [
    _Step(
      'Loket Pendaftaran',
      'Membawa identitas diri (KTP/SIM/KIA) dan mengambil nomor antrean loket '
          'pendaftaran.',
    ),
    _Step(
      'Pemeriksaan & Konsultasi Dokter',
      'Pemeriksaan oleh dokter umum/gigi di ruang pelayanan poli yang dituju.',
    ),
    _Step(
      'Kasir & Pembayaran Retribusi',
      'Pembayaran retribusi pelayanan sesuai Peraturan Bupati (Perbup) '
          'Kabupaten Sragen yang terjangkau.',
    ),
    _Step(
      'Loket Farmasi',
      'Penyerahan bukti pembayaran dan pengambilan obat resep di apotek '
          'Puskesmas.',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: PuskesmasColors.pageBackground,
      bottomNavigationBar: const PuskesmasBottomNav(),
      body: SafeArea(
        child: Column(
          children: [
            const PuskesmasHeader(title: 'Alur & Panduan'),
            Expanded(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                padding: const EdgeInsets.fromLTRB(20, 18, 20, 28),
                child: Column(
                  children: [
                    // ALUR BPJS
                    _buildFlowCard(
                      icon: Icons.health_and_safety_rounded,
                      accent: PuskesmasColors.primaryGreen,
                      title: 'Alur Pasien BPJS Kesehatan / KIS',
                      subtitle: 'FKTP Terdaftar di Puskesmas Wilayah Sragen',
                      steps: _bpjsSteps,
                    ),
                    const SizedBox(height: 14),

                    // ALUR UMUM
                    _buildFlowCard(
                      icon: Icons.badge_rounded,
                      accent: const Color(0xFF2F80ED),
                      title: 'Alur Pasien Umum',
                      subtitle: 'Warga tanpa jaminan BPJS / Domisili Luar',
                      steps: _umumSteps,
                    ),
                    const SizedBox(height: 16),

                    // EMERGENCY BANNER
                    _buildEmergencyBanner(context),
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
  // FLOW CARD
  // ============================================================
  Widget _buildFlowCard({
    required IconData icon,
    required Color accent,
    required String title,
    required String subtitle,
    required List<_Step> steps,
  }) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
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
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // HEADER
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 44,
                height: 44,
                decoration: BoxDecoration(
                  color: accent.withValues(alpha: 0.12),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(icon, size: 22, color: accent),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                        fontSize: 15.5,
                        fontWeight: FontWeight.w800,
                        color: PuskesmasColors.darkText,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      subtitle,
                      style: const TextStyle(
                        fontSize: 11.5,
                        color: PuskesmasColors.greyText,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),

          // STEPS TIMELINE
          ...List.generate(steps.length, (i) {
            final isLast = i == steps.length - 1;
            return _buildStep(steps[i], i + 1, accent, isLast);
          }),
        ],
      ),
    );
  }

  Widget _buildStep(_Step step, int number, Color accent, bool isLast) {
    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Timeline
          Column(
            children: [
              Container(
                width: 28,
                height: 28,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: accent,
                  shape: BoxShape.circle,
                ),
                child: Text(
                  '$number',
                  style: const TextStyle(
                    fontSize: 12.5,
                    fontWeight: FontWeight.w800,
                    color: Colors.white,
                  ),
                ),
              ),
              if (!isLast)
                Expanded(
                  child: Container(
                    width: 2,
                    color: accent.withValues(alpha: 0.25),
                  ),
                ),
            ],
          ),
          const SizedBox(width: 13),
          // Konten
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(bottom: isLast ? 0 : 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    step.title,
                    style: const TextStyle(
                      fontSize: 13.5,
                      fontWeight: FontWeight.w700,
                      color: PuskesmasColors.darkText,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    step.desc,
                    style: const TextStyle(
                      fontSize: 11.5,
                      color: PuskesmasColors.greyText,
                      height: 1.45,
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

  // ============================================================
  // EMERGENCY BANNER — PSC 119
  // ============================================================
  Widget _buildEmergencyBanner(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
          colors: [Color(0xFFFDEBEF), Color(0xFFFDF3EC)],
        ),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFF6CAD4)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 44,
                height: 44,
                decoration: BoxDecoration(
                  color: const Color(0xFFFAD4DC),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Icon(Icons.call_rounded,
                    size: 22, color: Color(0xFFD92D2D)),
              ),
              const SizedBox(width: 12),
              const Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Layanan Gawat Darurat PSC 119 Sragen',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w800,
                        color: PuskesmasColors.darkText,
                      ),
                    ),
                    SizedBox(height: 3),
                    Text(
                      'Hubungi PSC 119 Sragen untuk penanganan medis darurat, '
                      'ambulans jemput pasien, dan bencana 24 Jam.',
                      style: TextStyle(
                        fontSize: 11.5,
                        color: Color(0xFF8A6B70),
                        height: 1.4,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 14),
          Row(
            children: [
              Expanded(
                child: GestureDetector(
                  onTap: () => _call(context),
                  child: Container(
                    height: 44,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: const Color(0xFFD92D2D),
                      borderRadius: BorderRadius.circular(11),
                      boxShadow: [
                        BoxShadow(
                          color: const Color(0xFFD92D2D)
                              .withValues(alpha: 0.3),
                          blurRadius: 10,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: const Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.emergency_rounded,
                            size: 17, color: Colors.white),
                        SizedBox(width: 7),
                        Text(
                          'Panggil 119',
                          style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w800,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: GestureDetector(
                  onTap: () => _showInfo(context),
                  child: Container(
                    height: 44,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(11),
                      border: Border.all(color: const Color(0xFFF0D0D6)),
                    ),
                    child: const Text(
                      'Info Kedaruratan',
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w700,
                        color: PuskesmasColors.darkText,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // ============================================================
  // ACTIONS
  // ============================================================
  Future<void> _call(BuildContext context) async {
    final uri = Uri(scheme: 'tel', path: '119');
    final launched =
        await launchUrl(uri, mode: LaunchMode.externalApplication);
    if (!launched && context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Tidak dapat memulai panggilan ke 119.'),
          behavior: SnackBarBehavior.floating,
        ),
      );
    }
  }

  void _showInfo(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(22)),
      ),
      builder: (_) => Padding(
        padding: const EdgeInsets.fromLTRB(20, 18, 20, 28),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Container(
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: PuskesmasColors.cardBorder,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
            ),
            const SizedBox(height: 18),
            Row(
              children: [
                Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: const Color(0xFFFAD4DC),
                    borderRadius: BorderRadius.circular(11),
                  ),
                  child: const Icon(Icons.emergency_rounded,
                      size: 20, color: Color(0xFFD92D2D)),
                ),
                const SizedBox(width: 12),
                const Expanded(
                  child: Text(
                    'PSC 119 Sragen',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w800,
                      color: PuskesmasColors.darkText,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            _infoRow(Icons.access_time_rounded,
                'Layanan 24 jam setiap hari, termasuk hari libur.'),
            const SizedBox(height: 10),
            _infoRow(Icons.local_shipping_rounded,
                'Ambulans gawat darurat untuk jemput & rujukan pasien.'),
            const SizedBox(height: 10),
            _infoRow(Icons.volunteer_activism_rounded,
                'Penanganan kegawatdaruratan medis dan tanggap bencana.'),
            const SizedBox(height: 10),
            _infoRow(Icons.money_off_rounded,
                'Layanan darurat PSC 119 tidak dipungut biaya.'),
            const SizedBox(height: 20),
            SizedBox(
              width: double.infinity,
              child: GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                  _call(context);
                },
                child: Container(
                  height: 46,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: const Color(0xFFD92D2D),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Text(
                    'Panggil 119 Sekarang',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w800,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _infoRow(IconData icon, String text) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, size: 18, color: PuskesmasColors.primaryGreen),
        const SizedBox(width: 10),
        Expanded(
          child: Text(
            text,
            style: const TextStyle(
              fontSize: 12.5,
              color: PuskesmasColors.darkText,
              height: 1.4,
            ),
          ),
        ),
      ],
    );
  }
}

// ================================================================
// MODEL
// ================================================================
class _Step {
  final String title;
  final String desc;
  const _Step(this.title, this.desc);
}
