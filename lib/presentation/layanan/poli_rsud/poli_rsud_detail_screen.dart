import 'package:flutter/material.dart';
import '../../agenda/agenda_screen.dart';
import 'jadwal_dokter_screen.dart';
import 'info_kamar_screen.dart';
import 'reservasi_poli_screen.dart';
import 'cek_batal_screen.dart';

// ================================================================
// POLI RSUD DETAIL - SETELAH PILIH RUMAH SAKIT
// Desain sesuai context/poli2.png
// ================================================================

class PoliRsudDetailScreen extends StatelessWidget {
  final String hospitalName;
  final String hospitalLocation;

  const PoliRsudDetailScreen({
    super.key,
    required this.hospitalName,
    required this.hospitalLocation,
  });

  // ============================================================
  // COLORS
  // ============================================================

  static const Color primaryGreen = Color(0xFF1B6B5B);
  static const Color darkGreen = Color(0xFF145047);
  static const Color mintGreen = Color(0xFFE8F5F1);
  static const Color mintGreenBorder = Color(0xFFB8E0D6);
  static const Color darkText = Color(0xFF202124);
  static const Color greyText = Color(0xFF737B86);
  static const Color pageBackground = Color(0xFFF8FAFC);
  static const Color cardBorder = Color(0xFFE8ECEF);
  static const Color infoBg = Color(0xFFF0FAF7);
  static const Color infoBorder = Color(0xFFB8E0D6);

  // Navbar colors (sama persis seperti home_screen & agenda_screen)
  static const Color primaryBlue = Color(0xFF007EA7);
  static const Color lightBlue = Color(0xFF58D8EC);
  static const Color darkBlue = Color(0xFF315579);

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
            // HEADER
            _buildHeader(context),

            // SCROLLABLE CONTENT
            Expanded(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                padding: const EdgeInsets.only(bottom: 30),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 20),

                    // HOSPITAL CARD (hijau besar)
                    _buildHospitalCard(),

                    const SizedBox(height: 28),

