import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../agenda/agenda_screen.dart';
import '../../bantuan/bantuan_screen.dart';

/// Layanan Geospasial Sragen (sesuai desain context/geo1.png).
///
/// Menampilkan toggle Maps/Dataset, peta interaktif (placeholder), serta
/// daftar layer peta yang dapat dicari dan dicentang, lengkap dengan badge
/// PUBLISH dan sub-section "Satu Peta".
class GeospasialScreen extends StatefulWidget {
  const GeospasialScreen({super.key});

  @override
  State<GeospasialScreen> createState() => _GeospasialScreenState();
}

class _GeospasialScreenState extends State<GeospasialScreen> {
  // ============================================================
  // COLORS
  // ============================================================
  static const Color _primaryBlue = Color(0xFF007EA7);
  static const Color _tabActive = Color(0xFF0B5A8A);
  static const Color _publishBlue = Color(0xFF1C74B8);
  static const Color _lightBlue = Color(0xFF58D8EC);
  static const Color _darkBlue = Color(0xFF315579);
  static const Color _darkText = Color(0xFF202124);
  static const Color _greyText = Color(0xFF737B86);
  static const Color _pageBackground = Color(0xFFF3F5FB);

  static const String _mapAsset = 'assets/images/bus_sekolah/map_bg-3e98e6.png';

  // ============================================================
  // STATE
  // ============================================================
  int _selectedTab = 0; // 0 = Maps, 1 = Dataset
  final TextEditingController _searchController = TextEditingController();
  String _query = '';

  final List<_MapLayer> _layers = const [
    _MapLayer('Gesi Saluran Irigase Tersier'),
    _MapLayer('Sukodono Saluran Irigase Tersier'),
    _MapLayer('Miri Saluran Irigase Tersier'),
    _MapLayer('Sumberlawang Saluran Irigase Tersier'),
    _MapLayer('Kalijambe Saluran Irigase Tersier'),
    _MapLayer('Gemolong Saluran Irigase Tersier'),
    _MapLayer('Tanon Saluran Irigase Tersier'),
    _MapLayer('Plupuh Saluran Irigase Tersier'),
    _MapLayer('Kedawung Saluran Irigase Tersier'),
    _MapLayer('Karangmalang Saluran Irigase Tersier'),
    _MapLayer('Sragen Saluran Irigase Tersier'),
    _MapLayer('Sidoharjo Saluran Irigase Tersier'),
    _MapLayer('Sambungmacan Saluran Irigase Tersier'),
    _MapLayer('Sambirejo Saluran Irigase Tersier'),
    _MapLayer('Ngrampal Saluran Irigase Tersier'),
    _MapLayer('Masaran Saluran Irigasi Tersier'),
    _MapLayer('Gondang Saluran Irigasi Tersier'),
    _MapLayer('Potensi Air Tanah'),
    _MapLayer('Desa Kemiskinan'),
    _MapLayer('WIFI GRATIS'),
  ];

  final List<_MapLayer> _satuPeta = const [
    _MapLayer('Rencana Pola Ruang'),
  ];

  final Set<String> _checkedLayers = {};

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  // ============================================================
  // BUILD
  // ============================================================
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _pageBackground,
      bottomNavigationBar: _buildBottomNavigation(),
      body: SafeArea(
        child: Stack(
          children: [
            Column(
              children: [
                _buildHeader(context),
                Expanded(
                  child: SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    padding: const EdgeInsets.fromLTRB(16, 16, 16, 24),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Toggle Maps / Dataset
                        _buildTabToggle(),

                        const SizedBox(height: 16),

                        // Konten sesuai tab
                        if (_selectedTab == 0) ...[
                          _buildMapView(),
                          const SizedBox(height: 20),
                          _buildLayerSection(),
                        ] else
                          _buildDatasetView(),
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
            color: _primaryBlue,
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
  // HEADER — ← Layanan Geospasial (seragam dengan layanan lain)
  // ============================================================
  Widget _buildHeader(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 66,
      decoration: const BoxDecoration(
        color: _pageBackground,
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
              color: _primaryBlue,
            ),
          ),
          const SizedBox(width: 16),
          const Text(
            'Layanan Geospasial',
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.w700,
              color: _primaryBlue,
            ),
          ),
        ],
      ),
    );
  }

  // ============================================================
  // TAB TOGGLE (Maps / Dataset)
  // ============================================================
  Widget _buildTabToggle() {
    return Container(
      padding: const EdgeInsets.all(6),
      decoration: BoxDecoration(
        color: const Color(0xFFEAEEF6),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          Expanded(child: _buildTabButton('Maps', 0)),
          Expanded(child: _buildTabButton('Dataset', 1)),
        ],
      ),
    );
  }

