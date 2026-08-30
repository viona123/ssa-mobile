import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

/// E-Tiket final (sesuai desain context/E-Tiket.png).
///
/// Ditampilkan setelah pengguna menekan tombol "Cetak E-Tiket" pada
/// [PembayaranScreen]. Berisi header pemerintah, data pemesan + QR,
/// tabel destinasi, total bayar, catatan, dan tombol Cetak/Transaksi Baru.
class ETiketScreen extends StatelessWidget {
  final String namaWisata;
  final String namaLengkap;
  final String noNota;
  final String idBilling;
  final String email;
  final DateTime tanggalKunjungan;
  final int jumlahTiket;
  final int hargaSatuan;
  final int totalBayar;

  const ETiketScreen({
    super.key,
    required this.namaWisata,
    required this.namaLengkap,
    required this.noNota,
    required this.idBilling,
    required this.email,
    required this.tanggalKunjungan,
    required this.jumlahTiket,
    required this.hargaSatuan,
    required this.totalBayar,
  });

  // ============================================================
  // COLORS
  // ============================================================
  static const Color headerColor = Color(0xFF1B1F2A);
  static const Color primaryCyan = Color(0xFF00B4D8);
  static const Color darkText = Color(0xFF202124);
  static const Color greyText = Color(0xFF737B86);
  static const Color pageBackground = Color(0xFFF1F3F6);
  static const Color greenPrint = Color(0xFF1DB954);

