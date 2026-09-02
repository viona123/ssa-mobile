import 'package:flutter/material.dart';

import '../../agenda/agenda_screen.dart';
import '../../bantuan/bantuan_screen.dart';

class PerdaganganScreen extends StatefulWidget {
  const PerdaganganScreen({super.key});

  @override
  State<PerdaganganScreen> createState() => _PerdaganganScreenState();
}

class _PerdaganganScreenState extends State<PerdaganganScreen> {
  static const Color _primaryBlue = Color(0xFF007EA7);
  static const Color _lightBlue = Color(0xFF58D8EC);
  static const Color _darkBlue = Color(0xFF315579);
  static const Color _pageBackground = Color(0xFFF5F8FA);
  static const Color _darkText = Color(0xFF16191D);
  static const Color _greyText = Color(0xFF5F6368);
  static const Color _green = Color(0xFF087D53);

  // Jumlah item per halaman (slide).
  static const int _itemsPerPage = 10;

  final ScrollController _scrollController = ScrollController();
  String _selectedCommodity = 'Semua Komoditas';
  int _currentPage = 1;

  static const List<String> _commodities = [
    'Semua Komoditas',
    'Beras',
    'Gula',
    'Minyak Goreng',
    'Tepung Terigu',
  ];

  // Data lengkap komoditas (SIKONDANG Kabupaten Sragen).
  static const List<_CommodityItem> _items = [
    _CommodityItem(name: 'BERAS MEDIUM', price: 'Rp 13.500', unit: 'Kg'),
    _CommodityItem(name: 'BERAS PREMIUM', price: 'Rp 15.000', unit: 'Kg'),
    _CommodityItem(name: 'BERAS SPHP', price: 'Rp 12.000', unit: 'Kg'),
    _CommodityItem(name: 'GULA PASIR CURAH', price: 'Rp 17.500', unit: 'Kg'),
    _CommodityItem(name: 'GULA PASIR KEMASAN', price: 'Rp 18.083', unit: 'Kg'),
    _CommodityItem(
      name: 'MINYAK GORENG CURAH',
      price: 'Rp 19.567',
      unit: 'Ltr',
      change: '+Rp 100',
      percentage: '0.51%',
      trend: _Trend.up,
    ),
    _CommodityItem(name: 'MINYAK KITA', price: 'Rp 16.000', unit: 'Ltr'),
    _CommodityItem(
        name: 'MINYAK GORENG PREMIUM', price: 'Rp 22.250', unit: 'Ltr'),
    _CommodityItem(
      name: 'SETARA SEGITIGA BIRU PROTEIN SEDANG',
      price: 'Rp 10.000',
      unit: 'kg',
    ),
    _CommodityItem(
        name: 'TEPUNG TERIGU KEMASAN', price: 'Rp 12.000', unit: 'kg'),
    _CommodityItem(
      name: 'CABE MERAH KERITING',
      price: 'Rp 29.333',
      unit: 'Kg',
      change: '+Rp 1.333',
      percentage: '4.76%',
      trend: _Trend.up,
    ),
    _CommodityItem(name: 'CABE MERAH BESAR', price: 'Rp 29.333', unit: 'Kg'),
    _CommodityItem(
      name: 'CABE RAWIT MERAH',
      price: 'Rp 57.667',
      unit: 'Kg',
      change: '+Rp 1.667',
      percentage: '2.98%',
      trend: _Trend.up,
    ),
    _CommodityItem(
      name: 'CABE RAWIT HIJAU',
      price: 'Rp 46.000',
      unit: 'Kg',
      change: '+Rp 2.000',
      percentage: '4.55%',
      trend: _Trend.up,
    ),
    _CommodityItem(
        name: 'BAWANG MERAH UKURAN SEDANG', price: 'Rp 29.333', unit: 'Kg'),
    _CommodityItem(name: 'BAWANG PUTIH (HONAN)', price: 'Rp 31.000', unit: 'Kg'),
    _CommodityItem(
        name: 'BAWANG PUTIH (KATING)', price: 'Rp 37.000', unit: 'Kg'),
    _CommodityItem(name: 'DAGING AYAM RAS', price: 'Rp 41.333', unit: 'Kg'),
    _CommodityItem(
        name: 'DAGING AYAM KAMPUNG (PILIHAN)',
        price: 'Rp 70.000',
        unit: 'Ekor'),
    _CommodityItem(name: 'TELUR AYAM RAS', price: 'Rp 24.000', unit: 'Kg'),
    _CommodityItem(name: 'TELUR AYAM KAMPUNG', price: 'Rp 48.000', unit: 'Kg'),
    _CommodityItem(
        name: 'INDOMIE KUAH KARI AYAM', price: 'Rp 3.067', unit: 'Bungkus'),
    _CommodityItem(
        name: 'DAGING SAPI PAHA BELAKANG', price: 'Rp 136.667', unit: 'Kg'),
    _CommodityItem(
        name: 'DAGING SAPI PAHA DEPAN', price: 'Rp 136.667', unit: 'Kg'),
    _CommodityItem(
        name: 'DAGING SAPI SANDUNG LAMUR (BRISKET)',
        price: 'Rp 62.000',
        unit: 'Kg'),
    _CommodityItem(name: 'DAGING SAPI TETELAN', price: 'Rp 98.000', unit: 'Kg'),
    _CommodityItem(
        name: 'DAGING SAPI BEKU IMPOR', price: 'Rp 32.000', unit: 'Kg'),
    _CommodityItem(
        name: 'DAGING KERBAU BEKU IMPOR', price: 'Rp 32.000', unit: 'Kg'),
    _CommodityItem(name: 'KEDELAI LOKAL', price: 'Rp 32.000', unit: 'kg'),
    _CommodityItem(
      name: 'KEDELAI IMPOR',
      price: 'Rp 10.617',
      unit: 'kg',
      change: '+Rp 84',
      percentage: '0.80%',
      trend: _Trend.up,
    ),
    _CommodityItem(
        name: 'SUSU KENTAL MANIS', price: 'Rp 12.967', unit: '385gr'),
    _CommodityItem(name: 'SUSU BUBUK', price: 'Rp 52.950', unit: '400gr'),
    _CommodityItem(name: 'SUSU BALITA', price: 'Rp 53.600', unit: '400gr'),
    _CommodityItem(name: 'TEMPE', price: 'Rp 15.000', unit: 'Kg'),
    _CommodityItem(name: 'TAHU PUTIH', price: 'Rp 9.000', unit: 'Kg'),
    _CommodityItem(name: 'GARAM HALUS', price: 'Rp 15.000', unit: 'Kg'),
    _CommodityItem(name: 'IKAN KEMBUNG', price: 'Rp 50.000', unit: 'Kg'),
    _CommodityItem(name: 'IKAN BANDENG', price: 'Rp 45.000', unit: 'Kg'),
    _CommodityItem(name: 'IKAN TONGKOL', price: 'Rp 40.000', unit: 'Kg'),
    _CommodityItem(name: 'IKAN TERI', price: 'Rp 40.000', unit: 'Kg'),
    _CommodityItem(
        name: 'UDANG BASAH SEDANG', price: 'Rp 100.000', unit: 'Kg'),
    _CommodityItem(name: 'JAGUNG PIPILAN', price: 'Rp 6.483', unit: 'Kg'),
    _CommodityItem(name: 'BAWANG BOMBAY', price: 'Rp 28.000', unit: 'Kg'),
    _CommodityItem(name: 'JERUK BUAH', price: 'Rp 20.000', unit: 'Kg'),
    _CommodityItem(name: 'PISANG', price: 'Rp 11.000', unit: 'Kg'),
    _CommodityItem(name: 'KACANG TANAH', price: 'Rp 42.000', unit: 'Kg'),
    _CommodityItem(name: 'KACANG HIJAU', price: 'Rp 26.000', unit: 'Kg'),
    _CommodityItem(name: 'KETELA POHON', price: 'Rp 4.500', unit: 'Kg'),
    _CommodityItem(name: 'SAWI HIJAU', price: 'Rp 5.000', unit: 'Kg'),
    _CommodityItem(
      name: 'TOMAT',
      price: 'Rp 5.000',
      unit: 'Kg',
      change: '-Rp 1.000',
      percentage: '16.67%',
      trend: _Trend.down,
    ),
    _CommodityItem(name: 'KENTANG', price: 'Rp 17.000', unit: 'Kg'),
    _CommodityItem(
      name: 'KANGKUNG',
      price: 'Rp 5.000',
      unit: 'Kg',
      change: '-Rp 1.000',
      percentage: '16.67%',
      trend: _Trend.down,
    ),
    _CommodityItem(name: 'KACANG PANJANG', price: 'Rp 11.000', unit: 'Kg'),
    _CommodityItem(name: 'KETIMUN', price: 'Rp 8.000', unit: 'Kg'),
    _CommodityItem(name: 'GKP', price: 'Rp 8.300', unit: 'Kg'),
    _CommodityItem(name: 'GKG', price: 'Rp 9.350', unit: 'Kg'),
  ];

