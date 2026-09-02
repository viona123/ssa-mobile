import 'package:flutter/material.dart';
import '../../agenda/agenda_screen.dart';
import '../../bantuan/bantuan_screen.dart';
import 'inovasi_detail_model.dart';
import 'inovasi_detail_screen.dart';

/// Layanan Inovasi Daerah (sesuai desain context/inovasi1.png).
///
/// Menampilkan pencarian, filter (Inisiator, Jenis Inovasi, Tahapan), dan
/// daftar kartu inovasi dengan badge kategori, tahapan, info inisiator/OPD,
/// tanggal uji coba, serta tombol "Lihat Detail".
class InovasiScreen extends StatefulWidget {
  const InovasiScreen({super.key});

  @override
  State<InovasiScreen> createState() => _InovasiScreenState();
}

class _InovasiScreenState extends State<InovasiScreen> {
  // ============================================================
  // COLORS
  // ============================================================
  static const Color _appBlue = Color(0xFF007EA7);
  static const Color _green = Color(0xFF0B7A4B);
  static const Color _navy = Color(0xFF007EA7);
  static const Color _tealLight = Color(0xFF58D8EC);
  static const Color _darkBlue = Color(0xFF315579);
  static const Color _darkText = Color(0xFF1A2530);
  static const Color _greyText = Color(0xFF6B7280);
  static const Color _bg = Color(0xFFF5F6FB);
  static const Color _fieldBg = Color(0xFFEDF0F6);

  // ============================================================
  // STATE
  // ============================================================
  final TextEditingController _searchController = TextEditingController();
  String _query = '';
  String _inisiator = 'Semua Inisiator';
  String _jenis = 'Semua Jenis';
  String _tahapan = 'Semua Tahapan';

  // Pagination (pola seperti Riwayat Aduan) — 10 baris per halaman
  int _currentPage = 1;
  static const int _perPage = 10;

  final List<String> _inisiatorOptions = const [
    'Semua Inisiator',
    'ASN',
    'Kepala Daerah',
    'Masyarakat',
    'OPD',
  ];
  final List<String> _jenisOptions = const [
    'Semua Jenis',
    'Digital',
    'Non Digital',
  ];
  final List<String> _tahapanOptions = const [
    'Semua Tahapan',
    'Inisiatif',
    'Penerapan',
    'Uji Coba',
  ];

