import 'package:flutter/material.dart';

import '../../agenda/agenda_screen.dart';

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

  static const List<_CommodityItem> _items = [
    _CommodityItem(
      name: 'BERAS MEDIUM',
      price: 'Rp 13.500',
      unit: 'Kg',
      sourceY: 980,
    ),
    _CommodityItem(
      name: 'BERAS PREMIUM',
      price: 'Rp 16.000',
      unit: 'Kg',
      sourceY: 1780,
      change: '+ Rp 500',
      percentage: '↗ 0.68%',
      isIncreasing: true,
    ),
    _CommodityItem(
      name: 'BERAS SPHP',
      price: 'Rp 12.000',
      unit: 'Kg',
      sourceY: 2580,
    ),
    _CommodityItem(
      name: 'GULA PASIR CURAH',
      price: 'Rp 17.000',
      unit: 'Kg',
      sourceY: 3390,
    ),
    _CommodityItem(
      name: 'GULA PASIR KEMASAN',
      price: 'Rp 18.083',
      unit: 'Kg',
      sourceY: 4200,
    ),
    _CommodityItem(
      name: 'MINYAK GORENG CURAH',
      price: 'Rp 17.000',
      unit: 'Kg',
      sourceY: 5000,
    ),
    _CommodityItem(
      name: 'MINYAK KITA',
      price: 'Rp 16.000',
      unit: 'Ltr',
      sourceY: 5800,
    ),
    _CommodityItem(
      name: 'MINYAK GORENG PREMIUM',
      price: 'Rp 22.250',
      unit: 'Ltr',
      sourceY: 6590,
    ),
    _CommodityItem(
      name: 'MINYAK KITA',
      price: 'Rp 16.000',
      unit: 'Ltr',
      sourceY: 7390,
    ),
    _CommodityItem(
      name: 'SETARA SEGITIGA BIRU PROTEIN SEDANG',
      price: 'Rp 10.000',
      unit: 'Kg',
      sourceY: 8190,
    ),
  ];

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
        child: Column(
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
                    ..._items.map(_buildCommodityCard),
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
    return const Column(
      children: [
        Text(
          'Informasi Harga Pangan',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 26,
            fontWeight: FontWeight.w800,
            color: _darkText,
          ),
        ),
        SizedBox(height: 8),
        Text(
          'Sistem Informasi Ketersediaan dan Perkembangan\nHarga Bahan Pokok (SIKONDANG) Kabupaten\nSragen',
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 14, height: 1.45, color: _greyText),
        ),
        SizedBox(height: 15),
        Text(
          'Update Terakhir: Kamis, 6 Agustus 2026',
          style: TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w500,
            color: Color(0xFF008FCB),
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
          SizedBox(
            width: double.infinity,
            height: 52,
            child: ElevatedButton.icon(
              onPressed: () => _showMessage('Unduh perkembangan harga'),
              icon: const Icon(Icons.download_rounded, size: 22),
              label: const Text(
                'Unduh Perkembangan Harga',
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.w700),
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
          const SizedBox(height: 22),
          Align(
            alignment: Alignment.centerRight,
            child: OutlinedButton.icon(
              onPressed: () => _showMessage('Data diperbarui'),
              icon: const Icon(Icons.refresh_rounded, size: 18),
              label: const Text('Refresh Data'),
              style: OutlinedButton.styleFrom(
                foregroundColor: _greyText,
                backgroundColor: const Color(0xFFF0F2F4),
                side: BorderSide.none,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCommodityCard(_CommodityItem item) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: 20),
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
          SizedBox(
            height: 190,
            width: double.infinity,
            child: _ReferenceCommodityCrop(sourceY: item.sourceY),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 22, 20, 22),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item.name,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w800,
                    color: _darkText,
                  ),
                ),
                const SizedBox(height: 22),
                const Text(
                  'Harga Rata-rata',
                  style: TextStyle(fontSize: 13, color: _greyText),
                ),
                const SizedBox(height: 3),
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
                                fontSize: 22,
                                fontWeight: FontWeight.w800,
                                color: Color(0xFF0095CC),
                              ),
                            ),
                            TextSpan(
                              text: ' / ${item.unit}',
                              style: const TextStyle(
                                fontSize: 14,
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
                const SizedBox(height: 18),
                const Divider(color: Color(0xFFDDE2E7)),
                const SizedBox(height: 15),
                Row(
                  children: [
                    const Text(
                      'Perubahan',
                      style: TextStyle(fontSize: 14, color: _greyText),
                    ),
                    const Spacer(),
                    Text(
                      item.change,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                        color: item.isIncreasing
                            ? const Color(0xFFE9272D)
                            : const Color(0xFFE47700),
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

  Widget _buildStatusBadge(_CommodityItem item) {
    if (item.isIncreasing) {
      return Container(
        padding: const EdgeInsets.symmetric(horizontal: 13, vertical: 8),
        decoration: BoxDecoration(
          color: const Color(0xFFFFECEE),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Text(
          item.percentage,
          style: const TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w700,
            color: Color(0xFFE9272D),
          ),
        ),
      );
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 13, vertical: 8),
      decoration: BoxDecoration(
        color: const Color(0xFFFFF8E7),
        borderRadius: BorderRadius.circular(20),
      ),
      child: const Text(
        '— Stabil',
        style: TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w700,
          color: Color(0xFFE47700),
        ),
      ),
    );
  }

  Widget _buildPagination() {
    final int middlePage = _currentPage <= 2
        ? 2
        : (_currentPage >= 7 ? 6 : _currentPage);

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
          _pageButton(middlePage),
          const SizedBox(
            width: 20,
            child: Center(
              child: Text('...', style: TextStyle(color: _greyText)),
            ),
          ),
          _pageButton(7),
          const SizedBox(width: 5),
          Expanded(
            child: _paginationLabel(
              'Selanjutnya',
              enabled: _currentPage < 7,
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
    if (page < 1 || page > 7) return;
    setState(() => _currentPage = page);
    _scrollController.animateTo(
      0,
      duration: const Duration(milliseconds: 350),
      curve: Curves.easeOut,
    );
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
                onTap: () => Navigator.pop(context),
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
                      builder: (_) => const AgendaScreen(showBottomNav: false),
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

class _ReferenceCommodityCrop extends StatelessWidget {
  const _ReferenceCommodityCrop({required this.sourceY});

  static const double _sourceWidth = 860;
  static const double _sourceHeight = 9358;
  static const double _sourceX = 83;
  static const double _cropWidth = 734;

  final double sourceY;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final double scale = constraints.maxWidth / _cropWidth;
        return ClipRect(
          child: Stack(
            children: [
              Positioned(
                left: -_sourceX * scale,
                top: -sourceY * scale,
                width: _sourceWidth * scale,
                height: _sourceHeight * scale,
                child: Image.asset(
                  'context/perdagangan.png',
                  fit: BoxFit.fill,
                  filterQuality: FilterQuality.medium,
                  errorBuilder: (_, __, ___) => Container(
                    width: _sourceWidth * scale,
                    height: _sourceHeight * scale,
                    color: const Color(0xFFE8F1F8),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class _CommodityItem {
  const _CommodityItem({
    required this.name,
    required this.price,
    required this.unit,
    required this.sourceY,
    this.change = 'Rp 0',
    this.percentage = '',
    this.isIncreasing = false,
  });

  final String name;
  final String price;
  final String unit;
  final double sourceY;
  final String change;
  final String percentage;
  final bool isIncreasing;
}
