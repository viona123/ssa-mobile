import 'package:flutter/material.dart';
import '../../bantuan/bantuan_screen.dart';

class PengaduanScreen extends StatefulWidget {
  const PengaduanScreen({super.key});

  @override
  State<PengaduanScreen> createState() => _PengaduanScreenState();
}

class _PengaduanScreenState extends State<PengaduanScreen> {
  // ============================================================
  // COLORS
  // ============================================================

  static const Color primaryBlue = Color(0xFF007EA7);
  static const Color lightBlue = Color(0xFF58D8EC);
  static const Color darkBlue = Color(0xFF315579);
  static const Color darkText = Color(0xFF202124);
  static const Color greyText = Color(0xFF737B86);
  static const Color pageBackground = Color(0xFFF8FAFC);
  static const Color sectionBorder = Color(0xFFD2E9F1);

  // ============================================================
  // STATE
  // ============================================================

  int _selectedTab = 0; // 0 = Buat Aduan, 1 = Riwayat Aduan
  String? _selectedKategori;
  final String _sifatAduan = 'Publik (Terbuka)';
  final TextEditingController _isiAduanController = TextEditingController();
  final TextEditingController _lokasiController = TextEditingController();
  final TextEditingController _teleponController = TextEditingController();

  final List<String> _kategoriList = [
    'Infrastruktur',
    'Pelayanan Publik',
    'Lingkungan',
    'Pendidikan',
    'Kesehatan',
    'Keamanan',
    'Lainnya',
  ];

  // ============================================================
  // PAGINATION STATE
  // ============================================================

  int _currentPage = 1;
  static const int _totalPages = 11;

  // ============================================================
  // DATA RIWAYAT ADUAN
  // ============================================================

  final List<Map<String, String>> _riwayatAduan = [
    {
      'id': '#LBW00000164',
      'tanggal': '4 Jul 2026',
      'kategori': 'Limbah Industri',
      'status': 'SELESAI',
      'deskripsi':
          'Mohon ijin melaporkan limbah dari PG Mojo yang tidak sesuai dengan amanat undang\u2026',
      'lokasi': 'Cantel Kulon, RT 01 RW 22, sragen kulon, sragen',
    },
    {
      'id': '#LBW00000163',
      'tanggal': '3 Jul 2026',
      'kategori': 'Limbah Industri',
      'status': 'SELESAI',
      'deskripsi':
          'Yth. Bapak Bupati, Kami memohon perhatian dan tindakan nyata terkait pencemaran\u2026',
      'lokasi': 'Cantel Wetan RT 2 RW 13, Sragen Tengah, Sragen',
    },
    {
      'id': '#LBW00000161',
      'tanggal': '3 Jul 2026',
      'kategori': 'Lain-lain',
      'status': 'SELESAI',
      'deskripsi':
          'Yth. Bapak Bupati, Dengan hormat, Kami sebagai warga mengajukan pengaduan terk\u2026',
      'lokasi': 'Jl Musi no 15 B cantel wetan RT 02 RW 13 Sragen Tengah Sragen',
    },
    {
      'id': '#LBW00000161',
      'tanggal': '3 Jul 2026',
      'kategori': 'Lain-lain',
      'status': 'SELESAI',
      'deskripsi':
          'Yth. Bapak Bupati, Dengan hormat, Kami sebagai warga mengajukan pengaduan terk\u2026',
      'lokasi': 'Jl Musi no 15 B cantel wetan RT 02 RW 13 Sragen Tengah Sragen',
    },
  ];

  @override
  void dispose() {
    _isiAduanController.dispose();
    _lokasiController.dispose();
    _teleponController.dispose();
    super.dispose();
  }

