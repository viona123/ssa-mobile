import 'package:flutter/material.dart';
import '../../agenda/agenda_screen.dart';
import '../../bantuan/bantuan_screen.dart';

// ================================================================
// CEK DATA KEMISKINAN SCREEN
// Desain sesuai context/DataMiskin.png & kemiskinan2.png
// ================================================================

class KemiskinanScreen extends StatefulWidget {
  const KemiskinanScreen({super.key});

  @override
  State<KemiskinanScreen> createState() => _KemiskinanScreenState();
}

class _KemiskinanScreenState extends State<KemiskinanScreen>
    with SingleTickerProviderStateMixin {
  // ============================================================
  // COLORS
  // ============================================================

  static const Color _appBlue = Color(0xFF007EA7);
  static const Color _tealLight = Color(0xFF58D8EC);
  static const Color _navyDark = Color(0xFF315579);
  static const Color _bg = Color(0xFFF8FAFC);
  static const Color _ink = Color(0xFF202124);
  static const Color _smoke = Color(0xFF737B86);
  static const Color _btnTeal = Color(0xFF0E7490);
  static const Color _cardBorder = Color(0xFFE8ECF0);

  // ============================================================
  // STATE
  // ============================================================

  late TabController _tabController;
  final TextEditingController _nikController = TextEditingController();
  final TextEditingController _namaController = TextEditingController();
  bool _isRobotCheckedNIK = false;
  bool _isRobotCheckedNama = false;
  bool _showHasilPencarian = false;

  // Data dummy hasil pencarian
  final List<_HasilPencarianItem> _hasilPencarian = [
    _HasilPencarianItem(
      nama: 'Budi Kurniawan',
      jenisKelamin: 'Laki-laki',
      umur: 40,
      alamat: 'Kec. Sidoharjo, Desa Jetis',
    ),
    _HasilPencarianItem(
      nama: 'Ika Budi Kurniawan',
      jenisKelamin: 'Laki-laki',
      umur: 51,
      alamat: 'Kec. Masaran, Desa Kliwonan',
    ),
    _HasilPencarianItem(
      nama: 'Rok Budi Kurniawan',
      jenisKelamin: 'Laki-laki',
      umur: 45,
      alamat: 'Kec. Plupuh, Desa Karanganyar',
    ),
    _HasilPencarianItem(
      nama: 'Rok Budi Kurniawan',
      jenisKelamin: 'Laki-laki',
      umur: 45,
      alamat: 'Kec. Plupuh, Desa Karanganyar',
    ),
    _HasilPencarianItem(
      nama: 'Sri Budi Kurniawan',
      jenisKelamin: 'Perempuan',
      umur: 38,
      alamat: 'Kec. Gondang, Desa Ngrombo',
    ),
    _HasilPencarianItem(
      nama: 'Wati Budi Kurniawan',
      jenisKelamin: 'Perempuan',
      umur: 42,
      alamat: 'Kec. Tanon, Desa Sumberejo',
    ),
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _tabController.addListener(() => setState(() {}));
  }

  @override
  void dispose() {
    _tabController.dispose();
    _nikController.dispose();
    _namaController.dispose();
    super.dispose();
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
                        _buildTransparansiSection(),
                        const SizedBox(height: 20),
                        _buildSearchCard(),
                        if (_showHasilPencarian && _tabController.index == 1)
                          ...[
                            const SizedBox(height: 24),
                            _buildHasilPencarian(),
                          ],
                        const SizedBox(height: 30),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),

          // ====================================================
          // PUSAT BANTUAN — FIXED DI KANAN BAWAH
          // ====================================================
          Positioned(
            right: 26,
            bottom: 14,
            child: _buildHelpButton(),
          ),
        ],
      ),
    );
  }

  // ============================================================
  // HEADER — App bar dengan back button
  // ============================================================

  Widget _buildHeader() {
    return Container(
      width: double.infinity,
      height: 66,
      decoration: const BoxDecoration(
        color: _bg,
        border: Border(
          bottom: BorderSide(
            color: Color(0xFFE5E7EB),
            width: 0.7,
          ),
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
            'Cek Data Kemiskinan',
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
  // TRANSPARANSI DATA — Centered & dipercantik
  // ============================================================

  Widget _buildTransparansiSection() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(24, 28, 24, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Judul utama — centered
          const Text(
            'Transparansi Data',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 26,
              fontWeight: FontWeight.w800,
              color: _ink,
              height: 1.2,
            ),
          ),

          const SizedBox(height: 12),

          // Deskripsi — centered
          Text(
            'Temukan informasi bantuan sosial dan status kemiskinan dengan memasukkan NIK atau Nama Lengkap Anda.',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 14,
              color: _smoke,
              height: 1.6,
            ),
          ),
        ],
      ),
    );
  }

  // ============================================================
  // SEARCH CARD — Tab Cari by NIK / Cari by Nama
  // ============================================================

  Widget _buildSearchCard() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: _cardBorder),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.05),
              blurRadius: 16,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          children: [
            // ====================================================
            // TAB BAR
            // ====================================================
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
              child: Container(
                height: 48,
                decoration: BoxDecoration(
                  color: const Color(0xFFF1F5F9),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: TabBar(
                  controller: _tabController,
                  indicator: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.08),
                        blurRadius: 4,
                        offset: const Offset(0, 1),
                      ),
                    ],
                  ),
                  indicatorSize: TabBarIndicatorSize.tab,
                  indicatorPadding: const EdgeInsets.all(4),
                  dividerColor: Colors.transparent,
                  labelColor: _appBlue,
                  unselectedLabelColor: _smoke,
                  labelStyle: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                  ),
                  unselectedLabelStyle: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                  tabs: const [
                    Tab(text: 'Cari by NIK'),
                    Tab(text: 'Cari by Nama'),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 20),

            // ====================================================
            // TAB CONTENT
            // ====================================================
            AnimatedSize(
              duration: const Duration(milliseconds: 250),
              curve: Curves.easeInOut,
              child: _tabController.index == 0
                  ? _buildNIKContent()
                  : _buildNamaContent(),
            ),
          ],
        ),
      ),
    );
  }

  // ============================================================
  // TAB CONTENT — CARI BY NIK
  // ============================================================

  Widget _buildNIKContent() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 0, 20, 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Label
          const Text(
            'Nomor Induk Kependudukan (NIK)',
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w700,
              color: _ink,
            ),
          ),
          const SizedBox(height: 10),

          // Input NIK
          Container(
            height: 54,
            decoration: BoxDecoration(
              color: const Color(0xFFF8FAFC),
              borderRadius: BorderRadius.circular(14),
              border: Border.all(color: const Color(0xFFE2E8F0)),
            ),
            child: Row(
              children: [
                const SizedBox(width: 16),
                Container(
                  width: 36,
                  height: 36,
                  decoration: BoxDecoration(
                    color: _appBlue.withValues(alpha: 0.08),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: const Icon(
                    Icons.badge_outlined,
                    size: 20,
                    color: _appBlue,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: TextField(
                    controller: _nikController,
                    keyboardType: TextInputType.number,
                    maxLength: 16,
                    style: const TextStyle(
                      fontSize: 14,
                      color: _ink,
                      fontWeight: FontWeight.w500,
                    ),
                    decoration: const InputDecoration(
                      hintText: 'Masukkan 16 digit NIK',
                      hintStyle: TextStyle(
                        fontSize: 13.5,
                        color: Color(0xFF9CA3AF),
                      ),
                      border: InputBorder.none,
                      counterText: '',
                      contentPadding: EdgeInsets.zero,
                    ),
                  ),
                ),
                const SizedBox(width: 16),
              ],
            ),
          ),

          const SizedBox(height: 8),

          // Helper text — fixed overflow with Flexible
          Text(
            'Pastikan NIK sesuai dengan yang tertera di KTP.',
            style: TextStyle(
              fontSize: 12,
              color: _smoke.withValues(alpha: 0.8),
            ),
          ),

          const SizedBox(height: 20),

          // reCAPTCHA
          _buildCaptchaBox(
            checked: _isRobotCheckedNIK,
            onTap: () {
              setState(() => _isRobotCheckedNIK = !_isRobotCheckedNIK);
            },
          ),

          const SizedBox(height: 24),

          // Tombol Cek
          _buildSearchButton(
            label: 'Cek Data',
            onTap: () {
              // TODO: implementasi pencarian by NIK
            },
          ),
        ],
      ),
    );
  }

  // ============================================================
  // TAB CONTENT — CARI BY NAMA
  // ============================================================

  Widget _buildNamaContent() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 0, 20, 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Label
          const Text(
            'Nama Lengkap',
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w700,
              color: _ink,
            ),
          ),
          const SizedBox(height: 10),

          // Input Nama
          Container(
            height: 54,
            decoration: BoxDecoration(
              color: const Color(0xFFF8FAFC),
              borderRadius: BorderRadius.circular(14),
              border: Border.all(color: const Color(0xFFE2E8F0)),
            ),
            child: Row(
              children: [
                const SizedBox(width: 16),
                Container(
                  width: 36,
                  height: 36,
                  decoration: BoxDecoration(
                    color: _appBlue.withValues(alpha: 0.08),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: const Icon(
                    Icons.person_outline_rounded,
                    size: 20,
                    color: _appBlue,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: TextField(
                    controller: _namaController,
                    keyboardType: TextInputType.name,
                    textCapitalization: TextCapitalization.words,
                    style: const TextStyle(
                      fontSize: 14,
                      color: _ink,
                      fontWeight: FontWeight.w500,
                    ),
                    decoration: const InputDecoration(
                      hintText: 'Masukkan minimal 3 karakter nama',
                      hintStyle: TextStyle(
                        fontSize: 13.5,
                        color: Color(0xFF9CA3AF),
                      ),
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.zero,
                    ),
                  ),
                ),
                const SizedBox(width: 16),
              ],
            ),
          ),

          const SizedBox(height: 8),

          // Helper text
          Text(
            'Pastikan NIK sesuai dengan yang tertera di KTP.',
            style: TextStyle(
              fontSize: 12,
              color: _smoke.withValues(alpha: 0.8),
            ),
          ),

          const SizedBox(height: 20),

          // reCAPTCHA
          _buildCaptchaBox(
            checked: _isRobotCheckedNama,
            onTap: () {
              setState(() => _isRobotCheckedNama = !_isRobotCheckedNama);
            },
          ),

          const SizedBox(height: 24),

          // Tombol Cek
          _buildSearchButton(
            label: 'Cek Nama',
            onTap: () {
              setState(() {
                _showHasilPencarian = true;
              });
            },
          ),
        ],
      ),
    );
  }

  // ============================================================
  // HASIL PENCARIAN — List result cards
  // ============================================================

  Widget _buildHasilPencarian() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header hasil pencarian
          Row(
            children: [
              Container(
                width: 36,
                height: 36,
                decoration: BoxDecoration(
                  color: _appBlue.withValues(alpha: 0.08),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Icon(
                  Icons.description_outlined,
                  size: 20,
                  color: _appBlue,
                ),
              ),
              const SizedBox(width: 12),
              Text(
                'Hasil Pencarian (${_hasilPencarian.length})',
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                  color: _ink,
                ),
              ),
              const Spacer(),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 6,
                ),
                decoration: BoxDecoration(
                  color: _ink,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: const Text(
                  'LIVE DATA',
                  style: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.w700,
                    color: Colors.white,
                    letterSpacing: 0.5,
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(height: 16),

          // List items
          ...List.generate(_hasilPencarian.length, (index) {
            return _buildHasilCard(_hasilPencarian[index]);
          }),
        ],
      ),
    );
  }

  // ============================================================
  // HASIL CARD — Single result item
  // ============================================================

  Widget _buildHasilCard(_HasilPencarianItem item) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border(
          left: BorderSide(
            color: _appBlue,
            width: 4,
          ),
          top: BorderSide(color: _cardBorder, width: 1),
          right: BorderSide(color: _cardBorder, width: 1),
          bottom: BorderSide(color: _cardBorder, width: 1),
        ),
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
          // Nama
          Text(
            item.nama,
            style: const TextStyle(
              fontSize: 17,
              fontWeight: FontWeight.w700,
              color: _appBlue,
            ),
          ),

          const SizedBox(height: 10),

          // Jenis Kelamin & Umur
          Row(
            children: [
              Icon(
                Icons.person_outline_rounded,
                size: 16,
                color: _smoke,
              ),
              const SizedBox(width: 6),
              Text(
                item.jenisKelamin,
                style: const TextStyle(
                  fontSize: 13,
                  color: _smoke,
                ),
              ),
              const SizedBox(width: 20),
              Icon(
                Icons.cake_outlined,
                size: 16,
                color: _smoke,
              ),
              const SizedBox(width: 6),
              Text(
                '${item.umur} Tahun',
                style: const TextStyle(
                  fontSize: 13,
                  color: _smoke,
                ),
              ),
            ],
          ),

          const SizedBox(height: 6),

          // Alamat
          Row(
            children: [
              Icon(
                Icons.location_on_outlined,
                size: 16,
                color: _smoke,
              ),
              const SizedBox(width: 6),
              Expanded(
                child: Text(
                  item.alamat,
                  style: const TextStyle(
                    fontSize: 13,
                    color: _smoke,
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(height: 14),

          // Tombol Detail
          SizedBox(
            height: 34,
            child: ElevatedButton(
              onPressed: () {
                // TODO: navigasi ke detail
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: _appBlue,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                padding: const EdgeInsets.symmetric(horizontal: 20),
                elevation: 0,
              ),
              child: const Text(
                'Detail',
                style: TextStyle(
                  fontSize: 13,
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
  // CAPTCHA BOX
  // ============================================================

  Widget _buildCaptchaBox({
    required bool checked,
    required VoidCallback onTap,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 16),
      decoration: BoxDecoration(
        color: const Color(0xFFFAFAFA),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: const Color(0xFFE5E7EB)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.02),
            blurRadius: 4,
            offset: const Offset(0, 1),
          ),
        ],
      ),
      child: Row(
        children: [
          GestureDetector(
            onTap: onTap,
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              width: 28,
              height: 28,
              decoration: BoxDecoration(
                color: checked ? _appBlue : Colors.white,
                borderRadius: BorderRadius.circular(6),
                border: Border.all(
                  color: checked ? _appBlue : const Color(0xFFD1D5DB),
                  width: 2,
                ),
              ),
              child: checked
                  ? const Icon(Icons.check, size: 18, color: Colors.white)
                  : null,
            ),
          ),
          const SizedBox(width: 14),
          const Expanded(
            child: Text(
              'Saya bukan robot',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: _ink,
              ),
            ),
          ),
          // reCAPTCHA icon
          Column(
            children: [
              Icon(
                Icons.recycling_rounded,
                size: 28,
                color: _smoke.withValues(alpha: 0.5),
              ),
              const Text(
                'reCAPTCHA',
                style: TextStyle(
                  fontSize: 8,
                  color: Color(0xFF9CA3AF),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // ============================================================
  // SEARCH BUTTON
  // ============================================================

  Widget _buildSearchButton({
    required String label,
    required VoidCallback onTap,
  }) {
    return SizedBox(
      width: double.infinity,
      height: 56,
      child: ElevatedButton(
        onPressed: onTap,
        style: ElevatedButton.styleFrom(
          backgroundColor: _btnTeal,
          foregroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          elevation: 4,
          shadowColor: _btnTeal.withValues(alpha: 0.35),
        ),
        child: Text(
          label,
          style: const TextStyle(
            fontSize: 17,
            fontWeight: FontWeight.w700,
            letterSpacing: 0.3,
          ),
        ),
      ),
    );
  }

  // ============================================================
  // PUSAT BANTUAN — identik dengan home_screen
  // ============================================================

  Widget _buildHelpButton() {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: BorderRadius.circular(16),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const BantuanScreen(),
            ),
          );
        },
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
            color: Colors.white,
            size: 29,
          ),
        ),
      ),
    );
  }

  // ============================================================
  // BOTTOM NAVIGATION BAR (identik home & agenda & pajak)
  // ============================================================

  Widget _buildNavBar() {
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
                () => Navigator.pop(context),
              ),
            ),
            Expanded(
              child: _navItem(
                Icons.grid_view_rounded,
                Icons.grid_view_rounded,
                'Layanan',
                true,
                () {},
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
                    MaterialPageRoute(
                      builder: (_) => const AgendaScreen(),
                    ),
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
                  color: active ? _navyDark : const Color(0xFF374151),
                ),
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
// MODEL HASIL PENCARIAN
// ================================================================

class _HasilPencarianItem {
  final String nama;
  final String jenisKelamin;
  final int umur;
  final String alamat;

  const _HasilPencarianItem({
    required this.nama,
    required this.jenisKelamin,
    required this.umur,
    required this.alamat,
  });
}
