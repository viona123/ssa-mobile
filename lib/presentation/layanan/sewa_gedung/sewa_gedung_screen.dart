import 'package:flutter/material.dart';

import '../../agenda/agenda_screen.dart';
import 'sewa_gedung_data.dart';
import 'sewa_gedung_detail_screen.dart';

// ================================================================
// INFORMASI SEWA GEDUNG / AREA TERBUKA — Disperkimtaru Sragen
// Desain mengikuti context/sewa.png. Section berurutan:
//  1. Hero + search + daftar gedung
//  2. Kalender Agenda Pemerintah
//  3. Agenda Kegiatan (filter)
//  4. Tata Cara Penyewaan (timeline)
//  5. Informasi Lebih Lanjut (kontak)
// ================================================================

class SewaGedungScreen extends StatefulWidget {
  const SewaGedungScreen({super.key});

  @override
  State<SewaGedungScreen> createState() => _SewaGedungScreenState();
}

class _SewaGedungScreenState extends State<SewaGedungScreen> {
  static const Color _primary = Color(0xFF0E4C7A);
  static const Color _blue = Color(0xFF127BB5);
  static const Color _lightBlue = Color(0xFF58D8EC);
  static const Color _darkBlue = Color(0xFF315579);
  static const Color _ink = Color(0xFF1B2430);
  static const Color _smoke = Color(0xFF6B7683);
  static const Color _bg = Color(0xFFF3F7FB);
  static const Color _cardBorder = Color(0xFFE3E9EF);
  static const Color _green = Color(0xFF17A673);
  static const Color _greenBg = Color(0xFFE7F8EF);
  static const Color _specBg = Color(0xFFF5F8FB);

  String _query = '';

