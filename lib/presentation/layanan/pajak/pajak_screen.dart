import 'package:flutter/material.dart';
import '../../agenda/agenda_screen.dart';
import '../../bantuan/bantuan_screen.dart';

// ================================================================
// LAYANAN PAJAK SCREEN
// Desain 1:1 sesuai context/gambar3.png
// ================================================================

class PajakScreen extends StatefulWidget {
  const PajakScreen({super.key});

  @override
  State<PajakScreen> createState() => _PajakScreenState();
}

class _PajakScreenState extends State<PajakScreen> {
  // ============================================================
  // COLORS
  // ============================================================

  static const Color _appBlue = Color(0xFF007EA7);
  static const Color _tealLight = Color(0xFF58D8EC);
  static const Color _navyDark = Color(0xFF315579);
  static const Color _bg = Color(0xFFF8FAFC);
  static const Color _ink = Color(0xFF202124);
  static const Color _smoke = Color(0xFF737B86);

  // Hero gradient sesuai permintaan
  static const Color _gradTop = Color(0xFF006193);
  static const Color _gradMid = Color(0xFF004B73);
  static const Color _gradBot = Color(0xFF001D31);

  // Section placeholder bg
  static const Color _sectionBg = Color(0xFFEDF4F8);
  static const Color _placeholderBg = Color(0xFFEDF2F7);

  // Button
  static const Color _btnBlue = Color(0xFF005F8A);

  // Badge
  static const Color _badgeBg = Color(0xFFE8EDF2);
  static const Color _badgeText = Color(0xFF4A5568);

  // ============================================================
  // STATE
  // ============================================================

  final TextEditingController _nopController = TextEditingController();
  int _tahunTagihan = 2026;

