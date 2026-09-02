import 'package:flutter/material.dart';
import '../../agenda/agenda_screen.dart';
import '../../bantuan/bantuan_screen.dart';
import 'poli_rsud_detail_screen.dart';

// ================================================================
// POLI RSUD - RESERVASI POLIKLINIK ONLINE
// Desain sesuai context/poli1.png
// ================================================================

class PoliRsudScreen extends StatefulWidget {
  const PoliRsudScreen({super.key});

  @override
  State<PoliRsudScreen> createState() => _PoliRsudScreenState();
}

class _PoliRsudScreenState extends State<PoliRsudScreen> {
  // ============================================================
  // COLORS
  // ============================================================

  static const Color primaryGreen = Color(0xFF1B6B5B);
  static const Color mintGreen = Color(0xFFE8F5F1);
  static const Color mintGreenBorder = Color(0xFFB8E0D6);
  static const Color darkText = Color(0xFF202124);
  static const Color greyText = Color(0xFF737B86);
  static const Color pageBackground = Color(0xFFF8FAFC);
  static const Color cardBorder = Color(0xFFE5E9EE);
  static const Color infoBg = Color(0xFFF0FAF7);
  static const Color infoBorder = Color(0xFFB8E0D6);

  // Navbar colors (sama persis seperti home_screen & agenda_screen)
  static const Color primaryBlue = Color(0xFF007EA7);
  static const Color lightBlue = Color(0xFF58D8EC);
  static const Color darkBlue = Color(0xFF315579);

  // ============================================================
  // STATE
  // ============================================================

  int _selectedHospital = 0; // default pilih RS pertama

  // ============================================================
  // DATA RUMAH SAKIT
  // ============================================================

  final List<_HospitalItem> _hospitals = [
    _HospitalItem(
      name: 'RSUD Soehadi Prijonegoro',
      location: 'Sragen Kota',
      icon: Icons.calendar_view_month_rounded,
    ),
    _HospitalItem(
      name: 'RSUD dr. Soeratno',
      location: 'Gemolong',
      icon: Icons.local_hospital_outlined,
    ),
    _HospitalItem(
      name: 'RSUD Sukowati',
      location: 'Tangen',
      icon: Icons.medical_services_outlined,
    ),
  ];

