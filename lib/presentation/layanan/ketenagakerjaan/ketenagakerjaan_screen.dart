import 'package:flutter/material.dart';

import '../../agenda/agenda_screen.dart';
import 'ketenagakerjaan_data.dart';
import 'ketenagakerjaan_detail_screen.dart';

// ================================================================
// LAYANAN KETENAGAKERJAAN — Portal Disnaker Sragen
// Desain mengikuti context/kerja.png.
// ================================================================

class KetenagakerjaanScreen extends StatefulWidget {
  const KetenagakerjaanScreen({super.key});

  @override
  State<KetenagakerjaanScreen> createState() => _KetenagakerjaanScreenState();
}

class _KetenagakerjaanScreenState extends State<KetenagakerjaanScreen> {
  // ---- Warna aplikasi (sama seperti screen lain) ----
  static const Color _appBlue = Color(0xFF007EA7);
  static const Color _lightBlue = Color(0xFF58D8EC);
  static const Color _darkBlue = Color(0xFF315579);
  static const Color _ink = Color(0xFF202124);
  static const Color _smoke = Color(0xFF737B86);
  static const Color _bg = Color(0xFFF8FAFC);
  static const Color _cardBorder = Color(0xFFE5E9EE);
  static const Color _green = Color(0xFF12B76A);
  static const Color _greenBg = Color(0xFFE7F8EF);

  String _query = '';