  @override
  void dispose() {
    _nopController.dispose();
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
                        _buildHeroCard(),
                        const SizedBox(height: 20),
                        _buildPencarianSection(),
                        const SizedBox(height: 20),
                        _buildInfoObjekPajak(),
                        const SizedBox(height: 16),
                        _buildTagihanPBB(),
                        const SizedBox(height: 16),
                        _buildQRISPembayaran(),
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
  // HEADER — sama dengan home_screen & agenda_screen
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
            'Layanan Pajak',
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
  // HERO CARD — kotak rounded dengan gradient #001D31 #004B73 #006193
  // ============================================================

  Widget _buildHeroCard() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
      child: Container(
        padding: const EdgeInsets.fromLTRB(22, 22, 22, 26),
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [_gradTop, _gradMid, _gradBot],
          ),
          borderRadius: BorderRadius.circular(18),
          boxShadow: [
            BoxShadow(
              color: _gradBot.withValues(alpha: 0.45),
              blurRadius: 18,
              offset: const Offset(0, 8),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Badge PAJAK PBB SRAGEN
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.12),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: const Icon(
                    Icons.account_balance_rounded,
                    size: 18,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(width: 10),
                const Text(
                  'PAJAK PBB SRAGEN',
                  style: TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.w600,
                    color: Colors.white70,
                    letterSpacing: 0.6,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 18),

            // Judul utama
            const Text(
              'Cek objek pajak, tagihan\nPBB, dan buat QRIS\npembayaran dalam satu\nalur.',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.w800,
                color: Colors.white,
                height: 1.35,
              ),
            ),

            const SizedBox(height: 14),

            // Deskripsi
            Text(
              'Layanan ini terhubung ke referensi SIMPDRD\nSragen untuk sinkronisasi data yang akurat.',
              style: TextStyle(
                fontSize: 12.5,
                fontWeight: FontWeight.w400,
                color: Colors.white.withValues(alpha: 0.70),
                height: 1.5,
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ============================================================
  // PENCARIAN PAJAK — termasuk catatan integrasi di dalamnya
  // ============================================================

  Widget _buildPencarianSection() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: _cardDeco(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header: icon + title
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: const Color(0xFFE8F4FA),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Icon(
                    Icons.description_outlined,
                    size: 22,
                    color: _appBlue,
                  ),
                ),
                const SizedBox(width: 14),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text(
                      'Pencarian Pajak',
                      style: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.w700,
                        color: _ink,
                      ),
                    ),
                    SizedBox(height: 2),
                    Text(
                      'Masukkan NOP dan tahun tagihan PBB.',
                      style: TextStyle(
                        fontSize: 12,
                        color: _smoke,
                      ),
                    ),
                  ],
                ),
              ],
            ),

            const SizedBox(height: 22),

            // Label NOP
            const Text(
              'Nomor Objek Pajak',
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w600,
                color: _ink,
              ),
            ),
            const SizedBox(height: 8),

            // Input NOP
            Container(
              height: 48,
              decoration: BoxDecoration(
                color: _placeholderBg,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: const Color(0xFFDDE3EA)),
              ),
              child: TextField(
                controller: _nopController,
                keyboardType: TextInputType.number,
                style: const TextStyle(
                  fontSize: 14,
                  color: _ink,
                ),
                decoration: const InputDecoration(
                  hintText: 'Masukan 18 Digit',
                  hintStyle: TextStyle(
                    fontSize: 13,
                    color: Color(0xFF9CA3AF),
                  ),
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 13,
                  ),
                ),
              ),
            ),

            const SizedBox(height: 16),

            // Label Tahun Tagihan
            const Text(
              'Tahun Tagihan',
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w600,
                color: _ink,
              ),
            ),
            const SizedBox(height: 8),

            // Dropdown Tahun
            Container(
              height: 48,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              decoration: BoxDecoration(
                color: _placeholderBg,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: const Color(0xFFDDE3EA)),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '$_tahunTagihan',
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: _ink,
                    ),
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      GestureDetector(
                        onTap: () => setState(() => _tahunTagihan++),
                        child: const Icon(
                          Icons.keyboard_arrow_up_rounded,
                          size: 18,
                          color: _smoke,
                        ),
                      ),
                      GestureDetector(
                        onTap: () => setState(() => _tahunTagihan--),
                        child: const Icon(
                          Icons.keyboard_arrow_down_rounded,
                          size: 18,
                          color: _smoke,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),

            // Tombol Cari
            SizedBox(
              width: double.infinity,
              height: 48,
              child: ElevatedButton.icon(
                onPressed: () {
                  // TODO: implementasi pencarian
                },
                icon: const Icon(Icons.search_rounded, size: 18),
                label: const Text(
                  'Cari objek pajak dan tagihan',
                  style: TextStyle(
                    fontSize: 13.5,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: _btnBlue,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  elevation: 2,
                  shadowColor: _btnBlue.withValues(alpha: 0.30),
                ),
              ),
            ),

            const SizedBox(height: 20),

            // Catatan integrasi — di dalam card pencarian sesuai gambar
            Container(
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: const Color(0xFFF7F9FB),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: const Color(0xFFE8ECF0)),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Icon(
                    Icons.info_outline_rounded,
                    size: 18,
                    color: _smoke,
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        Text(
                          'Catatan integrasi',
                          style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w700,
                            color: _ink,
                          ),
                        ),
                        SizedBox(height: 4),
                        Text(
                          'QRIS dibentuk dari parameter billing sesuai referensi SIMPDRD. Pada respons tagihan saat ini, nilai yang tersedia mengikuti NOP aktif.',
                          style: TextStyle(
                            fontSize: 12,
                            color: _smoke,
                            height: 1.5,
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
    );
  }

  // ============================================================
  // INFORMASI OBJEK PAJAK
  // ============================================================

  Widget _buildInfoObjekPajak() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: _cardDeco(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header: title + badge
            Row(
              children: [
                const Text(
                  'Informasi Objek Pajak',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    color: _ink,
                  ),
                ),
                const SizedBox(width: 10),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: _badgeBg,
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: const Color(0xFFD4DAE1)),
                  ),
                  child: const Text(
                    'Belum dicek',
                    style: TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.w600,
                      color: _badgeText,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 4),
            const Text(
              'Hasil endpoint getInfoNop',
              style: TextStyle(
                fontSize: 11.5,
                color: _smoke,
              ),
            ),

            const SizedBox(height: 16),

            // Placeholder
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 26, horizontal: 20),
              decoration: BoxDecoration(
                color: _sectionBg,
                borderRadius: BorderRadius.circular(14),
              ),
              child: const Text(
                'Data objek pajak akan muncul setelah\nNOP dicek.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 12.5,
                  color: _smoke,
                  height: 1.5,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ============================================================
  // TAGIHAN PBB
  // ============================================================

  Widget _buildTagihanPBB() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: _cardDeco(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Tagihan PBB',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w700,
                color: _ink,
              ),
            ),
            const SizedBox(height: 4),
            const Text(
              'Hasil endpoint getTagihanPBB',
              style: TextStyle(
                fontSize: 11.5,
                color: _smoke,
              ),
            ),

            const SizedBox(height: 16),

            // Placeholder
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 26, horizontal: 20),
              decoration: BoxDecoration(
                color: _sectionBg,
                borderRadius: BorderRadius.circular(14),
              ),
              child: const Text(
                'Tagihan tahun 2026 akan ditampilkan\nsetelah pencarian dilakukan.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 12.5,
                  color: _smoke,
                  height: 1.5,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ============================================================
  // QRIS PEMBAYARAN
  // ============================================================

  Widget _buildQRISPembayaran() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: _cardDeco(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header: icon + title
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(9),
                  decoration: BoxDecoration(
                    color: const Color(0xFFE6F9F0),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: const Icon(
                    Icons.qr_code_2_rounded,
                    size: 20,
                    color: Color(0xFF0D9F6E),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Text(
                        'QRIS Pembayaran',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                          color: _ink,
                        ),
                      ),
                      SizedBox(height: 2),
                      Text(
                        'Hasil endpoint genQRIS yang dirender\nmenjadi kode QR',
                        style: TextStyle(
                          fontSize: 11.5,
                          color: _smoke,
                          height: 1.4,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),

            const SizedBox(height: 20),

            // QR Placeholder
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 28, horizontal: 20),
              decoration: BoxDecoration(
                color: _sectionBg,
                borderRadius: BorderRadius.circular(14),
              ),
              child: Column(
                children: [
                  // QR Code placeholder
                  Container(
                    width: 110,
                    height: 110,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(
                        color: const Color(0xFFDDE3EA),
                        width: 1.5,
                      ),
                    ),
                    child: const Icon(
                      Icons.qr_code_rounded,
                      size: 64,
                      color: Color(0xFFB0BEC5),
                    ),
                  ),

                  const SizedBox(height: 18),

                  const Text(
                    'QRIS pembayaran akan ditampilkan\ndi sini setelah tagihan ditemukan\ndan tombol pembuatan QRIS\ndijalankan.',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 12.5,
                      color: _smoke,
                      height: 1.5,
                    ),
                  ),
                ],
              ),
            ),
          ],
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
  // BOTTOM NAVIGATION BAR (identik home & agenda)
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
                () => Navigator.popUntil(context, (route) => route.isFirst),
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

  // ============================================================
  // HELPER — dekorasi kartu putih
  // ============================================================

  BoxDecoration _cardDeco() => BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: const Color(0xFFE8ECF0)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.04),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      );
}
