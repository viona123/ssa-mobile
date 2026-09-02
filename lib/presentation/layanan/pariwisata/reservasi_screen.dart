import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'konfirmasi_screen.dart';

class ReservasiScreen extends StatefulWidget {
  final String namaWisata;
  final String lokasi;
  final String deskripsi;

  const ReservasiScreen({
    super.key,
    required this.namaWisata,
    required this.lokasi,
    required this.deskripsi,
  });

  @override
  State<ReservasiScreen> createState() => _ReservasiScreenState();
}

class _ReservasiScreenState extends State<ReservasiScreen> {
  // ============================================================
  // COLORS
  // ============================================================
  static const Color primaryBlue = Color(0xFF007EA7);
  static const Color darkText = Color(0xFF202124);
  static const Color greyText = Color(0xFF737B86);
  static const Color pageBackground = Color(0xFFF8FAFC);
  static const Color fieldBackground = Color(0xFFF5F7FA);
  static const Color borderColor = Color(0xFFE0E0E0);

  // ============================================================
  // CONTROLLERS & STATE
  // ============================================================
  final TextEditingController _namaController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  DateTime? _tanggalKunjungan;
  int _jumlahTiket = 1;

  String _jenisTiket = 'Umum/Wisdan';
  final List<String> _jenisTiketOptions = [
    'Umum/Wisdan',
    'Pelajar',
    'Wisman',
    'Rombongan',
  ];

  String _metodePembayaran = 'QRIS (Otomatis)';
  final List<String> _metodePembayaranOptions = [
    'QRIS (Otomatis)',
    'Transfer Bank Jateng',
  ];

  @override
  void dispose() {
    _namaController.dispose();
    _emailController.dispose();
    super.dispose();
  }