  // ============================================================
  // BUILD
  // ============================================================

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: pageBackground,
      bottomNavigationBar: _buildBottomNavigation(),
      body: Stack(
        children: [
          SafeArea(
            child: Column(
              children: [
                // HEADER
                _buildHeader(),

                // BODY
                Expanded(
                  child: SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    padding: const EdgeInsets.only(bottom: 90),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 20),

                        // TITLE
                        _buildTitle(),

                        const SizedBox(height: 16),

                        // TAB SWITCHER
                        _buildTabSwitcher(),

                        const SizedBox(height: 20),

                        // CONTENT BASED ON TAB
                        if (_selectedTab == 0) _buildBuatAduanContent(),
                        if (_selectedTab == 1) _buildRiwayatAduanContent(),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),

          // PUSAT BANTUAN BUTTON
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
      height: 60,
      decoration: BoxDecoration(
        color: pageBackground,
        border: Border(
          bottom: BorderSide(color: Colors.grey.shade200, width: 1),
        ),
      ),
      child: Row(
        children: [
          const SizedBox(width: 8),

          IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(
              Icons.arrow_back_ios_new_rounded,
              size: 22,
              color: primaryBlue,
            ),
          ),

          const SizedBox(width: 4),

          Text(
            _selectedTab == 0 ? 'Formulir Aduan' : 'Riwayat Aduan',
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w600,
              color: primaryBlue,
            ),
          ),
        ],
      ),
    );
  }

  // ============================================================
  // TITLE
  // ============================================================

