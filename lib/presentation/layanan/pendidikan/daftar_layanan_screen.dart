import 'package:flutter/material.dart';

import '../../agenda/agenda_screen.dart';
import 'layanan_ajuan_form.dart';
import 'layanan_detail_pendidikan_screen.dart';

// ================================================================
// DAFTAR LAYANAN — Langit Sukowati DISDIKBUD
// Desain mengikuti context/daftar.png:
//  - Search + dropdown "Semua Bidang"
//  - Info jumlah layanan aktif
//  - Kartu layanan yang bisa di-expand (nama, bidang, detail)
// ================================================================

class DaftarLayananScreen extends StatefulWidget {
  const DaftarLayananScreen({super.key});

  @override
  State<DaftarLayananScreen> createState() => _DaftarLayananScreenState();
}

class _DaftarLayananScreenState extends State<DaftarLayananScreen> {
  static const Color _appBlue = Color(0xFF007EA7);
  static const Color _tealLight = Color(0xFF58D8EC);
  static const Color _navyDark = Color(0xFF315579);
  static const Color _bg = Color(0xFFF8FAFC);
  static const Color _titleBlue = Color(0xFF003D6B);
  static const Color _smoke = Color(0xFF6B7280);
  static const Color _cardBorder = Color(0xFFE8ECF0);

  String _query = '';
  String _bidang = 'Semua Bidang';

  // ---- Bidang + ikon + warna ----
  static const Map<String, _BidangStyle> _bidangStyles = {
    'Sekretariat': _BidangStyle(
        Icons.admin_panel_settings_rounded, Color(0xFF12B76A)),
    'Bidang Pembinaan GTK': _BidangStyle(Icons.groups_rounded, Color(0xFF7B57C7)),
    'Bidang Pembinaan SD': _BidangStyle(Icons.school_rounded, Color(0xFF2F80ED)),
    'Bidang Pembinaan SMP':
        _BidangStyle(Icons.menu_book_rounded, Color(0xFFE0567F)),
    'Bidang Pembinaan PAUDPNF':
        _BidangStyle(Icons.child_care_rounded, Color(0xFFE0A118)),
  };

  // ---- 22 layanan ----
  static const List<_Layanan> _all = [
    _Layanan('Perubahan Akun Dapodik', 'Sekretariat'),
    _Layanan('Penyesuaian Data PTK - PAUDPNF', 'Bidang Pembinaan GTK'),
    _Layanan('Penyesuaian Data PTK - SD', 'Bidang Pembinaan GTK'),
    _Layanan('Penyesuaian Data PTK - SMP', 'Bidang Pembinaan GTK'),
    _Layanan('Permohonan Kode Referal Operator Yayasan', 'Sekretariat'),
    _Layanan('Surat Keterangan Pindah Keluar Siswa SD', 'Sekretariat'),
    _Layanan('Surat Keterangan Pindah Keluar Siswa SMP', 'Sekretariat'),
    _Layanan('Penyesuaian Data Rombel Siswa', 'Sekretariat'),
    _Layanan('Penerbitan NPSN dan NSS', 'Sekretariat'),
    _Layanan('Mutasi Dapodik PTK - SD', 'Bidang Pembinaan GTK'),
    _Layanan('Mutasi Dapodik PTK - SMP', 'Bidang Pembinaan GTK'),
    _Layanan('Mutasi Dapodik PTK - PAUD/PNF', 'Bidang Pembinaan GTK'),
    _Layanan('Penugasan Kepala Sekolah & Plt. Kepala Sekolah SD - Dapodik',
        'Bidang Pembinaan GTK'),
    _Layanan('Penugasan Kepala Sekolah & Plt. Kepala SMP - Dapodik',
        'Bidang Pembinaan GTK'),
    _Layanan('Penerbitan NPYP (Nomor Pokok Yayasan Pendidikan)', 'Sekretariat'),
    _Layanan('Pengaktifan kembali siswa dapodik', 'Sekretariat'),
    _Layanan('Penugasan Kepala Sekolah & Plt. Kepala PAUD/PNF',
        'Bidang Pembinaan GTK'),
    _Layanan('Pengadaan Barang dan Jasa', 'Bidang Pembinaan SMP'),
    _Layanan('Pembatalan Kelulusan/Meluluskan Siswa di DAPODIK', 'Sekretariat'),
    _Layanan('Laporan Bulanan Kepegawaian', 'Bidang Pembinaan GTK'),
    _Layanan('Laporan Progres SEDUKARSA', 'Bidang Pembinaan SD'),
    _Layanan(
        'Penerbitan NPSN PAUD, PKBM, LKP, BIMBEL', 'Bidang Pembinaan PAUDPNF'),
  ];

