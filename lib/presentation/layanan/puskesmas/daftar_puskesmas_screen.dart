import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import 'puskesmas_shared.dart';
import 'portal_klinisia_screen.dart';

// ================================================================
// DAFTAR 25 PUSKESMAS SE-KABUPATEN SRAGEN
// Desain mengikuti context/25puskesmas.png dengan nuansa hijau:
//  - Search + dropdown kecamatan
//  - Filter Tipe Layanan (Semua / Rawat Inap 24 Jam / UGD 24 Jam / PONED)
//  - Kartu puskesmas (badge, alamat, telepon, Petunjuk Arah, Daftar Online)
//  - Pagination Sebelumnya / Selanjutnya
// ================================================================

class DaftarPuskesmasScreen extends StatefulWidget {
  const DaftarPuskesmasScreen({super.key});

  @override
  State<DaftarPuskesmasScreen> createState() => _DaftarPuskesmasScreenState();
}

class _DaftarPuskesmasScreenState extends State<DaftarPuskesmasScreen> {
  static const int _pageSize = 8;

  // Filter tipe layanan
  static const List<String> _filters = [
    'Semua',
    'Rawat Inap 24 Jam',
    'UGD 24 Jam',
    'PONED (Persalinan)',
  ];

  String _query = '';
  String _activeFilter = 'Semua';
  String _kecamatan = 'Semua';
  int _page = 0;