  List<JobItem> get _filtered {
    final q = _query.trim().toLowerCase();
    if (q.isEmpty) return kJobList;
    return kJobList
        .where((j) =>
            j.title.toLowerCase().contains(q) ||
            j.description.toLowerCase().contains(q))
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _bg,
      bottomNavigationBar: _buildBottomNavigation(),
      body: SafeArea(
        child: Column(
          children: [
            _buildHeader(),
            Expanded(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                padding: const EdgeInsets.only(bottom: 28),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildHero(),
                    const SizedBox(height: 16),
                    _buildSearchPanel(),
                    const SizedBox(height: 16),
                    ..._buildCards(),
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
            'Ketenagakerjaan',
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
  // HERO — gradient biru Portal Disnaker
  // ============================================================
  Widget _buildHero() {
    return Container(
      margin: const EdgeInsets.fromLTRB(20, 16, 20, 0),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color(0xFFDCF1FB), Color(0xFFEAF5FD), Color(0xFFF3FAFE)],
        ),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: const Color(0xFFBFE6F5)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // BADGE
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 12, vertical: 7),
                      decoration: BoxDecoration(
                        color: Colors.white.withValues(alpha: 0.7),
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(color: const Color(0xFFBFE6F5)),
                      ),
                      child: const Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(Icons.work_rounded, size: 14, color: _appBlue),
                          SizedBox(width: 6),
                          Text(
                            'PORTAL DISNAKER SRAGEN',
                            style: TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.w700,
                              color: _appBlue,
                              letterSpacing: 0.5,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 14),
                    const Text(
                      'Info Layanan Ketenagakerjaan Terbaru',
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.w800,
                        color: _ink,
                        height: 1.2,
                      ),
                    ),
                    const SizedBox(height: 10),
                    const Text(
                      'Temukan peluang karir impian Anda. Terintegrasi langsung '
                      'dengan Layanan Lapak (Layanan Pasar Kerja) Kabupaten Sragen.',
                      style: TextStyle(fontSize: 12.5, color: _smoke, height: 1.5),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 12),
              Container(
                width: 46,
                height: 46,
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.6),
                  borderRadius: BorderRadius.circular(13),
                  border: Border.all(color: const Color(0xFFBFE6F5)),
                ),
                child: const Icon(Icons.explore_rounded,
                    size: 22, color: _appBlue),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // ============================================================
  // SEARCH PANEL
  // ============================================================
  Widget _buildSearchPanel() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
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
              color: const Color(0xFFF7F8FA),
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: _cardBorder),
            ),
            child: Row(
              children: [
                const Icon(Icons.search_rounded, size: 18, color: _smoke),
                const SizedBox(width: 8),
                Expanded(
                  child: TextField(
                    onChanged: (v) => setState(() => _query = v),
                    style: const TextStyle(fontSize: 12.5, color: _ink),
                    decoration: const InputDecoration(
                      isCollapsed: true,
                      border: InputBorder.none,
                      hintText:
                          'Cari lowongan pekerjaan (contoh: Operator, Perkebunan, ART...)',
                      hintStyle:
                          TextStyle(fontSize: 12, color: Color(0xFFB0B7BF)),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              // TOTAL LOWONGAN
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 9),
                decoration: BoxDecoration(
                  color: const Color(0xFFF7F8FA),
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: _cardBorder),
                ),
                child: Row(
                  children: [
                    const Text(
                      'Total Lowongan: ',
                      style: TextStyle(fontSize: 11.5, color: _smoke),
                    ),
                    Text(
                      '${_filtered.length}',
                      style: const TextStyle(
                        fontSize: 12.5,
                        fontWeight: FontWeight.w800,
                        color: _appBlue,
                      ),
                    ),
                  ],
                ),
              ),
              const Spacer(),
              // REFRESH
              GestureDetector(
                onTap: () {
                  setState(() => _query = '');
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Daftar lowongan diperbarui.'),
                      behavior: SnackBarBehavior.floating,
                      duration: Duration(seconds: 1),
                    ),
                  );
                },
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 9),
                  decoration: BoxDecoration(
                    color: _appBlue,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: const Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.refresh_rounded, size: 15, color: Colors.white),
                      SizedBox(width: 6),
                      Text(
                        'Refresh',
                        style: TextStyle(
                          fontSize: 12.5,
                          fontWeight: FontWeight.w700,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // ============================================================
  // CARDS
  // ============================================================
  List<Widget> _buildCards() {
    final items = _filtered;
    if (items.isEmpty) {
      return [
        Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(vertical: 40),
          alignment: Alignment.center,
          child: const Column(
            children: [
              Icon(Icons.work_off_rounded, size: 40, color: _smoke),
              SizedBox(height: 10),
              Text(
                'Lowongan tidak ditemukan.',
                style: TextStyle(fontSize: 12.5, color: _smoke),
              ),
            ],
          ),
        ),
      ];
    }
    return items
        .map((j) => Padding(
              padding: const EdgeInsets.fromLTRB(20, 0, 20, 12),
              child: _buildCard(j),
            ))
        .toList();
  }

  Widget _buildCard(JobItem job) {
    return GestureDetector(
      onTap: () => _openDetail(job),
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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // ID + AKTIF
                  Row(
                    children: [
                      _pill('ID #${job.id}', const Color(0xFFEFF3F7), _smoke),
                      const Spacer(),
                      if (job.aktif) _pill('AKTIF', _greenBg, _green),
                    ],
                  ),
                  const SizedBox(height: 12),
                  // TITLE
                  Text(
                    job.title,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w800,
                      color: _ink,
                      height: 1.25,
                    ),
                  ),
                  const SizedBox(height: 12),
                  // DATES
                  _dateRow(Icons.event_note_rounded, 'Awal: ${job.awal}'),
                  const SizedBox(height: 6),
                  _dateRow(Icons.event_busy_rounded, 'Akhir: ${job.akhir}'),
                  const SizedBox(height: 12),
                  const Divider(height: 1, color: _cardBorder),
                  const SizedBox(height: 12),
                  // DESC snippet
                  Text(
                    job.summary,
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 12,
                      color: _smoke,
                      height: 1.5,
                    ),
                  ),
                ],
              ),
            ),
            const Divider(height: 1, color: _cardBorder),
            // FOOTER: posted + Detail
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              child: Row(
                children: [
                  const Icon(Icons.schedule_rounded, size: 15, color: _smoke),
                  const SizedBox(width: 6),
                  Text(
                    job.posted,
                    style: const TextStyle(fontSize: 11.5, color: _smoke),
                  ),
                  const Spacer(),
                  GestureDetector(
                    onTap: () => _openDetail(job),
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 14, vertical: 8),
                      decoration: BoxDecoration(
                        color: const Color(0xFFEAF7FC),
                        borderRadius: BorderRadius.circular(9),
                      ),
                      child: const Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            'Detail',
                            style: TextStyle(
                              fontSize: 12.5,
                              fontWeight: FontWeight.w700,
                              color: _appBlue,
                            ),
                          ),
                          SizedBox(width: 5),
                          Icon(Icons.arrow_forward_rounded,
                              size: 15, color: _appBlue),
                        ],
                      ),
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

  Widget _dateRow(IconData icon, String text) {
    return Row(
      children: [
        Icon(icon, size: 15, color: _appBlue),
        const SizedBox(width: 8),
        Expanded(
          child: Text(
            text,
            style: const TextStyle(fontSize: 12, color: _ink),
          ),
        ),
      ],
    );
  }

  Widget _pill(String text, Color bg, Color fg) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        text,
        style: TextStyle(
          fontSize: 10.5,
          fontWeight: FontWeight.w700,
          color: fg,
        ),
      ),
    );
  }

  void _openDetail(JobItem job) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => KetenagakerjaanDetailScreen(job: job),
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
              child: _navItem(Icons.home_outlined, Icons.home_rounded,
                  'Beranda', false, () => Navigator.pop(context)),
            ),
            Expanded(
              child: _navItem(Icons.grid_view_rounded, Icons.grid_view_rounded,
                  'Layanan', true, () {}),
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

  Widget _navItem(IconData offIcon, IconData onIcon, String label, bool active,
      VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Center(
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          width: 95,
          height: 52,
          decoration: BoxDecoration(
            color: active ? _lightBlue : Colors.transparent,
            borderRadius: BorderRadius.circular(27),
          ),
          child: Transform.translate(
            offset: const Offset(0, -1),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(active ? onIcon : offIcon,
                    size: 22,
                    color: active ? _darkBlue : const Color(0xFF374151)),
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