  static const String _logoAsset =
      'assets/images/splash/logo_kabupaten_sragen.png';

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
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 20,
                ),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.06),
                        blurRadius: 16,
                        offset: const Offset(0, 6),
                      ),
                    ],
                  ),
                  clipBehavior: Clip.antiAlias,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Header pemerintah
                      _buildHeader(),

                      Padding(
                        padding: const EdgeInsets.all(20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Data pemesan + QR
                            _buildInfoSection(),

                            const SizedBox(height: 24),

                            // Tabel destinasi
                            _buildTicketTable(),

                            const SizedBox(height: 20),

                            // Catatan
                            _buildNote(),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),

            // Tombol bawah
            _buildBottomButtons(context),
          ],
        ),
      ),
    );
  }

  // ============================================================
  // HEADER (dark, logo + judul pemerintah)
  // ============================================================
  Widget _buildHeader() {
    return Container(
      width: double.infinity,
      color: headerColor,
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 22),
      child: Row(
        children: [
          // Logo
          Container(
            width: 56,
            height: 66,
            alignment: Alignment.center,
            child: Image.asset(
              _logoAsset,
              fit: BoxFit.contain,
              errorBuilder: (_, __, ___) => const Icon(
                Icons.account_balance,
                color: Colors.white,
                size: 44,
              ),
            ),
          ),
          const SizedBox(width: 16),
          // Judul
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Text(
                  'PEMERINTAH KABUPATEN SRAGEN',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w800,
                    letterSpacing: 0.3,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  namaWisata.toUpperCase(),
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    color: primaryCyan,
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                    letterSpacing: 0.5,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 56),
        ],
      ),
    );
  }

  // ============================================================
  // INFO SECTION (data pemesan + QR)
  // ============================================================
  Widget _buildInfoSection() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Data pemesan
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildInfoRow('Nama', namaLengkap.isEmpty ? '-' : namaLengkap),
              const SizedBox(height: 12),
              _buildInfoRow('No Nota', noNota, isMono: true),
              const SizedBox(height: 12),
              _buildInfoRow('ID Billing', idBilling,
                  isMono: true, isHighlight: true),
              const SizedBox(height: 12),
              _buildInfoRow('Email', email.isEmpty ? '-' : email),
            ],
          ),
        ),
        const SizedBox(width: 16),
        // QR Code
        Container(
          width: 96,
          height: 96,
          padding: const EdgeInsets.all(6),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: const Color(0xFFE0E0E0)),
          ),
          child: CustomPaint(
            painter: _QRCodePainter(),
            size: const Size(84, 84),
          ),
        ),
      ],
    );
  }

  Widget _buildInfoRow(
    String label,
    String value, {
    bool isMono = false,
    bool isHighlight = false,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 78,
          child: Text(
            label,
            style: const TextStyle(
              fontSize: 13,
              color: greyText,
            ),
          ),
        ),
        const Text(
          ':  ',
          style: TextStyle(fontSize: 13, color: greyText),
        ),
        Expanded(
          child: Text(
            value,
            style: TextStyle(
              fontSize: 13,
              fontWeight: isHighlight ? FontWeight.w700 : FontWeight.w600,
              color: isHighlight ? primaryCyan : darkText,
              fontFamily: isMono ? 'monospace' : null,
            ),
          ),
        ),
      ],
    );
  }

  // ============================================================
  // TICKET TABLE
  // ============================================================
  Widget _buildTicketTable() {
    final formatter = NumberFormat('#,###', 'id_ID');
    final String hargaStr = 'Rp ${formatter.format(hargaSatuan)}';
    final String totalStr = 'Rp ${formatter.format(totalBayar)}';
    final String tanggalStr = _formatTanggal(tanggalKunjungan);

    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFFE5E7EB)),
      ),
      clipBehavior: Clip.antiAlias,
      child: Column(
        children: [
          // Header row
          Container(
            color: const Color(0xFFF8FAFC),
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
            child: Row(
              children: const [
                _TableCell('No', flex: 1, isHeader: true),
                _TableCell('Destinasi', flex: 3, isHeader: true),
                _TableCell('Tanggal', flex: 3, isHeader: true),
                _TableCell('Jumlah', flex: 2, isHeader: true),
                _TableCell('Harga', flex: 2, isHeader: true, alignEnd: true),
                _TableCell('Total', flex: 2, isHeader: true, alignEnd: true),
              ],
            ),
          ),
          Container(height: 1, color: const Color(0xFFE5E7EB)),
          // Data row
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const _TableCell('1', flex: 1),
                _TableCell(namaWisata, flex: 3, isBold: true),
                _TableCell(tanggalStr, flex: 3),
                _TableCell('$jumlahTiket', flex: 2, isBold: true),
                _TableCell(hargaStr, flex: 2, alignEnd: true),
                _TableCell(totalStr, flex: 2, isBold: true, alignEnd: true),
              ],
            ),
          ),
          Container(height: 1, color: const Color(0xFFE5E7EB)),
          // BAYAR row
          Container(
            color: const Color(0xFFFAFBFC),
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
            child: Row(
              children: [
                const Spacer(flex: 9),
                const Expanded(
                  flex: 2,
                  child: Text(
                    'BAYAR',
                    textAlign: TextAlign.end,
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w800,
                      color: darkText,
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  flex: 2,
                  child: Text(
                    totalStr,
                    textAlign: TextAlign.end,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w800,
                      color: primaryCyan,
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

  // ============================================================
  // NOTE
  // ============================================================
  Widget _buildNote() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(14),
      decoration: const BoxDecoration(
        color: Color(0xFFEFF6FF),
        border: Border(
          left: BorderSide(color: primaryCyan, width: 4),
        ),
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(8),
          bottomRight: Radius.circular(8),
        ),
      ),
      child: Text(
        '* Tiket ini merupakan alat bukti yang sah. Tunjukkan kepada petugas '
        'loket baik dalam bentuk softcopy maupun hardcopy.',
        style: TextStyle(
          fontSize: 12,
          color: darkText.withValues(alpha: 0.8),
          height: 1.5,
        ),
      ),
    );
  }

  // ============================================================
  // BOTTOM BUTTONS (Cetak / Print + Transaksi Baru)
  // ============================================================
  Widget _buildBottomButtons(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
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
          // Cetak / Print
          Expanded(
            child: ElevatedButton.icon(
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('E-Tiket sedang disiapkan untuk dicetak...'),
                    backgroundColor: greenPrint,
                  ),
                );
              },
              icon: const Icon(Icons.print, size: 20),
              label: const Text(
                'Cetak / Print',
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w700,
                ),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: greenPrint,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                padding: const EdgeInsets.symmetric(vertical: 16),
                elevation: 0,
              ),
            ),
          ),

          const SizedBox(width: 14),

          // Transaksi Baru -> kembali ke halaman awal pariwisata
          Expanded(
            child: OutlinedButton(
              onPressed: () {
                Navigator.of(context).popUntil((route) => route.isFirst);
              },
              style: OutlinedButton.styleFrom(
                foregroundColor: darkText,
                backgroundColor: const Color(0xFFE9EDF2),
                side: const BorderSide(color: Color(0xFFDDE3EA)),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                padding: const EdgeInsets.symmetric(vertical: 16),
              ),
              child: const Text(
                'Transaksi Baru',
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w700,
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
    const List<String> hariList = [
      'Senin', 'Selasa', 'Rabu', 'Kamis', 'Jumat', 'Sabtu', 'Minggu'
    ];
    const List<String> bulanList = [
      'Januari', 'Februari', 'Maret', 'April', 'Mei', 'Juni',
      'Juli', 'Agustus', 'September', 'Oktober', 'November', 'Desember'
    ];

    final String hari = hariList[date.weekday - 1];
    final String bulan = bulanList[date.month - 1];
    return '$hari, ${date.day} $bulan ${date.year}';
  }
}

// ================================================================
// TABLE CELL
// ================================================================
class _TableCell extends StatelessWidget {
  final String text;
  final int flex;
  final bool isHeader;
  final bool isBold;
  final bool alignEnd;

  const _TableCell(
    this.text, {
    required this.flex,
    this.isHeader = false,
    this.isBold = false,
    this.alignEnd = false,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: flex,
      child: Text(
        text,
        textAlign: alignEnd ? TextAlign.end : TextAlign.start,
        style: TextStyle(
          fontSize: isHeader ? 12 : 12.5,
          fontWeight: isHeader
              ? FontWeight.w700
              : (isBold ? FontWeight.w700 : FontWeight.w400),
          color: isHeader
              ? ETiketScreen.darkText
              : ETiketScreen.darkText.withValues(alpha: 0.85),
        ),
      ),
    );
  }
}

// ================================================================
// QR CODE PAINTER (visual placeholder)
// ================================================================
class _QRCodePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..color = Colors.black;
    const int modules = 21;
    final double cell = size.width / modules;

    void drawFinder(int gx, int gy) {
      // Outer 7x7
      canvas.drawRect(
        Rect.fromLTWH(gx * cell, gy * cell, 7 * cell, 7 * cell),
        paint,
      );
      // Inner white 5x5
      canvas.drawRect(
        Rect.fromLTWH((gx + 1) * cell, (gy + 1) * cell, 5 * cell, 5 * cell),
        Paint()..color = Colors.white,
      );
      // Center 3x3
      canvas.drawRect(
        Rect.fromLTWH((gx + 2) * cell, (gy + 2) * cell, 3 * cell, 3 * cell),
        paint,
      );
    }

    // Finder patterns
    drawFinder(0, 0);
    drawFinder(modules - 7, 0);
    drawFinder(0, modules - 7);

    // Pseudo-random data modules (deterministic)
    for (int r = 0; r < modules; r++) {
      for (int c = 0; c < modules; c++) {
        // Skip finder pattern zones
        final bool inTL = r < 8 && c < 8;
        final bool inTR = r < 8 && c > modules - 9;
        final bool inBL = r > modules - 9 && c < 8;
        if (inTL || inTR || inBL) continue;

        if ((r * 7 + c * 13 + r * c) % 3 == 0) {
          canvas.drawRect(
            Rect.fromLTWH(c * cell, r * cell, cell, cell),
            paint,
          );
        }
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
