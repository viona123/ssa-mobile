import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'etiket_screen.dart';

class PembayaranScreen extends StatelessWidget {
  final String namaWisata;
  final String noNota;
  final String idBilling;
  final DateTime tanggalKunjungan;
  final int totalBayar;
  final String metodePembayaran;
  final String namaLengkap;
  final String email;
  final int jumlahTiket;
  final int hargaSatuan;

  const PembayaranScreen({
    super.key,
    required this.namaWisata,
    required this.noNota,
    required this.idBilling,
    required this.tanggalKunjungan,
    required this.totalBayar,
    required this.metodePembayaran,
    this.namaLengkap = '',
    this.email = '',
    this.jumlahTiket = 1,
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

                    // QR Code Section
                    _buildQRCodeSection(),

                    const SizedBox(height: 16),

                    // Info Text
                    _buildInfoText(),

                    const SizedBox(height: 20),

                    // Nota Summary
                    _buildNotaSummary(),

                    const SizedBox(height: 24),
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
  // STEPPER (All completed, Pembayaran active)
  // ============================================================
  Widget _buildStepper() {
    final steps = [
      _StepInfo(label: 'Pilih Destinasi', icon: Icons.location_on, isCompleted: true),
      _StepInfo(label: 'Isi Data', icon: Icons.edit_note, isCompleted: true),
      _StepInfo(label: 'Konfirmasi', icon: Icons.description_outlined, isCompleted: true),
      _StepInfo(label: 'Pembayaran', icon: Icons.payment_outlined, isCompleted: true, isActive: true),
    ];

    return Row(
      children: List.generate(steps.length * 2 - 1, (index) {
        if (index.isOdd) {
          return Expanded(
            child: Container(
              height: 3,
              color: primaryBlue,
            ),
          );
        }

        final step = steps[index ~/ 2];
        return _buildStepIcon(step);
      }),
    );
  }

  Widget _buildStepIcon(_StepInfo step) {
    return Column(
      children: [
        Container(
          width: 36,
          height: 36,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: primaryBlue,
            border: Border.all(color: primaryBlue, width: 2),
            boxShadow: step.isActive
                ? [
                    BoxShadow(
                      color: primaryBlue.withValues(alpha: 0.3),
                      blurRadius: 8,
                      offset: const Offset(0, 2),
                    ),
                  ]
                : null,
          ),
          child: Center(
            child: Icon(
              step.icon,
              size: 18,
              color: Colors.white,
            ),
          ),
        ),
        const SizedBox(height: 6),
        Text(
          step.label,
          textAlign: TextAlign.center,
          style: const TextStyle(
            fontSize: 9,
            fontWeight: FontWeight.w600,
            color: primaryBlue,
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
      padding: const EdgeInsets.symmetric(vertical: 22),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color(0xFF00C9A7), Color(0xFF00B4D8)],
        ),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF00C9A7).withValues(alpha: 0.3),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          const Icon(
            Icons.check_circle_outline,
            size: 38,
            color: Colors.white,
          ),
          const SizedBox(height: 10),
          const Text(
            'Transaksi Sukses',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w700,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            'Bayar via QRis - ID Billing: $idBilling',
            style: const TextStyle(
              fontSize: 12,
              color: Colors.white70,
            ),
          ),
        ],
      ),
    );
  }

  // ============================================================
  // QR CODE SECTION
  // ============================================================
  Widget _buildQRCodeSection() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFE8E8E8)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.04),
            blurRadius: 8,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        children: [
          // Billing ID
          RichText(
            text: TextSpan(
              text: 'Billing: ',
              style: const TextStyle(
                fontSize: 14,
                color: greyText,
              ),
              children: [
                TextSpan(
                  text: idBilling,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    color: primaryBlue,
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 20),

          // QR Code Placeholder
          Container(
            width: 220,
            height: 220,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: const Color(0xFFE0E0E0), width: 2),
            ),
            child: Stack(
              alignment: Alignment.center,
              children: [
                // QR Code pattern placeholder
                CustomPaint(
                  size: const Size(200, 200),
                  painter: _QRCodePainter(),
                ),
                // Center logo
                Container(
                  width: 44,
                  height: 44,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.1),
                        blurRadius: 4,
                      ),
                    ],
                  ),
                  child: const Center(
                    child: Icon(
                      Icons.qr_code_2,
                      size: 30,
                      color: primaryBlue,
                    ),
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 14),

          // OWI Label
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            decoration: BoxDecoration(
              color: const Color(0xFFF0F7FA),
              borderRadius: BorderRadius.circular(8),
            ),
            child: const Text(
              'OWI - OBJEK WISATA\nKAB SRAGEN',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w700,
                color: darkText,
                height: 1.4,
              ),
            ),
          ),

          const SizedBox(height: 16),

          // Scan instruction
          const Text(
            'Scan QR Code di atas untuk pembayaran',
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: darkText,
            ),
          ),
          const SizedBox(height: 4),
          const Text(
            'Simpan Billing untuk menyimpan tiket',
            style: TextStyle(
              fontSize: 11,
              color: greyText,
            ),
          ),
          const SizedBox(height: 8),
          const Text(
            'Masa berlaku QRis: 5 menit',
            style: TextStyle(
              fontSize: 11,
              color: Color(0xFF00B4D8),
              fontStyle: FontStyle.italic,
            ),
          ),
        ],
      ),
    );
  }

  // ============================================================
  // INFO TEXT
  // ============================================================
  Widget _buildInfoText() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: Text(
        'Segera bayar tagihan Anda melalui QRis, kemudian tiket dapat diterbitkan setelah dilakukan pembayaran.',
        textAlign: TextAlign.center,
        style: TextStyle(
          fontSize: 12,
          color: greyText.withValues(alpha: 0.9),
          height: 1.5,
        ),
      ),
    );
  }

  // ============================================================
  // NOTA SUMMARY
  // ============================================================
  Widget _buildNotaSummary() {
    final formatter = NumberFormat('#,###', 'id_ID');
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
          // Row 1: No Nota & Destinasi
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'No Nota',
                      style: TextStyle(fontSize: 11, color: greyText),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      noNota,
                      style: const TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                        color: darkText,
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Destinasi',
                      style: TextStyle(fontSize: 11, color: greyText),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      namaWisata,
                      style: const TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                        color: darkText,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),

          const SizedBox(height: 16),

          // Row 2: Tanggal & Total
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Tanggal',
                      style: TextStyle(fontSize: 11, color: greyText),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      tanggalFormatted,
                      style: const TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                        color: darkText,
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Total',
                      style: TextStyle(fontSize: 11, color: greyText),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'Rp ${formatter.format(totalBayar)}',
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w800,
                        color: Color(0xFFFF6B6B),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // ============================================================
  // BOTTOM BUTTONS (Cetak E-Tiket & Transaksi Baru)
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
          // Cetak E-Tiket
          Expanded(
            flex: 3,
            child: ElevatedButton.icon(
              onPressed: () {
                // Buka E-Tiket sesuai desain saat tombol Cetak ditekan
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => ETiketScreen(
                      namaWisata: namaWisata,
                      namaLengkap: namaLengkap,
                      noNota: noNota,
                      idBilling: idBilling,
                      email: email,
                      tanggalKunjungan: tanggalKunjungan,
                      jumlahTiket: jumlahTiket,
                      hargaSatuan: hargaSatuan,
                      totalBayar: totalBayar,
                    ),
                  ),
                );
              },
              icon: const Icon(Icons.print_outlined, size: 18),
              label: const Text(
                'Cetak E-Tiket',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF00C9A7),
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                padding: const EdgeInsets.symmetric(vertical: 14),
                elevation: 0,
              ),
            ),
          ),

          const SizedBox(width: 14),

          // Transaksi Baru
          Expanded(
            flex: 3,
            child: OutlinedButton(
              onPressed: () {
                // Kembali ke halaman pariwisata (pop semua screen reservasi)
                Navigator.of(context).popUntil((route) => route.isFirst);
              },
              style: OutlinedButton.styleFrom(
                foregroundColor: greyText,
                side: const BorderSide(color: Color(0xFFE0E0E0)),
                backgroundColor: const Color(0xFFF5F5F5),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                padding: const EdgeInsets.symmetric(vertical: 14),
              ),
              child: const Text(
                'Transaksi Baru',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ============================================================
  // HELPER
  // ============================================================
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
// QR CODE PAINTER (Visual placeholder)
// ================================================================
class _QRCodePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..color = Colors.black;
    final random = [
      3, 7, 11, 15, 19, 23, 27, 31, 35, 39, 5, 9, 13, 17, 21, 25, 29, 33, 37,
      2, 6, 10, 14, 18, 22, 26, 30, 34, 38, 4, 8, 12, 16, 20, 24, 28, 32, 36,
    ];

    final double cellSize = size.width / 25;
    final double padding = 15;

    // Corner patterns (top-left)
    _drawFinderPattern(canvas, paint, padding, padding, cellSize);
    // Corner patterns (top-right)
    _drawFinderPattern(canvas, paint, size.width - padding - 7 * cellSize, padding, cellSize);
    // Corner patterns (bottom-left)
    _drawFinderPattern(canvas, paint, padding, size.height - padding - 7 * cellSize, cellSize);

    // Random data cells
    for (int i = 0; i < random.length; i++) {
      final int row = (i * 3 + 8) % 20 + 2;
      final int col = (random[i] + i * 2) % 20 + 2;
      final double x = padding + col * cellSize;
      final double y = padding + row * cellSize;

      if (x + cellSize < size.width - padding && y + cellSize < size.height - padding) {
        canvas.drawRect(
          Rect.fromLTWH(x, y, cellSize * 0.85, cellSize * 0.85),
          paint,
        );
      }
    }

    // More random patterns for density
    for (int r = 8; r < 20; r++) {
      for (int c = 8; c < 20; c++) {
        if ((r + c) % 3 == 0 || (r * c) % 7 == 0) {
          final double x = padding + c * cellSize;
          final double y = padding + r * cellSize;
          canvas.drawRect(
            Rect.fromLTWH(x, y, cellSize * 0.8, cellSize * 0.8),
            paint,
          );
        }
      }
    }
  }

  void _drawFinderPattern(Canvas canvas, Paint paint, double x, double y, double cellSize) {
    // Outer border
    canvas.drawRect(
      Rect.fromLTWH(x, y, 7 * cellSize, 7 * cellSize),
      paint,
    );
    // White inner
    final whitePaint = Paint()..color = Colors.white;
    canvas.drawRect(
      Rect.fromLTWH(x + cellSize, y + cellSize, 5 * cellSize, 5 * cellSize),
      whitePaint,
    );
    // Black center
    canvas.drawRect(
      Rect.fromLTWH(x + 2 * cellSize, y + 2 * cellSize, 3 * cellSize, 3 * cellSize),
      paint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
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