  final List<_Inovasi> _all = const [
    _Inovasi(
      judul:
          'SIKASEP RISKI BILAR (Sistem Kartu Skor Pencegahan Risiko Tinggi Berat Lahir Rendah)',
      jenis: 'Non Digital',
      tahapan: 'Penerapan',
      inisiator: 'ASN',
      instansi: 'Puskesmas Tanon 1',
      ujiCoba: '13/8/2026',
      detail: sikasepRiskiBilar,
    ),
    _Inovasi(
      judul: 'SIBERSA (Sistem Informasi Bidang Perumahan Sragen)',
      jenis: 'Digital',
      tahapan: 'Penerapan',
      inisiator: 'OPD',
      instansi:
          'Dinas Perumahan Rakyat, Kawasan Permukiman, Pertanahan dan Tata Ruang',
      ujiCoba: 'Invalid Date',
    ),
    _Inovasi(
      judul:
          'SI MPOK (SISTEM INFORMASI MONITORING PENGENDALIAN OPERASIONAL KEGIATAN)',
      jenis: 'Non Digital',
      tahapan: 'Uji Coba',
      inisiator: 'OPD',
      instansi: 'Bagian Administrasi Pembangunan',
      ujiCoba: '30/3/2026',
    ),
    _Inovasi(
      judul: 'SIKONDANG (Sistem Informasi Kebutuhan Pokok dan Perdagangan)',
      jenis: 'Digital',
      tahapan: 'Uji Coba',
      inisiator: '-',
      instansi:
          'Dinas Koperasi, Usaha Kecil dan Menengah, Perindustrian dan Perdagangan',
      ujiCoba: '13/1/2026',
    ),
    _Inovasi(
      judul:
          'Si-JADI Versi 2 (Sistem Jaringan Dokumentasi dan Informasi Hukum Desa)',
      jenis: 'Digital',
      tahapan: 'Penerapan',
      inisiator: 'OPD',
      instansi: 'Bagian Hukum',
      ujiCoba: '6/1/2026',
    ),
    _Inovasi(
      judul: 'SI DUTA CANTING (Sistem Informasi Padu Data Cegah Stunting)',
      jenis: 'Digital',
      tahapan: 'Penerapan',
      inisiator: 'Kepala Daerah',
      instansi:
          'Badan Perencanaan Pembangunan Riset dan Inovasi Daerah',
      ujiCoba: '5/1/2026',
    ),
    _Inovasi(
      judul: 'SI PENGAWAL (Sistem Pelaporan Pengamanan Wilayah)',
      jenis: 'Digital',
      tahapan: 'Penerapan',
      inisiator: 'OPD',
      instansi: 'Badan Kesatuan Bangsa dan Politik',
      ujiCoba: '2/1/2026',
    ),
    _Inovasi(
      judul: 'SIGERCEP RI (SISTEM GERAK CEPAT PEMBERANTASAN ROKOK ILEGAL)',
      jenis: 'Digital',
      tahapan: 'Penerapan',
      inisiator: 'ASN',
      instansi: 'Satuan Polisi Pamong Praja',
      ujiCoba: '1/1/2026',
    ),
    _Inovasi(
      judul: 'Sistem Informasi Manajemen Prasarana Tempat Ibadah (versi 2)',
      jenis: 'Digital',
      tahapan: 'Penerapan',
      inisiator: 'OPD',
      instansi: 'Bagian Kesejahteraan Rakyat',
      ujiCoba: 'Invalid Date',
    ),
    _Inovasi(
      judul:
          'OPTIMALISASI PENEMUAN PASIEN TERDUGA TBC DENGAN QR CODE SIGAP TBC (SISTEM GERAK AKTIF PASIEN TERDUGA TUBERCULOSIS) DI PUSKESMAS KEDAWUNG 1',
      jenis: 'Digital',
      tahapan: 'Penerapan',
      inisiator: 'ASN',
      instansi: 'Puskesmas Kedawung 1',
      ujiCoba: '12/12/2025',
    ),
    _Inovasi(
      judul: 'SI MACAN (Sistem Informasi Matur Camat Sambungmacan)',
      jenis: 'Digital',
      tahapan: 'Penerapan',
      inisiator: 'OPD',
      instansi: 'Kecamatan Sambungmacan',
      ujiCoba: '21/11/2025',
    ),
    _Inovasi(
      judul:
          'SELANCAR KEDAWUNG Plus (Sistem Elektronik Layanan Administrasi dan Aduan Responsif)',
      jenis: 'Digital',
      tahapan: 'Penerapan',
      inisiator: 'Kepala Daerah',
      instansi: 'Kecamatan Kedawung',
      ujiCoba: '19/11/2025',
    ),
    _Inovasi(
      judul: 'SIGAP SRAGEN (Sistem Informasi Gedung dan Area Publik Sragen)',
      jenis: 'Digital',
      tahapan: 'Penerapan',
      inisiator: '-',
      instansi:
          'Dinas Perumahan Rakyat, Kawasan Permukiman, Pertanahan dan Tata Ruang',
      ujiCoba: '1/11/2025',
    ),
    _Inovasi(
      judul:
          'SEDINA BERKAH (Sistem Elektronik Dispensasi Nikah Berbasis Kolaborasi dan Harmoni Kecamatan Sidoharjo)',
      jenis: 'Non Digital',
      tahapan: 'Uji Coba',
      inisiator: 'ASN',
      instansi: 'Kecamatan Sidoharjo',
      ujiCoba: '1/10/2025',
    ),
    _Inovasi(
      judul:
          'SIP MAS DON (Sistem Informasi dan Pelayanan Masyarakat Kecamatan Sukodono)',
      jenis: 'Digital',
      tahapan: 'Penerapan',
      inisiator: 'ASN',
      instansi: 'Kecamatan Sukodono',
      ujiCoba: '27/9/2025',
    ),
    _Inovasi(
      judul: 'Si SULTAN (Sistem Informasi Konsultasi dan Pengaduan)',
      jenis: 'Digital',
      tahapan: 'Penerapan',
      inisiator: 'OPD',
      instansi: 'Dinas Kependudukan dan Pencatatan Sipil',
      ujiCoba: '5/8/2025',
    ),
    _Inovasi(
      judul:
          'SI JAGA MATA (Sistem Informasi Jadwal Kegiatan ASN Kecamatan Tangen) Version 2.0',
      jenis: 'Digital',
      tahapan: 'Penerapan',
      inisiator: 'ASN',
      instansi: 'Kecamatan Tangen',
      ujiCoba: '4/8/2025',
    ),
    _Inovasi(
      judul:
          'Tingkatkan IMTAQ Siswa SMPN 3 Satu Atap Sumberlawang melalui SADAR (Sistem Absensi Dhuha dan Dhuhur Berjamaah)',
      jenis: 'Digital',
      tahapan: 'Penerapan',
      inisiator: '-',
      instansi: 'SMPN 3 SATAP SUMBERLAWANG',
      ujiCoba: '21/7/2025',
    ),
    _Inovasi(
      judul: 'SIAP TENAR (Sistem Informasi Administrasi Persuratan)',
      jenis: 'Digital',
      tahapan: 'Penerapan',
      inisiator: 'OPD',
      instansi: 'SMP Negeri 3 Satu Atap Jenar',
      ujiCoba: '1/7/2025',
    ),
    _Inovasi(
      judul: 'MAS SIDIK (Membangun Sistem Informasi Diklat)',
      jenis: 'Digital',
      tahapan: 'Penerapan',
      inisiator: '-',
      instansi: 'RSUD Sukowati Tangen',
      ujiCoba: '1/7/2025',
    ),
    _Inovasi(
      judul:
          'SIPESTA (Sistem Informasi Pelayanan Penerbitan Surat Keterangan Terdaftar)',
      jenis: 'Digital',
      tahapan: 'Penerapan',
      inisiator: '-',
      instansi: 'Dinas Ketahanan Pangan, Pertanian dan Perikanan',
      ujiCoba: '19/6/2025',
    ),
    _Inovasi(
      judul: 'SIPERKAS (Sistem Penemu Arsip menggunakan Daftar Berkas)',
      jenis: 'Digital',
      tahapan: 'Penerapan',
      inisiator: '-',
      instansi: 'Sekretariat DPRD',
      ujiCoba: '9/6/2025',
    ),
    _Inovasi(
      judul:
          'SIAP PMI (Sistem Integrasi Akses Pembiayaan Pekerja Migran Indonesia)',
      jenis: 'Digital',
      tahapan: 'Penerapan',
      inisiator: '-',
      instansi: 'PT. BPR Djoko Tingkir',
      ujiCoba: '7/4/2025',
    ),
    _Inovasi(
      judul:
          'SI PENEBAR VER-2 (Sistem Informasi Penanggulangan Demam Berdarah Dengue Versi 2)',
      jenis: 'Digital',
      tahapan: 'Penerapan',
      inisiator: 'OPD',
      instansi: 'Dinas Kesehatan',
      ujiCoba: '1/4/2025',
    ),
    _Inovasi(
      judul: 'SI LITEL JEPOL (SISTEM LITERASI JENDELA PENGHUBUNG ONLINE)',
      jenis: 'Digital',
      tahapan: 'Penerapan',
      inisiator: '-',
      instansi: 'SDN Tangkil 3',
      ujiCoba: '21/2/2025',
    ),
    _Inovasi(
      judul:
          'SI-PION SPENIP (Sistem informasi pencatatan poin pelanggaran SMP Negeri 1 Plupuh)',
      jenis: 'Digital',
      tahapan: 'Penerapan',
      inisiator: 'ASN',
      instansi: 'SMPN 1 PLUPUH',
      ujiCoba: '20/2/2025',
    ),
    _Inovasi(
      judul: 'SI MONIKA (Sistem Monitoring Kesehatan Ibu Nifas di Kalijambe)',
      jenis: 'Digital',
      tahapan: 'Penerapan',
      inisiator: 'OPD',
      instansi: 'Puskesmas Kalijambe',
      ujiCoba: '6/1/2025',
    ),
    _Inovasi(
      judul:
          'Si Mas PeDe (Sistem Informasi Evaluasi LPPD di Kecamatan Plupuh) dan Transparansi Pemerintahan Desa Berbasis Penilaian Publik',
      jenis: 'Digital',
      tahapan: 'Penerapan',
      inisiator: '-',
      instansi: 'Kecamatan Plupuh',
      ujiCoba: '6/1/2025',
    ),
    _Inovasi(
      judul:
          'SIOPSI FORMEN LINMAS (Sistem Opsi Solusi Informasi Manajemen Pelindungan Masyarakat)',
      jenis: 'Digital',
      tahapan: 'Penerapan',
      inisiator: 'ASN',
      instansi: 'Satuan Polisi Pamong Praja',
      ujiCoba: '1/1/2025',
    ),
    _Inovasi(
      judul: 'SIAPIK (Sistem Aplikasi Kependudukan Desa Slendro)',
      jenis: 'Digital',
      tahapan: 'Penerapan',
      inisiator: 'OPD',
      instansi: 'Desa Slendro, Gesi',
      ujiCoba: '1/1/2025',
    ),
    _Inovasi(
      judul: 'SI KADO (Sistem Informasi Data Kesehatan Puskesmas Sukodono)',
      jenis: 'Digital',
      tahapan: 'Penerapan',
      inisiator: '-',
      instansi: 'Puskesmas Sukodono',
      ujiCoba: '1/1/2025',
    ),
    _Inovasi(
      judul:
          'SI BILLY JAIM (Sistem Informasi Akuntabilitas Kinerja Instansi Pemerintah)',
      jenis: 'Digital',
      tahapan: 'Penerapan',
      inisiator: '-',
      instansi: 'Bagian Organisasi',
      ujiCoba: '2/12/2024',
    ),
    _Inovasi(
      judul: 'SI JANDA (Sistem Jaringan iNternet milik DesA)',
      jenis: 'Non Digital',
      tahapan: 'Penerapan',
      inisiator: 'OPD',
      instansi: 'Desa Tanggan, Gesi',
      ujiCoba: '1/12/2024',
    ),
    _Inovasi(
      judul: 'SIBARES (Sistem Informasi Bayar Retribusi Sampah)',
      jenis: 'Digital',
      tahapan: 'Penerapan',
      inisiator: 'OPD',
      instansi: 'Dinas Lingkungan Hidup',
      ujiCoba: '1/11/2024',
    ),
    _Inovasi(
      judul:
          'SI MAKARENA (Sistem Informasi Evaluasi Akuntabilitas Kinerja Internal)',
      jenis: 'Digital',
      tahapan: 'Penerapan',
      inisiator: '-',
      instansi:
          'Badan Kepegawaian dan Pengembangan Sumber Daya Manusia',
      ujiCoba: '21/10/2024',
    ),
    _Inovasi(
      judul: 'Sistem Poin Pelanggaran Siswa',
      jenis: 'Digital',
      tahapan: 'Uji Coba',
      inisiator: 'ASN',
      instansi: 'SMPN 3 SRAGEN',
      ujiCoba: '15/9/2024',
    ),
    _Inovasi(
      judul: 'Sistem Informasi Terpadu Sekolah (SI-DULAH)',
      jenis: 'Digital',
      tahapan: 'Penerapan',
      inisiator: '-',
      instansi: 'SMPN 1 GONDANG',
      ujiCoba: '15/7/2024',
    ),
    _Inovasi(
      judul:
          'PENERAPAN APLIKASI SIPINTAR (SISTEM PEMBELAJARAN INOVATIF INTERAKTIF DAN ATRAKTIF)',
      jenis: 'Digital',
      tahapan: 'Penerapan',
      inisiator: '-',
      instansi: 'SDN KEDAWUNG 2 MONDOKAN',
      ujiCoba: '4/3/2024',
    ),
    _Inovasi(
      judul: 'SIP JEMPOL (Sistem Pelayanan Jemput Bola)',
      jenis: 'Non Digital',
      tahapan: 'Penerapan',
      inisiator: 'Kepala Daerah',
      instansi: 'Desa Tegaldowo, Gemolong',
      ujiCoba: '1/1/2024',
    ),
    _Inovasi(
      judul: 'SITANDUK (Sistem Data Penduduk)',
      jenis: 'Digital',
      tahapan: 'Penerapan',
      inisiator: 'Masyarakat',
      instansi: 'Desa Nganti, Gemolong',
      ujiCoba: 'Invalid Date',
    ),
    _Inovasi(
      judul:
          'Tingkatkan IMTAQ Siswa SMPN 3 Satu Atap Sumberlawang melalui SADAR (Sistem Absensi Dhuha dan Dhuhur Berjamaah)',
      jenis: 'Digital',
      tahapan: 'Penerapan',
      inisiator: '-',
      instansi: 'SMPN 3 SATAP SUMBERLAWANG',
      ujiCoba: 'Invalid Date',
    ),
    _Inovasi(
      judul: 'Sistem Informasi Digital Kearsipan Spensada (SIDAKS)',
      jenis: 'Digital',
      tahapan: 'Penerapan',
      inisiator: 'ASN',
      instansi: 'SMPN 1 KEDAWUNG',
      ujiCoba: '15/4/2024',
    ),
    _Inovasi(
      judul:
          '"Si PeBi BerARty" Sistem Pembelajaran Berdiferensiasi Berbasis Augmented dan Virtual Reality',
      jenis: 'Digital',
      tahapan: 'Uji Coba',
      inisiator: 'ASN',
      instansi: 'SDN Bandung 1',
      ujiCoba: '14/3/2024',
    ),
    _Inovasi(
      judul: 'SI SANTANA (Sistem Informasi Sambirejo Tanggap Bencana)',
      jenis: 'Digital',
      tahapan: 'Penerapan',
      inisiator: '-',
      instansi: 'Kecamatan Sambirejo',
      ujiCoba: '4/3/2024',
    ),
    _Inovasi(
      judul: 'Sistem belajar mandiri',
      jenis: 'Digital',
      tahapan: 'Uji Coba',
      inisiator: 'Masyarakat',
      instansi: 'SD Birrul Walidain Muhammadiyah Sragen',
      ujiCoba: '6/2/2024',
    ),
    _Inovasi(
      judul: 'SIBEL (Sistem Informasi Pembelajaran) SMP Negeri 2 Sragen',
      jenis: 'Digital',
      tahapan: 'Penerapan',
      inisiator: '-',
      instansi: 'SMPN 2 SRAGEN',
      ujiCoba: '2/1/2024',
    ),
    _Inovasi(
      judul: 'SI-ASNA (Sistem Informasi Aset Pertanahan Kabupaten Sragen) 3',
      jenis: 'Digital',
      tahapan: 'Penerapan',
      inisiator: '-',
      instansi:
          'Dinas Perumahan Rakyat, Kawasan Permukiman, Pertanahan dan Tata Ruang',
      ujiCoba: '2/1/2023',
    ),
    _Inovasi(
      judul: 'SI-ASNA (Sistem Informasi Aset Pertanahan Kabupaten Sragen) 2',
      jenis: 'Digital',
      tahapan: 'Penerapan',
      inisiator: '-',
      instansi:
          'Dinas Perumahan Rakyat, Kawasan Permukiman, Pertanahan dan Tata Ruang',
      ujiCoba: '1/12/2022',
    ),
    _Inovasi(
      judul:
          'Komputerisasi Pembukuan Pendapatan SDIT Darul Hikmah Menggunakan Google Sheets',
      jenis: 'Digital',
      tahapan: 'Penerapan',
      inisiator: 'Masyarakat',
      instansi: 'SDIT Darul Hikmah',
      ujiCoba: 'Invalid Date',
    ),
    _Inovasi(
      judul: 'E-BOOK (MENGENAL SISTEM TATA SURYA)',
      jenis: 'Digital',
      tahapan: 'Inisiatif',
      inisiator: 'ASN',
      instansi: 'SDN KARANGUDI 3',
      ujiCoba: 'Invalid Date',
    ),
  ];

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  List<_Inovasi> get _filtered {
    final String q = _query.toLowerCase();
    return _all.where((i) {
      final matchQuery = i.judul.toLowerCase().contains(q) ||
          i.instansi.toLowerCase().contains(q);
      final matchInisiator =
          _inisiator == 'Semua Inisiator' || i.inisiator == _inisiator;
      final matchJenis = _jenis == 'Semua Jenis' || i.jenis == _jenis;
      final matchTahapan =
          _tahapan == 'Semua Tahapan' || i.tahapan == _tahapan;
      return matchQuery && matchInisiator && matchJenis && matchTahapan;
    }).toList();
  }

