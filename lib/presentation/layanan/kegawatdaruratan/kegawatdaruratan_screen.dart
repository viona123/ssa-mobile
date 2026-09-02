import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../agenda/agenda_screen.dart';
import '../../bantuan/bantuan_screen.dart';
import 'detail_rs_screen.dart';

// ================================================================
// LAYANAN DARURAT / KEGAWATDARURATAN SCREEN
// Desain sesuai context/true.png + context/kamar.png
// ================================================================

class KegawatdaruratanScreen extends StatefulWidget {
  const KegawatdaruratanScreen({super.key});

  @override
  State<KegawatdaruratanScreen> createState() =>
      _KegawatdaruratanScreenState();
}

class _KegawatdaruratanScreenState extends State<KegawatdaruratanScreen> {
  // ============================================================
  // COLORS
  // ============================================================

  static const Color _appBlue = Color(0xFF007EA7);
  static const Color _tealLight = Color(0xFF58D8EC);
  static const Color _navyDark = Color(0xFF315579);
  static const Color _bg = Color(0xFFF8FAFC);
  static const Color _ink = Color(0xFF202124);
  static const Color _smoke = Color(0xFF737B86);

  // Stok Darah
  static const Color _stokDarahHeader = Color(0xFF93000A);
  static const Color _bloodPinkBorder = Color(0xFFF2B8B8);
  static const Color _bloodPinkBg = Color(0xFFFDF0F0);
  static const Color _bloodRedText = Color(0xFFBA1A1A);

  // Kontak Darurat
  static const Color _kontakBiru = Color(0xFF0040A1);

  // Table — sesuai kamar.png (full oren)
  static const Color _tableOren = Color(0xFFF4A700);
  static const Color _tableNameBlue = Color(0xFF0040A1);

  // ============================================================
  // DATA
  // ============================================================

  final List<_StokDarahItem> _stokDarah = [
    _StokDarahItem(golongan: 'A', jumlah: 163),
    _StokDarahItem(golongan: 'B', jumlah: 232),
    _StokDarahItem(golongan: 'O', jumlah: 118),
    _StokDarahItem(golongan: 'AB', jumlah: 54),
  ];

  final List<_KontakDaruratItem> _kontakDarurat = [
    _KontakDaruratItem(nama: 'UGD RSUD SRAGEN', telepon: '(0271) 891068', telNum: '0271891068', icon: Icons.local_hospital_rounded, iconBg: Color(0xFF1565C0)),
    _KontakDaruratItem(nama: 'PEMADAM KEBAKARAN', telepon: '(0271) 891113', telNum: '0271891113', icon: Icons.local_fire_department_rounded, iconBg: Color(0xFFD84315)),
    _KontakDaruratItem(nama: 'POLRES SRAGEN', telepon: '(0271) 891510', telNum: '0271891510', icon: Icons.shield_rounded, iconBg: Color(0xFF2E7D32)),
  ];

  final List<_KamarItem> _rumahSakitUmum = [
    _KamarItem(nama: 'RSUD dr. SOEHADI PRIJONEGORO', jumlah: 280, isi: 162, kosong: 118, update: '20-08-2026 06:57:02'),
    _KamarItem(nama: 'RS Mardi Lestari Sragen', jumlah: 68, isi: 13, kosong: 55, update: '20-08-2026 05:54:18'),
    _KamarItem(nama: 'RSU Sarila Husada', jumlah: 130, isi: 73, kosong: 57, update: '20-08-2026 05:31:47'),
    _KamarItem(nama: 'RSU Amal Sehat Sragen', jumlah: 104, isi: 66, kosong: 38, update: '20-08-2026 05:59:36'),
    _KamarItem(nama: 'RSU Assalam', jumlah: 95, isi: 35, kosong: 60, update: '19-08-2026 09:16:32'),
    _KamarItem(nama: 'RSUD dr. SOERATNO GEMOLONG', jumlah: 133, isi: 83, kosong: 50, update: '14-08-2026 07:46:04'),
    _KamarItem(nama: 'RSU PKU MUHAMMADIYAH SRAGEN', jumlah: 101, isi: 48, kosong: 53, update: '20-08-2026 04:45:03'),
    _KamarItem(nama: 'RSU Islam YAKSSI Gemolong', jumlah: 61, isi: 30, kosong: 31, update: '20-08-2026 05:49:54'),
    _KamarItem(nama: 'RSU Rizky Amalia', jumlah: 50, isi: 22, kosong: 28, update: '20-08-2026 07:12:20'),
    _KamarItem(nama: 'Hastuti', jumlah: 37, isi: 4, kosong: 33, update: '20-08-2026 12:00:34'),
    _KamarItem(nama: 'RSU Saras Ibnu Sina Sukowati', jumlah: 75, isi: 50, kosong: 25, update: '20-08-2026 06:16:48'),
    _KamarItem(nama: 'Rumah Sakit Sukowati Tangen', jumlah: 58, isi: 8, kosong: 50, update: '20-08-2026 06:01:27'),
  ];

