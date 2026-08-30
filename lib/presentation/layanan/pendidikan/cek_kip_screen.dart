import 'package:flutter/material.dart';
import '../../agenda/agenda_screen.dart';

// ================================================================
// CEK KIP / PIP SCREEN
// Desain 1:1 sesuai context/gambar5.png
// ================================================================

class CekKipScreen extends StatefulWidget {
  const CekKipScreen({super.key});

  @override
  State<CekKipScreen> createState() => _CekKipScreenState();
}

class _CekKipScreenState extends State<CekKipScreen> {
  // ============================================================
  // COLORS
  // ============================================================

  static const Color _appBlue = Color(0xFF007EA7);
  static const Color _tealLight = Color(0xFF58D8EC);
  static const Color _navyDark = Color(0xFF315579);
  static const Color _bg = Color(0xFFF8FAFC);
  static const Color _ink = Color(0xFF202124);
  static const Color _smoke = Color(0xFF6B7280);
  static const Color _btnBlue = Color(0xFF005F8A);
  static const Color _border = Color(0xFFD4DAE1);
  static const Color _iconBg = Color(0xFFDCEEF5);

  // ============================================================
  // STATE
  // ============================================================

  final TextEditingController _nisnController = TextEditingController();
  final TextEditingController _tglLahirController = TextEditingController();

  @override
  void dispose() {
    _nisnController.dispose();
    _tglLahirController.dispose();
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
      body: SafeArea(
        child: Column(
          children: [
            _buildHeader(),
            Expanded(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 30,
                ),
                child: Column(
                  children: [
                    // Icon
                    Container(
                      width: 80,
                      height: 80,
                      decoration: BoxDecoration(
                        color: _iconBg,
                        borderRadius: BorderRadius.circular(18),
                      ),
                      child: const Icon(
                        Icons.badge_outlined,
                        size: 38,
                        color: _appBlue,
                      ),
                    ),

                    const SizedBox(height: 20),

                    // Title
                    const Text(
                      'Pengecekan Data PIP',
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.w800,
                        color: _ink,
                      ),
                    ),

                    const SizedBox(height: 10),

                    // Subtitle
                    const Text(
                      'Silakan masukkan NISN dan Tanggal Lahir siswa\nuntuk mengecek status PIP.',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 13,
                        color: _smoke,
                        height: 1.5,
                      ),
                    ),

                    const SizedBox(height: 28),

                    // Form Card
                    _buildFormCard(),
                  ],
                ),
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

  Widget _buildHeader() {
    return Container(
      width: double.infinity,
      height: 66,
      decoration: const BoxDecoration(
        color: Colors.white,
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
              color: _ink,
            ),
          ),
          const SizedBox(width: 16),
          const Text(
            'Cek KIP / PIP',
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.w700,
              color: _ink,
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
      width: double.infinity,
      padding: const EdgeInsets.all(22),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: _border.withValues(alpha: 0.6)),
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
          // NISN Label
          RichText(
            text: const TextSpan(
              text: 'NISN ',
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w600,
                color: _ink,
              ),
              children: [
                TextSpan(
                  text: '*',
                  style: TextStyle(
                    color: Color(0xFFD92D2D),
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 10),

          // NISN Input
          Container(
            height: 50,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: _border),
            ),
            child: TextField(
              controller: _nisnController,
              keyboardType: TextInputType.number,
              style: const TextStyle(
                fontSize: 14,
                color: _ink,
              ),
              decoration: const InputDecoration(
                prefixIcon: Icon(
                  Icons.badge_outlined,
                  size: 20,
                  color: _smoke,
                ),
                hintText: 'Contoh: 3161372050',
                hintStyle: TextStyle(
                  fontSize: 13,
                  color: Color(0xFF9CA3AF),
                ),
                border: InputBorder.none,
                contentPadding: EdgeInsets.symmetric(
                  horizontal: 14,
                  vertical: 14,
                ),
              ),
            ),
          ),

          const SizedBox(height: 18),

          // Tanggal Lahir Label
          RichText(
            text: const TextSpan(
              text: 'Tanggal Lahir ',
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w600,
                color: _ink,
              ),
              children: [
                TextSpan(
                  text: '*',
                  style: TextStyle(
                    color: Color(0xFFD92D2D),
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 10),

          // Tanggal Lahir Input
          GestureDetector(
            onTap: () async {
              final DateTime? picked = await showDatePicker(
                context: context,
                initialDate: DateTime(2005, 1, 1),
                firstDate: DateTime(1990),
                lastDate: DateTime.now(),
              );
              if (picked != null) {
                setState(() {
                  _tglLahirController.text =
                      '${picked.month.toString().padLeft(2, '0')}/${picked.day.toString().padLeft(2, '0')}/${picked.year}';
                });
              }
            },
            child: AbsorbPointer(
              child: Container(
                height: 50,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: _border),
                ),
                child: TextField(
                  controller: _tglLahirController,
                  style: const TextStyle(
                    fontSize: 14,
                    color: _ink,
                  ),
                  decoration: const InputDecoration(
                    prefixIcon: Icon(
                      Icons.calendar_today_outlined,
                      size: 20,
                      color: _smoke,
                    ),
                    hintText: 'mm/dd/yyyy',
                    hintStyle: TextStyle(
                      fontSize: 13,
                      color: Color(0xFF9CA3AF),
                    ),
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.symmetric(
                      horizontal: 14,
                      vertical: 14,
                    ),
                  ),
                ),
              ),
            ),
          ),

          const SizedBox(height: 22),

          // Button Cek Status PIP
          SizedBox(
            width: double.infinity,
            height: 52,
            child: ElevatedButton.icon(
              onPressed: () {
                // TODO: implementasi cek status PIP
              },
              icon: const Icon(Icons.search_rounded, size: 20),
              label: const Text(
                'Cek Status PIP',
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w700,
                ),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: _btnBlue,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(14),
                ),
                elevation: 2,
                shadowColor: _btnBlue.withValues(alpha: 0.30),
              ),
            ),
          ),
        ],
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
                () {
                  Navigator.popUntil(context, (route) => route.isFirst);
                },
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