  int get _totalPages => (_items.length / _itemsPerPage).ceil();

  List<_CommodityItem> get _currentPageItems {
    final int start = (_currentPage - 1) * _itemsPerPage;
    final int end = (start + _itemsPerPage) > _items.length
        ? _items.length
        : (start + _itemsPerPage);
    return _items.sublist(start, end);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

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
                _buildHeader(),
                Expanded(
                  child: SingleChildScrollView(
                    controller: _scrollController,
                    physics: const BouncingScrollPhysics(),
                    padding: const EdgeInsets.fromLTRB(24, 24, 24, 32),
                    child: Column(
                      children: [
                        _buildIntroduction(),
                        const SizedBox(height: 26),
                        _buildFilterPanel(),
                        const SizedBox(height: 24),
                        ..._currentPageItems.map(_buildCommodityCard),
                        const SizedBox(height: 8),
                        _buildPagination(),
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

  Widget _buildHeader() {
    return Container(
      width: double.infinity,
      height: 66,
      padding: const EdgeInsets.symmetric(horizontal: 24),
      decoration: const BoxDecoration(
        color: _pageBackground,
        border: Border(
          bottom: BorderSide(color: Color(0xFFE5E7EB), width: 0.7),
        ),
      ),
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
            'Layanan Perdagangan',
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

  Widget _buildIntroduction() {
    return Column(
      children: [
        // Badge ikon di atas judul
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 7),
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: [Color(0xFF00A6C9), Color(0xFF007EA7)],
            ),
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: _primaryBlue.withValues(alpha: 0.25),
                blurRadius: 8,
                offset: const Offset(0, 3),
              ),
            ],
          ),
          child: const Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.storefront_rounded, size: 15, color: Colors.white),
              SizedBox(width: 6),
              Text(
                'SIKONDANG SRAGEN',
                style: TextStyle(
                  fontSize: 10.5,
                  fontWeight: FontWeight.w800,
                  color: Colors.white,
                  letterSpacing: 0.8,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 14),
        // Judul dengan gradient
        ShaderMask(
          shaderCallback: (bounds) => const LinearGradient(
            colors: [Color(0xFF007EA7), Color(0xFF00B4D8), Color(0xFF58D8EC)],
          ).createShader(bounds),
          child: const Text(
            'Informasi Harga Pangan',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 25,
              fontWeight: FontWeight.w900,
              color: Colors.white,
              height: 1.15,
            ),
          ),
        ),
        const SizedBox(height: 8),
        Text(
          'Sistem Informasi Ketersediaan dan Perkembangan Harga '
          'Bahan Pokok (SIKONDANG) Kabupaten Sragen',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 13,
            height: 1.5,
            color: _greyText.withValues(alpha: 0.95),
          ),
        ),
        const SizedBox(height: 14),
        // Pil "Update Terakhir"
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
          decoration: BoxDecoration(
            color: const Color(0xFF008FCB).withValues(alpha: 0.10),
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: const Color(0xFF008FCB).withValues(alpha: 0.22),
            ),
          ),
          child: const Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.schedule_rounded, size: 14, color: Color(0xFF008FCB)),
              SizedBox(width: 6),
              Text(
                'Update Terakhir: Kamis, 6 Agustus 2026',
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w700,
                  color: Color(0xFF008FCB),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildFilterPanel() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 14,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        children: [
          Container(
            height: 52,
            padding: const EdgeInsets.symmetric(horizontal: 14),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: const Color(0xFFD6DCE2)),
            ),
            child: Row(
              children: [
                const Icon(Icons.filter_alt_outlined, color: _greyText),
                const SizedBox(width: 12),
                Expanded(
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton<String>(
                      value: _selectedCommodity,
                      isExpanded: true,
                      icon: const Icon(Icons.keyboard_arrow_down_rounded),
                      style: const TextStyle(fontSize: 15, color: _darkText),
                      items: _commodities
                          .map(
                            (commodity) => DropdownMenuItem(
                              value: commodity,
                              child: Text(commodity),
                            ),
                          )
                          .toList(),
                      onChanged: (value) {
                        if (value != null) {
                          setState(() => _selectedCommodity = value);
                        }
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              // Unduh Perkembangan Harga (utama)
              Expanded(
                child: SizedBox(
                  height: 52,
                  child: ElevatedButton.icon(
                    onPressed: () => _showMessage('Unduh perkembangan harga'),
                    icon: const Icon(Icons.download_rounded, size: 20),
                    label: const Text(
                      'Unduh Harga',
                      style:
                          TextStyle(fontSize: 14, fontWeight: FontWeight.w700),
                    ),
                    style: ElevatedButton.styleFrom(
                      elevation: 0,
                      backgroundColor: _green,
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              // Refresh Data — ikon saja
              SizedBox(
                width: 52,
                height: 52,
                child: IconButton(
                  onPressed: () => _showMessage('Data diperbarui'),
                  tooltip: 'Refresh data',
                  icon: const Icon(Icons.refresh_rounded, size: 22),
                  style: IconButton.styleFrom(
                    foregroundColor: _greyText,
                    backgroundColor: const Color(0xFFF0F2F4),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildCommodityCard(_CommodityItem item) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: 16),
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.045),
            blurRadius: 12,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _CommodityThumbnail(name: item.name),
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 14, 16, 14),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item.name,
                  style: const TextStyle(
                    fontSize: 14.5,
                    fontWeight: FontWeight.w800,
                    color: _darkText,
                  ),
                ),
                const SizedBox(height: 12),
                const Text(
                  'Harga Rata-rata',
                  style: TextStyle(fontSize: 12, color: _greyText),
                ),
                const SizedBox(height: 2),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Expanded(
                      child: RichText(
                        text: TextSpan(
                          children: [
                            TextSpan(
                              text: item.price,
                              style: const TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w800,
                                color: Color(0xFF0095CC),
                              ),
                            ),
                            TextSpan(
                              text: ' / ${item.unit}',
                              style: const TextStyle(
                                fontSize: 13,
                                color: _greyText,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    _buildStatusBadge(item),
                  ],
                ),
                const SizedBox(height: 12),
                const Divider(color: Color(0xFFDDE2E7), height: 1),
                const SizedBox(height: 10),
                Row(
                  children: [
                    const Text(
                      'Perubahan',
                      style: TextStyle(fontSize: 13, color: _greyText),
                    ),
                    const Spacer(),
                    Text(
                      item.change,
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w700,
                        color: _changeColor(item.trend),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Color _changeColor(_Trend trend) {
    switch (trend) {
      case _Trend.up:
        return const Color(0xFFE9272D);
      case _Trend.down:
        return const Color(0xFF087D53);
      case _Trend.stable:
        return _greyText;
    }
  }

  Widget _buildStatusBadge(_CommodityItem item) {
    switch (item.trend) {
      case _Trend.up:
        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 13, vertical: 8),
          decoration: BoxDecoration(
            color: const Color(0xFFFFECEE),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Text(
            '\u2197 ${item.percentage}',
            style: const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w700,
              color: Color(0xFFE9272D),
            ),
          ),
        );
      case _Trend.down:
        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 13, vertical: 8),
          decoration: BoxDecoration(
            color: const Color(0xFFE7F6EF),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Text(
            '\u2198 ${item.percentage}',
            style: const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w700,
              color: Color(0xFF087D53),
            ),
          ),
        );
      case _Trend.stable:
        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 13, vertical: 8),
          decoration: BoxDecoration(
            color: const Color(0xFFFFF8E7),
            borderRadius: BorderRadius.circular(20),
          ),
          child: const Text(
            '\u2014 Stabil',
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w700,
              color: Color(0xFFE47700),
            ),
          ),
        );
    }
  }

  Widget _buildPagination() {
    final int totalPages = _totalPages;
    final int middlePage = _currentPage <= 2
        ? 2
        : (_currentPage >= (totalPages - 1) ? (totalPages - 1) : _currentPage);
    final bool showMiddle = totalPages > 2;
    final bool showEllipsis = totalPages > 3;

    return SizedBox(
      width: double.infinity,
      child: Row(
        children: [
          Expanded(
            child: _paginationLabel(
              'Sebelumnya',
              enabled: _currentPage > 1,
              onTap: () => _changePage(_currentPage - 1),
            ),
          ),
          const SizedBox(width: 5),
          _pageButton(1),
          if (showMiddle && middlePage != 1 && middlePage != totalPages)
            _pageButton(middlePage),
          if (showEllipsis)
            const SizedBox(
              width: 20,
              child: Center(
                child: Text('...', style: TextStyle(color: _greyText)),
              ),
            ),
          if (totalPages > 1) _pageButton(totalPages),
          const SizedBox(width: 5),
          Expanded(
            child: _paginationLabel(
              'Selanjutnya',
              enabled: _currentPage < totalPages,
              onTap: () => _changePage(_currentPage + 1),
            ),
          ),
        ],
      ),
    );
  }

  Widget _paginationLabel(
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
              color: enabled ? _darkText : _greyText,
            ),
          ),
        ),
      ),
    );
  }

  Widget _pageButton(int page) {
    final bool selected = _currentPage == page;
    return GestureDetector(
      onTap: () => _changePage(page),
      child: Container(
        width: 38,
        height: 40,
        margin: const EdgeInsets.symmetric(horizontal: 2),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: selected ? _primaryBlue : Colors.white,
          borderRadius: BorderRadius.circular(9),
          border: Border.all(
            color: selected ? _primaryBlue : const Color(0xFFE0E5EA),
          ),
        ),
        child: Text(
          '$page',
          style: TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w600,
            color: selected ? Colors.white : _darkText,
          ),
        ),
      ),
    );
  }

  void _changePage(int page) {
    if (page < 1 || page > _totalPages) return;
    setState(() => _currentPage = page);
    if (_scrollController.hasClients) {
      _scrollController.animateTo(
        0,
        duration: const Duration(milliseconds: 1500),
        curve: Curves.easeInOut,
      );
    }
  }

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
                onTap: () =>
                    Navigator.popUntil(context, (route) => route.isFirst),
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
                onTap: () {
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
        child: Container(
          width: 95,
          height: 52,
          decoration: BoxDecoration(
            color: active ? _lightBlue : Colors.transparent,
            borderRadius: BorderRadius.circular(27),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                active ? activeIcon : icon,
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
    );
  }

  void _showMessage(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        behavior: SnackBarBehavior.floating,
        duration: const Duration(seconds: 2),
      ),
    );
  }
}

/// Thumbnail komoditas berupa banner gradasi dengan ikon kategori,
/// menggantikan crop gambar referensi agar setiap item punya visual sendiri.
class _CommodityThumbnail extends StatelessWidget {
  const _CommodityThumbnail({required this.name});

