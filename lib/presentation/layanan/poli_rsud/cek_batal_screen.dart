import 'package:flutter/material.dart';
import '../../agenda/agenda_screen.dart';

// ================================================================
// CEK / BATAL RESERVASI - POLI RSUD
// Cari reservasi dengan Kode Booking, lihat detail, dan batalkan.
// ================================================================

class CekBatalScreen extends StatefulWidget {
  final String hospitalName;
  final String hospitalLocation;

  const CekBatalScreen({
    super.key,
    required this.hospitalName,
    required this.hospitalLocation,
  });

  @override
  State<CekBatalScreen> createState() => _CekBatalScreenState();
}

class _CekBatalScreenState extends State<CekBatalScreen> {
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
  static const Color danger = Color(0xFFD92D2D);

  // Navbar colors (seragam layanan lain)
  static const Color lightBlue = Color(0xFF58D8EC);
  static const Color darkBlue = Color(0xFF315579);

  final TextEditingController _kodeController = TextEditingController();

  // Reservasi yang ditemukan (simulasi)
  _Reservasi? _hasil;
  bool _dibatalkan = false;

  @override
  void dispose() {
    _kodeController.dispose();
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
                    _buildCariCard(),
                    if (_hasil != null) ...[
                      const SizedBox(height: 20),
                      _buildHasilCard(),
                    ],
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
          const Expanded(
            child: Text(
              'Cek / Batal Reservasi',
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w700,
                color: primaryGreen,
              ),
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
            color: primaryGreen.withValues(alpha: 0.25),
            blurRadius: 16,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            width: 56,
            height: 56,
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.18),
              borderRadius: BorderRadius.circular(16),
            ),
            child: const Icon(
              Icons.medical_services_rounded,
              size: 28,
              color: Colors.white,
            ),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'RUMAH SAKIT TERPILIH',
                  style: TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.w700,
                    letterSpacing: 0.6,
                    color: Colors.white.withValues(alpha: 0.75),
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  widget.hospitalName,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w800,
                    color: Colors.white,
                    height: 1.2,
                  ),
                ),
                const SizedBox(height: 6),
                Row(
                  children: [
                    Icon(
                      Icons.location_on_outlined,
                      size: 14,
                      color: Colors.white.withValues(alpha: 0.85),
                    ),
                    const SizedBox(width: 4),
                    Expanded(
                      child: Text(
                        '${widget.hospitalLocation}, Kabupaten Sragen, Jawa Tengah',
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.white.withValues(alpha: 0.85),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // ============================================================
  // KARTU CARI KODE BOOKING
  // ============================================================
  Widget _buildCariCard() {
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
          Row(
            children: [
              const Text(
                '1.',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w800,
                  color: primaryGreen,
                ),
              ),
              const SizedBox(width: 8),
              const Text(
                'Kode Booking',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w800,
                  color: darkText,
                ),
              ),
            ],
          ),
          const SizedBox(height: 18),
          const Text(
            'Masukkan Kode Booking',
            style: TextStyle(
              fontSize: 13.5,
              fontWeight: FontWeight.w600,
              color: darkText,
            ),
          ),
          const SizedBox(height: 10),
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
                      const Icon(Icons.qr_code_2_rounded,
                          size: 20, color: greyText),
                      const SizedBox(width: 8),
                      Expanded(
                        child: TextField(
                          controller: _kodeController,
                          textCapitalization:
                              TextCapitalization.characters,
                          style: const TextStyle(
                              fontSize: 14, color: darkText),
                          decoration: const InputDecoration(
                            isCollapsed: true,
                            border: InputBorder.none,
                            hintText: 'Contoh: BK-2026-0001',
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
                onTap: _cariReservasi,
                child: Container(
                  height: 52,
                  padding: const EdgeInsets.symmetric(horizontal: 22),
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
                  child: const Text(
                    'Cek',
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w800,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Icon(Icons.info_outline_rounded,
                  size: 16, color: greyText),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  'Kode Booking terdapat pada bukti reservasi yang Anda '
                  'terima saat mendaftar.',
                  style: TextStyle(
                    fontSize: 12,
                    color: greyText,
                    height: 1.4,
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
  // KARTU HASIL RESERVASI
  // ============================================================
  Widget _buildHasilCard() {
    final r = _hasil!;
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(
          color: _dibatalkan ? danger.withValues(alpha: 0.4) : cardBorder,
        ),
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
          Row(
            children: [
              const Text(
                'Detail Reservasi',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w800,
                  color: darkText,
                ),
              ),
              const Spacer(),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                decoration: BoxDecoration(
                  color: _dibatalkan
                      ? danger.withValues(alpha: 0.12)
                      : primaryGreen.withValues(alpha: 0.12),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  _dibatalkan ? 'Dibatalkan' : 'Terjadwal',
                  style: TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.w800,
                    color: _dibatalkan ? danger : primaryGreen,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          _detailRow('Kode Booking', r.kode),
          _detailRow('Nama Pasien', r.nama),
          _detailRow('Poliklinik', r.poli),
          _detailRow('Dokter', r.dokter),
          _detailRow('Tanggal', r.tanggal),
          _detailRow('No. Antrian', r.antrian),
          const SizedBox(height: 8),
          if (!_dibatalkan)
            SizedBox(
              width: double.infinity,
              child: GestureDetector(
                onTap: _konfirmasiBatal,
                child: Container(
                  height: 48,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: danger.withValues(alpha: 0.10),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: danger.withValues(alpha: 0.4)),
                  ),
                  child: const Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.cancel_outlined, size: 18, color: danger),
                      SizedBox(width: 8),
                      Text(
                        'Batalkan Reservasi',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w800,
                          color: danger,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            )
          else
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: danger.withValues(alpha: 0.06),
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Row(
                children: [
                  Icon(Icons.check_circle_outline, size: 18, color: danger),
                  SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      'Reservasi ini telah dibatalkan.',
                      style: TextStyle(
                        fontSize: 12.5,
                        fontWeight: FontWeight.w600,
                        color: danger,
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

  Widget _detailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 110,
            child: Text(
              label,
              style: const TextStyle(fontSize: 13, color: greyText),
            ),
          ),
          const Text(': ', style: TextStyle(fontSize: 13, color: greyText)),
          Expanded(
            child: Text(
              value,
              style: const TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w700,
                color: darkText,
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _cariReservasi() {
    FocusScope.of(context).unfocus();
    final kode = _kodeController.text.trim();
    if (kode.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Masukkan Kode Booking terlebih dahulu.'),
          behavior: SnackBarBehavior.floating,
          duration: Duration(seconds: 2),
        ),
      );
      return;
    }
    setState(() {
      _dibatalkan = false;
      _hasil = _Reservasi(
        kode: kode.toUpperCase(),
        nama: 'Budi Santoso',
        poli: 'Poli Penyakit Dalam',
        dokter: 'dr. Andi Wijaya, Sp.PD',
        tanggal: 'Senin, 31 Agustus 2026',
        antrian: 'A-014',
      );
    });
  }

  void _konfirmasiBatal() {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: const Row(
          children: [
            Icon(Icons.cancel_outlined, color: danger),
            SizedBox(width: 10),
            Text('Batalkan Reservasi'),
          ],
        ),
        content: const Text(
          'Apakah Anda yakin ingin membatalkan reservasi ini? Tindakan ini '
          'tidak dapat dibatalkan.',
          style: TextStyle(height: 1.5),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Tidak'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              setState(() => _dibatalkan = true);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Reservasi berhasil dibatalkan.'),
                  behavior: SnackBarBehavior.floating,
                  duration: Duration(seconds: 2),
                ),
              );
            },
            child: const Text(
              'Ya, Batalkan',
              style:
                  TextStyle(color: danger, fontWeight: FontWeight.w700),
            ),
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
            Icons.qr_code_2_rounded,
            'Gunakan Kode Booking untuk mengecek status reservasi Anda.',
          ),
          const SizedBox(height: 12),
          _buildInfoItem(
            Icons.event_busy_outlined,
            'Pembatalan sebaiknya dilakukan minimal 1 hari sebelum tanggal '
            'kunjungan.',
          ),
          const SizedBox(height: 12),
          _buildInfoItem(
            Icons.phone_in_talk_outlined,
            'Untuk kendala pembatalan, hubungi bagian pendaftaran rumah '
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

// ================================================================
// MODEL RESERVASI
// ================================================================
class _Reservasi {
  final String kode;
  final String nama;
  final String poli;
  final String dokter;
  final String tanggal;
  final String antrian;

  const _Reservasi({
    required this.kode,
    required this.nama,
    required this.poli,
    required this.dokter,
    required this.tanggal,
    required this.antrian,
  });
}