  final List<_KamarItem> _puskesmasRawatInap = [
    _KamarItem(nama: 'KALIJAMBE', jumlah: 10, isi: 10, kosong: 0, update: '20-08-2026 07:56:27'),
    _KamarItem(nama: 'PLUPUH I', jumlah: 10, isi: 5, kosong: 5, update: '20-08-2026 07:46:08'),
    _KamarItem(nama: 'PLUPUH II', jumlah: 6, isi: 3, kosong: 3, update: '20-08-2026 07:56:03'),
    _KamarItem(nama: 'MASARAN II', jumlah: 10, isi: 4, kosong: 6, update: '20-08-2026 07:54:11'),
    _KamarItem(nama: 'MASARAN I', jumlah: 8, isi: 8, kosong: 0, update: '20-08-2026 07:55:38'),
    _KamarItem(nama: 'KEDAWUNG I', jumlah: 9, isi: 7, kosong: 2, update: '19-08-2026 07:47:19'),
    _KamarItem(nama: 'KEDAWUNG II', jumlah: 10, isi: 6, kosong: 4, update: '20-08-2026 07:45:30'),
    _KamarItem(nama: 'SAMBIREJO', jumlah: 10, isi: 7, kosong: 3, update: '20-08-2026 07:52:09'),
    _KamarItem(nama: 'GONDANG', jumlah: 10, isi: 5, kosong: 5, update: '19-08-2026 07:55:27'),
    _KamarItem(nama: 'SAMBUNG MACAN I', jumlah: 8, isi: 7, kosong: 1, update: '20-08-2026 07:44:33'),
    _KamarItem(nama: 'SAMBUNG MACAN II', jumlah: 10, isi: 4, kosong: 6, update: '20-08-2026 07:53:14'),
    _KamarItem(nama: 'NGRAMPAL', jumlah: 7, isi: 0, kosong: 7, update: '20-08-2026 07:48:50'),
    _KamarItem(nama: 'TANON I', jumlah: 9, isi: 4, kosong: 5, update: '19-08-2026 07:51:02'),
    _KamarItem(nama: 'TANON II', jumlah: 5, isi: 4, kosong: 1, update: '20-08-2026 07:47:50'),
    _KamarItem(nama: 'MIRI', jumlah: 11, isi: 5, kosong: 6, update: '20-08-2026 07:50:34'),
    _KamarItem(nama: 'SUMBERLAWANG', jumlah: 10, isi: 5, kosong: 5, update: '19-08-2026 07:45:33'),
    _KamarItem(nama: 'MONDOKAN', jumlah: 9, isi: 4, kosong: 5, update: '19-08-2026 07:50:03'),
    _KamarItem(nama: 'SUKODONO', jumlah: 10, isi: 4, kosong: 6, update: '20-08-2026 07:53:37'),
    _KamarItem(nama: 'GESI', jumlah: 8, isi: 5, kosong: 3, update: '20-08-2026 07:52:48'),
    _KamarItem(nama: 'TANGEN', jumlah: 9, isi: 8, kosong: 1, update: '20-08-2026 07:51:30'),
    _KamarItem(nama: 'JENAR', jumlah: 7, isi: 2, kosong: 5, update: '20-08-2026 07:49:18'),
  ];

  final List<_KamarItem> _puskesmasRawatJalan = [
    _KamarItem(nama: 'KARANG MALANG', jumlah: 2, isi: 0, kosong: 2, update: '20-08-2026 07:49:44'),
    _KamarItem(nama: 'SRAGEN', jumlah: 3, isi: 0, kosong: 3, update: '20-08-2026 07:47:03'),
    _KamarItem(nama: 'SIDOHARJO', jumlah: 4, isi: 0, kosong: 4, update: '19-08-2026 07:53:25'),
    _KamarItem(nama: 'GEMOLONG II', jumlah: 2, isi: 0, kosong: 2, update: '20-08-2026 07:48:27'),
  ];

  final List<_KamarItem> _klinik = [
    _KamarItem(nama: 'RSIA Restu Ibu', jumlah: 52, isi: 1, kosong: 51, update: '20-08-2026 04:43:27'),
    _KamarItem(nama: 'Klinik Ibu Anak Dentatama, Sragen', jumlah: 42, isi: 13, kosong: 29, update: '14-06-2017'),
    _KamarItem(nama: 'Sukowati Husada', jumlah: 10, isi: 8, kosong: 2, update: '09-09-2025 07:37:48'),
    _KamarItem(nama: 'Permata Hati Abadi', jumlah: 22, isi: 0, kosong: 22, update: '22-11-2022'),
    _KamarItem(nama: 'Kharisma Medika', jumlah: 0, isi: 0, kosong: 0, update: '--'),
    _KamarItem(nama: 'Insan Sehat', jumlah: 0, isi: 0, kosong: 0, update: '--'),
    _KamarItem(nama: 'Wijayanti', jumlah: 0, isi: 0, kosong: 0, update: '--'),
    _KamarItem(nama: 'PT. KAI', jumlah: 0, isi: 0, kosong: 0, update: '--'),
    _KamarItem(nama: 'Dr. Netty', jumlah: 0, isi: 0, kosong: 0, update: '--'),
    _KamarItem(nama: 'Aisyiyah', jumlah: 0, isi: 0, kosong: 0, update: '--'),
    _KamarItem(nama: 'Sumber Medika', jumlah: 0, isi: 0, kosong: 0, update: '--'),
    _KamarItem(nama: 'Kartika 25', jumlah: 0, isi: 0, kosong: 0, update: '--'),
    _KamarItem(nama: 'Yonif 408', jumlah: 0, isi: 0, kosong: 0, update: '--'),
    _KamarItem(nama: 'Narwastu', jumlah: 0, isi: 0, kosong: 0, update: '--'),
    _KamarItem(nama: 'Parama Medika', jumlah: 8, isi: 5, kosong: 3, update: '01-04-2024 08:34:07'),
    _KamarItem(nama: 'Utami Nugroho', jumlah: 10, isi: 2, kosong: 8, update: '24-01-2025 01:44:04'),
    _KamarItem(nama: 'Prima Tauhid', jumlah: 0, isi: 0, kosong: 0, update: '--'),
    _KamarItem(nama: 'Al-ikhlas', jumlah: 0, isi: 0, kosong: 0, update: '--'),
    _KamarItem(nama: 'Wisnu Husada', jumlah: 0, isi: 0, kosong: 0, update: '--'),
    _KamarItem(nama: 'Panacea', jumlah: 7, isi: 2, kosong: 5, update: '17-11-2020'),
    _KamarItem(nama: 'Gita Medika', jumlah: 9, isi: 0, kosong: 9, update: '14-06-2017'),
    _KamarItem(nama: 'Rama Husada', jumlah: 0, isi: 0, kosong: 0, update: '--'),
    _KamarItem(nama: 'Shafira Medika', jumlah: 0, isi: 0, kosong: 0, update: '--'),
    _KamarItem(nama: 'Saras Medika', jumlah: 0, isi: 0, kosong: 0, update: '--'),
    _KamarItem(nama: 'Delima Rahayu', jumlah: 0, isi: 0, kosong: 0, update: '--'),
    _KamarItem(nama: 'Wahyu Mulia', jumlah: 0, isi: 0, kosong: 0, update: '--'),
    _KamarItem(nama: 'Dr.Sinung', jumlah: 0, isi: 0, kosong: 0, update: '--'),
    _KamarItem(nama: 'Kusuma Amanda I', jumlah: 0, isi: 0, kosong: 0, update: '--'),
    _KamarItem(nama: 'Wahyu Widodo', jumlah: 0, isi: 0, kosong: 0, update: '--'),
    _KamarItem(nama: 'Wyanda Medika', jumlah: 9, isi: 3, kosong: 6, update: '22-03-2025 09:16:06'),
    _KamarItem(nama: 'Margo Husodo', jumlah: 10, isi: 6, kosong: 4, update: '24-01-2025 01:46:30'),
    _KamarItem(nama: 'Rifda Medika', jumlah: 0, isi: 0, kosong: 0, update: '--'),
    _KamarItem(nama: 'Dian Mediza', jumlah: 0, isi: 0, kosong: 0, update: '--'),
    _KamarItem(nama: 'Prima Mediza', jumlah: 13, isi: 7, kosong: 6, update: '20-07-2023'),
    _KamarItem(nama: 'Ar-Rahman', jumlah: 0, isi: 0, kosong: 0, update: '--'),
    _KamarItem(nama: 'Akma Husada', jumlah: 0, isi: 0, kosong: 0, update: '--'),
    _KamarItem(nama: 'Madhelyn', jumlah: 0, isi: 0, kosong: 0, update: '--'),
    _KamarItem(nama: 'Harapan Kita', jumlah: 0, isi: 0, kosong: 0, update: '--'),
    _KamarItem(nama: 'Asyifa', jumlah: 0, isi: 0, kosong: 0, update: '--'),
    _KamarItem(nama: 'Prima Husada', jumlah: 10, isi: 4, kosong: 6, update: '14-06-2017'),
    _KamarItem(nama: 'Prima Husada 2', jumlah: 8, isi: 2, kosong: 6, update: '14-06-2017'),
  ];

