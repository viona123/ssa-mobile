import 'package:flutter/material.dart';

import 'mpp_shared.dart';

// ================================================================
// ANTREAN LAYANAN MPP
// Formulir Antrean (Ambil/Cek) + Panduan Singkat + Jam Operasional.
// ================================================================

class AntreanMppScreen extends StatefulWidget {
  const AntreanMppScreen({super.key});

  @override
  State<AntreanMppScreen> createState() => _AntreanMppScreenState();
}

class _AntreanMppScreenState extends State<AntreanMppScreen> {
  static final Uri _antreanUri =
      Uri.parse('https://mpp.sragenkab.go.id/antrian/');

  bool _ambilMode = true;
  String? _gerai;
  String? _loket;
  DateTime? _tanggal;
  final TextEditingController _waController = TextEditingController();
  final TextEditingController _cekWaController = TextEditingController();

  static const List<String> _geraiList = [
    'DPMPTSP',
    'Dukcapil',
    'Kepolisian (Polres)',
    'Imigrasi',
    'BPJS Kesehatan',
    'BPJS Ketenagakerjaan',
    'Samsat',
    'Bank Jateng',
    'PLN',
    'PDAM',
  ];

  static const List<String> _loketList = [
    'Loket 1 - Perizinan Berusaha',
    'Loket 2 - Perizinan Non-Berusaha',
    'Loket 3 - Informasi & Pengaduan',
    'Loket 4 - Konsultasi',
    'Loket 5 - Pelayanan Umum',
  ];

