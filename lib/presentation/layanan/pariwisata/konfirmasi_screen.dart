import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'pembayaran_screen.dart';

class KonfirmasiScreen extends StatelessWidget {
  final String namaWisata;
  final String lokasi;
  final String namaLengkap;
  final String email;
  final DateTime tanggalKunjungan;
  final int jumlahTiket;
  final String jenisTiket;
  final String metodePembayaran;
  final int hargaSatuan;

  const KonfirmasiScreen({
    super.key,
    required this.namaWisata,
    required this.lokasi,
    required this.namaLengkap,
    required this.email,
    required this.tanggalKunjungan,
    required this.jumlahTiket,
    required this.jenisTiket,
    required this.metodePembayaran,
    this.hargaSatuan = 5000,
  });

  // ============================================================
  // COLORS
  // ============================================================
  static const Color primaryBlue = Color(0xFF007EA7);
  static const Color darkText = Color(0xFF202124);
  static const Color greyText = Color(0xFF737B86);
  static const Color pageBackground = Color(0xFFF8FAFC);

  // ============================================================
  // DISKON — hanya berlaku untuk Gunung Kemukus + tiket Pelajar
  // ============================================================
  bool get _diskonBerlaku =>
      namaWisata == 'Gunung Kemukus' && jenisTiket == 'Pelajar';

  // ============================================================
  // BUILD
  // ============================================================
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: pageBackground,
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    // Header
                    _buildHeader(),

                    const SizedBox(height: 24),

                    // Stepper
                    _buildStepper(),

                    const SizedBox(height: 24),

                    // Success Banner
                    _buildSuccessBanner(),

                    const SizedBox(height: 20),

                    // Nota Details Card
                    _buildNotaCard(),

                    const SizedBox(height: 16),