  // ============================================================
  // DATA 25 PUSKESMAS
  // ============================================================
  static const List<_Pkm> _all = [
    _Pkm(
      name: 'Puskesmas Sragen Kota',
      kecamatan: 'Sragen',
      rawatInap: false,
      ugd24: true,
      poned: false,
      alamat: 'Jl. Dr. Sutomo No. 1, Sragen Kulon, Kec. Sragen',
      telepon: '(0271) 891043',
    ),
    _Pkm(
      name: 'Puskesmas Karangmalang',
      kecamatan: 'Karangmalang',
      rawatInap: true,
      ugd24: true,
      poned: true,
      alamat: 'Jl. Raya Karangmalang - Kedawung KM 2, Kec. Karangmalang',
      telepon: '(0271) 891742',
    ),
    _Pkm(
      name: 'Puskesmas Kedawung 1',
      kecamatan: 'Kedawung',
      rawatInap: true,
      ugd24: true,
      poned: true,
      alamat: 'Jl. Raya Kedawung - Batam KM 1, Kec. Kedawung',
      telepon: '(0271) 892109',
    ),
    _Pkm(
      name: 'Puskesmas Kedawung 2',
      kecamatan: 'Kedawung',
      rawatInap: false,
      ugd24: false,
      poned: false,
      alamat: 'Ds. Bendungan, Kec. Kedawung, Kab. Sragen',
      telepon: '(0271) 892110',
    ),
    _Pkm(
      name: 'Puskesmas Sambirejo',
      kecamatan: 'Sambirejo',
      rawatInap: true,
      ugd24: true,
      poned: true,
      alamat: 'Jl. Raya Sambirejo - Sragen No. 18, Kec. Sambirejo',
      telepon: '(0271) 892285',
    ),
    _Pkm(
      name: 'Puskesmas Gondang',
      kecamatan: 'Gondang',
      rawatInap: true,
      ugd24: true,
      poned: true,
      alamat: 'Jl. Raya Gondang - Sambungmacan No. 12, Kec. Gondang',
      telepon: '(0271) 892387',
    ),
    _Pkm(
      name: 'Puskesmas Sambungmacan 1',
      kecamatan: 'Sambungmacan',
      rawatInap: true,
      ugd24: true,
      poned: true,
      alamat: 'Jl. Raya Timur KM 14, Banaran, Kec. Sambungmacan',
      telepon: '(0271) 892456',
    ),
    _Pkm(
      name: 'Puskesmas Sambungmacan 2',
      kecamatan: 'Sambungmacan',
      rawatInap: false,
      ugd24: false,
      poned: false,
      alamat: 'Ds. Bedoro, Kec. Sambungmacan, Kab. Sragen',
      telepon: '(0271) 892458',
    ),
    _Pkm(
      name: 'Puskesmas Ngrampal',
      kecamatan: 'Ngrampal',
      rawatInap: true,
      ugd24: true,
      poned: true,
      alamat: 'Jl. Raya Ngrampal - Sragen KM 5, Kec. Ngrampal',
      telepon: '(0271) 892560',
    ),
    _Pkm(
      name: 'Puskesmas Sidoharjo',
      kecamatan: 'Sidoharjo',
      rawatInap: true,
      ugd24: true,
      poned: false,
      alamat: 'Jl. Raya Sidoharjo No. 22, Kec. Sidoharjo',
      telepon: '(0271) 892661',
    ),
    _Pkm(
      name: 'Puskesmas Masaran 1',
      kecamatan: 'Masaran',
      rawatInap: true,
      ugd24: true,
      poned: true,
      alamat: 'Jl. Raya Masaran - Sragen KM 4, Kec. Masaran',
      telepon: '(0271) 892762',
    ),
    _Pkm(
      name: 'Puskesmas Masaran 2',
      kecamatan: 'Masaran',
      rawatInap: false,
      ugd24: false,
      poned: false,
      alamat: 'Ds. Krebet, Kec. Masaran, Kab. Sragen',
      telepon: '(0271) 892763',
    ),
    _Pkm(
      name: 'Puskesmas Tanon 1',
      kecamatan: 'Tanon',
      rawatInap: true,
      ugd24: true,
      poned: true,
      alamat: 'Jl. Raya Tanon - Gabugan No. 3, Kec. Tanon',
      telepon: '(0271) 892864',
    ),
    _Pkm(
      name: 'Puskesmas Tanon 2',
      kecamatan: 'Tanon',
      rawatInap: false,
      ugd24: false,
      poned: false,
      alamat: 'Ds. Gabugan, Kec. Tanon, Kab. Sragen',
      telepon: '(0271) 892865',
    ),
    _Pkm(
      name: 'Puskesmas Gemolong',
      kecamatan: 'Gemolong',
      rawatInap: true,
      ugd24: true,
      poned: true,
      alamat: 'Jl. Citrosancakan No. 5, Kec. Gemolong',
      telepon: '(0271) 892966',
    ),
    _Pkm(
      name: 'Puskesmas Miri',
      kecamatan: 'Miri',
      rawatInap: false,
      ugd24: true,
      poned: false,
      alamat: 'Jl. Raya Miri - Gemolong KM 3, Kec. Miri',
      telepon: '(0271) 893067',
    ),
    _Pkm(
      name: 'Puskesmas Sumberlawang',
      kecamatan: 'Sumberlawang',
      rawatInap: true,
      ugd24: true,
      poned: true,
      alamat: 'Jl. Raya Solo - Purwodadi KM 25, Kec. Sumberlawang',
      telepon: '(0271) 893168',
    ),
    _Pkm(
      name: 'Puskesmas Mondokan',
      kecamatan: 'Mondokan',
      rawatInap: false,
      ugd24: true,
      poned: false,
      alamat: 'Jl. Raya Mondokan - Sukodono No. 7, Kec. Mondokan',
      telepon: '(0271) 893269',
    ),
    _Pkm(
      name: 'Puskesmas Sukodono',
      kecamatan: 'Sukodono',
      rawatInap: false,
      ugd24: true,
      poned: false,
      alamat: 'Jl. Raya Sukodono - Gesi No. 9, Kec. Sukodono',
      telepon: '(0271) 893370',
    ),
    _Pkm(
      name: 'Puskesmas Gesi',
      kecamatan: 'Gesi',
      rawatInap: false,
      ugd24: false,
      poned: false,
      alamat: 'Ds. Gesi, Kec. Gesi, Kab. Sragen',
      telepon: '(0271) 893471',
    ),
    _Pkm(
      name: 'Puskesmas Tangen',
      kecamatan: 'Tangen',
      rawatInap: true,
      ugd24: true,
      poned: true,
      alamat: 'Jl. Raya Tangen - Jenar KM 2, Kec. Tangen',
      telepon: '(0271) 893572',
    ),
    _Pkm(
      name: 'Puskesmas Jenar',
      kecamatan: 'Jenar',
      rawatInap: false,
      ugd24: true,
      poned: false,
      alamat: 'Jl. Raya Jenar - Tangen No. 4, Kec. Jenar',
      telepon: '(0271) 893673',
    ),
    _Pkm(
      name: 'Puskesmas Kalijambe',
      kecamatan: 'Kalijambe',
      rawatInap: true,
      ugd24: true,
      poned: true,
      alamat: 'Jl. Raya Solo - Purwodadi KM 14, Kec. Kalijambe',
      telepon: '(0271) 893774',
    ),
    _Pkm(
      name: 'Puskesmas Plupuh 1',
      kecamatan: 'Plupuh',
      rawatInap: false,
      ugd24: true,
      poned: false,
      alamat: 'Jl. Raya Plupuh - Gemolong KM 3, Kec. Plupuh',
      telepon: '(0271) 893875',
    ),
    _Pkm(
      name: 'Puskesmas Plupuh 2',
      kecamatan: 'Plupuh',
      rawatInap: false,
      ugd24: false,
      poned: false,
      alamat: 'Ds. Sidokerto, Kec. Plupuh, Kab. Sragen',
      telepon: '(0271) 893876',
    ),
  ];