  // ============================================================
  // PHONE CALL
  // ============================================================

  Future<void> _makePhoneCall(String number) async {
    final Uri phoneUri = Uri(scheme: 'tel', path: number);
    if (await canLaunchUrl(phoneUri)) {
      await launchUrl(phoneUri);
    }
  }

  // ============================================================
  // BUILD
  // ============================================================

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _bg,
      bottomNavigationBar: _buildNavBar(),
      body: Stack(
        children: [
          SafeArea(
            child: Column(
              children: [
                _buildHeader(),
                Expanded(
                  child: SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    padding: const EdgeInsets.only(bottom: 30),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        _buildHeroSection(),
                        const SizedBox(height: 16),
                        _buildStokDarahSection(),
                        const SizedBox(height: 20),
                        _buildKontakDaruratSection(),
                        const SizedBox(height: 28),
                        _buildKetersediaanKamarTitle(),
                        const SizedBox(height: 12),
                        _buildKamarTable(context: context, title: 'Rumah Sakit Umum', data: _rumahSakitUmum, footerText: 'Klik Nama Rumah Sakit Untuk Melihat Detail Kamar/Layanan'),
                        const SizedBox(height: 20),
                        _buildKamarTable(context: context, title: 'Puskesmas Rawat Inap', data: _puskesmasRawatInap, footerText: 'Klik Nama Puskesmas Untuk Melihat Detail Kamar/Layanan'),
                        const SizedBox(height: 20),
                        _buildKamarTable(context: context, title: 'Puskesmas Rawat Jalan', data: _puskesmasRawatJalan, footerText: 'Klik Nama Puskesmas Untuk Melihat Detail Kamar/Layanan'),
                        const SizedBox(height: 20),
                        _buildKamarTable(context: context, title: 'Klinik', data: _klinik, footerText: 'Klik Nama Klinik Untuk Melihat Detail Kamar/Layanan'),
                        const SizedBox(height: 30),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          Positioned(right: 26, bottom: 14, child: _buildHelpButton()),
        ],
      ),
    );
  }

  // ============================================================
  // HEADER
  // ============================================================

  Widget _buildHeader() {
    return Container(
      width: double.infinity,
      height: 60,
      decoration: const BoxDecoration(
        color: Colors.white,
        border: Border(bottom: BorderSide(color: Color(0xFFE0E0E0), width: 1)),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        children: [
          GestureDetector(
            onTap: () => Navigator.pop(context),
            child: const Icon(Icons.arrow_back_ios_new_rounded, size: 22, color: _appBlue),
          ),
          const SizedBox(width: 14),
          const Text('Layanan Darurat', style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700, color: _appBlue)),
        ],
      ),
    );
  }

  // ============================================================
  // HERO SECTION
  // ============================================================

  Widget _buildHeroSection() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(24, 24, 24, 20),
      decoration: const BoxDecoration(
        color: Colors.white,
        border: Border(bottom: BorderSide(color: Color(0xFFE8E8E8), width: 1)),
      ),
      child: const Column(
        children: [
          Text(
            'Layanan Kegawatdaruratan &\nKetersediaan Kamar',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 21, fontWeight: FontWeight.w800, color: _ink, height: 1.3),
          ),
          SizedBox(height: 10),
          Text(
            'Informasi Real-time Stok Darah dan\nKetersediaan Kamar RS/Puskesmas di\nKabupaten Sragen',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 13, color: _smoke, height: 1.5),
          ),
        ],
      ),
    );
  }

  // ============================================================
  // STOK DARAH — circles PINK SUPER SOFT, huruf MERAH
  // ============================================================

  Widget _buildStokDarahSection() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [BoxShadow(color: Colors.black.withValues(alpha: 0.05), blurRadius: 8, offset: const Offset(0, 2))],
        ),
        child: Column(
          children: [
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 14),
              decoration: const BoxDecoration(
                color: _stokDarahHeader,
                borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
              ),
              child: const Row(
                children: [
                  Icon(Icons.water_drop_rounded, size: 20, color: Colors.white),
                  SizedBox(width: 10),
                  Text('Stok Darah PMI Sragen', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700, color: Colors.white)),
                ],
              ),
            ),
            const Padding(
              padding: EdgeInsets.only(top: 16, bottom: 8),
              child: Text('Update Terakhir: Hari ini, 08:00:00', style: TextStyle(fontSize: 12, color: _smoke)),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 12, 20, 24),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: _stokDarah.map((item) => _buildBloodCircle(item)).toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBloodCircle(_StokDarahItem item) {
    return Column(
      children: [
        Container(
          width: 62,
          height: 62,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: _bloodPinkBg,
            border: Border.all(color: _bloodPinkBorder, width: 2.5),
          ),
          child: Center(
            child: Text(
              item.golongan,
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w900, color: _bloodRedText),
            ),
          ),
        ),
        const SizedBox(height: 10),
        Text('${item.jumlah}', style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w800, color: _ink)),
        const SizedBox(height: 2),
        const Text('KOLF', style: TextStyle(fontSize: 10, fontWeight: FontWeight.w500, color: _smoke, letterSpacing: 0.5)),
      ],
    );
  }

  // ============================================================
  // KONTAK DARURAT — spacing bagus, tanpa garis, klik = telepon
  // ============================================================

  Widget _buildKontakDaruratSection() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [BoxShadow(color: Colors.black.withValues(alpha: 0.05), blurRadius: 8, offset: const Offset(0, 2))],
        ),
        child: Column(
          children: [
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 14),
              decoration: const BoxDecoration(
                color: _kontakBiru,
                borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
              ),
              child: const Row(
                children: [
                  Icon(Icons.contact_phone_rounded, size: 20, color: Colors.white),
                  SizedBox(width: 10),
                  Text('Kontak Darurat', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700, color: Colors.white)),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 18, 16, 18),
              child: Column(
                children: List.generate(_kontakDarurat.length, (index) {
                  final item = _kontakDarurat[index];
                  return Padding(
                    padding: EdgeInsets.only(bottom: index < _kontakDarurat.length - 1 ? 18 : 0),
                    child: Row(
                      children: [
                        Container(
                          width: 44,
                          height: 44,
                          decoration: BoxDecoration(color: item.iconBg, shape: BoxShape.circle),
                          child: Icon(item.icon, size: 22, color: Colors.white),
                        ),
                        const SizedBox(width: 14),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(item.nama, style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w700, color: _ink)),
                              const SizedBox(height: 3),
                              Row(
                                children: [
                                  const Icon(Icons.phone_outlined, size: 14, color: _smoke),
                                  const SizedBox(width: 4),
                                  Text(item.telepon, style: const TextStyle(fontSize: 13, color: _smoke)),
                                ],
                              ),
                            ],
                          ),
                        ),
                        GestureDetector(
                          onTap: () => _makePhoneCall(item.telNum),
                          child: Container(
                            width: 44,
                            height: 44,
                            decoration: const BoxDecoration(color: _kontakBiru, shape: BoxShape.circle),
                            child: const Icon(Icons.phone_rounded, size: 22, color: Colors.white),
                          ),
                        ),
                      ],
                    ),
                  );
                }),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ============================================================
  // KETERSEDIAAN KAMAR — TITLE
  // ============================================================

  Widget _buildKetersediaanKamarTitle() {
    return const Padding(
      padding: EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        children: [
          Icon(Icons.bed_rounded, size: 24, color: _ink),
          SizedBox(width: 8),
          Text('Ketersediaan Kamar', style: TextStyle(fontSize: 20, fontWeight: FontWeight.w800, color: _ink)),
        ],
      ),
    );
  }

  // ============================================================
  // KAMAR TABLE — sesuai kamar.png
  // Full oren header (2 baris semua oren)
  // Nama RS warna BIRU
  // Rows putih dengan garis border
  // ============================================================

  Widget _buildKamarTable({
    required BuildContext context,
    required String title,
    required List<_KamarItem> data,
    required String footerText,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // === Footer text di tengah atas ===
          Padding(
            padding: const EdgeInsets.only(bottom: 10),
            child: Text(
              footerText,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 11, color: _tableNameBlue, fontWeight: FontWeight.w500),
            ),
          ),
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: const Color(0xFFDDDDDD), width: 1),
            ),
            clipBehavior: Clip.antiAlias,
            child: Column(
              children: [
                // === HEADER ROW 1: oren — title kiri, KAMAR + sub-kolom kanan ===
                Container(
                  color: _tableOren,
                  child: IntrinsicHeight(
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        // Kolom kiri: nama kategori (Rumah Sakit Umum, dll)
                        Expanded(
                          flex: 5,
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(14, 10, 8, 10),
                            child: Align(
                              alignment: Alignment.centerLeft,
                              child: Text(title, style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w800, color: Colors.black)),
                            ),
                          ),
                        ),
                        // Garis vertikal pemisah nama & kolom data
                        Container(width: 1, color: const Color(0xFFD48F00)),
                        // Kolom kanan: KAMAR di atas, JUMLAH/ISI/KOSONG/UPDATE di bawah
                        Expanded(
                          flex: 9,
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              // Baris KAMAR
                              const Padding(
                                padding: EdgeInsets.symmetric(vertical: 6),
                                child: Text('KAMAR', textAlign: TextAlign.center, style: TextStyle(fontSize: 12, fontWeight: FontWeight.w800, color: Colors.black, letterSpacing: 0.5)),
                              ),
                              // Garis horizontal pemisah KAMAR dan sub-kolom (full lebar kolom kanan)
                              Container(height: 1, color: const Color(0xFFD48F00)),
                              // Baris JUMLAH ISI KOSONG UPDATE
                              IntrinsicHeight(
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.stretch,
                                  children: [
                                    Expanded(
                                      flex: 2,
                                      child: Container(
                                        padding: const EdgeInsets.symmetric(vertical: 6),
                                        decoration: const BoxDecoration(
                                          border: Border(right: BorderSide(color: Color(0xFFD48F00), width: 1)),
                                        ),
                                        child: const Text('JUMLAH', textAlign: TextAlign.center, style: TextStyle(fontSize: 9, fontWeight: FontWeight.w700, color: Colors.black)),
                                      ),
                                    ),
                                    Expanded(
                                      flex: 2,
                                      child: Container(
                                        padding: const EdgeInsets.symmetric(vertical: 6),
                                        decoration: const BoxDecoration(
                                          border: Border(right: BorderSide(color: Color(0xFFD48F00), width: 1)),
                                        ),
                                        child: const Text('ISI', textAlign: TextAlign.center, style: TextStyle(fontSize: 9, fontWeight: FontWeight.w700, color: Colors.black)),
                                      ),
                                    ),
                                    Expanded(
                                      flex: 2,
                                      child: Container(
                                        padding: const EdgeInsets.symmetric(vertical: 6),
                                        decoration: const BoxDecoration(
                                          border: Border(right: BorderSide(color: Color(0xFFD48F00), width: 1)),
                                        ),
                                        child: const Text('KOSONG', textAlign: TextAlign.center, style: TextStyle(fontSize: 9, fontWeight: FontWeight.w700, color: Colors.black)),
                                      ),
                                    ),
                                    Expanded(
                                      flex: 3,
                                      child: Container(
                                        padding: const EdgeInsets.symmetric(vertical: 6),
                                        child: const Text('UPDATE TERAKHIR', textAlign: TextAlign.center, style: TextStyle(fontSize: 8, fontWeight: FontWeight.w700, color: Colors.black)),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                // === DATA ROWS: putih, border garis horizontal + vertikal ===
                ...List.generate(data.length, (index) {
                  final item = data[index];
                  return Container(
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      border: Border(bottom: BorderSide(color: Color(0xFFD0D0D0), width: 1)),
                    ),
                    child: IntrinsicHeight(
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          // Nama RS/Puskesmas (bisa diklik)
                          Expanded(
                            flex: 5,
                            child: GestureDetector(
                              onTap: () => _navigateToDetail(context, item),
                              child: Padding(
                                padding: const EdgeInsets.fromLTRB(14, 13, 8, 13),
                                child: Text(item.nama, style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w700, color: _tableNameBlue)),
                              ),
                            ),
                          ),
                          // Garis vertikal penuh pemisah nama & data
                          Container(width: 1, color: const Color(0xFFD0D0D0)),
                          // JUMLAH
                          Expanded(
                            flex: 2,
                            child: Container(
                              padding: const EdgeInsets.symmetric(vertical: 13),
                              decoration: const BoxDecoration(
                                border: Border(right: BorderSide(color: Color(0xFFD0D0D0), width: 1)),
                              ),
                              child: Text('${item.jumlah}', textAlign: TextAlign.center, style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: _ink)),
                            ),
                          ),
                          // ISI
                          Expanded(
                            flex: 2,
                            child: Container(
                              padding: const EdgeInsets.symmetric(vertical: 13),
                              decoration: const BoxDecoration(
                                border: Border(right: BorderSide(color: Color(0xFFD0D0D0), width: 1)),
                              ),
                              child: Text('${item.isi}', textAlign: TextAlign.center, style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: _ink)),
                            ),
                          ),
                          // KOSONG
                          Expanded(
                            flex: 2,
                            child: Container(
                              padding: const EdgeInsets.symmetric(vertical: 13),
                              decoration: const BoxDecoration(
                                border: Border(right: BorderSide(color: Color(0xFFD0D0D0), width: 1)),
                              ),
                              child: Text('${item.kosong}', textAlign: TextAlign.center, style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: _ink)),
                            ),
                          ),
                          // UPDATE TERAKHIR
                          Expanded(
                            flex: 3,
                            child: Container(
                              padding: const EdgeInsets.symmetric(vertical: 13),
                              child: Text(item.update, textAlign: TextAlign.center, style: const TextStyle(fontSize: 9, color: _smoke)),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                }),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // ============================================================
  // NAVIGATE TO DETAIL RS
  // ============================================================

  void _navigateToDetail(BuildContext context, _KamarItem item) {
    // Data detail untuk RSUD dr. SOEHADI PRIJONEGORO
    final Map<String, _DetailRsData> detailData = {
      'RSUD dr. SOEHADI PRIJONEGORO': _DetailRsData(
        alamat: 'Jl. Raya Sukowati No.534, Sragen Tengah, Kec. Sragen, Kabupaten Sragen, Jawa Tengah 57211',
        telepon: '(0271) 891068',
        detailKamar: [
          DetailKamarItem(namaKamar: 'Alamanda', kelas: 'Kelas III', kapasitas: 8, isi: 0, kosong: 8, update: '--'),
          DetailKamarItem(namaKamar: 'Alamanda', kelas: 'Kelas II', kapasitas: 2, isi: 0, kosong: 2, update: '--'),
          DetailKamarItem(namaKamar: 'Anggrek', kelas: 'Kelas II', kapasitas: 3, isi: 0, kosong: 3, update: '20-08-2026 01:26:23'),
          DetailKamarItem(namaKamar: 'Anggrek', kelas: 'Kelas III', kapasitas: 8, isi: 2, kosong: 6, update: '20-08-2026 01:26:36'),
          DetailKamarItem(namaKamar: 'Anggrek', kelas: 'ISOLASI', kapasitas: 5, isi: 0, kosong: 5, update: '20-08-2026 01:26:54'),
          DetailKamarItem(namaKamar: 'Anggrek', kelas: 'VIP', kapasitas: 2, isi: 1, kosong: 1, update: '20-08-2026 01:27:21'),
          DetailKamarItem(namaKamar: 'Anggrek', kelas: 'PICU', kapasitas: 1, isi: 0, kosong: 1, update: '20-08-2026 01:27:45'),
          DetailKamarItem(namaKamar: 'Anggrek', kelas: 'HCU', kapasitas: 2, isi: 0, kosong: 2, update: '20-08-2026 01:28:17'),
          DetailKamarItem(namaKamar: 'Anggrek', kelas: 'Kelas 1', kapasitas: 2, isi: 0, kosong: 2, update: '20-08-2026 01:28:52'),
          DetailKamarItem(namaKamar: 'Aster', kelas: 'ISOLASI', kapasitas: 1, isi: 1, kosong: 0, update: '19-08-2026 06:29:29'),
          DetailKamarItem(namaKamar: 'Aster', kelas: 'Kelas III', kapasitas: 5, isi: 2, kosong: 3, update: '20-08-2026 06:42:54'),
          DetailKamarItem(namaKamar: 'Aster', kelas: 'Kelas II', kapasitas: 3, isi: 3, kosong: 0, update: '19-08-2026 06:31:59'),
          DetailKamarItem(namaKamar: 'Bougenville', kelas: 'NICU', kapasitas: 10, isi: 6, kosong: 4, update: '19-08-2026 08:44:32'),
          DetailKamarItem(namaKamar: 'Bougenville', kelas: 'Peri', kapasitas: 5, isi: 1, kosong: 4, update: '19-08-2026 08:44:59'),
          DetailKamarItem(namaKamar: 'Cempaka', kelas: 'VIP', kapasitas: 1, isi: 1, kosong: 0, update: '20-08-2026 02:21:07'),
          DetailKamarItem(namaKamar: 'Cempaka', kelas: 'Kelas I', kapasitas: 2, isi: 0, kosong: 2, update: '20-08-2026 02:21:51'),
          DetailKamarItem(namaKamar: 'Cempaka', kelas: 'Kelas II', kapasitas: 6, isi: 3, kosong: 3, update: '20-08-2026 02:22:16'),
          DetailKamarItem(namaKamar: 'Cempaka', kelas: 'ISOLASI', kapasitas: 5, isi: 1, kosong: 4, update: '20-08-2026 02:22:45'),
          DetailKamarItem(namaKamar: 'Cempaka', kelas: 'Kelas III', kapasitas: 8, isi: 3, kosong: 5, update: '20-08-2026 02:24:43'),
          DetailKamarItem(namaKamar: 'Cempaka', kelas: 'HCU', kapasitas: 2, isi: 0, kosong: 2, update: '20-08-2026 02:23:37'),
          DetailKamarItem(namaKamar: 'ICCU', kelas: '-', kapasitas: 6, isi: 4, kosong: 2, update: '20-08-2026 01:24:24'),
          DetailKamarItem(namaKamar: 'ICU', kelas: '-', kapasitas: 15, isi: 12, kosong: 3, update: '20-08-2026 06:57:02'),
          DetailKamarItem(namaKamar: 'Lavender', kelas: 'Kelas III', kapasitas: 10, isi: 7, kosong: 3, update: '20-08-2026 01:47:19'),
          DetailKamarItem(namaKamar: 'Lavender', kelas: 'Kelas II', kapasitas: 6, isi: 4, kosong: 2, update: '20-08-2026 01:48:23'),
          DetailKamarItem(namaKamar: 'Lavender', kelas: 'Kelas I', kapasitas: 2, isi: 1, kosong: 1, update: '20-08-2026 01:47:56'),
          DetailKamarItem(namaKamar: 'Lavender', kelas: 'HCU', kapasitas: 4, isi: 0, kosong: 4, update: '20-08-2026 01:48:10'),
          DetailKamarItem(namaKamar: 'Mawar', kelas: 'Kelas III', kapasitas: 36, isi: 17, kosong: 19, update: '20-08-2026 01:45:08'),
          DetailKamarItem(namaKamar: 'Melati Barat', kelas: 'Kelas III', kapasitas: 24, isi: 19, kosong: 5, update: '19-08-2026 01:46:05'),
          DetailKamarItem(namaKamar: 'Melati Barat', kelas: 'ISOLASI', kapasitas: 4, isi: 3, kosong: 1, update: '19-08-2026 01:46:34'),
          DetailKamarItem(namaKamar: 'Melati Timur', kelas: 'Kelas III', kapasitas: 24, isi: 10, kosong: 14, update: '20-08-2026 02:02:45'),
          DetailKamarItem(namaKamar: 'Paviliun Wijaya Kusuma', kelas: 'SVVIP', kapasitas: 1, isi: 0, kosong: 1, update: '20-08-2026 06:24:51'),
          DetailKamarItem(namaKamar: 'Paviliun Wijaya Kusuma', kelas: 'VVIP', kapasitas: 2, isi: 2, kosong: 0, update: '20-08-2026 06:25:15'),
          DetailKamarItem(namaKamar: 'Paviliun Wijaya Kusuma', kelas: 'VIP', kapasitas: 6, isi: 4, kosong: 2, update: '20-08-2026 06:25:54'),
          DetailKamarItem(namaKamar: 'Paviliun Wijaya Kusuma', kelas: 'ISOLASI', kapasitas: 1, isi: 1, kosong: 0, update: '20-08-2026 06:25:32'),
          DetailKamarItem(namaKamar: 'Sakura', kelas: 'Kelas III', kapasitas: 6, isi: 5, kosong: 1, update: '20-08-2026 06:42:11'),
          DetailKamarItem(namaKamar: 'Sakura', kelas: 'ISOLASI', kapasitas: 1, isi: 0, kosong: 1, update: '20-08-2026 06:41:38'),
          DetailKamarItem(namaKamar: 'Teratai', kelas: 'Kelas I', kapasitas: 6, isi: 5, kosong: 1, update: '20-08-2026 05:47:15'),
          DetailKamarItem(namaKamar: 'Teratai', kelas: 'Kelas II', kapasitas: 8, isi: 6, kosong: 2, update: '20-08-2026 05:48:07'),
          DetailKamarItem(namaKamar: 'Teratai', kelas: 'ISOLASI', kapasitas: 2, isi: 1, kosong: 1, update: '19-08-2026 06:13:40'),
          DetailKamarItem(namaKamar: 'Tulip', kelas: 'Kelas I', kapasitas: 8, isi: 6, kosong: 2, update: '20-08-2026 01:46:11'),
          DetailKamarItem(namaKamar: 'Tulip', kelas: 'Kelas II', kapasitas: 12, isi: 11, kosong: 1, update: '20-08-2026 01:47:20'),
          DetailKamarItem(namaKamar: 'Tulip', kelas: 'Kelas III', kapasitas: 12, isi: 1, kosong: 11, update: '20-08-2026 05:26:48'),
          DetailKamarItem(namaKamar: 'Tulip', kelas: 'ISOLASI', kapasitas: 3, isi: 1, kosong: 2, update: '20-08-2026 05:26:17'),
        ],
        layanan: [
          'Instalasi Gawat Darurat (IGD) 24 Jam',
          'Instalasi Rawat Inap',
          'Kemo Terapi',
          'Instalasi Rehabilitasi Medik',
          'Hemodialisa',
          'Poliklinik Spesialis Dalam',
          'Poliklinik Spesialis Jantung',
          'Poliklinik Spesialis Syaraf',
          'Poliklinik Spesialis Orthopedi',
          'Poliklinik Spesialis Paru-Paru',
          'Poliklinik Spesialis Bedah',
          'Poliklinik Spesialis Urologi',
          'Poliklinik Spesialis Jiwa',
          'Poliklinik Spesialis Gigi',
          'Poliklinik Spesialis Kandungan',
          'Poliklinik Spesialis Oncologi',
          'Poliklinik Spesialis Kulit dan Kelamin',
          'Poliklinik Spesialis Mata',
          'Poliklinik Umum',
          'Ambulance',
          'ICU - ICCU',
          'PICU - NICU',
        ],
      ),
      'RS Mardi Lestari Sragen': _DetailRsData(
        alamat: 'Jl. Rokan No.8, Magero, Sragen Tengah, Sragen, Jawa Tengah 57251',
        telepon: '0271-891033, 0271-8852962',
        detailKamar: [
          DetailKamarItem(namaKamar: 'Bangsal Antonius', kelas: 'Kelas III', kapasitas: 6, isi: 4, kosong: 2, update: '20-08-2026 05:52:23'),
          DetailKamarItem(namaKamar: 'Bangsal Antonius', kelas: 'Kelas II', kapasitas: 8, isi: 1, kosong: 7, update: '20-08-2026 05:52:10'),
          DetailKamarItem(namaKamar: 'Bangsal Antonius', kelas: 'Kelas I', kapasitas: 5, isi: 0, kosong: 5, update: '20-08-2026 05:52:53'),
          DetailKamarItem(namaKamar: 'Bangsal Antonius', kelas: 'VIP', kapasitas: 3, isi: 2, kosong: 1, update: '20-08-2026 05:53:35'),
          DetailKamarItem(namaKamar: 'Bangsal Fransiskus', kelas: 'Kelas III', kapasitas: 9, isi: 3, kosong: 6, update: '20-08-2026 05:51:32'),
          DetailKamarItem(namaKamar: 'Bangsal Fransiskus', kelas: 'Kelas II', kapasitas: 8, isi: 1, kosong: 7, update: '20-08-2026 05:52:00'),
          DetailKamarItem(namaKamar: 'Bangsal Fransiskus', kelas: 'Kelas I', kapasitas: 5, isi: 1, kosong: 4, update: '20-08-2026 05:53:04'),
          DetailKamarItem(namaKamar: 'Bangsal Fransiskus', kelas: 'VIP', kapasitas: 3, isi: 0, kosong: 3, update: '20-08-2026 05:53:45'),
          DetailKamarItem(namaKamar: 'Bangsal ICU', kelas: 'VIP', kapasitas: 4, isi: 0, kosong: 4, update: '20-08-2026 05:54:11'),
          DetailKamarItem(namaKamar: 'Bangsal Isolasi', kelas: 'Umum', kapasitas: 7, isi: 0, kosong: 7, update: '20-08-2026 05:54:02'),
          DetailKamarItem(namaKamar: 'Bangsal Lukas', kelas: 'Kelas III', kapasitas: 3, isi: 0, kosong: 3, update: '20-08-2026 05:51:42'),
          DetailKamarItem(namaKamar: 'Bangsal Lukas', kelas: 'Kelas II', kapasitas: 2, isi: 1, kosong: 1, update: '20-08-2026 05:52:36'),
          DetailKamarItem(namaKamar: 'Bangsal Lukas', kelas: 'Kelas I', kapasitas: 2, isi: 0, kosong: 2, update: '20-08-2026 05:53:12'),
          DetailKamarItem(namaKamar: 'NICU/PICU', kelas: 'Khusus', kapasitas: 3, isi: 0, kosong: 3, update: '20-08-2026 05:54:18'),
        ],
        layanan: [
          'Poliklinik Spesialis Penyakit Dalam',
          'Poliklinik Spesialis Syaraf',
          'Poliklinik Spesialis Bedah',
          'Poliklinik Spesialis Paru',
          'Poliklinik Spesialis Obsgyn',
          'Poliklinik Spesialis Orthopedi',
          'Poliklinik Spesialis Mata',
          'Poliklinik Spesialis Orthopedi',
          'Instalasi Rawat Inap',
          'Ambulance',
          'Laboratorium 24 Jam',
          'Poliklinik Spesialis Anak',
          'Intensive Care Unit (ICU)',
          'Farmasi 24 Jam',
          'Physiotherapy',
          'Instalasi Gawat Darurat (IGD) 24 jam',
          'Poliklinik Umum',
          'Radiologi 24 Jam',
          'Spesialis Patologi Klinik',
          'Spesialis Radiologi',
          'Poli Klinik Spesialis Rehabilitasi Medik',
          'Poliklinik Spesialis THT',
        ],
        dokter: [
          DokterItem(nama: 'dr. Thomas Lukhwy Sewy', spesialisasi: 'UMUM'),
          DokterItem(nama: 'dr. Gregorius Raditya Indra', spesialisasi: 'UMUM'),
          DokterItem(nama: 'dr. Anang Abdul Wahid', spesialisasi: 'UMUM'),
          DokterItem(nama: 'dr. Djoko Purwanto', spesialisasi: 'UMUM'),
          DokterItem(nama: 'dr. Indarsih', spesialisasi: 'UMUM'),
          DokterItem(nama: 'dr. Martinus Nori W', spesialisasi: 'UMUM'),
          DokterItem(nama: 'dr. Tristira Rosida', spesialisasi: 'UMUM'),
          DokterItem(nama: 'dr. Antonius Pradika Cahya Perdana', spesialisasi: 'UMUM'),
        ],
      ),
    };

    final detail = detailData[item.nama];

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => DetailRsScreen(
          namaRs: item.nama,
          alamat: detail?.alamat ?? 'Kabupaten Sragen, Jawa Tengah',
          telepon: detail?.telepon ?? '-',
          totalKamar: item.jumlah,
          terisi: item.isi,
          kosong: item.kosong,
          detailKamar: detail?.detailKamar ?? [],
          layanan: detail?.layanan ?? [],
          dokter: detail?.dokter ?? [],
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
        onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const BantuanScreen())),
        child: Container(
          width: 58,
          height: 58,
          decoration: BoxDecoration(
            color: _appBlue,
            borderRadius: BorderRadius.circular(16),
            boxShadow: [BoxShadow(color: Colors.black.withValues(alpha: 0.16), blurRadius: 10, offset: const Offset(0, 4))],
          ),
          child: const Icon(Icons.support_agent_rounded, color: Colors.white, size: 29),
        ),
      ),
    );
  }

  // ============================================================
  // BOTTOM NAVIGATION BAR
  // ============================================================

  Widget _buildNavBar() {
    return Container(
      height: 95,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(22)),
        boxShadow: [BoxShadow(color: Colors.black.withValues(alpha: 0.07), blurRadius: 10, offset: const Offset(0, -3))],
      ),
      child: SafeArea(
        top: false,
        child: Row(
          children: [
            Expanded(child: _navItem(Icons.home_outlined, Icons.home_rounded, 'Beranda', false, () => Navigator.popUntil(context, (route) => route.isFirst))),
            Expanded(child: _navItem(Icons.grid_view_rounded, Icons.grid_view_rounded, 'Layanan', true, () {})),
            Expanded(child: _navItem(Icons.calendar_month_outlined, Icons.calendar_month_rounded, 'Agenda', false, () {
              Navigator.push(context, MaterialPageRoute(builder: (_) => const AgendaScreen()));
            })),
          ],
        ),
      ),
    );
  }

  Widget _navItem(IconData off, IconData on, String label, bool active, VoidCallback tap) {
    return GestureDetector(
      onTap: tap,
      child: Center(
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          width: 95,
          height: 52,
          decoration: BoxDecoration(color: active ? _tealLight : Colors.transparent, borderRadius: BorderRadius.circular(27)),
          child: Transform.translate(
            offset: const Offset(0, -1),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(active ? on : off, size: 22, color: active ? _navyDark : const Color(0xFF374151)),
                const SizedBox(height: 1),
                Text(label, style: TextStyle(fontSize: 9, fontWeight: active ? FontWeight.w600 : FontWeight.w400, color: active ? _navyDark : const Color(0xFF374151))),
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

class _StokDarahItem {
  final String golongan;
  final int jumlah;
  const _StokDarahItem({required this.golongan, required this.jumlah});
}

class _KontakDaruratItem {
  final String nama;
  final String telepon;
  final String telNum;
  final IconData icon;
  final Color iconBg;
  const _KontakDaruratItem({required this.nama, required this.telepon, required this.telNum, required this.icon, required this.iconBg});
}

class _KamarItem {
  final String nama;
  final int jumlah;
  final int isi;
  final int kosong;
  final String update;
  const _KamarItem({required this.nama, required this.jumlah, required this.isi, required this.kosong, required this.update});
}

class _DetailRsData {
  final String alamat;
  final String telepon;
  final List<DetailKamarItem> detailKamar;
  final List<String> layanan;
  final List<DokterItem> dokter;
  const _DetailRsData({required this.alamat, required this.telepon, required this.detailKamar, required this.layanan, this.dokter = const []});
}