  Widget _buildTitle() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Text(
            'Formulir Aduan Masyarakat',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w700,
              color: darkText,
            ),
          ),

          const SizedBox(height: 6),

          Text(
            'Layanan Pengaduan Terintegrasi Lapor Bupati Sragen',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 13,
              color: greyText,
              fontWeight: FontWeight.w400,
            ),
          ),
        ],
      ),
    );
  }

  // ============================================================
  // TAB SWITCHER
  // ============================================================

  Widget _buildTabSwitcher() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Container(
        height: 48,
        decoration: BoxDecoration(
          color: const Color(0xFFE8EDF2),
          borderRadius: BorderRadius.circular(25),
        ),
        child: Row(
          children: [
            Expanded(
              child: GestureDetector(
                onTap: () {
                  setState(() => _selectedTab = 0);
                },
                child: Container(
                  margin: const EdgeInsets.all(4),
                  decoration: BoxDecoration(
                    color: _selectedTab == 0
                        ? Colors.white
                        : Colors.transparent,
                    borderRadius: BorderRadius.circular(22),
                    boxShadow: _selectedTab == 0
                        ? [
                            BoxShadow(
                              color: Colors.black.withValues(alpha: 0.06),
                              blurRadius: 4,
                              offset: const Offset(0, 2),
                            ),
                          ]
                        : null,
                  ),
                  child: Center(
                    child: Text(
                      'Buat Aduan',
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: _selectedTab == 0
                            ? FontWeight.w600
                            : FontWeight.w500,
                        color: _selectedTab == 0 ? primaryBlue : greyText,
                      ),
                    ),
                  ),
                ),
              ),
            ),

            Expanded(
              child: GestureDetector(
                onTap: () {
                  setState(() => _selectedTab = 1);
                },
                child: Container(
                  margin: const EdgeInsets.all(4),
                  decoration: BoxDecoration(
                    color: _selectedTab == 1
                        ? Colors.white
                        : Colors.transparent,
                    borderRadius: BorderRadius.circular(22),
                    boxShadow: _selectedTab == 1
                        ? [
                            BoxShadow(
                              color: Colors.black.withValues(alpha: 0.06),
                              blurRadius: 4,
                              offset: const Offset(0, 2),
                            ),
                          ]
                        : null,
                  ),
                  child: Center(
                    child: Text(
                      'Riwayat Aduan',
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: _selectedTab == 1
                            ? FontWeight.w600
                            : FontWeight.w500,
                        color: _selectedTab == 1 ? primaryBlue : greyText,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ============================================================
  // BUAT ADUAN CONTENT
  // ============================================================

  Widget _buildBuatAduanContent() {
    return Column(
      children: [
        // INFO BANNER
        _buildInfoBanner(),

        const SizedBox(height: 20),

        // SECTION 1: DETAIL ADUAN
        _buildDetailAduanSection(),

        const SizedBox(height: 20),

        // SECTION 2: INFORMASI LOKASI
        _buildInformasiLokasiSection(),

        const SizedBox(height: 20),

        // SECTION 3: KONTAK & BUKTI
        _buildKontakBuktiSection(),

        const SizedBox(height: 28),

        // BUTTONS
        _buildActionButtons(),
      ],
    );
  }

  // ============================================================
  // INFO BANNER
  // ============================================================

  Widget _buildInfoBanner() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: const Color(0xFFEAF6FB),
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: const Color(0xFFB8DFF0)),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Icon(
              Icons.info_outline_rounded,
              size: 22,
              color: primaryBlue,
            ),

            const SizedBox(width: 12),

            Expanded(
              child: Text(
                'Silakan sampaikan aduan Anda dengan bahasa yang sopan dan jelas. '
                'Identitas Anda aman dan dilindungi. Pastikan Anda mengisi lokasi dengan akurat pada peta.',
                style: TextStyle(
                  fontSize: 12,
                  height: 1.5,
                  color: darkText.withValues(alpha: 0.8),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ============================================================
  // SECTION 1: DETAIL ADUAN
  // ============================================================

  Widget _buildDetailAduanSection() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: sectionBorder),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // SECTION HEADER
            _buildSectionHeader('1. DETAIL ADUAN'),

            const SizedBox(height: 8),
            const Divider(color: Color(0xFFE0E8EF)),
            const SizedBox(height: 16),

            // KATEGORI
            _buildLabel('Kategori'),
            const SizedBox(height: 8),
            _buildKategoriDropdown(),

            const SizedBox(height: 20),

            // SIFAT ADUAN
            _buildLabel('Sifat Aduan'),
            const SizedBox(height: 8),
            _buildSifatAduan(),

            const SizedBox(height: 20),

            // ISI ADUAN
            _buildLabel('Isi Aduan'),
            const SizedBox(height: 8),
            _buildIsiAduan(),
          ],
        ),
      ),
    );
  }

  // ============================================================
  // SECTION 2: INFORMASI LOKASI
  // ============================================================

  Widget _buildInformasiLokasiSection() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: sectionBorder),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // SECTION HEADER
            _buildSectionHeader('2. INFORMASI LOKASI'),

            const SizedBox(height: 8),
            const Divider(color: Color(0xFFE0E8EF)),
            const SizedBox(height: 16),

            // LOKASI ADUAN LENGKAP
            _buildLabel('Lokasi Aduan Lengkap'),
            const SizedBox(height: 8),
            _buildLokasiField(),

            const SizedBox(height: 20),

            // TITIK LOKASI (PETA)
            _buildLabel('Titik Lokasi (Klik Peta)'),
            const SizedBox(height: 8),
            _buildMapPlaceholder(),

            const SizedBox(height: 8),

            Row(
              children: [
                Icon(Icons.location_on_outlined, size: 14, color: greyText),
                const SizedBox(width: 4),
                Text(
                  'Klik pada peta untuk menandai lokasi secara akurat.',
                  style: TextStyle(fontSize: 11, color: greyText),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // ============================================================
  // SECTION 3: KONTAK & BUKTI
  // ============================================================

  Widget _buildKontakBuktiSection() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: sectionBorder),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // SECTION HEADER
            _buildSectionHeader('3. KONTAK & BUKTI'),

            const SizedBox(height: 8),
            const Divider(color: Color(0xFFE0E8EF)),
            const SizedBox(height: 16),

            // NOMOR TELEPON
            _buildLabel('Nomor Telepon'),
            const SizedBox(height: 8),
            _buildTeleponField(),

            const SizedBox(height: 20),

            // LAMPIRAN
            const Text(
              'Lampiran Foto/Dokumen',
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w500,
                color: darkText,
              ),
            ),
            const SizedBox(height: 8),
            _buildFileUpload(),
          ],
        ),
      ),
    );
  }

  // ============================================================
  // SECTION HEADER
  // ============================================================

  Widget _buildSectionHeader(String title) {
    return Text(
      title,
      style: const TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w700,
        color: primaryBlue,
        letterSpacing: 0.3,
      ),
    );
  }

  // ============================================================
  // LABEL
  // ============================================================

  Widget _buildLabel(String label) {
    return RichText(
      text: TextSpan(
        text: label,
        style: const TextStyle(
          fontSize: 13,
          fontWeight: FontWeight.w500,
          color: darkText,
        ),
        children: const [
          TextSpan(
            text: ' *',
            style: TextStyle(color: Colors.red, fontWeight: FontWeight.w600),
          ),
        ],
      ),
    );
  }

  // ============================================================
  // KATEGORI DROPDOWN
  // ============================================================

  Widget _buildKategoriDropdown() {
    return Container(
      height: 50,
      padding: const EdgeInsets.symmetric(horizontal: 14),
      decoration: BoxDecoration(
        color: const Color(0xFFF5F7FA),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFFD9DEE5)),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: _selectedKategori,
          hint: Text(
            'Pilih Kategori',
            style: TextStyle(fontSize: 14, color: greyText),
          ),
          isExpanded: true,
          icon: const Icon(Icons.keyboard_arrow_down_rounded, color: greyText),
          items: _kategoriList.map((String kategori) {
            return DropdownMenuItem<String>(
              value: kategori,
              child: Text(
                kategori,
                style: const TextStyle(fontSize: 14, color: darkText),
              ),
            );
          }).toList(),
          onChanged: (String? value) {
            setState(() {
              _selectedKategori = value;
            });
          },
        ),
      ),
    );
  }

  // ============================================================
  // SIFAT ADUAN
  // ============================================================

  Widget _buildSifatAduan() {
    return Container(
      height: 50,
      padding: const EdgeInsets.symmetric(horizontal: 14),
      decoration: BoxDecoration(
        color: const Color(0xFFF5F7FA),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFFD9DEE5)),
      ),
      child: Row(
        children: [
          Icon(Icons.radio_button_checked, size: 20, color: primaryBlue),

          const SizedBox(width: 10),

          Text(
            _sifatAduan,
            style: const TextStyle(
              fontSize: 14,
              color: darkText,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  // ============================================================
  // ISI ADUAN TEXTAREA
  // ============================================================

  Widget _buildIsiAduan() {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFFF5F7FA),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFFD9DEE5)),
      ),
      child: TextField(
        controller: _isiAduanController,
        maxLines: 5,
        decoration: InputDecoration(
          hintText:
              'Jelaskan permasalahan anda secara lengkap, siapa, kapan, dan bagaimana',
          hintStyle: TextStyle(fontSize: 13, color: greyText, height: 1.5),
          contentPadding: const EdgeInsets.all(14),
          border: InputBorder.none,
        ),
        style: const TextStyle(fontSize: 14, color: darkText),
      ),
    );
  }

  // ============================================================
  // LOKASI FIELD
  // ============================================================

  Widget _buildLokasiField() {
    return Container(
      height: 50,
      decoration: BoxDecoration(
        color: const Color(0xFFF5F7FA),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFFD9DEE5)),
      ),
      child: TextField(
        controller: _lokasiController,
        decoration: InputDecoration(
          hintText: 'Contoh: Jl. Sukowati Km 5, Depan Pasar',
          hintStyle: TextStyle(fontSize: 13, color: greyText),
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 14,
            vertical: 14,
          ),
          border: InputBorder.none,
        ),
        style: const TextStyle(fontSize: 14, color: darkText),
      ),
    );
  }

  // ============================================================
  // MAP PLACEHOLDER
  // ============================================================

  Widget _buildMapPlaceholder() {
    return Container(
      height: 200,
      width: double.infinity,
      decoration: BoxDecoration(
        color: const Color(0xFFE8F4E8),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFFD9DEE5)),
      ),
      child: Stack(
        children: [
          // Map background placeholder
          ClipRRect(
            borderRadius: BorderRadius.circular(11),
            child: Container(
              width: double.infinity,
              height: double.infinity,
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [Color(0xFFD4E8D4), Color(0xFFB8D4E8)],
                ),
              ),
              child: CustomPaint(painter: _MapGridPainter()),
            ),
          ),

          // Map/Satellite toggle
          Positioned(
            left: 10,
            top: 10,
            child: Container(
              height: 30,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(6),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.1),
                    blurRadius: 4,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 6,
                    ),
                    decoration: BoxDecoration(
                      color: primaryBlue,
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: const Text(
                      'Map',
                      style: TextStyle(
                        fontSize: 11,
                        color: Colors.white,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 6,
                    ),
                    child: const Text(
                      'Satellite',
                      style: TextStyle(
                        fontSize: 11,
                        color: darkText,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Zoom controls
          Positioned(
            right: 10,
            top: 10,
            child: Column(
              children: [
                _buildMapControl(Icons.add),
                const SizedBox(height: 4),
                _buildMapControl(Icons.remove),
              ],
            ),
          ),

          // Location button
          Positioned(
            right: 10,
            bottom: 10,
            child: _buildMapControl(Icons.my_location),
          ),

          // Center marker
          const Center(
            child: Icon(Icons.location_on, size: 36, color: Colors.red),
          ),
        ],
      ),
    );
  }

  Widget _buildMapControl(IconData icon) {
    return Container(
      width: 32,
      height: 32,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(6),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.1),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Icon(icon, size: 18, color: darkText),
    );
  }

  // ============================================================
  // TELEPON FIELD
  // ============================================================

  Widget _buildTeleponField() {
    return Container(
      height: 50,
      decoration: BoxDecoration(
        color: const Color(0xFFF5F7FA),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFFD9DEE5)),
      ),
      child: Row(
        children: [
          // +62 prefix
          Container(
            width: 52,
            height: 50,
            decoration: const BoxDecoration(
              border: Border(right: BorderSide(color: Color(0xFFD9DEE5))),
            ),
            child: const Center(
              child: Text(
                '+62',
                style: TextStyle(
                  fontSize: 14,
                  color: darkText,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ),

          // Phone number input
          Expanded(
            child: TextField(
              controller: _teleponController,
              keyboardType: TextInputType.phone,
              decoration: InputDecoration(
                hintText: '081xxxxxxxxx',
                hintStyle: TextStyle(fontSize: 14, color: greyText),
                contentPadding: const EdgeInsets.symmetric(horizontal: 14),
                border: InputBorder.none,
              ),
              style: const TextStyle(fontSize: 14, color: darkText),
            ),
          ),
        ],
      ),
    );
  }

  // ============================================================
  // FILE UPLOAD
  // ============================================================

  Widget _buildFileUpload() {
    return GestureDetector(
      onTap: () {
        _showMessage('Upload File');
      },
      child: Container(
        width: double.infinity,
        height: 140,
        decoration: BoxDecoration(
          color: const Color(0xFFFAFCFE),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: primaryBlue.withValues(alpha: 0.4),
            style: BorderStyle.none,
          ),
        ),
        foregroundDecoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: primaryBlue.withValues(alpha: 0.4),
            style: BorderStyle.solid,
          ),
        ),
        child: CustomPaint(
          painter: _DashedBorderPainter(
            color: primaryBlue.withValues(alpha: 0.5),
            borderRadius: 12,
          ),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 48,
                  height: 48,
                  decoration: BoxDecoration(
                    color: const Color(0xFFE8F4FC),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.cloud_upload_outlined,
                    size: 26,
                    color: primaryBlue,
                  ),
                ),

                const SizedBox(height: 10),

                const Text(
                  'Tekan untuk unggah file',
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                    color: primaryBlue,
                  ),
                ),

                const SizedBox(height: 4),

                Text(
                  'PNG, JPG, PDF (Maks. 1MB, 5 file)',
                  style: TextStyle(fontSize: 11, color: greyText),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // ============================================================
  // ACTION BUTTONS
  // ============================================================

  Widget _buildActionButtons() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        children: [
          // KIRIM ADUAN
          GestureDetector(
            onTap: () {
              _showMessage('Kirim Aduan');
            },
            child: Container(
              width: double.infinity,
              height: 52,
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [Color(0xFF0B8DC5), Color(0xFF076E9B)],
                ),
                borderRadius: BorderRadius.circular(14),
                boxShadow: [
                  BoxShadow(
                    color: primaryBlue.withValues(alpha: 0.3),
                    blurRadius: 8,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.send_rounded, size: 20, color: Colors.white),
                  SizedBox(width: 10),
                  Text(
                    'Kirim Aduan',
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
          ),

          const SizedBox(height: 12),

          // KEMBALI
          GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: Container(
              width: double.infinity,
              height: 52,
              decoration: BoxDecoration(
                color: const Color(0xFFE8EDF2),
                borderRadius: BorderRadius.circular(14),
              ),
              child: const Center(
                child: Text(
                  'Kembali',
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                    color: darkText,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ============================================================
  // RIWAYAT ADUAN CONTENT
  // ============================================================

  Widget _buildRiwayatAduanContent() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        children: [
          // ADUAN CARDS
          ..._riwayatAduan.map((aduan) => _buildAduanCard(aduan)),

          const SizedBox(height: 28),

          // PAGINATION
          _buildPagination(),

          const SizedBox(height: 30),
        ],
      ),
    );
  }

  // ============================================================
  // ADUAN CARD
  // ============================================================

  Widget _buildAduanCard(Map<String, String> aduan) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFE2EBF0)),
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
          // ID, TANGGAL, KATEGORI (satu baris)
          Wrap(
            spacing: 8,
            runSpacing: 8,
            crossAxisAlignment: WrapCrossAlignment.center,
            children: [
              // ID BADGE
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 4,
                ),
                decoration: BoxDecoration(
                  color: darkBlue,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  aduan['id']!,
                  style: const TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
              ),

              // TANGGAL
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.calendar_today_outlined,
                    size: 13,
                    color: greyText,
                  ),
                  const SizedBox(width: 4),
                  Text(
                    aduan['tanggal']!,
                    style: TextStyle(fontSize: 12, color: greyText),
                  ),
                ],
              ),

              // KATEGORI (di sebelah tanggal)
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 4,
                ),
                decoration: BoxDecoration(
                  color: const Color(0xFFEDF2F7),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: const Color(0xFFCDD6E0)),
                ),
                child: Text(
                  aduan['kategori']!,
                  style: const TextStyle(
                    fontSize: 11,
                    color: darkText,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(height: 10),

          // STATUS BADGE
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
            decoration: BoxDecoration(
              color: const Color(0xFFD4F5E6),
              borderRadius: BorderRadius.circular(8),
            ),
            child: const Text(
              'SELESAI',
              style: TextStyle(
                fontSize: 11,
                fontWeight: FontWeight.w700,
                color: Color(0xFF0C7A52),
              ),
            ),
          ),

          const SizedBox(height: 12),

          // DESKRIPSI
          Text(
            aduan['deskripsi']!,
            maxLines: 3,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: darkText,
              height: 1.4,
            ),
          ),

          const SizedBox(height: 10),

          // LOKASI
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Icon(Icons.location_on_outlined, size: 16, color: greyText),
              const SizedBox(width: 4),
              Expanded(
                child: Text(
                  aduan['lokasi']!,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontSize: 12,
                    color: greyText,
                    height: 1.3,
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(height: 14),

          // LIHAT TIMELINE
          Align(
            alignment: Alignment.centerRight,
            child: GestureDetector(
              onTap: () {
                _showMessage('Lihat Timeline');
              },
              child: const Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'Lihat Timeline',
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                      color: primaryBlue,
                    ),
                  ),
                  SizedBox(width: 4),
                  Icon(
                    Icons.arrow_forward_rounded,
                    size: 16,
                    color: primaryBlue,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ============================================================
  // PAGINATION
  // ============================================================

  Widget _buildPagination() {
    final int middlePage = _currentPage <= 2
        ? 2
        : (_currentPage >= _totalPages ? _totalPages - 1 : _currentPage);

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 16),
      child: SizedBox(
        width: double.infinity,
        child: Row(
          children: [
            Expanded(
              child: _buildPaginationLabel(
                'Sebelumnya',
                enabled: _currentPage > 1,
                onTap: () => _changePage(_currentPage - 1),
              ),
            ),
            const SizedBox(width: 5),
            _buildPageNumber(1),
            _buildPageNumber(middlePage),
            const SizedBox(
              width: 20,
              child: Center(
                child: Text('...', style: TextStyle(color: greyText)),
              ),
            ),
            _buildPageNumber(_totalPages),
            const SizedBox(width: 5),
            Expanded(
              child: _buildPaginationLabel(
                'Selanjutnya',
                enabled: _currentPage < _totalPages,
                onTap: () => _changePage(_currentPage + 1),
              ),
            ),
          ],
        ),
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
        height: 40,
        padding: const EdgeInsets.symmetric(horizontal: 5),
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
              fontSize: 11,
              color: enabled ? darkText : greyText,
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
        width: 38,
        height: 40,
        margin: const EdgeInsets.symmetric(horizontal: 2),
        decoration: BoxDecoration(
          color: isActive ? primaryBlue : Colors.white,
          borderRadius: BorderRadius.circular(9),
          border: Border.all(
            color: isActive ? primaryBlue : const Color(0xFFE0E5EA),
          ),
        ),
        child: Center(
          child: Text(
            '$page',
            style: TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w600,
              color: isActive ? Colors.white : darkText,
            ),
          ),
        ),
      ),
    );
  }

  void _changePage(int page) {
    if (page < 1 || page > _totalPages) return;
    setState(() => _currentPage = page);
  }

  // ============================================================
  // PUSAT BANTUAN
  // ============================================================

  Widget _buildHelpButton() {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: BorderRadius.circular(16),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const BantuanScreen()),
          );
        },
        child: Container(
          width: 58,
          height: 58,
          decoration: BoxDecoration(
            color: primaryBlue,
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
  // BOTTOM NAVIGATION
  // ============================================================

  Widget _buildBottomNavigation() {
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
              child: _buildNavItem(
                icon: Icons.home_outlined,
                activeIcon: Icons.home_rounded,
                label: 'Beranda',
                active: false,
                onTap: () {
                  Navigator.pop(context);
                },
              ),
            ),

            Expanded(
              child: _buildNavItem(
                icon: Icons.grid_view_rounded,
                activeIcon: Icons.grid_view_rounded,
                label: 'Layanan',
                active: true,
                onTap: () {},
              ),
            ),

            Expanded(
              child: _buildNavItem(
                icon: Icons.calendar_month_outlined,
                activeIcon: Icons.calendar_month_rounded,
                label: 'Agenda',
                active: false,
                onTap: () {},
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ============================================================
  // NAV ITEM
  // ============================================================

  Widget _buildNavItem({
    required IconData icon,
    required IconData activeIcon,
    required String label,
    required bool active,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Center(
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          width: 95,
          height: 52,
          decoration: BoxDecoration(
            color: active ? lightBlue : Colors.transparent,
            borderRadius: BorderRadius.circular(27),
          ),
          child: Transform.translate(
            offset: const Offset(0, -1),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  active ? activeIcon : icon,
                  size: 22,
                  color: active ? darkBlue : const Color(0xFF374151),
                ),

                const SizedBox(height: 1),

                Text(
                  label,
                  style: TextStyle(
                    fontSize: 9,
                    fontWeight: active ? FontWeight.w600 : FontWeight.w400,
                    color: active ? darkBlue : const Color(0xFF374151),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // ============================================================
  // MESSAGE
  // ============================================================

  void _showMessage(String title) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('$title - Fitur akan tersedia segera'),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        duration: const Duration(seconds: 2),
      ),
    );
  }
}

// ================================================================
// DASHED BORDER PAINTER
// ================================================================

class _DashedBorderPainter extends CustomPainter {
  final Color color;
  final double borderRadius;

  _DashedBorderPainter({required this.color, required this.borderRadius});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.5;

    final path = Path();
    final rrect = RRect.fromRectAndRadius(
      Rect.fromLTWH(0, 0, size.width, size.height),
      Radius.circular(borderRadius),
    );
    path.addRRect(rrect);

    // Create dashed effect
    final dashPath = Path();
    const dashWidth = 6.0;
    const dashSpace = 4.0;

    for (final metric in path.computeMetrics()) {
      double distance = 0;
      while (distance < metric.length) {
        final end = (distance + dashWidth).clamp(0.0, metric.length);
        dashPath.addPath(metric.extractPath(distance, end), Offset.zero);
        distance += dashWidth + dashSpace;
      }
    }

    canvas.drawPath(dashPath, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

// ================================================================
// MAP GRID PAINTER
// ================================================================

class _MapGridPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = const Color(0xFFC8DCC8).withValues(alpha: 0.5)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 0.5;

    // Draw grid lines to simulate map
    for (double x = 0; x < size.width; x += 30) {
      canvas.drawLine(Offset(x, 0), Offset(x, size.height), paint);
    }
    for (double y = 0; y < size.height; y += 30) {
      canvas.drawLine(Offset(0, y), Offset(size.width, y), paint);
    }

    // Draw some "roads"
    final roadPaint = Paint()
      ..color = Colors.white.withValues(alpha: 0.7)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 3;

    canvas.drawLine(
      Offset(0, size.height * 0.4),
      Offset(size.width, size.height * 0.4),
      roadPaint,
    );
    canvas.drawLine(
      Offset(size.width * 0.3, 0),
      Offset(size.width * 0.3, size.height),
      roadPaint,
    );
    canvas.drawLine(
      Offset(size.width * 0.7, 0),
      Offset(size.width * 0.7, size.height),
      roadPaint,
    );
    canvas.drawLine(
      Offset(0, size.height * 0.7),
      Offset(size.width, size.height * 0.7),
      roadPaint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