  List<String> get _bidangOptions => ['Semua Bidang', ..._bidangStyles.keys];

  List<_Layanan> get _filtered {
    return _all.where((l) {
      final q = _query.trim().toLowerCase();
      if (q.isNotEmpty && !l.nama.toLowerCase().contains(q)) return false;
      if (_bidang != 'Semua Bidang' && l.bidang != _bidang) return false;
      return true;
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _bg,
      bottomNavigationBar: _buildNavBar(context),
      body: SafeArea(
        child: Column(
          children: [
            _buildHeader(context),
            _buildFilterPanel(),
            Expanded(
              child: _filtered.isEmpty
                  ? _buildEmpty()
                  : ListView.separated(
                      physics: const BouncingScrollPhysics(),
                      padding: const EdgeInsets.fromLTRB(20, 14, 20, 28),
                      itemCount: _filtered.length,
                      separatorBuilder: (_, __) => const SizedBox(height: 10),
                      itemBuilder: (context, index) {
                        return _buildCard(_filtered[index]);
                      },
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
        color: _bg,
        border: Border(bottom: BorderSide(color: Color(0xFFE5E7EB), width: 0.7)),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Row(
        children: [
          GestureDetector(
            onTap: () => Navigator.pop(context),
            child: const Icon(Icons.arrow_back_ios_new_rounded,
                size: 22, color: _appBlue),
          ),
          const SizedBox(width: 16),
          const Text(
            'Daftar Layanan',
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.w700,
              color: _appBlue,
            ),
          ),
        ],
      ),
    );
  }

  // ============================================================
  // FILTER PANEL
  // ============================================================
  Widget _buildFilterPanel() {
    return Container(
      margin: const EdgeInsets.fromLTRB(20, 14, 20, 0),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: _cardBorder),
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
          // SEARCH
          Container(
            height: 46,
            padding: const EdgeInsets.symmetric(horizontal: 12),
            decoration: BoxDecoration(
              color: const Color(0xFFF7F9FB),
              borderRadius: BorderRadius.circular(11),
              border: Border.all(color: _cardBorder),
            ),
            child: Row(
              children: [
                const Icon(Icons.search_rounded, size: 18, color: _smoke),
                const SizedBox(width: 8),
                Expanded(
                  child: TextField(
                    onChanged: (v) => setState(() => _query = v),
                    style: const TextStyle(fontSize: 13, color: _titleBlue),
                    decoration: const InputDecoration(
                      isCollapsed: true,
                      border: InputBorder.none,
                      hintText: 'Cari nama layanan...',
                      hintStyle:
                          TextStyle(fontSize: 13, color: Color(0xFFB0B7BF)),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 10),
          // DROPDOWN BIDANG
          Container(
            height: 46,
            padding: const EdgeInsets.symmetric(horizontal: 12),
            decoration: BoxDecoration(
              color: const Color(0xFFF7F9FB),
              borderRadius: BorderRadius.circular(11),
              border: Border.all(color: _cardBorder),
            ),
            child: DropdownButtonHideUnderline(
              child: DropdownButton<String>(
                value: _bidang,
                isExpanded: true,
                icon: const Icon(Icons.keyboard_arrow_down_rounded,
                    color: _smoke),
                style: const TextStyle(fontSize: 13, color: _titleBlue),
                items: _bidangOptions
                    .map((b) => DropdownMenuItem<String>(
                          value: b,
                          child: Text(b, overflow: TextOverflow.ellipsis),
                        ))
                    .toList(),
                onChanged: (v) => setState(() => _bidang = v ?? 'Semua Bidang'),
              ),
            ),
          ),
          const SizedBox(height: 12),
          // INFO
          Row(
            children: [
              const Icon(Icons.filter_list_rounded, size: 16, color: _smoke),
              const SizedBox(width: 6),
              Text(
                'Menampilkan ${_filtered.length} dari ${_all.length} layanan aktif',
                style: const TextStyle(fontSize: 12, color: _smoke),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // ============================================================
  // CARD — tap membuka halaman detail (bukan dropdown)
  // ============================================================
  Widget _buildCard(_Layanan l) {
    final style = _bidangStyles[l.bidang]!;

    return GestureDetector(
      onTap: () => _openDetail(l, style),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: _cardBorder),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.03),
              blurRadius: 6,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        padding: const EdgeInsets.all(14),
        child: Row(
          children: [
            // Icon chip bidang
            Container(
              width: 46,
              height: 46,
              decoration: BoxDecoration(
                color: style.color.withValues(alpha: 0.12),
                borderRadius: BorderRadius.circular(13),
              ),
              child: Icon(style.icon, size: 22, color: style.color),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    l.nama,
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                      color: _titleBlue,
                      height: 1.3,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 9, vertical: 5),
                    decoration: BoxDecoration(
                      color: style.color.withValues(alpha: 0.10),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(style.icon, size: 13, color: style.color),
                        const SizedBox(width: 5),
                        Text(
                          l.bidang,
                          style: TextStyle(
                            fontSize: 10.5,
                            fontWeight: FontWeight.w600,
                            color: style.color,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 8),
            Container(
              width: 30,
              height: 30,
              decoration: BoxDecoration(
                color: _appBlue.withValues(alpha: 0.08),
                shape: BoxShape.circle,
              ),
              child: const Icon(Icons.arrow_forward_ios_rounded,
                  size: 13, color: _appBlue),
            ),
          ],
        ),
      ),
    );
  }

  void _openDetail(_Layanan l, _BidangStyle style) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => LayananDetailPendidikanScreen(
          nama: l.nama,
          bidang: l.bidang,
          bidangIcon: style.icon,
          bidangColor: style.color,
          info: _infoFor(l),
        ),
      ),
    );
  }

  Widget _buildEmpty() {
    return const Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.search_off_rounded, size: 44, color: _smoke),
          SizedBox(height: 12),
          Text(
            'Layanan tidak ditemukan.',
            style: TextStyle(fontSize: 13, color: _smoke),
          ),
        ],
      ),
    );
  }

  // Konten dropdown per layanan.
  LayananInfo _infoFor(_Layanan l) {
    if (l.nama == 'Perubahan Akun Dapodik') {
      return const LayananInfo(
        nama: 'Perubahan Akun Dapodik',
        ringkasan:
            'Layanan perubahan atau update password dapodik untuk Guru, Tenaga '
            'Kependidikan, dan Operator Sekolah.',
        bullets: [
          LayananBullet('Untuk perubahan akun operator sekolah', [
            'Mencantumkan email yang akan digunakan, jika ubah email '
                '(disarankan email sekolah).',
            'Mencantumkan password yang akan digunakan dengan ketentuan minimal '
                '8 karakter mengandung huruf besar kecil, tanda baca, angka.',
          ]),
          LayananBullet('Untuk perubahan akun guru/ptk', [
            'Perubahan email bisa ditambahkan oleh operator sekolah setelah '
                'email lama dihapus oleh admin dinas.',
            'Untuk perubahan password mencantumkan password yang akan digunakan '
                'dengan ketentuan minimal 8 karakter mengandung huruf besar '
                'kecil, tanda baca, angka.',
          ]),
        ],
        tanggal: '2022-12-18',
        berkas: [
          BerkasItem('Surat Permohonan (pdf/gambar)', wajib: true),
          BerkasItem('Surat Penugasan Operator Dapodik (jika akun operator)'),
          BerkasItem(
              'Surat Penugasan Guru/Tenaga Kependidikan (jika akun guru)'),
        ],
      );
    }
    if (l.nama == 'Penyesuaian Data PTK - PAUDPNF') {
      return const LayananInfo(
        nama: 'Penyesuaian Data PTK - PAUDPNF',
        ringkasan:
            'Layanan Perbaikan Data Pendidik dan Tenaga Kependidikan pada '
            'Dapodik Jenjang PAUD PNF.',
        tanggal: '2022-12-18',
        berkas: [
          BerkasItem(
              'Surat Permohonan ditujukan kepada Kepala Dinas Pendidikan dan '
              'Kebudayaan',
              wajib: true),
          BerkasItem('Lampiran Pendukung Perubahan Data', wajib: true),
          BerkasItem('Pengantar Korwil', wajib: true),
        ],
      );
    }
    if (l.nama == 'Penyesuaian Data PTK - SD') {
      return const LayananInfo(
        nama: 'Penyesuaian Data PTK - SD',
        ringkasan:
            'Layanan Perbaikan Data Pendidik dan Tenaga Kependidikan pada '
            'Dapodik Jenjang SD, meliputi:',
        bullets: [
          LayananBullet('', [
            'Perubahan Jenis PTK pada pangkalan data DAPODIK',
            'Penyesuaian TMT pada pangkalan data DAPODIK',
            'Penyesuaian Tempat Penugasan pada pangkalan data DAPODIK',
          ]),
        ],
        tanggal: '2022-12-18',
        berkas: [
          BerkasItem('Surat Permohonan', wajib: true),
          BerkasItem('Lampiran Pendukung Perubahan Data', wajib: true),
          BerkasItem('Pengantar Korwil', wajib: true),
        ],
      );
    }
    if (l.nama == 'Penyesuaian Data PTK - SMP') {
      return const LayananInfo(
        nama: 'Penyesuaian Data PTK - SMP',
        ringkasan:
            'Layanan Perbaikan Data Pendidik dan Tenaga Kependidikan pada '
            'Dapodik Jenjang SMP, meliputi:',
        bullets: [
          LayananBullet('', [
            'Perubahan Jenis PTK pada pangkalan data DAPODIK',
            'Penyesuaian TMT pada pangkalan data DAPODIK',
          ]),
        ],
        tanggal: '2022-12-18',
        berkas: [
          BerkasItem('Surat Permohonan (pdf/gambar)', wajib: true),
          BerkasItem('Lampiran Pendukung Perubahan Data', wajib: true),
        ],
      );
    }
    if (l.nama == 'Permohonan Kode Referal Operator Yayasan') {
      return const LayananInfo(
        nama: 'Permohonan Kode Referal Operator Yayasan',
        ringkasan:
            'Permohonan Kode Referal untuk pendaftaran Operator Yayasan pada '
            'laman SDM Pusdatin (kemdikbud.go.id).',
        tanggal: '2022-12-18',
        berkas: [
          BerkasItem('Surat Penugasan Operator Yayasan (Gambar/PDF)',
              wajib: true),
        ],
      );
    }
    if (l.nama == 'Surat Keterangan Pindah Keluar Siswa SD') {
      return const LayananInfo(
        nama: 'Surat Keterangan Pindah Keluar Siswa SD',
        ringkasan: '',
        syarat: [
          SyaratGroup('Mutasi Keluar Sekolah dalam Kabupaten Sragen', [
            'Surat keterangan pindah sekolah yang ditandatangani Kepala '
                'Sekolah',
            'Surat Keterangan Formasi kelas dari Sekolah yang akan dituju',
            'Fotokopi raport rangkap 1 (satu)',
            'Menunjukkan rapot asli',
          ]),
          SyaratGroup('Mutasi Keluar Sekolah ke Kabupaten/Kota lain', [
            'Surat permohonan mutasi yang ditandatangani Kepala Sekolah',
            'Fotokopi rapot rangkap 1 (satu)',
            'Menunjukkan rapot asli',
          ]),
        ],
        tanggal: '2022-12-18',
        berkas: [
          BerkasItem('Surat Keterangan Pindah dari Sekolah asal (gambar/pdf)',
              wajib: true),
          BerkasItem('Rapot Siswa (Gambar/PDF)', wajib: true),
        ],
      );
    }
    if (l.nama == 'Penyesuaian Data Rombel Siswa') {
      return const LayananInfo(
        nama: 'Penyesuaian Data Rombel Siswa',
        ringkasan:
            'Layanan perubahan data siswa, rombel, kelas pada pangkalan data '
            'DAPODIK.\n\nCatatan: Untuk ajuan perubahan penyesuaian '
            'rombel/kelas peserta didik dipastikan anak sudah terdata pada '
            'Dapodik dan sekolah telah melakukan singkronisasi dapodik.',
        tanggal: '2022-12-21',
        berkas: [
          BerkasItem('Surat Permohonan (pdf/gambar)', wajib: true),
          BerkasItem('Lampiran Pendukung Perubahan Data', wajib: true),
        ],
      );
    }
    if (l.nama == 'Mutasi Dapodik PTK - SD') {
      return const LayananInfo(
        nama: 'Mutasi Dapodik PTK - SD',
        ringkasan: 'Permohonan Mutasi Data Dapodik GTK Sekolah Dasar.',
        tanggal: '2023-01-04',
        berkas: [
          BerkasItem(
              'Surat Permohonan Mutasi PTK dari KS kepada Kepala Dinas',
              wajib: true),
          BerkasItem('Ijazah S1 dan Sertifikat Pendidik', wajib: true),
          BerkasItem('SK Pembagian Tugas', wajib: true),
          BerkasItem('Surat keterangan Mutasi dari Sekolah Lama', wajib: true),
          BerkasItem('SK Penugasan di Unit Kerja Baru', wajib: true),
          BerkasItem('Profil PTK dari Dapodik', wajib: true),
          BerkasItem('Pengantar Korwil', wajib: true),
        ],
      );
    }
    if (l.nama == 'Mutasi Dapodik PTK - SMP') {
      return const LayananInfo(
        nama: 'Mutasi Dapodik PTK - SMP',
        ringkasan:
            'Permohonan Mutasi Data Dapodik GTK Sekolah Menengah Pertama.',
        tanggal: '2023-01-09',
        berkas: [
          BerkasItem('Surat Permohonan TTD Kepsek', wajib: true),
          BerkasItem('Ijazah', wajib: true),
          BerkasItem('Lolos Analisis Kebutuhan Guru', wajib: true),
          BerkasItem('Transkip Nilai', wajib: true),
          BerkasItem('Surat Penugasan', wajib: true),
          BerkasItem('Profil PTK dari Dapodik', wajib: true),
        ],
      );
    }
    if (l.nama == 'Mutasi Dapodik PTK - PAUD/PNF') {
      return const LayananInfo(
        nama: 'Mutasi Dapodik PTK - PAUD/PNF',
        ringkasan: 'Permohonan Mutasi Data Dapodik GTK PAUD dan PNF.',
        tanggal: '2023-01-16',
        berkas: [
          BerkasItem(
              'Surat Permohonan Mutasi PTK (diTTD Kepala Sekolah) ditujukan '
              'kepada Kepala Dinas',
              wajib: true),
          BerkasItem('Ijazah Terakhir', wajib: true),
          BerkasItem(
              'SK Pengangkatan di Unit Kerja Baru dari Yayasan / SK Penugasan '
              'Dinas apabila ASN',
              wajib: true),
          BerkasItem('Profil PTK dari Dapodik', wajib: true),
          BerkasItem('Pengantar Korwil', wajib: true),
          BerkasItem(
              'SK Pembagian Tugas Mengajar (diTTD Kepala Sekolah)',
              wajib: true),
          BerkasItem(
              'Surat Pernyataan Melepas dari Yayasan Lama (untuk GTY)',
              wajib: true),
        ],
      );
    }
    if (l.nama ==
        'Penugasan Kepala Sekolah & Plt. Kepala Sekolah SD - Dapodik') {
      return const LayananInfo(
        nama: 'Penugasan Kepala Sekolah & Plt. Kepala Sekolah SD - Dapodik',
        ringkasan:
            'Penugasan kepala sekolah baru sekolah dasar pada aplikasi dapodik.',
        tanggal: '2023-01-17',
        berkas: [
          BerkasItem('SK Pelantikan/Penugasan', wajib: true),
        ],
      );
    }
    if (l.nama == 'Penugasan Kepala Sekolah & Plt. Kepala SMP - Dapodik') {
      return const LayananInfo(
        nama: 'Penugasan Kepala Sekolah & Plt. Kepala SMP - Dapodik',
        ringkasan:
            'Penugasan kepala sekolah baru Sekolah menengah pertama pada '
            'aplikasi dapodik.',
        tanggal: '2023-01-17',
        berkas: [
          BerkasItem('Surat Permohonan (pdf/gambar)', wajib: true),
          BerkasItem('Dokumen Pendukung'),
        ],
      );
    }
    if (l.nama == 'Penerbitan NPYP (Nomor Pokok Yayasan Pendidikan)') {
      return const LayananInfo(
        nama: 'Penerbitan NPYP (Nomor Pokok Yayasan Pendidikan)',
        ringkasan:
            'Nomor Pokok Yayasan Pendidikan.\n\nNPYP adalah standar kode '
            'pengenal yang unik untuk yayasan yang mempunyai Satuan '
            'Pendidikan/Lembaga yang dikembangkan oleh Pusat Data dan '
            'Teknologi Informasi (Pusdatin) dan berlaku secara nasional.\n\n'
            'Kode NPYP Indonesia terdiri dari 6 digit kombinasi huruf dan '
            'angka dan diberikan kepada yayasan yang masih aktif.',
        tanggal: '2023-03-24',
        berkas: [
          BerkasItem(
              'Surat Permohonan Kepada Kepala Dinas Pendidikan dan Kebudayaan',
              wajib: true),
          BerkasItem('Formulir Pengajuan NPYP', wajib: true),
          BerkasItem('Foto Yayasan (max 1MB JPG)', wajib: true),
          BerkasItem('SK Pengesahan Badan Hukum Menkumham (Max 1Mb PDF)',
              wajib: true),
        ],
      );
    }
    if (l.nama == 'Pengaktifan kembali siswa dapodik') {
      return const LayananInfo(
        nama: 'Pengaktifan kembali siswa dapodik',
        ringkasan:
            'Pengaktifan kembali siswa pada dapodik yang telah dikeluarkan '
            'sebelumnya dikarenakan pindah sekolah atau putus sekolah, '
            'pastikan menyertakan NISN, Nama, Rombel dan sekolah aktif saat '
            'ini.',
        tanggal: '2023-08-04',
        berkas: [
          BerkasItem('Surat Pindah/Keterangan aktif dalam bentuk pdf',
              wajib: true),
        ],
      );
    }
    if (l.nama == 'Penugasan Kepala Sekolah & Plt. Kepala PAUD/PNF') {
      return const LayananInfo(
        nama: 'Penugasan Kepala Sekolah & Plt. Kepala PAUD/PNF',
        ringkasan:
            'Penambahan penugasan KEPALA SEKOLAH / PLT KEPALA SEKOLAH dan '
            'tugas tambahan pada pangkalan data DAPODIK.',
        tanggal: '2023-08-09',
        berkas: [
          BerkasItem('SK PLT Kepala Sekolah (PDF maksimal 1MB)', wajib: true),
        ],
      );
    }
    if (l.nama == 'Pengadaan Barang dan Jasa') {
      return const LayananInfo(
        nama: 'Pengadaan Barang dan Jasa',
        ringkasan:
            'Berkas yang diupload dalam bentuk PDF.\n\nSurat Permohonan PPK '
            'kepada PP (memuat jadwal pengiriman dan jumlah sesuai yang '
            'dipesan), HPS, RUP, DPA.',
        tanggal: '2024-03-13',
        berkas: [
          BerkasItem('Surat Permohonan PPK ke PP (PDF)'),
          BerkasItem('HPS (pdf)', wajib: true),
          BerkasItem('RUP (pdf)', wajib: true),
          BerkasItem('DPA (pdf)', wajib: true),
          BerkasItem('kl', wajib: true),
          BerkasItem('ADA', wajib: true),
        ],
      );
    }
    if (l.nama == 'Pembatalan Kelulusan/Meluluskan Siswa di DAPODIK') {
      return const LayananInfo(
        nama: 'Pembatalan Kelulusan/Meluluskan Siswa di DAPODIK',
        ringkasan:
            'Penting: Sebelum mengajukan murid baru atau mutasi terutama yang '
            'tidak bisa di TARIK ONLINE melalui SP DATADIK, pastikan sudah '
            'melakukan singkronisasi DAPODIK.',
        tanggal: '2025-07-23',
        berkas: [
          BerkasItem('Scan Ijazah/Surat Keterangan', wajib: true),
        ],
      );
    }
    if (l.nama == 'Laporan Bulanan Kepegawaian') {
      return const LayananInfo(
        nama: 'Laporan Bulanan Kepegawaian',
        ringkasan:
            'Layanan Laporan Bulanan Kepegawaian dari Sekolah Dasar dan '
            'Korwil.',
        tanggal: '2025-09-05',
        berkas: [
          BerkasItem('Surat Permohonan', wajib: true),
        ],
      );
    }
    if (l.nama == 'Laporan Progres SEDUKARSA') {
      return const LayananInfo(
        nama: 'Laporan Progres SEDUKARSA',
        ringkasan:
            'Laporan Progres Pelaksanaan Program SEDUKARSA bagi sekolah.',
        tanggal: '2026-04-20',
        berkas: [
          BerkasItem('Lampiran', wajib: true),
        ],
      );
    }
    if (l.nama == 'Penerbitan NPSN PAUD, PKBM, LKP, BIMBEL') {
      return const LayananInfo(
        nama: 'Penerbitan NPSN PAUD, PKBM, LKP, BIMBEL',
        ringkasan: 'Penerbitan NPSN PAUD, PKBM, LKP, BIMBEL.',
        tanggal: '2026-07-20',
        berkas: [
          BerkasItem('Surat Permohonan (pdf/gambar)', wajib: true),
          BerkasItem('Dokumen Pendukung'),
        ],
      );
    }
    if (l.nama == 'Surat Keterangan Pindah Keluar Siswa SMP') {
      return const LayananInfo(
        nama: 'Surat Keterangan Pindah Keluar Siswa SMP',
        ringkasan: '',
        syarat: [
          SyaratGroup('Mutasi Keluar Sekolah dalam Kabupaten Sragen', [
            'Surat keterangan pindah sekolah yang ditandatangani Kepala '
                'Sekolah',
            'Surat Keterangan Formasi kelas dari Sekolah yang akan dituju',
            'Fotokopi raport rangkap 1 (satu)',
            'Menunjukkan rapot asli',
          ]),
          SyaratGroup('Mutasi Keluar Sekolah ke Kabupaten/Kota lain', [
            'Surat permohonan mutasi yang ditandatangani Kepala Sekolah',
            'Fotokopi rapot rangkap 1 (satu)',
            'Menunjukkan rapot asli',
          ]),
        ],
        tanggal: '2022-12-18',
        berkas: [
          BerkasItem('Surat Keterangan Pindah dari Sekolah asal (gambar/pdf)',
              wajib: true),
          BerkasItem('Rapot Siswa (Gambar/PDF)', wajib: true),
        ],
      );
    }
    if (l.nama == 'Penerbitan NPSN dan NSS') {
      return const LayananInfo(
        nama: 'Penerbitan NPSN dan NSS',
        ringkasan:
            'Layanan Permohonan Penerbitan NPSN (nomor pokok sekolah '
            'nasional) bagi Satuan Pendidikan/Lembaga Baru.',
        syarat: [
          SyaratGroup('', [
            'Surat permohonan NPSN ditanda tangani Ketua Yayasan/Kepala '
                'Sekolah',
            'Mengisi formulir pengajuan ditanda tangani Ketua Yayasan/Kepala '
                'Sekolah',
            'Melampirkan Foto Papan Nama Sekolah',
            'Melampirkan Foto Sekolah Tampak Depan',
            'Melampirkan fotocopy SK Operasional',
            '',
          ], labelKiri: 'Persyaratan'),
          SyaratGroup(
            '',
            ['Nomor Pokok Sekolah Nasional Terdaftar Kemdikbud'],
            labelKiri: 'Jaminan Keamanan Produk Pelayanan',
            bernomor: false,
          ),
        ],
        tanggal: '2022-12-26',
        berkas: [
          BerkasItem('Surat Permohonan TTD Sekolah/Yayasan', wajib: true),
          BerkasItem('Formulir NPSN (form terlampir)', wajib: true),
          BerkasItem('SK Operasional Max Size 1Mb dalam bentuk PDF File',
              wajib: true),
          BerkasItem('Foto Papan Nama Sekolah Max Size 1Mb dalam bentuk JPG',
              wajib: true),
          BerkasItem(
              'Foto Sekolah Tampak Depan Max Size 1Mb dalam bentuk JPG File',
              wajib: true),
        ],
      );
    }
    // Layanan lain: konten generik.
    return LayananInfo(
      nama: l.nama,
      ringkasan:
          'Layanan "${l.nama}" dikelola oleh ${l.bidang} pada Dinas Pendidikan '
          'dan Kebudayaan Kabupaten Sragen melalui platform Langit Sukowati. '
          'Lengkapi formulir berikut untuk mengajukan layanan ini.',
    );
  }

  // ============================================================
  // BOTTOM NAVIGATION
  // ============================================================
  Widget _buildNavBar(BuildContext context) {
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
                  'Beranda', false, () => Navigator.popUntil(context, (route) => route.isFirst)),
            ),
            Expanded(
              child: _navItem(context, Icons.grid_view_rounded,
                  Icons.grid_view_rounded, 'Layanan', true, () {}),
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

  Widget _navItem(BuildContext context, IconData off, IconData on, String label,
      bool active, VoidCallback tap) {
    return GestureDetector(
      onTap: tap,
      child: Center(
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          width: 95,
          height: 52,
          decoration: BoxDecoration(
            color: active ? _tealLight : Colors.transparent,
            borderRadius: BorderRadius.circular(27),
          ),
          child: Transform.translate(
            offset: const Offset(0, -1),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(active ? on : off,
                    size: 22,
                    color: active ? _navyDark : const Color(0xFF374151)),
                const SizedBox(height: 1),
                Text(
                  label,
                  style: TextStyle(
                    fontSize: 9,
                    fontWeight: active ? FontWeight.w600 : FontWeight.w400,
                    color: active ? _navyDark : const Color(0xFF374151),
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
// MODELS
// ================================================================
class _Layanan {
  final String nama;
  final String bidang;
  const _Layanan(this.nama, this.bidang);
}

class _BidangStyle {
  final IconData icon;
  final Color color;
  const _BidangStyle(this.icon, this.color);
}