  // ============================================================
  // BUILD
  // ============================================================

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: pageBackground,
      bottomNavigationBar: _buildBottomNavigation(),
      body: SafeArea(
        child: Stack(
          children: [
            Column(
          children: [
            // HEADER
            _buildHeader(),

            // SCROLLABLE CONTENT
            Expanded(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                padding: const EdgeInsets.only(bottom: 30),
                child: Column(
                  children: [
                    // ==========================================
                    // GRADIENT HIJAU -> PUTIH (BACKGROUND ATAS)
                    // ==========================================
                    Container(
                      width: double.infinity,
                      decoration: const BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            Color(0xFFE8F8F4), // hijau muda atas
                            Color(0xFFF2FBF8), // hijau sangat muda
                            Color(0xFFF8FAFC), // putih bawah (pageBackground)
                          ],
                          stops: [0.0, 0.6, 1.0],
                        ),
                      ),
                      child: Column(
                        children: [
                          const SizedBox(height: 24),

                          // BADGE
                          _buildBadge(),

                          const SizedBox(height: 16),

                          // TITLE
                          _buildTitle(),

                          const SizedBox(height: 12),

                          // DESCRIPTION
                          _buildDescription(),

                          const SizedBox(height: 28),
                        ],
                      ),
                    ),

                    // HOSPITAL CARDS
                    ..._buildHospitalCards(),

                    const SizedBox(height: 24),

                    // INFO LAYANAN
                    _buildInfoLayanan(),

                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ),
          ],
            ),

            // Tombol Pusat Bantuan
            Positioned(right: 26, bottom: 14, child: _buildHelpButton()),
          ],
        ),
      ),
    );
  }

  // ============================================================
  // PUSAT BANTUAN
  // ============================================================
  Widget _buildHelpButton() {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: BorderRadius.circular(16),
        onTap: () => Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => const BantuanScreen()),
        ),
        child: Container(
          width: 58,
          height: 58,
          decoration: BoxDecoration(
            color: primaryBlue,
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.16),
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: const Icon(
            Icons.support_agent_rounded,
            size: 27,
            color: Colors.white,
          ),
        ),
      ),
    );
  }

  // ============================================================
  // HEADER
  // ============================================================

  Widget _buildHeader() {
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
  // BADGE
  // ============================================================

  Widget _buildBadge() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: mintGreen,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: mintGreenBorder, width: 1),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.medical_services_outlined,
            size: 16,
            color: primaryGreen,
          ),
          const SizedBox(width: 6),
          const Text(
            'LAYANAN KESEHATAN RSUD',
            style: TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.w700,
              color: primaryGreen,
              letterSpacing: 0.5,
            ),
          ),
        ],
      ),
    );
  }

  // ============================================================
  // TITLE
  // ============================================================

  Widget _buildTitle() {
    return const Padding(
      padding: EdgeInsets.symmetric(horizontal: 40),
      child: Text(
        'Reservasi Poliklinik\nOnline',
        textAlign: TextAlign.center,
        style: TextStyle(
          fontSize: 28,
          fontWeight: FontWeight.w800,
          color: darkText,
          height: 1.2,
        ),
      ),
    );
  }

  // ============================================================
  // DESCRIPTION
  // ============================================================

  Widget _buildDescription() {
    return const Padding(
      padding: EdgeInsets.symmetric(horizontal: 40),
      child: Text(
        'Daftar periksa secara online ke RSUD Kabupaten Sragen tanpa perlu antre panjang di loket.',
        textAlign: TextAlign.center,
        style: TextStyle(
          fontSize: 14,
          color: greyText,
          height: 1.5,
        ),
      ),
    );
  }

  // ============================================================
  // HOSPITAL CARDS
  // ============================================================

  List<Widget> _buildHospitalCards() {
    return List.generate(_hospitals.length, (index) {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 6),
        child: _buildHospitalCard(index),
      );
    });
  }

  Widget _buildHospitalCard(int index) {
    final bool isSelected = _selectedHospital == index;
    final hospital = _hospitals[index];

    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedHospital = index;
        });
        // Delay sebentar biar animasi select terlihat dulu
        Future.delayed(const Duration(milliseconds: 350), () {
          if (!mounted) return;
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => PoliRsudDetailScreen(
                hospitalName: hospital.name,
                hospitalLocation: hospital.location,
              ),
            ),
          );
        });
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        width: double.infinity,
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(
            color: isSelected ? primaryGreen : cardBorder,
            width: isSelected ? 2 : 1,
          ),
          boxShadow: [
            if (isSelected)
              BoxShadow(
                color: primaryGreen.withValues(alpha: 0.08),
                blurRadius: 12,
                offset: const Offset(0, 4),
              ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // TOP ROW - Icon & Check
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // ICON
                Container(
                  width: 44,
                  height: 44,
                  decoration: BoxDecoration(
                    color: isSelected
                        ? mintGreen
                        : const Color(0xFFEFF1F4),
                    borderRadius: BorderRadius.circular(11),
                  ),
                  child: Icon(
                    hospital.icon,
                    size: 22,
                    color: isSelected ? primaryGreen : greyText,
                  ),
                ),

                // CHECK ICON
                if (isSelected)
                  Container(
                    width: 26,
                    height: 26,
                    decoration: const BoxDecoration(
                      color: primaryGreen,
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.check,
                      size: 15,
                      color: Colors.white,
                    ),
                  ),
              ],
            ),

            const SizedBox(height: 12),

            // NAMA RS
            Text(
              hospital.name,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w700,
                color: darkText,
              ),
            ),

            const SizedBox(height: 3),

            // LOKASI
            Row(
              children: [
                const Icon(
                  Icons.location_on,
                  size: 13,
                  color: greyText,
                ),
                const SizedBox(width: 3),
                Text(
                  hospital.location,
                  style: const TextStyle(
                    fontSize: 12,
                    color: greyText,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 14),

            // BUTTON PILIH RS
            SizedBox(
              width: double.infinity,
              height: 40,
              child: ElevatedButton(
                onPressed: () {
                  setState(() {
                    _selectedHospital = index;
                  });
                  // Delay sebentar biar animasi select terlihat
                  Future.delayed(const Duration(milliseconds: 350), () {
                    if (!mounted) return;
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => PoliRsudDetailScreen(
                          hospitalName: hospital.name,
                          hospitalLocation: hospital.location,
                        ),
                      ),
                    );
                  });
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor:
                      isSelected ? primaryGreen : const Color(0xFFEFF1F4),
                  foregroundColor: isSelected ? Colors.white : greyText,
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: Text(
                  'Pilih RS',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                    color: isSelected ? Colors.white : greyText,
                  ),
                ),
              ),
            ),
          ],
        ),
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
          Row(
            children: [
              Icon(
                Icons.info_rounded,
                size: 20,
                color: primaryGreen,
              ),
              const SizedBox(width: 8),
              const Text(
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

  Widget _buildBottomNavigation() {
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
                () => Navigator.popUntil(context, (route) => route.isFirst),
              ),
            ),
            Expanded(
              child: _navItem(
                Icons.grid_view_rounded,
                Icons.grid_view_rounded,
                'Layanan',
                true,
                () {},
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
// HOSPITAL MODEL
// ================================================================

class _HospitalItem {
  final String name;
  final String location;
  final IconData icon;

  const _HospitalItem({
    required this.name,
    required this.location,
    required this.icon,
  });
}
