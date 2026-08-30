import 'package:flutter/material.dart';

// ================================================================
// LAYANAN AJUAN FORM (inline)
// Konten dropdown untuk tiap layanan pada Daftar Layanan:
//  - Deskripsi layanan (bullet + tanggal)
//  - Formulir Pengajuan Layanan
//  - Lampiran Berkas
//  - reCAPTCHA + tombol Kirim Ajuan
// Desain mengikuti context/perubahanakundapodik.png & daftar.png.
// ================================================================

class LayananInfo {
  final String nama;
  final String ringkasan;
  final List<LayananBullet> bullets;
  final String tanggal;
  final List<BerkasItem> berkas;

  const LayananInfo({
    required this.nama,
    required this.ringkasan,
    this.bullets = const [],
    this.tanggal = '2022-12-18',
    this.berkas = const [],
  });
}

class LayananBullet {
  final String judul;
  final List<String> subs;
  const LayananBullet(this.judul, this.subs);
}

class BerkasItem {
  final String nama;
  final bool wajib;
  const BerkasItem(this.nama, {this.wajib = false});
}

class LayananAjuanForm extends StatefulWidget {
  final LayananInfo info;
  const LayananAjuanForm({super.key, required this.info});

  @override
  State<LayananAjuanForm> createState() => _LayananAjuanFormState();
}

class _LayananAjuanFormState extends State<LayananAjuanForm> {
  static const Color _appBlue = Color(0xFF007EA7);
  static const Color _titleBlue = Color(0xFF003D6B);
  static const Color _smoke = Color(0xFF6B7280);
  static const Color _cardBorder = Color(0xFFE8ECF0);
  static const Color _fieldBg = Color(0xFFF7F9FB);
  static const Color _danger = Color(0xFFD92D2D);
  static const Color _green = Color(0xFF12B76A);

  final _nama = TextEditingController();
  final _email = TextEditingController();
  final _wa = TextEditingController();
  final _nik = TextEditingController();
  final _ket = TextEditingController();

  bool _robot = false;
  late List<String?> _files;

  List<BerkasItem> get _berkas => widget.info.berkas.isNotEmpty
      ? widget.info.berkas
      : const [
          BerkasItem('Surat Permohonan (pdf/gambar)', wajib: true),
          BerkasItem('Surat Penugasan Operator Dapodik (jika akun operator)'),
          BerkasItem('Surat Penugasan Guru/Tenaga Kependidikan (jika akun guru)'),
        ];

  @override
  void initState() {
    super.initState();
    _files = List<String?>.filled(_berkas.length, null);
  }