  @override
  void dispose() {
    _waController.dispose();
    _cekWaController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MppColors.pageBackground,
      bottomNavigationBar: const MppBottomNav(),
      body: SafeArea(
        child: Column(
          children: [
            const MppHeader(title: 'Antrean Layanan MPP'),
            Expanded(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                padding: const EdgeInsets.fromLTRB(20, 18, 20, 32),
                child: Column(
                  children: [
                    const MppHero(),
                    const SizedBox(height: 22),
                    _buildFormulirAntrean(),
                    const SizedBox(height: 16),
                    _buildPanduanSingkat(),
                    const SizedBox(height: 16),
                    _buildJamOperasional(),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFormulirAntrean() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: MppColors.cardBorder),
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
          const Text(
            'Formulir Antrean',
            style: TextStyle(
              fontSize: 17,
              fontWeight: FontWeight.w800,
              color: MppColors.darkText,
            ),
          ),
          const SizedBox(height: 3),
          const Text(
            'Pastikan data sesuai agar tiket dapat diproses otomatis.',
            style: TextStyle(fontSize: 12, color: MppColors.greyText),
          ),
          const SizedBox(height: 14),
          _buildModeToggle(),
          const SizedBox(height: 18),
          if (_ambilMode) ..._buildAmbilForm() else ..._buildCekForm(),
        ],
      ),
    );
  }

  Widget _buildModeToggle() {
    return Container(
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: const Color(0xFFEDF1F5),
        borderRadius: BorderRadius.circular(11),
      ),
      child: Row(
        children: [
          Expanded(child: _modeButton('Ambil Antrean', _ambilMode, true)),
          Expanded(child: _modeButton('Cek Antrean', !_ambilMode, false)),
        ],
      ),
    );
  }

  Widget _modeButton(String label, bool active, bool ambil) {
    return GestureDetector(
      onTap: () => setState(() => _ambilMode = ambil),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 180),
        height: 40,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: active ? MppColors.cyan : Colors.transparent,
          borderRadius: BorderRadius.circular(9),
          boxShadow: [
            if (active)
              BoxShadow(
                color: MppColors.cyan.withValues(alpha: 0.3),
                blurRadius: 8,
                offset: const Offset(0, 3),
              ),
          ],
        ),
        child: Text(
          label,
          style: TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w700,
            color: active ? Colors.white : MppColors.greyText,
          ),
        ),
      ),
    );
  }

  List<Widget> _buildAmbilForm() {
    return [
      _fieldLabel('Gerai'),
      const SizedBox(height: 6),
      _buildDropdown(
        value: _gerai,
        hint: 'Pilih Gerai',
        items: _geraiList,
        onChanged: (v) => setState(() => _gerai = v),
      ),
      const SizedBox(height: 14),
      _fieldLabel('Loket & Layanan'),
      const SizedBox(height: 6),
      _buildDropdown(
        value: _loket,
        hint: 'Pilih Loket',
        items: _loketList,
        onChanged: (v) => setState(() => _loket = v),
      ),
      const SizedBox(height: 14),
      _fieldLabel('Tanggal Kunjungan'),
      const SizedBox(height: 6),
      _buildDateField(),
      const SizedBox(height: 14),
      _fieldLabel('Nomor WA'),
      const SizedBox(height: 6),
      _buildTextField(_waController, '08xxxxxxxxxx',
          keyboardType: TextInputType.phone),
      const SizedBox(height: 14),
      const Text(
        'Pastikan nomor WA aktif untuk menerima informasi antrean.',
        style: TextStyle(fontSize: 11.5, color: MppColors.primaryBlue, height: 1.4),
      ),
      const SizedBox(height: 14),
      _buildSubmitButton(
          'Ambil Antrean', Icons.confirmation_number_rounded, _submitAmbil),
    ];
  }

  List<Widget> _buildCekForm() {
    return [
      _fieldLabel('Nomor WA'),
      const SizedBox(height: 6),
      _buildTextField(_cekWaController, '08xxxxxxxxxx',
          keyboardType: TextInputType.phone),
      const SizedBox(height: 8),
      const Text(
        'Masukkan nomor WA yang digunakan saat mengambil antrean.',
        style: TextStyle(fontSize: 11.5, color: MppColors.primaryBlue, height: 1.4),
      ),
      const SizedBox(height: 14),
      _buildSubmitButton('Cek Antrean', Icons.search_rounded, _submitCek),
    ];
  }

  Widget _fieldLabel(String text) {
    return Text(
      text,
      style: const TextStyle(
        fontSize: 12.5,
        fontWeight: FontWeight.w700,
        color: MppColors.darkText,
      ),
    );
  }

  Widget _buildDropdown({
    required String? value,
    required String hint,
    required List<String> items,
    required ValueChanged<String?> onChanged,
  }) {
    return Container(
      height: 50,
      padding: const EdgeInsets.symmetric(horizontal: 14),
      decoration: BoxDecoration(
        color: const Color(0xFFF7F9FB),
        borderRadius: BorderRadius.circular(11),
        border: Border.all(color: MppColors.cardBorder),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: value,
          isExpanded: true,
          hint: Text(hint,
              style: const TextStyle(fontSize: 13.5, color: Color(0xFFB0B7BF))),
          icon: const Icon(Icons.keyboard_arrow_down_rounded,
              color: MppColors.greyText),
          style: const TextStyle(fontSize: 13.5, color: MppColors.darkText),
          items: items
              .map((e) => DropdownMenuItem<String>(
                    value: e,
                    child: Text(e, overflow: TextOverflow.ellipsis),
                  ))
              .toList(),
          onChanged: onChanged,
        ),
      ),
    );
  }

  Widget _buildDateField() {
    final label = _tanggal == null
        ? 'dd-----yyyy'
        : '${_tanggal!.day.toString().padLeft(2, '0')}-'
            '${_tanggal!.month.toString().padLeft(2, '0')}-${_tanggal!.year}';
    return GestureDetector(
      onTap: _pickDate,
      child: Container(
        height: 50,
        padding: const EdgeInsets.symmetric(horizontal: 14),
        decoration: BoxDecoration(
          color: const Color(0xFFF7F9FB),
          borderRadius: BorderRadius.circular(11),
          border: Border.all(color: MppColors.cardBorder),
        ),
        child: Row(
          children: [
            Expanded(
              child: Text(
                label,
                style: TextStyle(
                  fontSize: 13.5,
                  color: _tanggal == null
                      ? const Color(0xFFB0B7BF)
                      : MppColors.darkText,
                ),
              ),
            ),
            const Icon(Icons.calendar_today_rounded,
                size: 17, color: MppColors.greyText),
          ],
        ),
      ),
    );
  }

  Widget _buildTextField(
    TextEditingController controller,
    String hint, {
    TextInputType keyboardType = TextInputType.text,
  }) {
    return Container(
      height: 50,
      padding: const EdgeInsets.symmetric(horizontal: 14),
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: const Color(0xFFF7F9FB),
        borderRadius: BorderRadius.circular(11),
        border: Border.all(color: MppColors.cardBorder),
      ),
      child: TextField(
        controller: controller,
        keyboardType: keyboardType,
        style: const TextStyle(fontSize: 13.5, color: MppColors.darkText),
        decoration: InputDecoration(
          isCollapsed: true,
          border: InputBorder.none,
          hintText: hint,
          hintStyle: const TextStyle(fontSize: 13.5, color: Color(0xFFB0B7BF)),
        ),
      ),
    );
  }

  Widget _buildSubmitButton(String label, IconData icon, VoidCallback onTap) {
    return Align(
      alignment: Alignment.centerRight,
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          height: 48,
          padding: const EdgeInsets.symmetric(horizontal: 26),
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: MppColors.cyan,
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: MppColors.cyan.withValues(alpha: 0.3),
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(icon, size: 18, color: Colors.white),
              const SizedBox(width: 8),
              Text(
                label,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w800,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPanduanSingkat() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: MppColors.cardBorder),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Panduan Singkat',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w800,
              color: MppColors.darkText,
            ),
          ),
          const SizedBox(height: 14),
          _panduanItem(Icons.storefront_rounded,
              'Pilih gerai dan loket layanan sesuai kebutuhan perizinan.'),
          const SizedBox(height: 12),
          _panduanItem(Icons.event_available_rounded,
              'Isi tanggal kunjungan pada hari kerja (Senin–Jumat).'),
          const SizedBox(height: 12),
          _panduanItem(Icons.support_agent_rounded,
              'Gunakan nomor WA aktif untuk menerima informasi antrean.'),
        ],
      ),
    );
  }

  Widget _panduanItem(IconData icon, String text) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, size: 18, color: MppColors.primaryBlue),
        const SizedBox(width: 12),
        Expanded(
          child: Text(
            text,
            style: const TextStyle(
              fontSize: 12.5,
              color: MppColors.greyText,
              height: 1.45,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildJamOperasional() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: MppColors.cardBorder),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Jam Operasional',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w800,
              color: MppColors.darkText,
            ),
          ),
          const SizedBox(height: 14),
          _jamRow('Senin - Kamis', '08.00 - 15.30'),
          const Divider(height: 20, color: MppColors.cardBorder),
          _jamRow('Jumat', '08.00 - 14.30'),
          const Divider(height: 20, color: MppColors.cardBorder),
          _jamRow('Sabtu - Minggu', 'Tutup', closed: true),
        ],
      ),
    );
  }

  Widget _jamRow(String day, String time, {bool closed = false}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(day, style: const TextStyle(fontSize: 13, color: MppColors.darkText)),
        Text(
          time,
          style: TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w800,
            color: closed ? MppColors.cyan : MppColors.darkText,
          ),
        ),
      ],
    );
  }

  Future<void> _pickDate() async {
    final now = DateTime.now();
    final picked = await showDatePicker(
      context: context,
      initialDate: _tanggal ?? now,
      firstDate: now,
      lastDate: DateTime(now.year + 1),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.light(primary: MppColors.primaryBlue),
          ),
          child: child!,
        );
      },
    );
    if (picked != null) setState(() => _tanggal = picked);
  }

  void _submitAmbil() {
    if (_gerai == null || _loket == null) {
      _snack('Pilih gerai dan loket layanan terlebih dahulu.');
      return;
    }
    if (_tanggal == null) {
      _snack('Pilih tanggal kunjungan terlebih dahulu.');
      return;
    }
    if (_waController.text.trim().length < 8) {
      _snack('Masukkan nomor WA yang valid.');
      return;
    }
    FocusScope.of(context).unfocus();
    openMppUrl(context, _antreanUri);
  }

  void _submitCek() {
    if (_cekWaController.text.trim().length < 8) {
      _snack('Masukkan nomor WA yang valid untuk cek antrean.');
      return;
    }
    FocusScope.of(context).unfocus();
    openMppUrl(context, _antreanUri);
  }

  void _snack(String msg) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(msg),
        behavior: SnackBarBehavior.floating,
        duration: const Duration(seconds: 2),
      ),
    );
  }
}