  int get _totalPages {
    final int pages = (_filtered.length / _perPage).ceil();
    return pages < 1 ? 1 : pages;
  }

  /// Item inovasi untuk halaman aktif saja (paginasi).
  List<_Inovasi> get _pageItems {
    final all = _filtered;
    final int start = (_currentPage - 1) * _perPage;
    if (start >= all.length) return const [];
    final int end =
        (start + _perPage) > all.length ? all.length : start + _perPage;
    return all.sublist(start, end);
  }

  /// Reset ke halaman 1 setiap kali filter/pencarian berubah.
  void _resetPage() => _currentPage = 1;

  void _changePage(int page) {
    if (page < 1 || page > _totalPages) return;
    setState(() => _currentPage = page);
  }

  // ============================================================
  // BUILD
  // ============================================================
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _bg,
      bottomNavigationBar: _buildNavBar(context),
      body: SafeArea(
        child: Stack(
          children: [
            Column(
              children: [
                _buildHeader(context),
                Expanded(
                  child: SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    padding: const EdgeInsets.fromLTRB(20, 18, 20, 24),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Search + refresh
                        _buildSearchRow(),
                        const SizedBox(height: 16),

                        // Filter dropdowns
                        _buildFilters(),
                        const SizedBox(height: 24),

                        // Daftar Inovasi header
                        const Text(
                          'Daftar Inovasi',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w800,
                            color: _darkText,
                          ),
                        ),
                        const SizedBox(height: 16),

                        // Kartu inovasi
                        if (_filtered.isEmpty)
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 40),
                            child: Center(
                              child: Text(
                                'Inovasi tidak ditemukan.',
                                style: TextStyle(
                                  fontSize: 14,
                                  color: _greyText,
                                ),
                              ),
                            ),
                          )
                        else ...[
                          ..._pageItems.map(_buildInovasiCard),
                          const SizedBox(height: 12),
                          _buildPagination(),
                        ],
                      ],
                    ),
                  ),
                ),
              ],
            ),

            // Tombol Pusat Bantuan
            Positioned(right: 26, bottom: 14, child: _buildHelpButton()),
          ],
        ),
      ),
    );
  }

  // ============================================================
  // PUSAT BANTUAN
  // ============================================================
  Widget _buildHelpButton() {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: BorderRadius.circular(16),
        onTap: () => Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => const BantuanScreen()),
        ),
        child: Container(
          width: 58,
          height: 58,
          decoration: BoxDecoration(
            color: _appBlue,
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.16),
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: const Icon(
            Icons.support_agent_rounded,
            size: 27,
            color: Colors.white,
          ),
        ),
      ),
    );
  }

  // ============================================================
  // HEADER — ← Inovasi Daerah
  // ============================================================
  Widget _buildHeader(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 66,
      decoration: const BoxDecoration(
        color: _bg,
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
              color: _appBlue,
            ),
          ),
          const SizedBox(width: 16),
          const Text(
            'Layanan Inovasi',
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
  // SEARCH ROW (search field + refresh button)
  // ============================================================
  Widget _buildSearchRow() {
    return Row(
      children: [
        Expanded(
          child: Container(
            height: 52,
            decoration: BoxDecoration(
              color: _fieldBg,
              borderRadius: BorderRadius.circular(12),
            ),
            child: TextField(
              controller: _searchController,
              onChanged: (v) => setState(() {
                _query = v;
                _resetPage();
              }),
              style: const TextStyle(fontSize: 15, color: _darkText),
              decoration: const InputDecoration(
                hintText: 'Cari inovasi...',
                hintStyle: TextStyle(fontSize: 15, color: _greyText),
                prefixIcon:
                    Icon(Icons.search_rounded, color: _greyText, size: 24),
                border: InputBorder.none,
                contentPadding: EdgeInsets.symmetric(vertical: 14),
              ),
            ),
          ),
        ),
        const SizedBox(width: 12),
        GestureDetector(
          onTap: () {
            setState(() {
              _searchController.clear();
              _query = '';
              _inisiator = 'Semua Inisiator';
              _jenis = 'Semua Jenis';
              _tahapan = 'Semua Tahapan';
              _resetPage();
            });
          },
          child: Container(
            width: 52,
            height: 52,
            decoration: BoxDecoration(
              color: _navy,
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Icon(Icons.refresh_rounded, color: Colors.white),
          ),
        ),
      ],
    );
  }

  // ============================================================
  // FILTERS (Inisiator / Jenis Inovasi / Tahapan)
  // ============================================================
  Widget _buildFilters() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      physics: const BouncingScrollPhysics(),
      child: Row(
        children: [
          _buildDropdown(
            label: 'Inisiator',
            value: _inisiator,
            items: _inisiatorOptions,
            onChanged: (v) => setState(() {
              _inisiator = v!;
              _resetPage();
            }),
          ),
          const SizedBox(width: 14),
          _buildDropdown(
            label: 'Jenis Inovasi',
            value: _jenis,
            items: _jenisOptions,
            onChanged: (v) => setState(() {
              _jenis = v!;
              _resetPage();
            }),
          ),
          const SizedBox(width: 14),
          _buildDropdown(
            label: 'Tahapan',
            value: _tahapan,
            items: _tahapanOptions,
            onChanged: (v) => setState(() {
              _tahapan = v!;
              _resetPage();
            }),
          ),
        ],
      ),
    );
  }

  Widget _buildDropdown({
    required String label,
    required String value,
    required List<String> items,
    required ValueChanged<String?> onChanged,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: _darkText,
          ),
        ),
        const SizedBox(height: 8),
        Container(
          width: 180,
          height: 50,
          padding: const EdgeInsets.symmetric(horizontal: 14),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: const Color(0xFFD7DEE8)),
          ),
          child: DropdownButtonHideUnderline(
            child: DropdownButton<String>(
              value: value,
              isExpanded: true,
              icon: const Icon(Icons.keyboard_arrow_down_rounded,
                  color: _greyText),
              style: const TextStyle(fontSize: 14, color: _darkText),
              items: items
                  .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                  .toList(),
              onChanged: onChanged,
            ),
          ),
        ),
      ],
    );
  }

  // ============================================================
  // INOVASI CARD
  // ============================================================
  Widget _buildInovasiCard(_Inovasi item) {
    final bool isDigital = item.jenis == 'Digital';
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: const Color(0xFFE6E9F0)),
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
          // Badge jenis + tahapan
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 9, vertical: 4),
                decoration: BoxDecoration(
                  color: isDigital
                      ? const Color(0xFFDFF5E7)
                      : const Color(0xFFE4E8F2),
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Text(
                  item.jenis,
                  style: TextStyle(
                    fontSize: 10.5,
                    fontWeight: FontWeight.w700,
                    color: isDigital ? _green : _darkBlue,
                  ),
                ),
              ),
              const Spacer(),
              Text(
                item.tahapan,
                style: const TextStyle(
                  fontSize: 11.5,
                  fontWeight: FontWeight.w600,
                  color: _greyText,
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),

          // Judul
          Text(
            item.judul,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w700,
              color: _darkText,
              height: 1.3,
            ),
          ),
          const SizedBox(height: 12),

          // Info rows
          _buildInfoRow(Icons.person_outline_rounded, item.inisiator),
          const SizedBox(height: 6),
          _buildInfoRow(Icons.account_balance_outlined, item.instansi),
          const SizedBox(height: 6),
          _buildInfoRow(
              Icons.calendar_today_outlined, 'Uji Coba: ${item.ujiCoba}'),
          const SizedBox(height: 14),

          // Tombol Lihat Detail
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () => _showDetail(item),
              style: ElevatedButton.styleFrom(
                backgroundColor: _navy,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(9),
                ),
                padding: const EdgeInsets.symmetric(vertical: 12),
                elevation: 0,
              ),
              child: const Text(
                'Lihat Detail',
                style: TextStyle(
                  fontSize: 13.5,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoRow(IconData icon, String text) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, size: 16, color: _greyText),
        const SizedBox(width: 8),
        Expanded(
          child: Text(
            text,
            style: const TextStyle(
              fontSize: 13,
              color: Color(0xFF3A4250),
              height: 1.35,
            ),
          ),
        ),
      ],
    );
  }

  void _showDetail(_Inovasi item) {
    // Jika inovasi punya halaman detail lengkap, buka halaman tersebut.
    if (item.detail != null) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => InovasiDetailScreen(detail: item.detail!),
        ),
      );
      return;
    }

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(22)),
      ),
      builder: (_) => Padding(
        padding: const EdgeInsets.fromLTRB(24, 16, 24, 32),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Container(
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: const Color(0xFFD9DEE5),
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
            ),
            const SizedBox(height: 20),
            Text(
              item.judul,
              style: const TextStyle(
                fontSize: 19,
                fontWeight: FontWeight.w800,
                color: _darkText,
                height: 1.3,
              ),
            ),
            const SizedBox(height: 18),
            _buildInfoRow(Icons.category_outlined, 'Jenis: ${item.jenis}'),
            const SizedBox(height: 10),
            _buildInfoRow(Icons.timeline_outlined, 'Tahapan: ${item.tahapan}'),
            const SizedBox(height: 10),
            _buildInfoRow(Icons.person_outline_rounded, item.inisiator),
            const SizedBox(height: 10),
            _buildInfoRow(Icons.account_balance_outlined, item.instansi),
            const SizedBox(height: 10),
            _buildInfoRow(
                Icons.calendar_today_outlined, 'Uji Coba: ${item.ujiCoba}'),
          ],
        ),
      ),
    );
  }

  // ============================================================
  // PAGINATION (pola Riwayat Aduan: Sebelumnya / nomor / Selanjutnya)
  // ============================================================
  Widget _buildPagination() {
    final int total = _totalPages;
    final int middlePage = _currentPage <= 2
        ? 2
        : (_currentPage >= total ? total - 1 : _currentPage);

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          Expanded(
            child: _buildPaginationLabel(
              'Sebelumnya',
              enabled: _currentPage > 1,
              onTap: () => _changePage(_currentPage - 1),
            ),
          ),
          const SizedBox(width: 6),
          _buildPageNumber(1),
          if (total >= 2 && middlePage != 1 && middlePage != total)
            _buildPageNumber(middlePage),
          if (total > 3)
            const SizedBox(
              width: 20,
              child: Center(
                child: Text('...', style: TextStyle(color: _greyText)),
              ),
            ),
          if (total > 1) _buildPageNumber(total),
          const SizedBox(width: 6),
          Expanded(
            child: _buildPaginationLabel(
              'Selanjutnya',
              enabled: _currentPage < total,
              onTap: () => _changePage(_currentPage + 1),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPaginationLabel(
    String label, {
    required bool enabled,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: enabled ? onTap : null,
      child: Container(
        height: 42,
        padding: const EdgeInsets.symmetric(horizontal: 6),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(9),
          border: Border.all(color: const Color(0xFFE0E5EA)),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.035),
              blurRadius: 5,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: FittedBox(
          fit: BoxFit.scaleDown,
          child: Text(
            label,
            maxLines: 1,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: enabled ? _darkText : _greyText,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildPageNumber(int page) {
    final bool isActive = _currentPage == page;
    return GestureDetector(
      onTap: () => _changePage(page),
      child: Container(
        width: 40,
        height: 42,
        margin: const EdgeInsets.symmetric(horizontal: 2),
        decoration: BoxDecoration(
          color: isActive ? _navy : Colors.white,
          borderRadius: BorderRadius.circular(9),
          border: Border.all(
            color: isActive ? _navy : const Color(0xFFE0E5EA),
          ),
        ),
        child: Center(
          child: Text(
            '$page',
            style: TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w700,
              color: isActive ? Colors.white : _darkText,
            ),
          ),
        ),
      ),
    );
  }

  // ============================================================
  // BOTTOM NAVIGATION (seragam dengan layanan lain)
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
              child: _navItem(
                Icons.home_outlined,
                Icons.home_rounded,
                'Beranda',
                false,
                () => Navigator.of(context).popUntil((r) => r.isFirst),
              ),
            ),
            Expanded(
              child: _navItem(
                Icons.grid_view_rounded,
                Icons.grid_view_rounded,
                'Layanan',
                true,
                () => Navigator.pop(context),
              ),
            ),
            Expanded(
              child: _navItem(
                Icons.calendar_month_outlined,
                Icons.calendar_month_rounded,
                'Agenda',
                false,
                () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => const AgendaScreen()),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _navItem(
    IconData off,
    IconData on,
    String label,
    bool active,
    VoidCallback tap,
  ) {
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
                Icon(
                  active ? on : off,
                  size: 22,
                  color: active ? _darkBlue : const Color(0xFF374151),
                ),
                const SizedBox(height: 1),
                Text(
                  label,
                  style: TextStyle(
                    fontSize: 9,
                    fontWeight: active ? FontWeight.w600 : FontWeight.w400,
                    color: active ? _darkBlue : const Color(0xFF374151),
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

// ============================================================
// MODEL
// ============================================================
class _Inovasi {
  final String judul;
  final String jenis;
  final String tahapan;
  final String inisiator;
  final String instansi;
  final String ujiCoba;
  final InovasiDetail? detail;

  const _Inovasi({
    required this.judul,
    required this.jenis,
    required this.tahapan,
    required this.inisiator,
    required this.instansi,
    required this.ujiCoba,
    this.detail,
  });
}