                    // LAYANAN UNGGULAN TITLE
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 24),
                      child: Text(
                        'Layanan Unggulan',
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.w800,
                          color: darkText,
                        ),
                      ),
                    ),

                    const SizedBox(height: 18),

                    // GRID 4 LAYANAN
                    _buildLayananGrid(context),

                    const SizedBox(height: 28),

                    // INFO LAYANAN
                    _buildInfoLayanan(),

                    const SizedBox(height: 20),
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
            'Layanan Poli RSUD',
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
  // HOSPITAL CARD (HIJAU BESAR)
  // ============================================================

  Widget _buildHospitalCard() {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.symmetric(horizontal: 24),
      padding: const EdgeInsets.fromLTRB(22, 20, 22, 24),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Color(0xFF1F7A68),
            Color(0xFF145047),
          ],
        ),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: primaryGreen.withValues(alpha: 0.25),
            blurRadius: 16,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Stack(
        children: [
          // DECORATIVE PATTERN (kanan atas)
          Positioned(
            right: -10,
            top: -10,
            child: Icon(
              Icons.grid_view_rounded,
              size: 90,
              color: Colors.white.withValues(alpha: 0.07),
            ),
          ),

          // CONTENT
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // BADGE "Fasilitas Terpilih"
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 6,
                ),
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.15),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.verified_rounded,
                      size: 14,
                      color: Colors.white.withValues(alpha: 0.9),
                    ),
                    const SizedBox(width: 5),
                    Text(
                      'Fasilitas Terpilih',
                      style: TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.w600,
                        color: Colors.white.withValues(alpha: 0.9),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 16),

              // NAMA RS
              Text(
                hospitalName,
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w800,
                  color: Colors.white,
                  height: 1.2,
                ),
              ),

              const SizedBox(height: 8),

              // LOKASI
              Row(
                children: [
                  Icon(
                    Icons.location_on_outlined,
                    size: 16,
                    color: Colors.white.withValues(alpha: 0.8),
                  ),
                  const SizedBox(width: 4),
                  Text(
                    '$hospitalLocation, Kabupaten Sragen',
                    style: TextStyle(
                      fontSize: 13,
                      color: Colors.white.withValues(alpha: 0.8),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  // ============================================================
  // DATA SUKOWATI
  // ============================================================
  static const List<KamarInfo> _kamarSukowati = [
    KamarInfo('ANGGREK', 'Kelas 1', 2, 0),
    KamarInfo('HCU', 'Kelas Utama', 2, 1),
    KamarInfo('Isolasi', 'Kelas Utama', 6, 0),
    KamarInfo('Kamar ICU', 'Kelas Utama', 5, 0),
    KamarInfo('Kamar Kelas I', 'Kelas 1', 7, 2),
    KamarInfo('Kamar Kelas II', 'Kelas 2', 12, 6),
    KamarInfo('Kamar Kelas III', 'Kelas 3', 26, 17),
    KamarInfo('Kamar Kelas VIP', 'Kelas VVIP', 1, 0),
    KamarInfo('Kamar NICU', 'Kelas Utama', 1, 0),
    KamarInfo('Kamar PICU', 'Kelas Utama', 1, 0),
    KamarInfo('Perina', 'Kelas Utama', 2, 0),
  ];

  static const List<InfoKamarItem> _infoSukowati = [
    InfoKamarItem(Icons.info_rounded,
        'Menampilkan jadwal praktek dokter dan ketersediaan kamar rawat inap RSUD Sukowati Tangen.'),
    InfoKamarItem(Icons.update_rounded,
        'Data diperbarui secara real-time dari sistem informasi rumah sakit.'),
    InfoKamarItem(Icons.phone_in_talk_outlined,
        'Hubungi RSUD Tangen untuk informasi reservasi dan pendaftaran pasien baru.'),
  ];

  // ============================================================
  // LAYANAN GRID (2x2 atau 1x2)
  // ============================================================

  Widget _buildLayananGrid(BuildContext context) {
    final bool isSukowati = hospitalName.contains('Sukowati');

    final List<_LayananItem> layananList = isSukowati
        ? [
            _LayananItem(
              title: 'Jadwal',
              subtitle: 'Cek jam praktik dokter spesialis',
              icon: Icons.calendar_view_month_rounded,
              iconBgColor: const Color(0xFFE8F5F1),
              iconColor: primaryGreen,
            ),
            _LayananItem(
              title: 'Info Kamar',
              subtitle: 'Pantau ranap secara real-time',
              icon: Icons.meeting_room_outlined,
              iconBgColor: const Color(0xFFFFF3E8),
              iconColor: const Color(0xFFD4770B),
            ),
          ]
        : [
            _LayananItem(
              title: 'Buat Reservasi',
              subtitle: 'Reservasi online cepat & mudah',
              icon: Icons.medical_services_outlined,
              iconBgColor: const Color(0xFFE8F5F1),
              iconColor: primaryGreen,
            ),
            _LayananItem(
              title: 'Jadwal',
              subtitle: 'Cek jam praktik dokter spesialis',
              icon: Icons.calendar_view_month_rounded,
              iconBgColor: const Color(0xFFE8F5F1),
              iconColor: primaryGreen,
            ),
            _LayananItem(
              title: 'Info Kamar',
              subtitle: 'Pantau ranap secara real-time',
              icon: Icons.meeting_room_outlined,
              iconBgColor: const Color(0xFFFFF3E8),
              iconColor: const Color(0xFFD4770B),
            ),
            _LayananItem(
              title: 'Cek/Batal Reservasi',
              subtitle: 'Kelola tiket & batal kunjungan',
              icon: Icons.history_rounded,
              iconBgColor: const Color(0xFFE8F5F1),
              iconColor: primaryGreen,
            ),
          ];

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: GridView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: layananList.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 14,
          mainAxisSpacing: 14,
          mainAxisExtent: 175,
        ),
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              if (layananList[index].title == 'Buat Reservasi') {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => ReservasiPoliScreen(
                      hospitalName: hospitalName,
                      hospitalLocation: hospitalLocation,
                    ),
                  ),
                );
              } else if (layananList[index].title == 'Cek/Batal Reservasi') {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => CekBatalScreen(
                      hospitalName: hospitalName,
                      hospitalLocation: hospitalLocation,
                    ),
                  ),
                );
              } else if (layananList[index].title == 'Jadwal') {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => JadwalDokterScreen(
                      hospitalName: hospitalName,
                      hospitalLocation: hospitalLocation,
                    ),
                  ),
                );
              } else if (layananList[index].title == 'Info Kamar') {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => isSukowati
                        ? InfoKamarScreen(
                            hospitalName: hospitalName,
                            hospitalLocation: hospitalLocation,
                            showRingkasan: true,
                            kamarList: _kamarSukowati,
                            infoItems: _infoSukowati,
                          )
                        : InfoKamarScreen(
                            hospitalName: hospitalName,
                            hospitalLocation: hospitalLocation,
                          ),
                  ),
                );
              }
            },
            child: _buildLayananCard(layananList[index]),
          );
        },
      ),
    );
  }

  Widget _buildLayananCard(_LayananItem item) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: cardBorder, width: 1),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.03),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ICON
          Container(
            width: 46,
            height: 46,
            decoration: BoxDecoration(
              color: item.iconBgColor,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(
              item.icon,
              size: 24,
              color: item.iconColor,
            ),
          ),

          const SizedBox(height: 14),

          // TITLE
          Text(
            item.title,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w700,
              color: darkText,
            ),
          ),

          const SizedBox(height: 4),

          // SUBTITLE
          Flexible(
            child: Text(
              item.subtitle,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                fontSize: 12,
                color: greyText,
                height: 1.3,
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ============================================================
  // INFO LAYANAN
  // ============================================================

  Widget _buildInfoLayanan() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 24),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: infoBg,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: infoBorder, width: 1),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // HEADER
          const Row(
            children: [
              Icon(
                Icons.info_rounded,
                size: 20,
                color: primaryGreen,
              ),
              SizedBox(width: 8),
              Text(
                'Informasi Layanan',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                  color: primaryGreen,
                ),
              ),
            ],
          ),

          const SizedBox(height: 16),

          // INFO 1
          _buildInfoItem(
            Icons.description_outlined,
            'Layanan ini khusus pasien lama yang sudah memiliki Nomor Rekam Medis (No RM).',
          ),

          const SizedBox(height: 12),

          // INFO 2
          _buildInfoItem(
            Icons.calendar_today_outlined,
            'Reservasi hanya dapat dilakukan minimal 1 hari sebelum tanggal kunjungan.',
          ),

          const SizedBox(height: 12),

          // INFO 3
          _buildInfoItem(
            Icons.confirmation_number_outlined,
            'Simpan Kode Booking untuk ditunjukkan kepada petugas di rumah sakit.',
          ),
        ],
      ),
    );
  }

  Widget _buildInfoItem(IconData icon, String text) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, size: 18, color: primaryGreen),
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
  // BOTTOM NAVIGATION (identik home_screen & agenda_screen)
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
              child: _navItem(
                context,
                Icons.home_outlined,
                Icons.home_rounded,
                'Beranda',
                false,
                () {
                  Navigator.popUntil(context, (route) => route.isFirst);
                },
              ),
            ),
            Expanded(
              child: _navItem(
                context,
                Icons.grid_view_rounded,
                Icons.grid_view_rounded,
                'Layanan',
                true,
                () {},
              ),
            ),
            Expanded(
              child: _navItem(
                context,
                Icons.calendar_month_outlined,
                Icons.calendar_month_rounded,
                'Agenda',
                false,
                () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => const AgendaScreen(),
                    ),
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
// LAYANAN ITEM MODEL
// ================================================================

class _LayananItem {
  final String title;
  final String subtitle;
  final IconData icon;
  final Color iconBgColor;
  final Color iconColor;

  const _LayananItem({
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.iconBgColor,
    required this.iconColor,
  });
}