  // ============================================================
  // FILTERING
  // ============================================================
  List<_Pkm> get _filtered {
    return _all.where((p) {
      // Search
      final q = _query.trim().toLowerCase();
      if (q.isNotEmpty) {
        final match = p.name.toLowerCase().contains(q) ||
            p.kecamatan.toLowerCase().contains(q) ||
            p.alamat.toLowerCase().contains(q);
        if (!match) return false;
      }
      // Kecamatan
      if (_kecamatan != 'Semua' && p.kecamatan != _kecamatan) return false;
      // Tipe layanan
      switch (_activeFilter) {
        case 'Rawat Inap 24 Jam':
          return p.rawatInap;
        case 'UGD 24 Jam':
          return p.ugd24;
        case 'PONED (Persalinan)':
          return p.poned;
        default:
          return true;
      }
    }).toList();
  }

  List<String> get _kecamatanList {
    final set = _all.map((e) => e.kecamatan).toSet().toList()..sort();
    return ['Semua', ...set];
  }

  int get _totalPages {
    final n = _filtered.length;
    if (n == 0) return 1;
    return (n / _pageSize).ceil();
  }

  List<_Pkm> get _pageItems {
    final list = _filtered;
    final start = _page * _pageSize;
    if (start >= list.length) return [];
    final end = (start + _pageSize).clamp(0, list.length);
    return list.sublist(start, end);
  }

  void _resetPage() => _page = 0;

