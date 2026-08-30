import 'package:flutter/material.dart';

import '../../agenda/agenda_screen.dart';
import 'layanan_ajuan_form.dart';

// ================================================================
// DETAIL LAYANAN PENDIDIKAN (halaman baru dari Daftar Layanan)
// Menampilkan header, judul + bidang, dan formulir pengajuan.
// ================================================================

class LayananDetailPendidikanScreen extends StatelessWidget {
  final String nama;
  final String bidang;
  final IconData bidangIcon;
  final Color bidangColor;
  final LayananInfo info;

  const LayananDetailPendidikanScreen({
    super.key,
    required this.nama,
    required this.bidang,
    required this.bidangIcon,
    required this.bidangColor,
    required this.info,
  });

  static const Color _appBlue = Color(0xFF007EA7);
  static const Color _tealLight = Color(0xFF58D8EC);
  static const Color _navyDark = Color(0xFF315579);
  static const Color _bg = Color(0xFFF8FAFC);
  static const Color _titleBlue = Color(0xFF003D6B);
  static const Color _cardBorder = Color(0xFFE8ECF0);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _bg,
      bottomNavigationBar: _buildNavBar(context),
      body: SafeArea(
        child: Column(
          children: [
            _buildHeader(context),
            Expanded(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                padding: const EdgeInsets.fromLTRB(20, 16, 20, 28),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Kartu judul + bidang
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(16),
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
                      child: Row(
                        children: [
                          Container(
                            width: 46,
                            height: 46,
                            decoration: BoxDecoration(
                              color: bidangColor.withValues(alpha: 0.12),
                              borderRadius: BorderRadius.circular(13),
                            ),
                            child: Icon(bidangIcon, size: 23, color: bidangColor),
                          ),
                          const SizedBox(width: 14),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  nama,
                                  style: const TextStyle(
                                    fontSize: 15.5,
                                    fontWeight: FontWeight.w800,
                                    color: _titleBlue,
                                    height: 1.25,
                                  ),
                                ),
                                const SizedBox(height: 6),
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 9, vertical: 5),
                                  decoration: BoxDecoration(
                                    color: bidangColor.withValues(alpha: 0.10),
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Icon(bidangIcon,
                                          size: 13, color: bidangColor),
                                      const SizedBox(width: 5),
                                      Text(
                                        bidang,
                                        style: TextStyle(
                                          fontSize: 10.5,
                                          fontWeight: FontWeight.w600,
                                          color: bidangColor,
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
                    const SizedBox(height: 16),
                    // Formulir (reuse)
                    LayananAjuanForm(info: info),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

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
          const Expanded(
            child: Text(
              'Detail Layanan',
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.w700,
                color: _appBlue,
              ),
            ),
          ),
        ],
      ),
    );
  }

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
              child: _navItem(Icons.home_outlined, Icons.home_rounded, 'Beranda',
                  false, () => Navigator.popUntil(context, (r) => r.isFirst)),
            ),
            Expanded(
              child: _navItem(Icons.grid_view_rounded, Icons.grid_view_rounded,
                  'Layanan', true, () => Navigator.pop(context)),
            ),
            Expanded(
              child: _navItem(Icons.calendar_month_outlined,
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

  Widget _navItem(IconData off, IconData on, String label, bool active,
      VoidCallback tap) {
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
