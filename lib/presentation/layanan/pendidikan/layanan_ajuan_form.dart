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
  final List<SyaratGroup> syarat;

  const LayananInfo({
    required this.nama,
    required this.ringkasan,
    this.bullets = const [],
    this.tanggal = '2022-12-18',
    this.berkas = const [],
    this.syarat = const [],
  });
}

class SyaratGroup {
  final String judul;
  final List<String> items;

  /// Label yang tampil di kolom kiri untuk kelompok ini (mis. "Persyaratan"
  /// atau "Jaminan Keamanan Produk Pelayanan"). Kosong = ikut sel kiri
  /// kelompok sebelumnya.
  final String labelKiri;

  /// Jika false, item ditampilkan tanpa nomor urut.
  final bool bernomor;

  const SyaratGroup(
    this.judul,
    this.items, {
    this.labelKiri = '',
    this.bernomor = true,
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
        if (widget.info.ringkasan.isNotEmpty)
          Text(
            widget.info.ringkasan,
            style: const TextStyle(fontSize: 13, color: _smoke, height: 1.5),
          ),
        if (widget.info.bullets.isNotEmpty) ...[
          const SizedBox(height: 12),
          ...widget.info.bullets.map(_buildBullet),
        ],
        if (widget.info.syarat.isNotEmpty) ...[
          const SizedBox(height: 14),
          _buildSyaratTable(),
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
          if (b.judul.isNotEmpty)
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
          ...b.subs.asMap().entries.map(
                (e) => Padding(
                  padding: EdgeInsets.only(
                      left: b.judul.isEmpty ? 0 : 18, top: 5),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 1, right: 8),
                        child: Text(
                          '${e.key + 1}.',
                          style: const TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w700,
                            color: _appBlue,
                            height: 1.45,
                          ),
                        ),
                      ),
                      Expanded(
                        child: Text(
                          e.value,
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

  // ---- Tabel Persyaratan: kolom kiri label (row-span per blok),
  //      kolom kanan judul kelompok + baris (bernomor / polos) ----
  Widget _buildSyaratTable() {
    // Kelompokkan syarat menjadi blok berdasarkan labelKiri.
    // Kelompok tanpa labelKiri ikut blok sebelumnya.
    final groups = widget.info.syarat;
    final blocks = <_SyaratBlock>[];
    for (final g in groups) {
      if (g.labelKiri.isNotEmpty || blocks.isEmpty) {
        blocks.add(_SyaratBlock(
          g.labelKiri.isEmpty ? 'Persyaratan' : g.labelKiri,
          [g],
        ));
      } else {
        blocks.last.groups.add(g);
      }
    }

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: _cardBorder),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.03),
            blurRadius: 5,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            for (var b = 0; b < blocks.length; b++)
              Container(
                decoration: BoxDecoration(
                  border: b == blocks.length - 1
                      ? null
                      : const Border(
                          bottom: BorderSide(color: _cardBorder),
                        ),
                ),
                child: IntrinsicHeight(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      // Kolom kiri: label blok
                      Container(
                        width: 96,
                        alignment: Alignment.topCenter,
                        padding: const EdgeInsets.fromLTRB(6, 7, 5, 10),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          border: const Border(
                            right: BorderSide(color: _cardBorder),
                          ),
                        ),
                        child: Text(
                          blocks[b].label,
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            fontSize: 11.5,
                            fontWeight: FontWeight.w800,
                            color: _titleBlue,
                            height: 1.3,
                          ),
                        ),
                      ),
                      // Kolom kanan: konten blok
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: _buildBlockRows(blocks[b]),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  List<Widget> _buildBlockRows(_SyaratBlock block) {
    final widgets = <Widget>[];
    for (var g = 0; g < block.groups.length; g++) {
      final group = block.groups[g];
      final bool firstGroup = g == 0;

      // Judul kelompok (dilewati jika kosong)
      if (group.judul.isNotEmpty) {
        widgets.add(
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border(
                top: firstGroup
                    ? BorderSide.none
                    : const BorderSide(color: _cardBorder),
                bottom: const BorderSide(color: _cardBorder),
              ),
            ),
            child: Text(
              group.judul,
              style: const TextStyle(
                fontSize: 11.5,
                fontWeight: FontWeight.w800,
                color: _titleBlue,
                height: 1.3,
              ),
            ),
          ),
        );
      }

      // Baris item
      for (var i = 0; i < group.items.length; i++) {
        final lastRow =
            g == block.groups.length - 1 && i == group.items.length - 1;
        widgets.add(
          Container(
            constraints: group.items[i].isEmpty
                ? const BoxConstraints(minHeight: 14)
                : const BoxConstraints(),
            padding:
                const EdgeInsets.symmetric(horizontal: 10, vertical: 7),
            decoration: BoxDecoration(
              color: Colors.white,
              border: lastRow
                  ? null
                  : const Border(
                      bottom: BorderSide(color: _cardBorder),
                    ),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Kolom nomor: tetap ada lebarnya agar teks sejajar dengan
                // baris bernomor, meski nomornya kosong.
                SizedBox(
                  width: 17,
                  child: (group.bernomor && group.items[i].isNotEmpty)
                      ? Text(
                          '${i + 1}',
                          style: const TextStyle(
                            fontSize: 11,
                            fontWeight: FontWeight.w700,
                            color: _appBlue,
                            height: 1.35,
                          ),
                        )
                      : null,
                ),
                Expanded(
                  child: Text(
                    group.items[i],
                    style: const TextStyle(
                      fontSize: 11,
                      color: _smoke,
                      height: 1.35,
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      }
    }
    return widgets;
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
        // Header dengan ikon + judul + progress chip
        Row(
          children: [
            Container(
              width: 34,
              height: 34,
              decoration: BoxDecoration(
                color: _appBlue.withValues(alpha: 0.12),
                borderRadius: BorderRadius.circular(10),
              ),
              child: const Icon(Icons.folder_copy_rounded,
                  size: 18, color: _appBlue),
            ),
            const SizedBox(width: 10),
            const Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Lampiran Berkas',
                    style: TextStyle(
                      fontSize: 14.5,
                      fontWeight: FontWeight.w800,
                      color: _titleBlue,
                    ),
                  ),
                  SizedBox(height: 2),
                  Text(
                    'Unggah dokumen pendukung ajuan Anda',
                    style: TextStyle(fontSize: 11, color: _smoke),
                  ),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(height: 14),
        // ---- Tabel Lampiran (No | Nama Berkas | Unggah | Aksi) ----
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(14),
            border: Border.all(color: _cardBorder),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.03),
                blurRadius: 5,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Column(
            children: [
              _tableHeader(),
              ...List.generate(_berkas.length, _berkasRow),
            ],
          ),
        ),
      ],
    );
  }

  // ---- Header tabel ----
  Widget _tableHeader() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 11),
      decoration: BoxDecoration(
        color: _appBlue.withValues(alpha: 0.08),
        borderRadius: const BorderRadius.vertical(top: Radius.circular(13)),
      ),
      child: Row(
        children: const [
          SizedBox(
            width: 26,
            child: Text(
              'No',
              style: TextStyle(
                fontSize: 11.5,
                fontWeight: FontWeight.w800,
                color: _titleBlue,
              ),
            ),
          ),
          SizedBox(width: 8),
          Expanded(
            child: Text(
              'Nama Berkas',
              style: TextStyle(
                fontSize: 11.5,
                fontWeight: FontWeight.w800,
                color: _titleBlue,
              ),
            ),
          ),
          SizedBox(width: 8),
          SizedBox(
            width: 76,
            child: Text(
              'Unggah',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 11.5,
                fontWeight: FontWeight.w800,
                color: _titleBlue,
              ),
            ),
          ),
          SizedBox(width: 8),
          SizedBox(
            width: 40,
            child: Text(
              'Aksi',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 11.5,
                fontWeight: FontWeight.w800,
                color: _titleBlue,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _berkasRow(int i) {
    final berkas = _berkas[i];
    final file = _files[i];
    final bool uploaded = file != null;
    final bool isLast = i == _berkas.length - 1;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
      decoration: BoxDecoration(
        color: uploaded ? _green.withValues(alpha: 0.05) : Colors.white,
        border: isLast
            ? null
            : const Border(
                bottom: BorderSide(color: _cardBorder),
              ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // No
          SizedBox(
            width: 26,
            child: Container(
              width: 24,
              height: 24,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [_appBlue, _appBlue.withValues(alpha: 0.75)],
                ),
                borderRadius: BorderRadius.circular(7),
              ),
              child: Text(
                '${i + 1}',
                style: const TextStyle(
                  fontSize: 11.5,
                  fontWeight: FontWeight.w800,
                  color: Colors.white,
                ),
              ),
            ),
          ),
          const SizedBox(width: 8),
          // Nama Berkas
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text.rich(
                  TextSpan(
                    children: [
                      TextSpan(
                        text: berkas.nama,
                        style: const TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w700,
                          color: _titleBlue,
                          height: 1.3,
                        ),
                      ),
                      if (berkas.wajib)
                        const TextSpan(
                          text: '  *',
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w800,
                            color: _danger,
                          ),
                        ),
                    ],
                  ),
                ),
                if (uploaded) ...[
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      const Icon(Icons.check_circle_rounded,
                          size: 12, color: _green),
                      const SizedBox(width: 4),
                      Flexible(
                        child: Text(
                          file,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            fontSize: 10.5,
                            fontWeight: FontWeight.w600,
                            color: _green,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ],
            ),
          ),
          const SizedBox(width: 8),
          // Unggah
          SizedBox(
            width: 76,
            child: Center(child: _uploadCell(i)),
          ),
          const SizedBox(width: 8),
          // Aksi (settings jika wajib, delete jika opsional)
          SizedBox(
            width: 40,
            child: Center(child: _aksiCell(i, berkas)),
          ),
        ],
      ),
    );
  }

  // Kolom "Unggah": tombol pilih berkas / indikator sudah diunggah
  Widget _uploadCell(int i) {
    final uploaded = _files[i] != null;
    return GestureDetector(
      onTap: () => setState(() => _files[i] = 'berkas_${i + 1}.pdf'),
      child: Container(
        height: 34,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: uploaded
              ? _green.withValues(alpha: 0.12)
              : _appBlue.withValues(alpha: 0.10),
          borderRadius: BorderRadius.circular(9),
          border: Border.all(
            color: uploaded
                ? _green.withValues(alpha: 0.35)
                : _appBlue.withValues(alpha: 0.30),
          ),
        ),
        child: Icon(
          uploaded ? Icons.autorenew_rounded : Icons.cloud_upload_rounded,
          size: 17,
          color: uploaded ? _green : _appBlue,
        ),
      ),
    );
  }

  // Kolom "Aksi": settings (berkas wajib) / delete (berkas opsional)
  Widget _aksiCell(int i, BerkasItem berkas) {
    final bool wajib = berkas.wajib;
    return GestureDetector(
      onTap: () {
        if (wajib) {
          _snack('Berkas wajib tidak dapat dihapus. Ganti file bila perlu.');
        } else {
          setState(() => _files[i] = null);
          _snack('Berkas opsional dihapus.');
        }
      },
      child: Container(
        width: 34,
        height: 34,
        decoration: BoxDecoration(
          color: wajib
              ? _appBlue.withValues(alpha: 0.12)
              : _danger.withValues(alpha: 0.12),
          borderRadius: BorderRadius.circular(9),
        ),
        child: Icon(
          wajib ? Icons.settings_rounded : Icons.delete_rounded,
          size: 17,
          color: wajib ? _appBlue : _danger,
        ),
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

class _SyaratBlock {
  final String label;
  final List<SyaratGroup> groups;
  _SyaratBlock(this.label, this.groups);
}

class _Dot extends StatelessWidget {
  final Color color;
  const _Dot({required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 6,
      height: 6,
      decoration: BoxDecoration(color: color, shape: BoxShape.circle),
    );
  }
}