  Widget _buildTabButton(String label, int index) {
    final bool active = _selectedTab == index;
    return GestureDetector(
      onTap: () => setState(() => _selectedTab = index),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(vertical: 13),
        decoration: BoxDecoration(
          color: active ? _tabActive : Colors.transparent,
          borderRadius: BorderRadius.circular(12),
          boxShadow: active
              ? [
                  BoxShadow(
                    color: _tabActive.withValues(alpha: 0.3),
                    blurRadius: 8,
                    offset: const Offset(0, 3),
                  ),
                ]
              : null,
        ),
        alignment: Alignment.center,
        child: Text(
          label,
          style: TextStyle(
            fontSize: 14.5,
            fontWeight: active ? FontWeight.w700 : FontWeight.w500,
            color: active ? Colors.white : _greyText,
          ),
        ),
      ),
    );
  }

  // ============================================================
  // MAP VIEW (placeholder image + controls)
  // ============================================================
  Widget _buildMapView() {
    return ClipRRect(
      borderRadius: BorderRadius.circular(14),
      child: SizedBox(
        height: 190,
        width: double.infinity,
        child: Stack(
          children: [
            // Peta (gambar placeholder)
            Positioned.fill(
              child: Image.asset(
                _mapAsset,
                fit: BoxFit.cover,
                errorBuilder: (_, __, ___) => Container(
                  color: const Color(0xFFDDE7DA),
                  child: const Center(
                    child: Icon(
                      Icons.map_rounded,
                      size: 60,
                      color: Color(0xFF9BB39A),
                    ),
                  ),
                ),
              ),
            ),

            // Toolbar atas (mock)
            Positioned(
              top: 8,
              left: 8,
              right: 8,
              child: Row(
                children: [
                  _buildMapChip('Geospasial Utama'),
                  const Spacer(),
                  _buildMapChip('Peta Utama'),
                ],
              ),
            ),

            // Tombol lokasi (kanan atas)
            Positioned(
              top: 52,
              right: 12,
              child: _buildMapControl(
                child: const Icon(
                  Icons.my_location_rounded,
                  color: _primaryBlue,
                  size: 22,
                ),
                onTap: () {},
              ),
            ),

            // Kontrol zoom (+/-)
            Positioned(
              top: 108,
              right: 12,
              child: _buildMapControl(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    _buildZoomButton(Icons.add, () {}),
                    Container(
                      width: 26,
                      height: 1,
                      color: const Color(0xFFE0E0E0),
                    ),
                    _buildZoomButton(Icons.remove, () {}),
                  ],
                ),
              ),
            ),

            // Marker pusat
            const Positioned.fill(
              child: Center(
                child: Icon(
                  Icons.circle,
                  size: 16,
                  color: _primaryBlue,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMapChip(String text) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.9),
        borderRadius: BorderRadius.circular(6),
      ),
      child: Text(
        text,
        style: const TextStyle(
          fontSize: 10,
          fontWeight: FontWeight.w600,
          color: _darkText,
        ),
      ),
    );
  }

  Widget _buildMapControl({required Widget child, VoidCallback? onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(6),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.15),
              blurRadius: 6,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: child,
      ),
    );
  }

  Widget _buildZoomButton(IconData icon, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: SizedBox(
        width: 28,
        height: 34,
        child: Icon(icon, size: 20, color: _darkText),
      ),
    );
  }

  // ============================================================
  // LAYER SECTION (LAYER PETA + search + list)
  // ============================================================
  Widget _buildLayerSection() {
    final String q = _query.toLowerCase();
    final filtered =
        _layers.where((l) => l.name.toLowerCase().contains(q)).toList();
    final filteredSatuPeta =
        _satuPeta.where((l) => l.name.toLowerCase().contains(q)).toList();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Judul section
        Row(
          children: const [
            Icon(Icons.layers_rounded, color: _primaryBlue, size: 20),
            SizedBox(width: 8),
            Text(
              'Layer Peta',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w700,
                color: _darkText,
              ),
            ),
          ],
        ),

        const SizedBox(height: 12),

        // Search bar
        _buildSearchBar(),

        const SizedBox(height: 6),

        // Daftar layer
        ...filtered.map(_buildLayerTile),

        // Sub-section SATU PETA
        if (filteredSatuPeta.isNotEmpty) ...[
          const SizedBox(height: 10),
          _buildSubSectionHeader('Satu Peta'),
          const SizedBox(height: 4),
          ...filteredSatuPeta.map(_buildLayerTile),
        ],

        if (filtered.isEmpty && filteredSatuPeta.isEmpty)
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 24),
            child: Center(
              child: Text(
                'Peta "$_query" tidak ditemukan.',
                style: const TextStyle(fontSize: 13, color: _greyText),
              ),
            ),
          ),
      ],
    );
  }

  Widget _buildSearchBar() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: const Color(0xFFDCE1EA)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.03),
            blurRadius: 6,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: TextField(
        controller: _searchController,
        onChanged: (val) => setState(() => _query = val),
        style: const TextStyle(fontSize: 15, color: _darkText),
        decoration: const InputDecoration(
          hintText: 'Cari Peta',
          hintStyle: TextStyle(fontSize: 15, color: _greyText),
          prefixIcon: Icon(Icons.search_rounded, color: _greyText, size: 24),
          border: InputBorder.none,
          contentPadding: EdgeInsets.symmetric(vertical: 16, horizontal: 8),
        ),
      ),
    );
  }

  Widget _buildSubSectionHeader(String title) {
    return Row(
      children: [
        Container(
          width: 4,
          height: 18,
          decoration: BoxDecoration(
            color: _primaryBlue,
            borderRadius: BorderRadius.circular(2),
          ),
        ),
        const SizedBox(width: 10),
        Text(
          title,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w700,
            color: _darkBlue,
          ),
        ),
      ],
    );
  }

  Widget _buildLayerTile(_MapLayer layer) {
    final bool checked = _checkedLayers.contains(layer.name);
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: GestureDetector(
        onTap: () {
          setState(() {
            if (checked) {
              _checkedLayers.remove(layer.name);
            } else {
              _checkedLayers.add(layer.name);
            }
          });
        },
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 180),
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(14),
            border: Border.all(
              color: checked
                  ? _primaryBlue.withValues(alpha: 0.35)
                  : const Color(0xFFE5E9EF),
              width: checked ? 1.4 : 1,
            ),
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
              // Checkbox
              Icon(
                checked
                    ? Icons.check_box_rounded
                    : Icons.check_box_outline_blank_rounded,
                size: 24,
                color: checked ? _primaryBlue : const Color(0xFFB9C2CE),
              ),
              const SizedBox(width: 12),
              // Nama layer
              Expanded(
                child: Text(
                  layer.name,
                  style: TextStyle(
                    fontSize: 13.5,
                    fontWeight: FontWeight.w600,
                    color: _darkText,
                    height: 1.35,
                  ),
                ),
              ),
              const SizedBox(width: 10),
              // Badge PUBLISH
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                decoration: BoxDecoration(
                  color: _publishBlue.withValues(alpha: 0.12),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Text(
                  'Publish',
                  style: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.w700,
                    color: _publishBlue,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // ============================================================
  // DATASET VIEW (tab kedua) — sesuai desain geo2.png
  // ============================================================
  Widget _buildDatasetView() {
    final String q = _query.toLowerCase();
    final filtered =
        _layers.where((l) => l.name.toLowerCase().contains(q)).toList();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        // Judul
        const SizedBox(height: 4),
        const Text(
          'Data Geospasial',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w800,
            color: _darkText,
          ),
        ),
        const SizedBox(height: 8),
        const Text(
          'Sistem Informasi Geografis – Bappeda Kabupaten Sragen. '
          'Akses informasi spasial terpadu.',
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 13, color: _greyText, height: 1.5),
        ),
        const SizedBox(height: 14),

        // Link Buka Portal Geoplan
        GestureDetector(
          onTap: _openPortalGeoplan,
          child: const Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Buka Portal Geoplan',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                  color: _primaryBlue,
                ),
              ),
              SizedBox(width: 6),
              Icon(Icons.open_in_new_rounded, size: 16, color: _primaryBlue),
            ],
          ),
        ),

        const SizedBox(height: 18),

        // Search bar
        _buildDatasetSearchBar(),

        const SizedBox(height: 14),

        // Chip jumlah + Refresh
        Row(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
              decoration: BoxDecoration(
                color: const Color(0xFFE6EEF6),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(Icons.grid_view_rounded,
                      size: 16, color: _primaryBlue),
                  const SizedBox(width: 8),
                  Text(
                    '${_layers.length} dataset',
                    style: const TextStyle(
                      fontSize: 13.5,
                      fontWeight: FontWeight.w600,
                      color: _darkText,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 12),
            GestureDetector(
              onTap: () {
                setState(() {
                  _searchController.clear();
                  _query = '';
                });
              },
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: const Color(0xFFDCE1EA)),
                ),
                child: const Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.refresh_rounded, size: 16, color: _darkText),
                    SizedBox(width: 8),
                    Text(
                      'Refresh',
                      style: TextStyle(
                        fontSize: 13.5,
                        fontWeight: FontWeight.w600,
                        color: _darkText,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),

        const SizedBox(height: 18),

        // Daftar kartu dataset
        if (filtered.isEmpty)
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 40),
            child: Center(
              child: Text(
                'Dataset "$_query" tidak ditemukan.',
                style: const TextStyle(fontSize: 13, color: _greyText),
              ),
            ),
          )
        else
          ...filtered.map(_buildDatasetCard),
      ],
    );
  }

  // ============================================================
  // BUKA PORTAL GEOPLAN (eksternal)
  // ============================================================
  Future<void> _openPortalGeoplan() async {
    final Uri uri = Uri.parse('https://geoplan.sragenkab.go.id/dataset');
    final bool launched =
        await launchUrl(uri, mode: LaunchMode.externalApplication);
    if (!launched && mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Tidak dapat membuka Portal Geoplan.'),
          behavior: SnackBarBehavior.floating,
        ),
      );
    }
  }

  Widget _buildDatasetSearchBar() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: const Color(0xFFDCE1EA)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.03),
            blurRadius: 6,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: TextField(
        controller: _searchController,
        onChanged: (val) => setState(() => _query = val),
        style: const TextStyle(fontSize: 15, color: _darkText),
        decoration: const InputDecoration(
          hintText: 'Cari dataset peta...',
          hintStyle: TextStyle(fontSize: 15, color: _greyText),
          prefixIcon: Icon(Icons.search_rounded, color: _greyText, size: 24),
          border: InputBorder.none,
          contentPadding: EdgeInsets.symmetric(vertical: 16, horizontal: 8),
        ),
      ),
    );
  }

  Widget _buildDatasetCard(_MapLayer layer) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFE6E9F0)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.04),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      clipBehavior: Clip.antiAlias,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Thumbnail peta
          SizedBox(
            height: 140,
            width: double.infinity,
            child: Stack(
              children: [
                Positioned.fill(
                  child: Image.asset(
                    _mapAsset,
                    fit: BoxFit.cover,
                    errorBuilder: (_, __, ___) => Container(
                      color: const Color(0xFFDDE7DA),
                      child: const Center(
                        child: Icon(Icons.map_rounded,
                            size: 40, color: Color(0xFF9BB39A)),
                      ),
                    ),
                  ),
                ),
                // Ikon peta & info kanan atas
                Positioned(
                  top: 10,
                  right: 10,
                  child: Row(
                    children: [
                      _buildRoundIcon(Icons.map_outlined),
                      const SizedBox(width: 8),
                      _buildRoundIcon(Icons.info_outline),
                      const SizedBox(width: 8),
                      _buildRoundIcon(Icons.arrow_forward_rounded),
                    ],
                  ),
                ),
              ],
            ),
          ),

          // Info dataset
          Padding(
            padding: const EdgeInsets.fromLTRB(14, 12, 14, 14),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Badge
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  decoration: BoxDecoration(
                    color: const Color(0xFFDCEBF7),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: const Text(
                    'Dataset Khusus',
                    style: TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.w600,
                      color: _primaryBlue,
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                // Judul
                Text(
                  layer.name,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w800,
                    color: _darkText,
                  ),
                ),
                const SizedBox(height: 3),
                const Text(
                  'admin',
                  style: TextStyle(fontSize: 13, color: _greyText),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRoundIcon(IconData icon) {
    return Container(
      width: 30,
      height: 30,
      decoration: const BoxDecoration(
        color: Colors.white,
        shape: BoxShape.circle,
      ),
      child: Icon(icon, size: 16, color: _primaryBlue),
    );
  }

  // ============================================================
  // BOTTOM NAVIGATION (Beranda / Layanan / Agenda)
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
                label: 'Beranda',
                active: false,
                onTap: () => Navigator.of(context)
                    .popUntil((route) => route.isFirst),
              ),
            ),
            Expanded(
              child: _buildNavItem(
                icon: Icons.grid_view_rounded,
                label: 'Layanan',
                active: true,
                onTap: () => Navigator.pop(context),
              ),
            ),
            Expanded(
              child: _buildNavItem(
                icon: Icons.calendar_month_outlined,
                label: 'Agenda',
                active: false,
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const AgendaScreen(),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNavItem({
    required IconData icon,
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
            color: active ? _lightBlue : Colors.transparent,
            borderRadius: BorderRadius.circular(27),
          ),
          child: Transform.translate(
            offset: const Offset(0, -1),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  icon,
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
class _MapLayer {
  final String name;
  const _MapLayer(this.name);
}