  // ============================================================
  // BUILD
  // ============================================================
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: pageBackground,
      body: SafeArea(
        child: _buildBody(),
      ),
      bottomNavigationBar: _buildBottomButtons(),
    );
  }

  // ============================================================
  // HEADER (judul tengah, seragam dengan Konfirmasi & Pembayaran)
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
  // BODY
  // ============================================================
  Widget _buildBody() {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Header (judul + subtitle di tengah)
          _buildHeader(),

          const SizedBox(height: 24),

          // Stepper
          _buildStepper(),

          const SizedBox(height: 24),

          // Destinasi Card
          _buildDestinasiCard(),

          const SizedBox(height: 20),

          // Form Isi Data
          _buildFormCard(),

          const SizedBox(height: 16),

          // Info Banner
          _buildInfoBanner(),

          const SizedBox(height: 20),
        ],
      ),
    );
  }

  // ============================================================
  // STEPPER (Pilih Destinasi ✓, Isi Data active, Konfirmasi, Pembayaran)
  // Gaya seragam dengan halaman lain (ikon + garis biru).
  // ============================================================
  Widget _buildStepper() {
    final steps = [
      _StepInfo(
          label: 'Pilih Destinasi',
          icon: Icons.location_on,
          isCompleted: true),
      _StepInfo(
          label: 'Isi Data',
          icon: Icons.edit_note,
          isCompleted: false,
          isActive: true),
      _StepInfo(
          label: 'Konfirmasi',
          icon: Icons.description_outlined,
          isCompleted: false),
      _StepInfo(
          label: 'Pembayaran',
          icon: Icons.payment_outlined,
          isCompleted: false),
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
        return _buildStepIcon(steps[index ~/ 2]);
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
  // DESTINASI CARD
  // ============================================================
  Widget _buildDestinasiCard() {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        gradient: const LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [Color(0xFF3B94A9), Color(0xFF2C6E7E)],
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.1),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      clipBehavior: Clip.antiAlias,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Top section with image and info
          Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Image placeholder
                Container(
                  width: 90,
                  height: 90,
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.2),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Center(
                    child: Icon(
                      Icons.landscape_rounded,
                      size: 40,
                      color: Colors.white70,
                    ),
                  ),
                ),

                const SizedBox(width: 14),

                // Info
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Badge
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: primaryBlue,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: const Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              Icons.verified,
                              size: 12,
                              color: Colors.white,
                            ),
                            SizedBox(width: 4),
                            Text(
                              'DESTINASI PILIHAN',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 9,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(height: 8),

                      // Nama
                      Text(
                        widget.namaWisata,
                        style: const TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.w700,
                          color: Colors.white,
                        ),
                      ),

                      const SizedBox(height: 6),

                      // Lokasi
                      Row(
                        children: [
                          const Icon(
                            Icons.location_on_outlined,
                            size: 14,
                            color: Colors.white70,
                          ),
                          const SizedBox(width: 4),
                          Expanded(
                            child: Text(
                              widget.lokasi,
                              style: const TextStyle(
                                fontSize: 12,
                                color: Colors.white70,
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
          ),

          // Divider
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 16),
            height: 1,
            color: Colors.white.withValues(alpha: 0.2),
          ),

          // Deskripsi
          Padding(
            padding: const EdgeInsets.all(16),
            child: Text(
              '"${widget.deskripsi}"',
              style: const TextStyle(
                fontSize: 12,
                color: Colors.white70,
                fontStyle: FontStyle.italic,
                height: 1.5,
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ============================================================
  // FORM CARD
  // ============================================================
  Widget _buildFormCard() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.04),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Title
          const Row(
            children: [
              Icon(Icons.person_add_outlined, size: 22, color: primaryBlue),
              SizedBox(width: 8),
              Text(
                'Isi Data Pembelian Tiket',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: darkText,
                ),
              ),
            ],
          ),

          const SizedBox(height: 20),

          // Nama Lengkap
          _buildLabel('Nama Lengkap', isRequired: true),
          const SizedBox(height: 8),
          _buildTextField(
            controller: _namaController,
            hint: 'Masukkan nama lengkap',
          ),

          const SizedBox(height: 18),

          // Email
          _buildLabel('Email', isRequired: true),
          const SizedBox(height: 8),
          _buildTextField(
            controller: _emailController,
            hint: 'email@contoh.com',
            keyboardType: TextInputType.emailAddress,
          ),

          const SizedBox(height: 18),

          // Tanggal Kunjungan
          _buildLabel('Tanggal Kunjungan', isRequired: true),
          const SizedBox(height: 8),
          _buildDateField(),

          const SizedBox(height: 18),

          // Jumlah & Jenis Tiket (Row)
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Jumlah
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildLabel('Jumlah', isRequired: true),
                    const SizedBox(height: 8),
                    _buildJumlahField(),
                  ],
                ),
              ),

              const SizedBox(width: 14),

              // Jenis Tiket
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildLabel('Jenis Tiket'),
                    const SizedBox(height: 8),
                    _buildDropdown(
                      value: _jenisTiket,
                      items: _jenisTiketOptions,
                      onChanged: (val) {
                        setState(() {
                          _jenisTiket = val!;
                        });
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),

          const SizedBox(height: 18),

          // Metode Pembayaran
          _buildLabel('Metode Pembayaran'),
          const SizedBox(height: 8),
          _buildMetodePembayaranDropdown(),
        ],
      ),
    );
  }

  // ============================================================
  // LABEL
  // ============================================================
  Widget _buildLabel(String text, {bool isRequired = false}) {
    return RichText(
      text: TextSpan(
        text: text,
        style: const TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w500,
          color: darkText,
        ),
        children: isRequired
            ? const [
                TextSpan(
                  text: ' *',
                  style: TextStyle(color: Colors.red, fontSize: 14),
                ),
              ]
            : null,
      ),
    );
  }

  // ============================================================
  // TEXT FIELD
  // ============================================================
  Widget _buildTextField({
    required TextEditingController controller,
    required String hint,
    TextInputType keyboardType = TextInputType.text,
  }) {
    return Container(
      height: 48,
      decoration: BoxDecoration(
        color: fieldBackground,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: borderColor),
      ),
      child: TextField(
        controller: controller,
        keyboardType: keyboardType,
        style: const TextStyle(fontSize: 14, color: darkText),
        decoration: InputDecoration(
          hintText: hint,
          hintStyle: const TextStyle(fontSize: 14, color: greyText),
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 14,
            vertical: 14,
          ),
        ),
      ),
    );
  }

  // ============================================================
  // DATE FIELD
  // ============================================================
  Widget _buildDateField() {
    return GestureDetector(
      onTap: _selectDate,
      child: Container(
        height: 48,
        padding: const EdgeInsets.symmetric(horizontal: 14),
        decoration: BoxDecoration(
          color: fieldBackground,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: borderColor),
        ),
        child: Row(
          children: [
            Expanded(
              child: Text(
                _tanggalKunjungan != null
                    ? DateFormat('MM/dd/yyyy').format(_tanggalKunjungan!)
                    : 'mm/dd/yyyy',
                style: TextStyle(
                  fontSize: 14,
                  color: _tanggalKunjungan != null ? darkText : greyText,
                ),
              ),
            ),
            const Icon(Icons.calendar_today_outlined, size: 20, color: greyText),
          ],
        ),
      ),
    );
  }

  Future<void> _selectDate() async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _tanggalKunjungan ?? DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 365)),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.light(
              primary: primaryBlue,
              onPrimary: Colors.white,
              surface: Colors.white,
              onSurface: darkText,
            ),
          ),
          child: child!,
        );
      },
    );
    if (picked != null) {
      setState(() {
        _tanggalKunjungan = picked;
      });
    }
  }

  // ============================================================
  // JUMLAH TIKET FIELD (dengan tombol + dan -)
  // ============================================================
  Widget _buildJumlahField() {
    return Container(
      height: 48,
      decoration: BoxDecoration(
        color: fieldBackground,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: borderColor),
      ),
      child: Row(
        children: [
          // Tombol kurang
          GestureDetector(
            onTap: () {
              if (_jumlahTiket > 1) {
                setState(() {
                  _jumlahTiket--;
                });
              }
            },
            child: Container(
              width: 36,
              height: 48,
              decoration: const BoxDecoration(
                border: Border(
                  right: BorderSide(color: borderColor),
                ),
              ),
              child: const Center(
                child: Icon(Icons.remove, size: 18, color: greyText),
              ),
            ),
          ),

          // Angka
          Expanded(
            child: Center(
              child: Text(
                '$_jumlahTiket',
                style: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                  color: darkText,
                ),
              ),
            ),
          ),

          // Tombol tambah
          GestureDetector(
            onTap: () {
              if (_jumlahTiket < 100) {
                setState(() {
                  _jumlahTiket++;
                });
              }
            },
            child: Container(
              width: 36,
              height: 48,
              decoration: const BoxDecoration(
                border: Border(
                  left: BorderSide(color: borderColor),
                ),
              ),
              child: const Center(
                child: Icon(Icons.add, size: 18, color: primaryBlue),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ============================================================
  // DROPDOWN GENERIC
  // ============================================================
  Widget _buildDropdown({
    required String value,
    required List<String> items,
    required ValueChanged<String?> onChanged,
  }) {
    return Container(
      height: 48,
      padding: const EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(
        color: fieldBackground,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: borderColor),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: value,
          isExpanded: true,
          icon: const Icon(Icons.keyboard_arrow_down, color: greyText),
          style: const TextStyle(fontSize: 14, color: darkText),
          items: items.map((item) {
            return DropdownMenuItem<String>(
              value: item,
              child: Text(
                item,
                style: const TextStyle(fontSize: 13, color: darkText),
              ),
            );
          }).toList(),
          onChanged: onChanged,
        ),
      ),
    );
  }

  // ============================================================
  // METODE PEMBAYARAN DROPDOWN (with icon)
  // ============================================================
  Widget _buildMetodePembayaranDropdown() {
    return Container(
      height: 48,
      padding: const EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(
        color: fieldBackground,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: borderColor),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: _metodePembayaran,
          isExpanded: true,
          icon: const Icon(Icons.keyboard_arrow_down, color: greyText),
          style: const TextStyle(fontSize: 14, color: darkText),
          items: _metodePembayaranOptions.map((item) {
            return DropdownMenuItem<String>(
              value: item,
              child: Row(
                children: [
                  Icon(
                    item.contains('QRIS')
                        ? Icons.qr_code_2_outlined
                        : Icons.account_balance_outlined,
                    size: 20,
                    color: primaryBlue,
                  ),
                  const SizedBox(width: 10),
                  Text(
                    item,
                    style: const TextStyle(fontSize: 13, color: darkText),
                  ),
                ],
              ),
            );
          }).toList(),
          onChanged: (val) {
            setState(() {
              _metodePembayaran = val!;
            });
          },
        ),
      ),
    );
  }

  // ============================================================
  // INFO BANNER
  // ============================================================
  Widget _buildInfoBanner() {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: const Color(0xFFEFF8FF),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFFBCE0F5)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Icon(
            Icons.info_outline,
            size: 20,
            color: primaryBlue,
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              'Pastikan data diri Anda sesuai dengan identitas resmi. Tiket akan dikirimkan melalui email yang terdaftar setelah pembayaran berhasil.',
              style: TextStyle(
                fontSize: 12,
                color: darkText.withValues(alpha: 0.8),
                height: 1.5,
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ============================================================
  // BOTTOM BUTTONS (Kembali & Selanjutnya)
  // ============================================================
  Widget _buildBottomButtons() {
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
      child: SafeArea(
        top: false,
        child: Row(
          children: [
            // Kembali
            Expanded(
              flex: 2,
              child: OutlinedButton(
                onPressed: () => Navigator.pop(context),
                style: OutlinedButton.styleFrom(
                  foregroundColor: primaryBlue,
                  side: const BorderSide(color: primaryBlue),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  padding: const EdgeInsets.symmetric(vertical: 14),
                ),
                child: const Text(
                  'Kembali',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),

            const SizedBox(width: 14),

            // Selanjutnya
            Expanded(
              flex: 3,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => KonfirmasiScreen(
                        namaWisata: widget.namaWisata,
                        lokasi: widget.lokasi,
                        namaLengkap: _namaController.text,
                        email: _emailController.text,
                        tanggalKunjungan: _tanggalKunjungan ?? DateTime.now(),
                        jumlahTiket: _jumlahTiket,
                        jenisTiket: _jenisTiket,
                        metodePembayaran: _metodePembayaran,
                      ),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: primaryBlue,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  elevation: 0,
                ),
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Selanjutnya',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(width: 6),
                    Icon(Icons.arrow_forward, size: 18),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
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
