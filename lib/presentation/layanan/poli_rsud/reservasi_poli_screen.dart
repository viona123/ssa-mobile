import 'package:flutter/material.dart';
import '../../agenda/agenda_screen.dart';

// ================================================================
// BUAT RESERVASI - POLI RSUD
// Desain sesuai context/reservasi.png:
//  - Kartu RS terpilih (hijau)
//  - Data Pasien: input No RM + tombol Cari
//  - Informasi Layanan
// ================================================================

class ReservasiPoliScreen extends StatefulWidget {
  final String hospitalName;
  final String hospitalLocation;

  const ReservasiPoliScreen({
    super.key,
    required this.hospitalName,
    required this.hospitalLocation,
  });

  @override
  State<ReservasiPoliScreen> createState() => _ReservasiPoliScreenState();
}

class _ReservasiPoliScreenState extends State<ReservasiPoliScreen> {
  // ============================================================
  // COLORS
  // ============================================================
  static const Color primaryGreen = Color(0xFF1B6B5B);
  static const Color darkText = Color(0xFF202124);
  static const Color greyText = Color(0xFF737B86);
  static const Color pageBackground = Color(0xFFF8FAFC);
  static const Color cardBorder = Color(0xFFE8ECEF);
  static const Color infoBg = Color(0xFFF0FAF7);
  static const Color infoBorder = Color(0xFFB8E0D6);

  // Navbar colors (seragam layanan lain)
  static const Color lightBlue = Color(0xFF58D8EC);
  static const Color darkBlue = Color(0xFF315579);

  final TextEditingController _noRmController = TextEditingController();

  @override
  void dispose() {
    _noRmController.dispose();
    super.dispose();
  }

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
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                padding: const EdgeInsets.fromLTRB(20, 20, 20, 28),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildHospitalCard(),
                    const SizedBox(height: 20),
                    _buildDataPasienCard(),
                    const SizedBox(height: 20),
                    _buildInfoLayanan(),
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
              color: primaryGreen,
            ),
          ),
          const SizedBox(width: 16),
          const Text(
            'Reservasi',
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.w700,
              color: primaryGreen,
            ),
          ),
        ],
      ),
    );
  }

  // ============================================================
  // KARTU RS TERPILIH (hijau)
  // ============================================================
  Widget _buildHospitalCard() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color(0xFF1F7A68), Color(0xFF145047)],
        ),
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: primaryGreen.withValues(alpha: 0.2),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            width: 42,
            height: 42,
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.15),
              borderRadius: BorderRadius.circular(11),
            ),
            child: const Icon(
              Icons.local_hospital_rounded,
              size: 22,
              color: Colors.white,
            ),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.hospitalName,
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w700,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 3),
                Text(
                  '${widget.hospitalLocation}, Kabupaten Sragen',
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.white.withValues(alpha: 0.8),
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
  // KARTU DATA PASIEN
  // ============================================================
  Widget _buildDataPasienCard() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: cardBorder),
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
          // Judul "Data Pasien"
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                width: 42,
                height: 42,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: primaryGreen.withValues(alpha: 0.10),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Icon(Icons.person_outline_rounded,
                    size: 23, color: primaryGreen),
              ),
              const SizedBox(width: 12),
              const Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Data Pasien',
                      style: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.w800,
                        color: darkText,
                      ),
                    ),
                    SizedBox(height: 2),
                    Text(
                      'Masukkan nomor rekam medis Anda',
                      style: TextStyle(fontSize: 12, color: greyText),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 18),
          Row(
            children: const [
              Icon(Icons.badge_outlined, size: 15, color: primaryGreen),
              SizedBox(width: 6),
              Text(
                'Nomor Rekam Medis (No RM)',
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w700,
                  color: darkText,
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          // Input + tombol Cari
          Row(
            children: [
              Expanded(
                child: Container(
                  height: 52,
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  decoration: BoxDecoration(
                    color: const Color(0xFFF7F9FB),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: cardBorder),
                  ),
                  child: Row(
                    children: [
                      const Icon(Icons.badge_outlined,
                          size: 20, color: greyText),
                      const SizedBox(width: 8),
                      Expanded(
                        child: TextField(
                          controller: _noRmController,
                          keyboardType: TextInputType.number,
                          style: const TextStyle(
                              fontSize: 14, color: darkText),
                          decoration: const InputDecoration(
                            isCollapsed: true,
                            border: InputBorder.none,
                            hintText: 'Masukkan No Rekam Medis',
                            hintStyle:
                                TextStyle(fontSize: 13.5, color: greyText),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(width: 12),
              GestureDetector(
                onTap: _cariPasien,
                child: Container(
                  height: 52,
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: primaryGreen,
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(
                        color: primaryGreen.withValues(alpha: 0.25),
                        blurRadius: 8,
                        offset: const Offset(0, 3),
                      ),
                    ],
                  ),
                  child: const Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.search_rounded, size: 18, color: Colors.white),
                      SizedBox(width: 6),
                      Text(
                        'Cari',
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w800,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 14),
          // Catatan
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
            decoration: BoxDecoration(
              color: infoBg,
              borderRadius: BorderRadius.circular(11),
              border: Border.all(color: infoBorder),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Icon(Icons.info_outline_rounded,
                    size: 16, color: primaryGreen),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    'Pastikan nomor RM yang dimasukkan sudah sesuai dengan '
                    'kartu pasien Anda.',
                    style: TextStyle(
                      fontSize: 12,
                      color: darkText.withValues(alpha: 0.75),
                      height: 1.4,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _cariPasien() {
    FocusScope.of(context).unfocus();
    if (_noRmController.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Masukkan Nomor Rekam Medis terlebih dahulu.'),
          behavior: SnackBarBehavior.floating,
          duration: Duration(seconds: 2),
        ),
      );
      return;
    }
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: const Row(
          children: [
            Icon(Icons.search_rounded, color: primaryGreen),
            SizedBox(width: 10),
            Text('Mencari Data'),
          ],
        ),
        content: Text(
          'Data pasien dengan No RM ${_noRmController.text.trim()} sedang '
          'dicari pada sistem ${widget.hospitalName}.',
          style: const TextStyle(height: 1.5),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Tutup'),
          ),
        ],
      ),
    );
  }

  // ============================================================
  // INFORMASI LAYANAN
  // ============================================================
  Widget _buildInfoLayanan() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: infoBg,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: infoBorder),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Row(
            children: [
              Icon(Icons.info_rounded, size: 20, color: primaryGreen),
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
          _buildInfoItem(
            Icons.person_search_outlined,
            'Layanan ini khusus pasien lama yang sudah memiliki Nomor Rekam '
            'Medis (No RM).',
          ),
          const SizedBox(height: 12),
          _buildInfoItem(
            Icons.calendar_today_outlined,
            'Reservasi hanya dapat dilakukan minimal 1 hari sebelum tanggal '
            'kunjungan.',
          ),
          const SizedBox(height: 12),
          _buildInfoItem(
            Icons.qr_code_2_rounded,
            'Simpan Kode Booking untuk ditunjukkan kepada petugas di rumah '
            'sakit.',
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
              height: 1.45,
            ),
          ),
        ),
      ],
    );
  }

  // ============================================================
  // BOTTOM NAVIGATION (seragam layanan lain)
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