                    // Rincian Biaya Card
                    _buildRincianBiayaCard(),

                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ),

            // Bottom Buttons
            _buildBottomButtons(context),
          ],
        ),
      ),
    );
  }

  // ============================================================
  // HEADER
  // ============================================================
  Widget _buildHeader() {
    return Column(
      children: [
        const Text(
          'E-Tiket Wisata Sragen',
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.w800,
            color: darkText,
          ),
        ),
        const SizedBox(height: 6),
        Text(
          'Layanan Pembelian Tiket Wisata Online Kabupaten Sragen',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 13,
            color: greyText.withValues(alpha: 0.9),
          ),
        ),
      ],
    );
  }

  // ============================================================
  // STEPPER (Pilih ✓, Isi Data ✓, Konfirmasi active, Pembayaran)
  // ============================================================
  Widget _buildStepper() {
    final steps = [
      _StepInfo(label: 'Pilih Destinasi', icon: Icons.location_on, isCompleted: true),
      _StepInfo(label: 'Isi Data', icon: Icons.edit_note, isCompleted: true),
      _StepInfo(label: 'Konfirmasi', icon: Icons.description_outlined, isCompleted: true, isActive: true),
      _StepInfo(label: 'Pembayaran', icon: Icons.payment_outlined, isCompleted: false),
    ];

    return Row(
      children: List.generate(steps.length * 2 - 1, (index) {
        if (index.isOdd) {
          final int stepBefore = index ~/ 2;
          final bool isCompletedLine = steps[stepBefore].isCompleted;
          return Expanded(
            child: Container(
              height: 3,
              color: isCompletedLine ? primaryBlue : const Color(0xFFE0E0E0),
            ),
          );
        }

        final step = steps[index ~/ 2];
        return _buildStepIcon(step);
      }),
    );
  }

  Widget _buildStepIcon(_StepInfo step) {
    final bool filled = step.isCompleted || step.isActive;
    return Column(
      children: [
        Container(
          width: 36,
          height: 36,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: filled ? primaryBlue : Colors.white,
            border: Border.all(
              color: filled ? primaryBlue : const Color(0xFFBDBDBD),
              width: 2,
            ),
          ),
          child: Center(
            child: Icon(
              step.icon,
              size: 18,
              color: filled ? Colors.white : const Color(0xFFBDBDBD),
            ),
          ),
        ),
        const SizedBox(height: 6),
        Text(
          step.label,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 9,
            fontWeight: filled ? FontWeight.w600 : FontWeight.w400,
            color: filled ? primaryBlue : greyText,
          ),
        ),
      ],
    );
  }

  // ============================================================
  // SUCCESS BANNER
  // ============================================================
  Widget _buildSuccessBanner() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 24),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color(0xFF007EA7), Color(0xFF00B4D8)],
        ),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF007EA7).withValues(alpha: 0.3),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: const Column(
        children: [
          Icon(
            Icons.check_circle_outline,
            size: 40,
            color: Colors.white,
          ),
          SizedBox(height: 10),
          Text(
            'Tiket Berhasil Dibuat',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w700,
              color: Colors.white,
            ),
          ),
          SizedBox(height: 4),
          Text(
            'Silakan lanjutkan ke pembayaran',
            style: TextStyle(
              fontSize: 13,
              color: Colors.white70,
            ),
          ),
        ],
      ),
    );
  }

  // ============================================================
  // NOTA DETAILS CARD
  // ============================================================
  Widget _buildNotaCard() {
    final String noNota = _generateNoNota();
    final String idBilling = _generateIdBilling();
    final String tanggalFormatted = _formatTanggal(tanggalKunjungan);

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: const Color(0xFFE8E8E8)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.03),
            blurRadius: 6,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          _buildNotaRow('No Nota', noNota, isBold: false),
          const SizedBox(height: 14),
          _buildNotaRow('ID Billing', idBilling, isHighlight: true),
          const SizedBox(height: 14),
          _buildNotaRow('Destinasi', namaWisata, isBold: true),
          const SizedBox(height: 14),
          _buildNotaRow('Tanggal Kunjungan', tanggalFormatted, isBold: false),
        ],
      ),
    );
  }

  Widget _buildNotaRow(String label, String value, {bool isBold = false, bool isHighlight = false}) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 130,
          child: Text(
            label,
            style: const TextStyle(
              fontSize: 13,
              color: greyText,
            ),
          ),
        ),
        Expanded(
          child: Text(
            value,
            style: TextStyle(
              fontSize: 13,
              fontWeight: (isBold || isHighlight) ? FontWeight.w700 : FontWeight.w500,
              color: isHighlight ? primaryBlue : darkText,
            ),
          ),
        ),
      ],
    );
  }

  // ============================================================
  // RINCIAN BIAYA CARD
  // ============================================================
  Widget _buildRincianBiayaCard() {
    final int totalBayar = hargaSatuan * jumlahTiket;
    final String diskon = _diskonBerlaku ? '50%' : '0%';
    final int totalSetelahDiskon =
        _diskonBerlaku ? (totalBayar * 0.5).toInt() : totalBayar;

    final formatter = NumberFormat('#,###', 'id_ID');

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: const Color(0xFFE8E8E8)),
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
          // Title
          const Text(
            'Rincian Biaya',
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w700,
              color: darkText,
            ),
          ),

          const SizedBox(height: 16),

          // Divider
          Container(height: 1, color: const Color(0xFFEEEEEE)),

          const SizedBox(height: 16),

          // Harga Satuan
          _buildBiayaRow('Harga Satuan', 'Rp ${formatter.format(hargaSatuan)}'),
          const SizedBox(height: 10),

          // Jumlah
          _buildBiayaRow('Jumlah', '$jumlahTiket orang'),
          const SizedBox(height: 10),

          // Diskon
          _buildBiayaRow('Diskon', diskon, valueColor: const Color(0xFF00B4D8)),
          const SizedBox(height: 10),

          // Metode Bayar
          _buildBiayaRow('Metode Bayar', metodePembayaran.contains('QRIS') ? 'QRis' : 'Transfer Bank Jateng'),

          const SizedBox(height: 16),

          // Divider
          Container(height: 1, color: const Color(0xFFEEEEEE)),

          const SizedBox(height: 16),

          // Total Bayar
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Total Bayar',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                  color: darkText,
                ),
              ),
              Text(
                'Rp ${formatter.format(totalSetelahDiskon)}',
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w800,
                  color: Color(0xFF00B4D8),
                  fontStyle: FontStyle.italic,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildBiayaRow(String label, String value, {Color? valueColor}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 13,
            color: greyText,
          ),
        ),
        Text(
          value,
          style: TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w500,
            color: valueColor ?? darkText,
          ),
        ),
      ],
    );
  }

  // ============================================================
  // BOTTOM BUTTONS (Batal & Bayar Sekarang)
  // ============================================================
  Widget _buildBottomButtons(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.06),
            blurRadius: 8,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: Row(
        children: [
          // Batal
          Expanded(
            flex: 2,
            child: OutlinedButton(
              onPressed: () {
                // Kembali ke halaman pariwisata
                Navigator.of(context).popUntil((route) => route.isFirst || route.settings.name == '/pariwisata');
                // Jika belum sampai, pop 2x
                if (Navigator.of(context).canPop()) {
                  Navigator.of(context).pop();
                  Navigator.of(context).pop();
                }
              },
              style: OutlinedButton.styleFrom(
                backgroundColor: Colors.white,
                foregroundColor: primaryBlue,
                side: const BorderSide(color: primaryBlue, width: 1.4),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                padding: const EdgeInsets.symmetric(vertical: 14),
              ),
              child: const Text(
                'Batal',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),

          const SizedBox(width: 14),

          // Bayar Sekarang
          Expanded(
            flex: 3,
            child: ElevatedButton.icon(
              onPressed: () {
                final int totalBayar = hargaSatuan * jumlahTiket;
                final int totalSetelahDiskon =
                    _diskonBerlaku ? (totalBayar * 0.5).toInt() : totalBayar;
                final String noNota = _generateNoNota();
                final String idBilling = _generateIdBilling();

                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => PembayaranScreen(
                      namaWisata: namaWisata,
                      noNota: noNota,
                      idBilling: idBilling,
                      tanggalKunjungan: tanggalKunjungan,
                      totalBayar: totalSetelahDiskon,
                      metodePembayaran: metodePembayaran,
                      namaLengkap: namaLengkap,
                      email: email,
                      jumlahTiket: jumlahTiket,
                      hargaSatuan: totalSetelahDiskon ~/ jumlahTiket,
                    ),
                  ),
                );
              },
              icon: const Icon(Icons.payment_outlined, size: 20),
              label: const Text(
                'Bayar Sekarang',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: primaryBlue,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                padding: const EdgeInsets.symmetric(vertical: 14),
                elevation: 0,
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ============================================================
  // HELPER METHODS
  // ============================================================
  String _generateNoNota() {
    final now = DateTime.now();
    return 'OL${now.year}${now.month.toString().padLeft(2, '0')}${now.day.toString().padLeft(2, '0')}${now.hour.toString().padLeft(2, '0')}${now.minute.toString().padLeft(2, '0')}${now.second.toString().padLeft(2, '0')}';
  }

  String _generateIdBilling() {
    final now = DateTime.now();
    return '${now.day.toString().padLeft(2, '0')}01${now.month.toString().padLeft(2, '0')}${now.second.toString().padLeft(2, '0')}${now.millisecond.toString().padLeft(3, '0')}';
  }

  String _formatTanggal(DateTime date) {
    final List<String> hariList = [
      'Senin', 'Selasa', 'Rabu', 'Kamis', 'Jumat', 'Sabtu', 'Minggu'
    ];
    final List<String> bulanList = [
      'Januari', 'Februari', 'Maret', 'April', 'Mei', 'Juni',
      'Juli', 'Agustus', 'September', 'Oktober', 'November', 'Desember'
    ];

    final String hari = hariList[date.weekday - 1];
    final String bulan = bulanList[date.month - 1];
    return '$hari, ${date.day} $bulan ${date.year}';
  }
}

// ================================================================
// STEP INFO MODEL
// ================================================================
class _StepInfo {
  final String label;
  final IconData icon;
  final bool isCompleted;
  final bool isActive;

  const _StepInfo({
    required this.label,
    required this.icon,
    required this.isCompleted,
    this.isActive = false,
  });
}
