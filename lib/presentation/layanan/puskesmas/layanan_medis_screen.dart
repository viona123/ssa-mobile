import 'package:flutter/material.dart';

import 'puskesmas_shared.dart';

// ================================================================
// LAYANAN MEDIS — Standar Pelayanan Medis Primer Puskesmas
// Desain mengikuti context/medis.png dengan nuansa hijau.
// ================================================================

class LayananMedisScreen extends StatelessWidget {
  const LayananMedisScreen({super.key});

  static const List<_Medis> _list = [
    _Medis(
      category: 'Pelayanan Medis Dasar',
      title: 'Poli Umum',
      desc:
          'Pemeriksaan kesehatan menyeluruh, diagnosis, pengobatan penyakit '
          'umum, serta rujukan medis berjenjang.',
      sasaran: 'Seluruh Usia / Pasien Umum & BPJS',
      icon: Icons.medical_services_rounded,
      color: Color(0xFF1B8A5A),
    ),
    _Medis(
      category: 'Kesehatan Gigi',
      title: 'Poli Gigi & Mulut',
      desc:
          'Pemeriksaan gigi berkala, penambalan, pencabutan gigi sulung/dewasa, '
          'dan pembersihan karang gigi dasar.',
      sasaran: 'Anak & Dewasa',
      icon: Icons.masks_rounded,
      color: Color(0xFF2F80ED),
    ),
    _Medis(
      category: 'Kesehatan Ibu & Anak',
      title: 'Poli KIA & KB',
      desc:
          'Pemeriksaan antenatal care (ANC terpadu), persalinan, nifas, '
          'imunisasi TT, serta pelayanan KB (IUD, Implan, Suntik, Pil).',
      sasaran: 'Ibu Hamil, PUS & Bayi',
      icon: Icons.pregnant_woman_rounded,
      color: Color(0xFFE0567F),
    ),
    _Medis(
      category: 'Pencegahan Penyakit',
      title: 'Poli Imunisasi',
      desc:
          'Imunisasi dasar lengkap (HB0, BCG, Polio, DPT-HB-Hib, Campak/MR) '
          'serta vaksinasi lanjutan sesuai jadwal Kemenkes.',
      sasaran: 'Bayi, Balita & Calon Pengantin',
      icon: Icons.vaccines_rounded,
      color: Color(0xFF7B57C7),
    ),
    _Medis(
      category: 'Penyakit Tidak Menular',
      title: 'Poli Lansia & PTM',
      desc:
          'Skrining dan pengelolaan penyakit kronis (Hipertensi, Diabetes '
          'Melitus, Jantung) dan Posbindu PTM terintegrasi.',
      sasaran: 'Pra-Lansia & Lansia (45+ Th)',
      icon: Icons.monitor_heart_rounded,
      color: Color(0xFFD9534F),
    ),
    _Medis(
      category: 'Penunjang Medis',
      title: 'Laboratorium Sederhana',
      desc:
          'Pemeriksaan hematologi rutin, urin lengkap, gula darah, kolesterol, '
          'asam urat, tes kehamilan, dan tes dahak/TBC.',
      sasaran: 'Pasien Rujukan Internal Poli',
      icon: Icons.science_rounded,
      color: Color(0xFF0F9BAE),
    ),
    _Medis(
      category: 'Kefarmasian',
      title: 'Pelayanan Farmasi',
      desc:
          'Pemberian obat resep terstandar formularium nasional, peracikan '
          'obat, dan konseling cara minum obat yang benar.',
      sasaran: 'Pasien Rawat Jalan & IGD',
      icon: Icons.medication_rounded,
      color: Color(0xFF2EA36B),
    ),
    _Medis(
      category: 'Kesehatan Masyarakat',
      title: 'Konseling Gizi',
      desc:
          'Konsultasi dietetik, penanganan balita gizi kurang/stunting, '
          'edukasi ASI eksklusif dan menu gizi seimbang.',
      sasaran: 'Balita, Ibu Hamil & Pasien Kronis',
      icon: Icons.restaurant_rounded,
      color: Color(0xFFE0A118),
    ),
    _Medis(
      category: 'Gawat Darurat',
      title: 'UGD & Rawat Inap 24 Jam',
      desc:
          'Penanganan kegawatdaruratan medis awal, observasi, stabilisasi '
          'pasien, serta rawat inap pada puskesmas DTP.',
      sasaran: 'Kasus Darurat Medis 24/7',
      icon: Icons.emergency_rounded,
      color: Color(0xFFD92D2D),
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
            const PuskesmasHeader(title: 'Layanan Medis'),
            Expanded(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                padding: const EdgeInsets.only(bottom: 28),
                child: Column(
                  children: [
                    _buildSectionHeader(),
                    const SizedBox(height: 18),
                    ..._list.map(
                      (m) => Padding(
                        padding: const EdgeInsets.fromLTRB(20, 0, 20, 12),
                        child: _buildCard(m),
                      ),
                    ),
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
  // SECTION HEADER
  // ============================================================
  Widget _buildSectionHeader() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(24, 22, 24, 0),
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [Color(0xFFEDF8F2), PuskesmasColors.pageBackground],
        ),
      ),
      child: const Column(
        children: [
          Text(
            'Standar Pelayanan Medis Primer Puskesmas',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 19,
              fontWeight: FontWeight.w800,
              color: PuskesmasColors.darkText,
              height: 1.25,
            ),
          ),
          SizedBox(height: 8),
          Text(
            'Disediakan oleh tenaga kesehatan profesional (Dokter Umum, Dokter '
            'Gigi, Bidan, Perawat, Apoteker, Analis Lab, dan Nutrisionis).',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 12,
              color: PuskesmasColors.greyText,
              height: 1.5,
            ),
          ),
          SizedBox(height: 20),
        ],
      ),
    );
  }

  // ============================================================
  // CARD
  // ============================================================
  Widget _buildCard(_Medis m) {
    return Container(
      padding: const EdgeInsets.all(16),
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
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // HEADER: icon + kategori + judul
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 46,
                height: 46,
                decoration: BoxDecoration(
                  color: m.color.withValues(alpha: 0.12),
                  borderRadius: BorderRadius.circular(13),
                ),
                child: Icon(m.icon, size: 23, color: m.color),
              ),
              const SizedBox(width: 13),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      m.category.toUpperCase(),
                      style: TextStyle(
                        fontSize: 9.5,
                        fontWeight: FontWeight.w700,
                        color: m.color,
                        letterSpacing: 0.5,
                      ),
                    ),
                    const SizedBox(height: 3),
                    Text(
                      m.title,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w800,
                        color: PuskesmasColors.darkText,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),

          // DESKRIPSI
          Text(
            m.desc,
            style: const TextStyle(
              fontSize: 12.5,
              color: PuskesmasColors.greyText,
              height: 1.5,
            ),
          ),
          const SizedBox(height: 14),

          const Divider(height: 1, color: PuskesmasColors.cardBorder),
          const SizedBox(height: 12),

          // SASARAN
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Icon(Icons.groups_rounded,
                  size: 17, color: PuskesmasColors.primaryGreen),
              const SizedBox(width: 8),
              const Text(
                'Sasaran:',
                style: TextStyle(
                  fontSize: 11.5,
                  fontWeight: FontWeight.w700,
                  color: PuskesmasColors.darkText,
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  m.sasaran,
                  textAlign: TextAlign.right,
                  style: const TextStyle(
                    fontSize: 11.5,
                    fontWeight: FontWeight.w600,
                    color: PuskesmasColors.primaryGreen,
                    height: 1.35,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

// ================================================================
// MODEL
// ================================================================
class _Medis {
  final String category;
  final String title;
  final String desc;
  final String sasaran;
  final IconData icon;
  final Color color;

  const _Medis({
    required this.category,
    required this.title,
    required this.desc,
    required this.sasaran,
    required this.icon,
    required this.color,
  });
}