  List<Gedung> get _filtered {
    final q = _query.trim().toLowerCase();
    if (q.isEmpty) return kGedungList;
    return kGedungList
        .where((g) =>
            g.nama.toLowerCase().contains(q) ||
            g.alamat.toLowerCase().contains(q))
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _bg,
      bottomNavigationBar: _buildBottomNav(),
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
                    const SizedBox(height: 8),
                    ..._filtered.map((g) => Padding(
                          padding: const EdgeInsets.fromLTRB(18, 0, 18, 16),
                          child: _buildGedungCard(g),
                        )),
                    const SizedBox(height: 8),
                    _buildKalenderSection(),
                    const SizedBox(height: 18),
                    _buildAgendaSection(),
                    const SizedBox(height: 18),
                    _buildProsedurSection(),
                    const SizedBox(height: 18),
                    _buildKontakSection(),
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
      height: 60,
      decoration: const BoxDecoration(
        color: Colors.white,
        border: Border(bottom: BorderSide(color: _cardBorder, width: 0.8)),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 18),
      child: Row(
        children: [
          GestureDetector(
            onTap: () => Navigator.pop(context),
            child: const Icon(Icons.arrow_back_rounded, size: 24, color: _primary),
          ),
          const SizedBox(width: 14),
          const Expanded(
            child: Text(
              'Sewa Gedung / Area',
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w800,
                color: _primary,
              ),
            ),
          ),
          const Icon(Icons.search_rounded, size: 22, color: _primary),
        ],
      ),
    );
  }

  // ============================================================
  // HERO + SEARCH
  // ============================================================
  Widget _buildHero() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(24, 22, 24, 20),
      child: Column(
        children: [
          Container(
            width: 62,
            height: 62,
            decoration: BoxDecoration(
              color: _primary,
              borderRadius: BorderRadius.circular(16),
            ),
            child: const Icon(Icons.domain_rounded, size: 30, color: Colors.white),
          ),
          const SizedBox(height: 16),
          const Text.rich(
            TextSpan(
              children: [
                TextSpan(
                  text: 'Informasi ',
                  style: TextStyle(color: _primary),
                ),
                TextSpan(
                  text: 'Sewa Gedung / Area Terbuka',
                  style: TextStyle(color: _ink),
                ),
              ],
            ),
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.w800,
              height: 1.25,
            ),
          ),
          const SizedBox(height: 10),
          const Text(
            'Portal resmi informasi lengkap gedung dan fasilitas Area Terbuka '
            'Publik milik pemerintah Kabupaten Sragen untuk keperluan kegiatan '
            'resmi, acara publik, dan pelayanan masyarakat.',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 12.5, color: _smoke, height: 1.55),
          ),
          const SizedBox(height: 18),
          // SEARCH
          Container(
            height: 52,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(14),
              border: Border.all(color: _cardBorder),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.03),
                  blurRadius: 8,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Row(
              children: [
                const Icon(Icons.search_rounded, size: 20, color: _smoke),
                const SizedBox(width: 10),
                Expanded(
                  child: TextField(
                    onChanged: (v) => setState(() => _query = v),
                    style: const TextStyle(fontSize: 14, color: _ink),
                    decoration: const InputDecoration(
                      isCollapsed: true,
                      border: InputBorder.none,
                      hintText: 'Cari gedung atau area...',
                      hintStyle: TextStyle(fontSize: 14, color: Color(0xFFAAB2BC)),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 4),
        ],
      ),
    );
  }

  // ============================================================
  // GEDUNG CARD
  // ============================================================
  Widget _buildGedungCard(Gedung g) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: _cardBorder),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.04),
            blurRadius: 10,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      clipBehavior: Clip.antiAlias,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // COVER
          SizedBox(
            height: 170,
            width: double.infinity,
            child: Stack(
              children: [
                Container(
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [Color(0xFF2E8BC0), Color(0xFF0E4C7A)],
                    ),
                  ),
                  child: const Center(
                    child: Icon(Icons.apartment_rounded,
                        size: 58, color: Colors.white38),
                  ),
                ),
                Positioned(
                  top: 12,
                  right: 12,
                  child: Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: const Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.check_circle_rounded, size: 13, color: _green),
                        SizedBox(width: 5),
                        Text(
                          'TERSEDIA',
                          style: TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.w800,
                            color: _green,
                            letterSpacing: 0.3,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  g.nama,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w800,
                    color: _ink,
                    height: 1.25,
                  ),
                ),
                const SizedBox(height: 8),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Icon(Icons.location_on_rounded,
                        size: 15, color: _smoke),
                    const SizedBox(width: 6),
                    Expanded(
                      child: Text(
                        g.alamat,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontSize: 12,
                          color: _smoke,
                          height: 1.4,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 14),
                // SPEC
                Container(
                  decoration: BoxDecoration(
                    color: _specBg,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: _cardBorder),
                  ),
                  child: Column(
                    children: [
                      _specRow(Icons.groups_rounded, 'Kapasitas', g.kapasitas),
                      const Divider(height: 1, color: _cardBorder),
                      _specRow(
                          Icons.square_foot_rounded, 'Luas Bangunan', g.luas),
                      const Divider(height: 1, color: _cardBorder),
                      _specRow(Icons.payments_rounded, 'Tarif Sewa',
                          '${g.tarif} / hari',
                          highlight: true),
                    ],
                  ),
                ),
                const SizedBox(height: 16),
                const Text(
                  'FASILITAS UTAMA',
                  style: TextStyle(
                    fontSize: 10.5,
                    fontWeight: FontWeight.w800,
                    color: _smoke,
                    letterSpacing: 0.5,
                  ),
                ),
                const SizedBox(height: 10),
                _buildFasilitasChips(g),
                const SizedBox(height: 16),
                SizedBox(
                  width: double.infinity,
                  child: GestureDetector(
                    onTap: () => _openDetail(g),
                    child: Container(
                      height: 50,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: _primary,
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: [
                          BoxShadow(
                            color: _primary.withValues(alpha: 0.25),
                            blurRadius: 10,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      child: const Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(Icons.visibility_rounded,
                              size: 18, color: Colors.white),
                          SizedBox(width: 9),
                          Text(
                            'Lihat Detail',
                            style: TextStyle(
                              fontSize: 14.5,
                              fontWeight: FontWeight.w800,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _specRow(IconData icon, String label, String value,
      {bool highlight = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 11),
      child: Row(
        children: [
          Icon(icon, size: 16, color: highlight ? _blue : _smoke),
          const SizedBox(width: 9),
          Text(
            label,
            style: TextStyle(
              fontSize: 12.5,
              fontWeight: highlight ? FontWeight.w800 : FontWeight.w500,
              color: highlight ? _blue : _ink,
            ),
          ),
          const Spacer(),
          Text(
            value,
            style: TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w800,
              color: highlight ? _blue : _ink,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFasilitasChips(Gedung g) {
    if (g.fasilitas.isEmpty) {
      return const Text(
        'Belum ada data fasilitas.',
        style: TextStyle(fontSize: 12, color: _smoke),
      );
    }
    final shown = g.fasilitas.take(4).toList();
    final extra = g.fasilitas.length - shown.length;
    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: [
        ...shown.map((f) => Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              decoration: BoxDecoration(
                color: _greenBg,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(Icons.check_rounded, size: 13, color: _green),
                  const SizedBox(width: 5),
                  Text(
                    f,
                    style: const TextStyle(
                      fontSize: 11.5,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF12805B),
                    ),
                  ),
                ],
              ),
            )),
        if (extra > 0)
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            decoration: BoxDecoration(
              color: const Color(0xFFF0F2F5),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Text(
              '+ $extra fasilitas lainnya',
              style: const TextStyle(
                fontSize: 11.5,
                fontWeight: FontWeight.w600,
                color: _smoke,
              ),
            ),
          ),
      ],
    );
  }

  // ============================================================
  // KALENDER AGENDA
  // ============================================================
  Widget _buildKalenderSection() {
    return _sectionCard(
      icon: Icons.calendar_month_rounded,
      title: 'Kalender Agenda Pemerintah',
      subtitle:
          'Informasi jadwal kegiatan dan agenda resmi fasilitas pemerintah '
          'yang telah terkonfirmasi dan terverifikasi.',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildDropdownMock('Semua Lokasi/Gedung'),
          const SizedBox(height: 14),
          _buildMiniCalendar(),
          const SizedBox(height: 14),
          _buildLegend(),
        ],
      ),
    );
  }

  Widget _buildMiniCalendar() {
    const days = ['Sen', 'Sel', 'Rab', 'Kam', 'Jum', 'Sab', 'Min'];
    // Contoh: 34 sel; "HARI INI" pada index 33.
    return Column(
      children: [
        Row(
          children: days
              .map((d) => Expanded(
                    child: Center(
                      child: Text(
                        d,
                        style: const TextStyle(
                          fontSize: 10.5,
                          fontWeight: FontWeight.w700,
                          color: _smoke,
                        ),
                      ),
                    ),
                  ))
              .toList(),
        ),
        const SizedBox(height: 8),
        GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: 34,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 7,
            mainAxisSpacing: 5,
            crossAxisSpacing: 5,
            childAspectRatio: 1.15,
          ),
          itemBuilder: (context, index) {
            final today = index == 33;
            return Container(
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: today ? _primary : const Color(0xFFF5F7FA),
                borderRadius: BorderRadius.circular(7),
              ),
              child: Text(
                today ? 'HARI\nINI' : 'LEWAT',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 6.5,
                  fontWeight: FontWeight.w700,
                  height: 1.1,
                  color: today ? Colors.white : const Color(0xFFB6BEC8),
                ),
              ),
            );
          },
        ),
      ],
    );
  }

  Widget _buildLegend() {
    return Wrap(
      spacing: 14,
      runSpacing: 6,
      children: const [
        _LegendDot(color: _green, label: 'Terkonfirmasi'),
        _LegendDot(color: Color(0xFFE0A118), label: 'Menunggu'),
        _LegendDot(color: Color(0xFFD92D2D), label: 'Dibatalkan'),
        _LegendDot(color: _primary, label: 'Hari Ini'),
        _LegendDot(color: Color(0xFFB6BEC8), label: 'Sudah Lewat'),
      ],
    );
  }

  // ============================================================
  // AGENDA KEGIATAN
  // ============================================================
  Widget _buildAgendaSection() {
    return _sectionCard(
      icon: Icons.view_agenda_rounded,
      title: 'Jadwal Gedung dan Aset Terbuka Sragen',
      subtitle: 'Agenda kegiatan dan acara resmi bulan Agustus 2026.',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Filter mini
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: _specBg,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: _cardBorder),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Row(
                  children: [
                    Icon(Icons.filter_alt_rounded, size: 15, color: _blue),
                    SizedBox(width: 6),
                    Text(
                      'Filter Pencarian',
                      style: TextStyle(
                        fontSize: 12.5,
                        fontWeight: FontWeight.w700,
                        color: _ink,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                _buildDropdownMock('Semua Lokasi/Gedung'),
                const SizedBox(height: 8),
                Container(
                  height: 42,
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: _cardBorder),
                  ),
                  child: const Row(
                    children: [
                      Icon(Icons.search_rounded, size: 16, color: _smoke),
                      SizedBox(width: 8),
                      Text('Cari nama acara...',
                          style:
                              TextStyle(fontSize: 12.5, color: Color(0xFFAAB2BC))),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 14),
          ...kAgendaList.map(_buildAgendaTile),
        ],
      ),
    );
  }

  Widget _buildAgendaTile(AgendaGedung a) {
    final Color statusColor;
    final String statusLabel;
    switch (a.status) {
      case AgendaStatus.terkonfirmasi:
        statusColor = _green;
        statusLabel = 'Terkonfirmasi';
        break;
      case AgendaStatus.menunggu:
        statusColor = const Color(0xFFE0A118);
        statusLabel = 'Menunggu';
        break;
      case AgendaStatus.dibatalkan:
        statusColor = const Color(0xFFD92D2D);
        statusLabel = 'Dibatalkan';
        break;
    }
    final parts = a.tanggal.split(' ');
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: _cardBorder),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Tanggal box
          Container(
            width: 46,
            padding: const EdgeInsets.symmetric(vertical: 8),
            decoration: BoxDecoration(
              color: _primary.withValues(alpha: 0.08),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Column(
              children: [
                Text(
                  parts.isNotEmpty ? parts[0] : '',
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w800,
                    color: _primary,
                  ),
                ),
                Text(
                  parts.length > 1 ? parts[1] : '',
                  style: const TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.w600,
                    color: _primary,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  a.judul,
                  style: const TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w700,
                    color: _ink,
                    height: 1.3,
                  ),
                ),
                const SizedBox(height: 5),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Icon(Icons.location_on_rounded,
                        size: 13, color: _smoke),
                    const SizedBox(width: 4),
                    Expanded(
                      child: Text(
                        a.lokasi,
                        style: const TextStyle(fontSize: 11, color: _smoke),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 9, vertical: 4),
                  decoration: BoxDecoration(
                    color: statusColor.withValues(alpha: 0.12),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    statusLabel,
                    style: TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.w700,
                      color: statusColor,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // ============================================================
  // PROSEDUR
  // ============================================================
  Widget _buildProsedurSection() {
    return _sectionCard(
      icon: Icons.assignment_rounded,
      title: 'Tata Cara Penyewaan Fasilitas',
      subtitle:
          'Panduan komprehensif untuk proses penyewaan fasilitas pemerintah '
          'dengan standar pelayanan terbaik.',
      child: Column(
        children: [
          ...List.generate(kProsedurList.length, (i) {
            return _buildProsedurStep(
                i + 1, kProsedurList[i], i == kProsedurList.length - 1);
          }),
          const SizedBox(height: 6),
          // selesai
          Container(
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: _greenBg,
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(Icons.check_circle_rounded, size: 18, color: _green),
                SizedBox(width: 10),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Proses Berhasil Diselesaikan',
                        style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w800,
                          color: Color(0xFF12805B),
                        ),
                      ),
                      SizedBox(height: 3),
                      Text(
                        'Anda telah menyelesaikan seluruh rangkaian prosedur '
                        'dengan baik.',
                        style: TextStyle(
                          fontSize: 11.5,
                          color: Color(0xFF12805B),
                          height: 1.4,
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
    );
  }

  Widget _buildProsedurStep(int number, ProsedurStep step, bool isLast) {
    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            children: [
              Container(
                width: 30,
                height: 30,
                alignment: Alignment.center,
                decoration: const BoxDecoration(
                  color: _primary,
                  shape: BoxShape.circle,
                ),
                child: Text(
                  '$number',
                  style: const TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w800,
                    color: Colors.white,
                  ),
                ),
              ),
              if (!isLast)
                Expanded(
                  child: Container(
                      width: 2, color: _primary.withValues(alpha: 0.2)),
                ),
            ],
          ),
          const SizedBox(width: 13),
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(bottom: isLast ? 12 : 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    step.judul,
                    style: const TextStyle(
                      fontSize: 13.5,
                      fontWeight: FontWeight.w700,
                      color: _ink,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    step.deskripsi,
                    style: const TextStyle(
                      fontSize: 11.5,
                      color: _smoke,
                      height: 1.45,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    'Tahap $number dari ${kProsedurList.length}',
                    style: const TextStyle(
                      fontSize: 10.5,
                      fontWeight: FontWeight.w700,
                      color: _blue,
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

  // ============================================================
  // KONTAK
  // ============================================================
  Widget _buildKontakSection() {
    return _sectionCard(
      icon: Icons.support_agent_rounded,
      title: 'Informasi Lebih Lanjut',
      subtitle:
          'Untuk informasi lebih lanjut mengenai penyewaan dan fasilitas, '
          'hubungi nomor berikut atau datang ke Kantor Disperkimtaru Kabupaten '
          'Sragen, Jl. Veteran No. 14 Sragen.',
      child: Column(
        children: kKontakList
            .map((k) => Container(
                  margin: const EdgeInsets.only(bottom: 10),
                  padding: const EdgeInsets.all(14),
                  decoration: BoxDecoration(
                    color: _specBg,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: _cardBorder),
                  ),
                  child: Row(
                    children: [
                      Container(
                        width: 42,
                        height: 42,
                        decoration: BoxDecoration(
                          color: _primary.withValues(alpha: 0.10),
                          borderRadius: BorderRadius.circular(11),
                        ),
                        child: Icon(k.icon, size: 21, color: _primary),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              k.kategori,
                              style: const TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w700,
                                color: _ink,
                              ),
                            ),
                            const SizedBox(height: 2),
                            Text(
                              k.nomor,
                              style: const TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.w600,
                                color: _blue,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const Icon(Icons.call_rounded, size: 18, color: _green),
                    ],
                  ),
                ))
            .toList(),
      ),
    );
  }

  // ============================================================
  // HELPERS
  // ============================================================
  Widget _sectionCard({
    required IconData icon,
    required String title,
    required String subtitle,
    required Widget child,
  }) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 18),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: _cardBorder),
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
          Row(
            children: [
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: _primary.withValues(alpha: 0.10),
                  borderRadius: BorderRadius.circular(11),
                ),
                child: Icon(icon, size: 20, color: _primary),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  title,
                  style: const TextStyle(
                    fontSize: 15.5,
                    fontWeight: FontWeight.w800,
                    color: _ink,
                    height: 1.25,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Text(
            subtitle,
            style: const TextStyle(fontSize: 12, color: _smoke, height: 1.5),
          ),
          const SizedBox(height: 16),
          child,
        ],
      ),
    );
  }

  Widget _buildDropdownMock(String label) {
    return Container(
      height: 44,
      padding: const EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: _cardBorder),
      ),
      child: Row(
        children: [
          Expanded(
            child: Text(
              label,
              style: const TextStyle(fontSize: 12.5, color: _ink),
            ),
          ),
          const Icon(Icons.expand_more_rounded, size: 20, color: _smoke),
        ],
      ),
    );
  }

  void _openDetail(Gedung g) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => SewaGedungDetailScreen(gedung: g)),
    );
  }

  // ============================================================
  // BOTTOM NAV
  // ============================================================
  Widget _buildBottomNav() {
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
            color: active ? _lightBlue : Colors.transparent,
            borderRadius: BorderRadius.circular(27),
          ),
          child: Transform.translate(
            offset: const Offset(0, -1),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(active ? on : off,
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

// ================================================================
// LEGEND DOT
// ================================================================
class _LegendDot extends StatelessWidget {
  final Color color;
  final String label;
  const _LegendDot({required this.color, required this.label});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 9,
          height: 9,
          decoration: BoxDecoration(color: color, shape: BoxShape.circle),
        ),
        const SizedBox(width: 5),
        Text(
          label,
          style: const TextStyle(
            fontSize: 10.5,
            color: Color(0xFF6B7683),
          ),
        ),
      ],
    );
  }
}