  @override
  void dispose() {
    _nama.dispose();
    _email.dispose();
    _wa.dispose();
    _nik.dispose();
    _ket.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // DESKRIPSI
        Text(
          widget.info.ringkasan,
          style: const TextStyle(fontSize: 13, color: _smoke, height: 1.5),
        ),
        if (widget.info.bullets.isNotEmpty) ...[
          const SizedBox(height: 12),
          ...widget.info.bullets.map(_buildBullet),
        ],
        const SizedBox(height: 12),
        const Divider(height: 1, color: _cardBorder),
        const SizedBox(height: 10),
        Row(
          children: [
            const Icon(Icons.calendar_today_rounded, size: 15, color: _smoke),
            const SizedBox(width: 8),
            Text(
              widget.info.tanggal,
              style: const TextStyle(fontSize: 12.5, color: _smoke),
            ),
          ],
        ),
        const SizedBox(height: 18),

        // FORMULIR
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: _fieldBg,
            borderRadius: BorderRadius.circular(14),
            border: Border.all(color: _cardBorder),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Row(
                children: [
                  Icon(Icons.edit_document, size: 18, color: _appBlue),
                  SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      'Formulir Pengajuan Layanan',
                      style: TextStyle(
                        fontSize: 14.5,
                        fontWeight: FontWeight.w800,
                        color: _titleBlue,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 6),
              Text.rich(
                TextSpan(
                  children: [
                    const TextSpan(
                      text: 'Lengkapi form di bawah ini untuk mengajukan '
                          'layanan ',
                      style: TextStyle(fontSize: 11.5, color: _smoke),
                    ),
                    TextSpan(
                      text: '${widget.info.nama}.',
                      style: const TextStyle(
                        fontSize: 11.5,
                        fontWeight: FontWeight.w700,
                        color: _smoke,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              _label('Nama Lengkap', wajib: true),
              const SizedBox(height: 6),
              _field(_nama, 'Nama lengkap sesuai KTP El'),
              const SizedBox(height: 12),
              _label('Email', wajib: true),
              const SizedBox(height: 6),
              _field(_email, 'Email aktif',
                  keyboardType: TextInputType.emailAddress),
              const SizedBox(height: 12),
              _label('Nomor Whatsapp', wajib: true),
              const SizedBox(height: 6),
              _field(_wa, '6281xxxx', keyboardType: TextInputType.phone),
              const SizedBox(height: 12),
              _label('NIK', wajib: true),
              const SizedBox(height: 6),
              _field(_nik, '33xxxxxxxxxxxx', keyboardType: TextInputType.number),
              const SizedBox(height: 12),
              _label('Keterangan', wajib: true),
              const SizedBox(height: 6),
              _field(_ket, 'Isikan keterangan tambahan jika ada..', maxLines: 3),
              const SizedBox(height: 20),
              _buildLampiran(),
              const SizedBox(height: 16),
              _buildRecaptcha(),
              const SizedBox(height: 14),
              _buildKirim(),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildBullet(LayananBullet b) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Padding(
                padding: EdgeInsets.only(top: 6, right: 8),
                child: _Dot(color: _titleBlue),
              ),
              Expanded(
                child: Text(
                  b.judul,
                  style: const TextStyle(
                    fontSize: 12.5,
                    fontWeight: FontWeight.w800,
                    color: _titleBlue,
                    height: 1.4,
                  ),
                ),
              ),
            ],
          ),
          ...b.subs.map(
            (s) => Padding(
              padding: const EdgeInsets.only(left: 16, top: 4),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Padding(
                    padding: EdgeInsets.only(top: 6, right: 8),
                    child: _Dot(color: Color(0xFFB0B7BF), size: 5),
                  ),
                  Expanded(
                    child: Text(
                      s,
                      style: const TextStyle(
                        fontSize: 12,
                        color: _smoke,
                        height: 1.45,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _label(String text, {bool wajib = false}) {
    return Text.rich(
      TextSpan(
        children: [
          TextSpan(
            text: text,
            style: const TextStyle(
              fontSize: 12.5,
              fontWeight: FontWeight.w700,
              color: _titleBlue,
            ),
          ),
          if (wajib)
            const TextSpan(
              text: ' *',
              style: TextStyle(
                fontSize: 12.5,
                fontWeight: FontWeight.w700,
                color: _danger,
              ),
            ),
        ],
      ),
    );
  }

  Widget _field(
    TextEditingController c,
    String hint, {
    TextInputType keyboardType = TextInputType.text,
    int maxLines = 1,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(11),
        border: Border.all(color: _cardBorder),
      ),
      child: TextField(
        controller: c,
        keyboardType: keyboardType,
        maxLines: maxLines,
        style: const TextStyle(fontSize: 13.5, color: _titleBlue),
        decoration: InputDecoration(
          isCollapsed: true,
          border: InputBorder.none,
          hintText: hint,
          hintStyle: const TextStyle(fontSize: 13, color: Color(0xFFB0B7BF)),
        ),
      ),
    );
  }

  Widget _buildLampiran() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Center(
          child: Text(
            'Lampiran Berkas',
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w800,
              color: _titleBlue,
            ),
          ),
        ),
        const SizedBox(height: 4),
        const Center(
          child: Text.rich(
            TextSpan(
              children: [
                TextSpan(
                  text: 'Berkas yang bertanda ',
                  style: TextStyle(fontSize: 11, color: _smoke),
                ),
                TextSpan(
                  text: 'BINTANG',
                  style: TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.w800,
                    color: _danger,
                  ),
                ),
                TextSpan(
                  text: ' Wajib diisi..!',
                  style: TextStyle(fontSize: 11, color: _smoke),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 12),
        ...List.generate(_berkas.length, _berkasRow),
        const SizedBox(height: 8),
        const Text.rich(
          TextSpan(
            children: [
              TextSpan(
                text: 'Berkas yang tidak bertanda bintang dan jika ',
                style: TextStyle(fontSize: 10.5, color: _smoke, height: 1.4),
              ),
              TextSpan(
                text: 'tidak',
                style: TextStyle(
                  fontSize: 10.5,
                  fontWeight: FontWeight.w800,
                  color: _danger,
                ),
              ),
              TextSpan(
                text: ' DIUPLOAD, maka klik tombol ',
                style: TextStyle(fontSize: 10.5, color: _smoke, height: 1.4),
              ),
              TextSpan(
                text: 'HAPUS',
                style: TextStyle(
                  fontSize: 10.5,
                  fontWeight: FontWeight.w800,
                  color: _danger,
                ),
              ),
              TextSpan(
                text: ' di sebelahnya..!',
                style: TextStyle(fontSize: 10.5, color: _smoke, height: 1.4),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _berkasRow(int i) {
    final berkas = _berkas[i];
    final file = _files[i];
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(11),
        border: Border.all(color: _cardBorder),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 22,
                height: 22,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: _fieldBg,
                  borderRadius: BorderRadius.circular(6),
                  border: Border.all(color: _cardBorder),
                ),
                child: Text(
                  '${i + 1}',
                  style: const TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.w800,
                    color: _titleBlue,
                  ),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Text.rich(
                  TextSpan(
                    children: [
                      TextSpan(
                        text: berkas.nama,
                        style: const TextStyle(
                          fontSize: 12.5,
                          fontWeight: FontWeight.w600,
                          color: _titleBlue,
                          height: 1.35,
                        ),
                      ),
                      if (berkas.wajib)
                        const TextSpan(
                          text: ' *',
                          style: TextStyle(
                            fontSize: 12.5,
                            fontWeight: FontWeight.w800,
                            color: _danger,
                          ),
                        ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              GestureDetector(
                onTap: () => setState(() => _files[i] = 'berkas_${i + 1}.pdf'),
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  decoration: BoxDecoration(
                    color: _fieldBg,
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: _cardBorder),
                  ),
                  child: const Text(
                    'Pilih Berkas',
                    style: TextStyle(
                      fontSize: 11.5,
                      fontWeight: FontWeight.w700,
                      color: _titleBlue,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Text(
                  file ?? 'Belum ada file',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: 11.5,
                    color: file == null ? const Color(0xFFB0B7BF) : _appBlue,
                    fontWeight:
                        file == null ? FontWeight.w400 : FontWeight.w600,
                  ),
                ),
              ),
              const SizedBox(width: 8),
              GestureDetector(
                onTap: () {
                  if (berkas.wajib) return;
                  setState(() => _files[i] = null);
                },
                child: Container(
                  width: 34,
                  height: 34,
                  decoration: BoxDecoration(
                    color: berkas.wajib
                        ? _appBlue.withValues(alpha: 0.12)
                        : _danger.withValues(alpha: 0.12),
                    borderRadius: BorderRadius.circular(9),
                  ),
                  child: Icon(
                    berkas.wajib
                        ? Icons.settings_rounded
                        : Icons.delete_rounded,
                    size: 17,
                    color: berkas.wajib ? _appBlue : _danger,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildRecaptcha() {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(9),
        border: Border.all(color: _cardBorder),
      ),
      child: Row(
        children: [
          GestureDetector(
            onTap: () => setState(() => _robot = !_robot),
            child: Container(
              width: 24,
              height: 24,
              decoration: BoxDecoration(
                color: _robot ? _appBlue : Colors.white,
                borderRadius: BorderRadius.circular(5),
                border: Border.all(
                  color: _robot ? _appBlue : const Color(0xFFC4C9CF),
                ),
              ),
              child: _robot
                  ? const Icon(Icons.check, size: 16, color: Colors.white)
                  : null,
            ),
          ),
          const SizedBox(width: 12),
          const Expanded(
            child: Text(
              "I'm not a robot",
              style: TextStyle(fontSize: 12.5, color: _titleBlue),
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: const [
              Icon(Icons.refresh_rounded, size: 20, color: Color(0xFF4285F4)),
              Text(
                'reCAPTCHA',
                style: TextStyle(
                  fontSize: 7,
                  fontWeight: FontWeight.w700,
                  color: _smoke,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildKirim() {
    return SizedBox(
      width: double.infinity,
      child: GestureDetector(
        onTap: _submit,
        child: Container(
          height: 48,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: _appBlue,
            borderRadius: BorderRadius.circular(12),
          ),
          child: const Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.send_rounded, size: 17, color: Colors.white),
              SizedBox(width: 9),
              Text(
                'Kirim Ajuan',
                style: TextStyle(
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

  void _submit() {
    if (_nama.text.trim().isEmpty ||
        _email.text.trim().isEmpty ||
        _wa.text.trim().isEmpty ||
        _nik.text.trim().isEmpty ||
        _ket.text.trim().isEmpty) {
      _snack('Lengkapi semua kolom bertanda bintang (*).');
      return;
    }
    if (_files.isNotEmpty && _files[0] == null) {
      _snack('Unggah berkas wajib (bertanda bintang) terlebih dahulu.');
      return;
    }
    if (!_robot) {
      _snack('Centang verifikasi "I\'m not a robot" terlebih dahulu.');
      return;
    }
    FocusScope.of(context).unfocus();
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: const Row(
          children: [
            Icon(Icons.check_circle_rounded, color: _green),
            SizedBox(width: 10),
            Text('Ajuan Terkirim'),
          ],
        ),
        content: Text(
          'Ajuan ${widget.info.nama} telah dikirim dan akan diproses oleh '
          'Disdikbud Kabupaten Sragen.',
          style: const TextStyle(height: 1.5),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Selesai'),
          ),
        ],
      ),
    );
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

class _Dot extends StatelessWidget {
  final Color color;
  final double size;
  const _Dot({required this.color, this.size = 6});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(color: color, shape: BoxShape.circle),
    );
  }
}