  final String name;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 185,
      width: double.infinity,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: _gradientFor(name),
        ),
      ),
      child: Stack(
        clipBehavior: Clip.hardEdge,
        children: [
          // Ornamen lingkaran dekoratif
          Positioned(
            right: -24,
            top: -30,
            child: Container(
              width: 120,
              height: 120,
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.08),
                shape: BoxShape.circle,
              ),
            ),
          ),
          Positioned(
            left: -20,
            bottom: -34,
            child: Container(
              width: 90,
              height: 90,
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.07),
                shape: BoxShape.circle,
              ),
            ),
          ),
          Center(
            child: Icon(
              _iconFor(name),
              size: 74,
              color: Colors.white.withValues(alpha: 0.95),
            ),
          ),
        ],
      ),
    );
  }

  List<Color> _gradientFor(String name) {
    final IconData icon = _iconFor(name);
    if (icon == Icons.local_fire_department_rounded) {
      return const [Color(0xFFF97316), Color(0xFFEA580C)];
    }
    if (icon == Icons.set_meal_rounded) {
      return const [Color(0xFF0EA5E9), Color(0xFF0369A1)];
    }
    if (icon == Icons.egg_rounded) {
      return const [Color(0xFFF59E0B), Color(0xFFD97706)];
    }
    if (icon == Icons.eco_rounded) {
      return const [Color(0xFF22C55E), Color(0xFF16A34A)];
    }
    if (icon == Icons.rice_bowl_rounded) {
      return const [Color(0xFF14B8A6), Color(0xFF0D9488)];
    }
    return const [Color(0xFF38BDF8), Color(0xFF0284C7)];
  }

  IconData _iconFor(String name) {
    final String n = name.toUpperCase();
    if (n.contains('CABE')) return Icons.local_fire_department_rounded;
    if (n.contains('IKAN') ||
        n.contains('UDANG') ||
        n.contains('DAGING') ||
        n.contains('AYAM') ||
        n.contains('KERBAU') ||
        n.contains('SAPI')) {
      return Icons.set_meal_rounded;
    }
    if (n.contains('TELUR')) return Icons.egg_rounded;
    if (n.contains('BERAS') ||
        n.contains('GKP') ||
        n.contains('GKG') ||
        n.contains('JAGUNG') ||
        n.contains('KEDELAI') ||
        n.contains('TEPUNG')) {
      return Icons.rice_bowl_rounded;
    }
    if (n.contains('CABE') ||
        n.contains('BAWANG') ||
        n.contains('TOMAT') ||
        n.contains('SAWI') ||
        n.contains('KANGKUNG') ||
        n.contains('KACANG') ||
        n.contains('KETIMUN') ||
        n.contains('KENTANG') ||
        n.contains('KETELA') ||
        n.contains('JERUK') ||
        n.contains('PISANG') ||
        n.contains('TEMPE') ||
        n.contains('TAHU')) {
      return Icons.eco_rounded;
    }
    return Icons.shopping_basket_rounded;
  }
}

enum _Trend { stable, up, down }

class _CommodityItem {
  const _CommodityItem({
    required this.name,
    required this.price,
    required this.unit,
    this.change = 'Rp 0',
    this.percentage = '',
    this.trend = _Trend.stable,
  });

  final String name;
  final String price;
  final String unit;
  final String change;
  final String percentage;
  final _Trend trend;
}