  // ============================================================
  // BUILD
  // ============================================================
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: PuskesmasColors.pageBackground,
      bottomNavigationBar: const PuskesmasBottomNav(),
      body: SafeArea(
        child: Column(
          children: [
            const PuskesmasHeader(title: 'Daftar 25 Puskesmas'),
            Expanded(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                padding: const EdgeInsets.fromLTRB(20, 16, 20, 28),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildFilterPanel(),
                    const SizedBox(height: 14),
                    _buildResultInfo(),
                    const SizedBox(height: 12),
                    ..._buildCards(),
                    const SizedBox(height: 8),
                    _buildPagination(),
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
  // FILTER PANEL — search + dropdown + chips
  // ============================================================
  Widget _buildFilterPanel() {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: PuskesmasColors.cardBorder),
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
            height: 44,
            padding: const EdgeInsets.symmetric(horizontal: 12),
            decoration: BoxDecoration(
              color: const Color(0xFFF7F8FA),
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: PuskesmasColors.cardBorder),
            ),
            child: Row(
              children: [
                const Icon(Icons.search_rounded,
                    size: 18, color: PuskesmasColors.greyText),
                const SizedBox(width: 8),
                Expanded(
                  child: TextField(
                    onChanged: (v) => setState(() {
                      _query = v;
                      _resetPage();
                    }),
                    style: const TextStyle(
                        fontSize: 12.5, color: PuskesmasColors.darkText),
                    decoration: const InputDecoration(
                      isCollapsed: true,
                      border: InputBorder.none,
                      hintText: 'Cari nama puskesmas, kecamatan, atau alamat...',
                      hintStyle: TextStyle(
                          fontSize: 12.5, color: Color(0xFFB0B7BF)),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 10),

          // DROPDOWN KECAMATAN
          Container(
            height: 44,
            padding: const EdgeInsets.symmetric(horizontal: 12),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: PuskesmasColors.cardBorder),
            ),
            child: DropdownButtonHideUnderline(
              child: DropdownButton<String>(
                value: _kecamatan,
                isExpanded: true,
                icon: const Icon(Icons.keyboard_arrow_down_rounded,
                    color: PuskesmasColors.greyText),
                style: const TextStyle(
                    fontSize: 12.5, color: PuskesmasColors.darkText),
                items: _kecamatanList.map((k) {
                  final label = k == 'Semua'
                      ? 'Semua Kecamatan (${_kecamatanList.length - 1} Kecamatan)'
                      : 'Kec. $k';
                  return DropdownMenuItem<String>(
                    value: k,
                    child: Text(label, overflow: TextOverflow.ellipsis),
                  );
                }).toList(),
                onChanged: (v) => setState(() {
                  _kecamatan = v ?? 'Semua';
                  _resetPage();
                }),
              ),
            ),
          ),
          const SizedBox(height: 12),

          // FILTER TIPE LAYANAN — grid 2 x 2
          const Text(
            'Tipe Layanan',
            style: TextStyle(
              fontSize: 11.5,
              fontWeight: FontWeight.w700,
              color: PuskesmasColors.darkText,
            ),
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              Expanded(child: _filterChip(_filters[0])),
              const SizedBox(width: 8),
              Expanded(child: _filterChip(_filters[1])),
            ],
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              Expanded(child: _filterChip(_filters[2])),
              const SizedBox(width: 8),
              Expanded(child: _filterChip(_filters[3])),
            ],
          ),
        ],
      ),
    );
  }

  Widget _filterChip(String f) {
    final active = _activeFilter == f;
    final label = f == 'Semua' ? 'Semua (${_all.length})' : f;
    final icon = _filterIcon(f);
    return GestureDetector(
      onTap: () => setState(() {
        _activeFilter = f;
        _resetPage();
      }),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 180),
        height: 42,
        padding: const EdgeInsets.symmetric(horizontal: 12),
        decoration: BoxDecoration(
          color: active
              ? PuskesmasColors.primaryGreen
              : PuskesmasColors.softGreenBg,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: active
                ? PuskesmasColors.primaryGreen
                : PuskesmasColors.mintGreenBorder,
          ),
          boxShadow: [
            if (active)
              BoxShadow(
                color: PuskesmasColors.primaryGreen.withValues(alpha: 0.25),
                blurRadius: 8,
                offset: const Offset(0, 3),
              ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              size: 15,
              color: active ? Colors.white : PuskesmasColors.primaryGreen,
            ),
            const SizedBox(width: 7),
            Flexible(
              child: Text(
                label,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontSize: 11.5,
                  fontWeight: FontWeight.w700,
                  color: active ? Colors.white : PuskesmasColors.darkText,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  IconData _filterIcon(String filter) {
    switch (filter) {
      case 'Rawat Inap 24 Jam':
        return Icons.hotel_rounded;
      case 'UGD 24 Jam':
        return Icons.emergency_rounded;
      case 'PONED (Persalinan)':
        return Icons.pregnant_woman_rounded;
      default:
        return Icons.apps_rounded;
    }
  }

  // ============================================================
  // RESULT INFO
  // ============================================================
  Widget _buildResultInfo() {
    final n = _filtered.length;
    return Text(
      n == 0
          ? 'Tidak ada puskesmas yang cocok'
          : 'Menampilkan ${_pageItems.length} dari $n puskesmas',
      style: const TextStyle(fontSize: 12, color: PuskesmasColors.greyText),
    );
  }

  // ============================================================
  // CARDS
  // ============================================================
  List<Widget> _buildCards() {
    final items = _pageItems;
    if (items.isEmpty) {
      return [
        Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(vertical: 40),
          alignment: Alignment.center,
          child: const Column(
            children: [
              Icon(Icons.search_off_rounded,
                  size: 40, color: PuskesmasColors.greyText),
              SizedBox(height: 10),
              Text(
                'Puskesmas tidak ditemukan.\nCoba ubah kata kunci atau filter.',
                textAlign: TextAlign.center,
                style:
                    TextStyle(fontSize: 12.5, color: PuskesmasColors.greyText),
              ),
            ],
          ),
        ),
      ];
    }
    return items
        .map((p) => Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: _buildCard(p),
            ))
        .toList();
  }

  Widget _buildCard(_Pkm p) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: PuskesmasColors.cardBorder),
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
          // HEADER: icon + nama + badge
          Padding(
            padding: const EdgeInsets.fromLTRB(14, 14, 14, 10),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 38,
                  height: 38,
                  decoration: BoxDecoration(
                    color: PuskesmasColors.mintGreen,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: const Icon(Icons.local_hospital_rounded,
                      size: 19, color: PuskesmasColors.primaryGreen),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        p.name,
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w800,
                          color: PuskesmasColors.darkText,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        'Kecamatan ${p.kecamatan}',
                        style: const TextStyle(
                          fontSize: 11,
                          color: PuskesmasColors.primaryGreen,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 8),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    _pillBadge(
                      p.rawatInap ? 'Rawat Inap' : 'Non Rawat Inap',
                      p.rawatInap
                          ? const Color(0xFFEAE6FB)
                          : const Color(0xFFF0F2F5),
                      p.rawatInap
                          ? const Color(0xFF6B4FBB)
                          : PuskesmasColors.greyText,
                    ),
                    if (p.ugd24) ...[
                      const SizedBox(height: 5),
                      _pillBadge(
                        'UGD 24 Jam',
                        PuskesmasColors.mintGreen,
                        PuskesmasColors.primaryGreen,
                      ),
                    ],
                    if (p.poned) ...[
                      const SizedBox(height: 5),
                      _pillBadge(
                        'PONED',
                        const Color(0xFFFDEBF1),
                        const Color(0xFFC24C77),
                      ),
                    ],
                  ],
                ),
              ],
            ),
          ),

          // ALAMAT
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 14),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Icon(Icons.location_on_rounded,
                    size: 15, color: PuskesmasColors.greyText),
                const SizedBox(width: 7),
                Expanded(
                  child: Text(
                    p.alamat,
                    style: const TextStyle(
                      fontSize: 11.5,
                      color: PuskesmasColors.greyText,
                      height: 1.4,
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 7),

          // TELEPON
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 14),
            child: Row(
              children: [
                const Icon(Icons.call_rounded,
                    size: 15, color: PuskesmasColors.greyText),
                const SizedBox(width: 7),
                Text(
                  p.telepon,
                  style: const TextStyle(
                    fontSize: 11.5,
                    color: PuskesmasColors.greyText,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 12),

          const Divider(height: 1, color: PuskesmasColors.cardBorder),

          // ACTIONS
          Padding(
            padding: const EdgeInsets.all(12),
            child: Row(
              children: [
                Expanded(
                  child: _buildDirectionButton(p),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: _buildDaftarButton(p),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _pillBadge(String text, Color bg, Color fg) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        text,
        style: TextStyle(
          fontSize: 9.5,
          fontWeight: FontWeight.w700,
          color: fg,
        ),
      ),
    );
  }

  Widget _buildDirectionButton(_Pkm p) {
    return GestureDetector(
      onTap: () => _openMaps(p),
      child: Container(
        height: 40,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: PuskesmasColors.cardBorder),
        ),
        child: const Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.place_rounded, size: 15, color: Color(0xFFD92D2D)),
            SizedBox(width: 6),
            Text(
              'Petunjuk Arah',
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w700,
                color: PuskesmasColors.darkText,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDaftarButton(_Pkm p) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => const PortalKlinisiaScreen()),
        );
      },
      child: Container(
        height: 40,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: PuskesmasColors.primaryGreen,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: PuskesmasColors.primaryGreen.withValues(alpha: 0.25),
              blurRadius: 8,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: const Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.schedule_rounded, size: 15, color: Colors.white),
            SizedBox(width: 6),
            Text(
              'Daftar Online',
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w700,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ============================================================
  // PAGINATION
  // ============================================================
  Widget _buildPagination() {
    if (_filtered.isEmpty) return const SizedBox.shrink();
    final canPrev = _page > 0;
    final canNext = _page < _totalPages - 1;
    return Row(
      children: [
        Expanded(
          child: _pageButton(
            label: 'Sebelumnya',
            icon: Icons.arrow_back_ios_new_rounded,
            enabled: canPrev,
            iconLeading: true,
            onTap: () => setState(() => _page--),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: Text(
            'Hal. ${_page + 1}/$_totalPages',
            style: const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w700,
              color: PuskesmasColors.darkText,
            ),
          ),
        ),
        Expanded(
          child: _pageButton(
            label: 'Selanjutnya',
            icon: Icons.arrow_forward_ios_rounded,
            enabled: canNext,
            iconLeading: false,
            onTap: () => setState(() => _page++),
          ),
        ),
      ],
    );
  }

  Widget _pageButton({
    required String label,
    required IconData icon,
    required bool enabled,
    required bool iconLeading,
    required VoidCallback onTap,
  }) {
    final color =
        enabled ? PuskesmasColors.primaryGreen : PuskesmasColors.greyText;
    final iconWidget = Icon(icon, size: 13, color: color);
    final textWidget = Text(
      label,
      style: TextStyle(
        fontSize: 12,
        fontWeight: FontWeight.w700,
        color: color,
      ),
    );
    return GestureDetector(
      onTap: enabled ? onTap : null,
      child: Container(
        height: 42,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: enabled ? Colors.white : const Color(0xFFF3F5F4),
          borderRadius: BorderRadius.circular(11),
          border: Border.all(
            color: enabled
                ? PuskesmasColors.mintGreenBorder
                : PuskesmasColors.cardBorder,
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: iconLeading
              ? [iconWidget, const SizedBox(width: 7), textWidget]
              : [textWidget, const SizedBox(width: 7), iconWidget],
        ),
      ),
    );
  }

  // ============================================================
  // OPEN MAPS
  // ============================================================
  Future<void> _openMaps(_Pkm p) async {
    final query = Uri.encodeComponent('${p.name}, ${p.alamat}');
    final uri = Uri.parse(
        'https://www.google.com/maps/search/?api=1&query=$query');
    final launched =
        await launchUrl(uri, mode: LaunchMode.externalApplication);
    if (!launched && mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Tidak dapat membuka peta.'),
          behavior: SnackBarBehavior.floating,
        ),
      );
    }
  }
}

// ================================================================
// MODEL
// ================================================================
class _Pkm {
  final String name;
  final String kecamatan;
  final bool rawatInap;
  final bool ugd24;
  final bool poned;
  final String alamat;
  final String telepon;

  const _Pkm({
    required this.name,
    required this.kecamatan,
    required this.rawatInap,
    required this.ugd24,
    required this.poned,
    required this.alamat,
    required this.telepon,
  });
}
