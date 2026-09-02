import 'package:flutter/material.dart';

import '../agenda/agenda_screen.dart';
import 'service_catalog.dart';

class LayananScreen extends StatefulWidget {
  final bool showBottomNav;
  final bool showAllServices;

  const LayananScreen({
    super.key,
    this.showBottomNav = true,
    this.showAllServices = false,
  });

  @override
  State<LayananScreen> createState() => _LayananScreenState();
}

class _LayananScreenState extends State<LayananScreen> {
  // ============================================================
  // COLORS
  // ============================================================
  static const Color _primaryBlue = Color(0xFF007EA7);
  static const Color _lightBlue = Color(0xFF58D8EC);
  static const Color _darkBlue = Color(0xFF315579);
  static const Color _pageBackground = Color(0xFFF8FAFC);
  static const Color _darkText = Color(0xFF202124);
  static const Color _greyText = Color(0xFF737B86);

  // ============================================================
  // STATE — Set berisi index kategori yang sedang terbuka
  // Bisa buka lebih dari satu sekaligus
  // ============================================================
  final Set<int> _expandedIndices = {};

  // ============================================================
  // DATA KATEGORI — dari katalog bersama (service_catalog.dart)
  // ============================================================
  final List<ServiceCategory> _categories = ServiceCatalog.categories;


  // ============================================================
  // BUILD
  // ============================================================
  @override
  Widget build(BuildContext context) {
    if (widget.showAllServices) {
      return _buildAllServicesSheet();
    }

    final content = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildHeader(),
        Expanded(
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            padding: const EdgeInsets.fromLTRB(20, 14, 20, 32),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Kategori header
                Row(
                  children: [
                    const Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Kategori',
                            style: TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.w700,
                              color: _darkText,
                            ),
                          ),
                          SizedBox(height: 4),
                          Text(
                            'Pilih kelompok layanan.',
                            style: TextStyle(fontSize: 13, color: _greyText),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 5,
                      ),
                      decoration: BoxDecoration(
                        color: const Color(0xFFEAF7FC),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        '${_categories.length} Kategori',
                        style: const TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.w600,
                          color: _primaryBlue,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),

                // Daftar kategori
                ..._buildCategoryList(),
              ],
            ),
          ),
        ),
      ],
    );

    if (!widget.showBottomNav) {
      return SafeArea(child: content);
    }

    return Scaffold(
      backgroundColor: _pageBackground,
      bottomNavigationBar: _buildBottomNavigation(),
      body: SafeArea(child: content),
    );
  }

  // ============================================================
  // SEMUA LAYANAN — MODE FLAT UNTUK BOTTOM SHEET HOME
  // ============================================================
  Widget _buildAllServicesSheet() {
    final allServices = _categories
        .expand((category) => category.services)
        .toList(growable: false);

    return Material(
      color: Colors.white,
      child: SafeArea(
        top: false,
        child: Column(
          children: [
            const SizedBox(height: 10),
            Container(
              width: 42,
              height: 4,
              decoration: BoxDecoration(
                color: const Color(0xFFDDE2E8),
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 14, 10, 12),
              child: Row(
                children: [
                  const Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Semua Layanan',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w700,
                            color: _darkText,
                          ),
                        ),
                        SizedBox(height: 3),
                        Text(
                          'Pilih layanan yang ingin dibuka.',
                          style: TextStyle(fontSize: 11, color: _greyText),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 9,
                      vertical: 5,
                    ),
                    decoration: BoxDecoration(
                      color: const Color(0xFFEAF7FC),
                      borderRadius: BorderRadius.circular(11),
                    ),
                    child: Text(
                      '${allServices.length} layanan',
                      style: const TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.w600,
                        color: _primaryBlue,
                      ),
                    ),
                  ),
                  IconButton(
                    tooltip: 'Tutup',
                    onPressed: () => Navigator.pop(context),
                    icon: const Icon(Icons.close_rounded, color: _greyText),
                  ),
                ],
              ),
            ),
            const Divider(height: 1, color: Color(0xFFE8EDF2)),
            Expanded(
              child: GridView.builder(
                physics: const BouncingScrollPhysics(),
                padding: const EdgeInsets.fromLTRB(20, 16, 20, 24),
                itemCount: allServices.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 4,
                  crossAxisSpacing: 11,
                  mainAxisSpacing: 14,
                  mainAxisExtent: 102,
                ),
                itemBuilder: (context, index) {
                  return _buildCompactServiceItem(allServices[index]);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCompactServiceItem(ServiceItem service) {
    return GestureDetector(
      onTap: () => _onServiceTap(service),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 60,
            height: 60,
            decoration: BoxDecoration(
              color: const Color(0xFFE5E9EE),
              borderRadius: BorderRadius.circular(13),
            ),
            child: Icon(service.icon, size: 27, color: _darkBlue),
          ),
          const SizedBox(height: 5),
          SizedBox(
            height: 32,
            child: Text(
              // Pecah kata panjang tertentu agar terbagi 2 baris dengan rapi,
              // bukan "Kegawatdarurat" lalu "an" sendirian di bawah.
              service.title == 'Kegawatdaruratan'
                  ? 'Kegawat\ndaruratan'
                  : service.title,
              textAlign: TextAlign.center,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                fontSize: 9,
                height: 1.1,
                color: _darkText,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
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
        border: Border(bottom: BorderSide(color: Color(0xFFE0E0E0), width: 1)),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: const Row(
        children: [
          Text(
            'Layanan Digital',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w700,
              color: _primaryBlue,
            ),
          ),
        ],
      ),
    );
  }

  // ============================================================
  // CATEGORY LIST
  // ============================================================
  List<Widget> _buildCategoryList() {
    final List<Widget> widgets = [];

    for (int i = 0; i < _categories.length; i++) {
      final category = _categories[i];
      final isExpanded = _expandedIndices.contains(i);

      widgets.add(_buildCategoryCard(category, i, isExpanded));
      widgets.add(const SizedBox(height: 10));
    }

    return widgets;
  }

  // ============================================================
  // CATEGORY CARD — satu card, tap = toggle expand
  // Bisa buka banyak kategori sekaligus
  // ============================================================
  Widget _buildCategoryCard(
    ServiceCategory category,
    int index,
    bool isExpanded,
  ) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 250),
      curve: Curves.easeInOut,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(
          color: isExpanded
              ? _primaryBlue.withValues(alpha: 0.25)
              : const Color(0xFFE8EDF2),
          width: isExpanded ? 1.5 : 1,
        ),
        boxShadow: isExpanded
            ? [
                BoxShadow(
                  color: _primaryBlue.withValues(alpha: 0.06),
                  blurRadius: 12,
                  offset: const Offset(0, 4),
                ),
              ]
            : [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.03),
                  blurRadius: 4,
                  offset: const Offset(0, 2),
                ),
              ],
      ),
      child: Column(
        children: [
          // ===== HEADER KATEGORI (hanya bagian ini yang toggle expand) =====
          GestureDetector(
            onTap: () {
              setState(() {
                if (isExpanded) {
                  _expandedIndices.remove(index);
                } else {
                  _expandedIndices.add(index);
                }
              });
            },
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                children: [
                  // Icon
                  Container(
                    width: 46,
                    height: 46,
                    decoration: BoxDecoration(
                      color: category.iconBackground,
                      borderRadius: BorderRadius.circular(13),
                    ),
                    child: Icon(
                      category.icon,
                      size: 22,
                      color: category.iconColor,
                    ),
                  ),
                  const SizedBox(width: 14),
                  // Teks
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          category.title,
                          style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w700,
                            color: _darkText,
                          ),
                        ),
                        const SizedBox(height: 3),
                        Text(
                          category.subtitle,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            fontSize: 11,
                            color: _greyText,
                          ),
                        ),
                      ],
                    ),
                  ),
                  // Arrow
                  AnimatedRotation(
                    turns: isExpanded ? 0.5 : 0,
                    duration: const Duration(milliseconds: 250),
                    child: Container(
                      width: 30,
                      height: 30,
                      decoration: BoxDecoration(
                        color: isExpanded
                            ? _primaryBlue.withValues(alpha: 0.1)
                            : const Color(0xFFF0F2F5),
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        Icons.keyboard_arrow_down_rounded,
                        size: 20,
                        color: isExpanded ? _primaryBlue : _greyText,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          // ===== EXPANDED SUB-ITEMS =====
          if (isExpanded) ...[
            // Sub-items dalam card terpisah dengan garis kiri
            Padding(
              padding: const EdgeInsets.fromLTRB(28, 4, 16, 14),
              child: Column(
                children: category.services.map((service) {
                  return _buildServiceItem(service);
                }).toList(),
              ),
            ),
          ],
        ],
      ),
    );
  }

  // ============================================================
  // SERVICE ITEM — card terpisah dengan garis kiri abu-abu
  // seperti design kategori3.png, seluruh card bisa di-tap
  // ============================================================
  Widget _buildServiceItem(ServiceItem service) {
    return GestureDetector(
      onTap: () => _onServiceTap(service),
      child: Container(
        margin: const EdgeInsets.only(bottom: 10),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: const Color(0xFFE8EDF2)),
        ),
        child: IntrinsicHeight(
          child: Row(
            children: [
              // Garis vertikal kiri abu-abu muda
              Container(
                width: 3.5,
                decoration: const BoxDecoration(
                  color: Color(0xFFDDE2E8),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(14),
                    bottomLeft: Radius.circular(14),
                  ),
                ),
              ),
              // Content
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 14,
                    vertical: 14,
                  ),
                  child: Row(
                    children: [
                      // Icon rounded berwarna
                      Container(
                        width: 44,
                        height: 44,
                        decoration: BoxDecoration(
                          color: service.iconBackground.withValues(alpha: 0.12),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Icon(
                          service.icon,
                          size: 20,
                          color: service.iconBackground,
                        ),
                      ),
                      const SizedBox(width: 14),
                      // Teks
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              service.title,
                              style: const TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w700,
                                color: _darkText,
                              ),
                            ),
                            const SizedBox(height: 2),
                            Text(
                              service.subtitle,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                fontSize: 11,
                                color: _greyText,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 8),
                      // Tombol Buka + icon (visual saja, tap seluruh card)
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Text(
                            'Buka',
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                              color: _primaryBlue,
                            ),
                          ),
                          const SizedBox(width: 4),
                          Container(
                            width: 26,
                            height: 26,
                            decoration: BoxDecoration(
                              color: _primaryBlue.withValues(alpha: 0.08),
                              borderRadius: BorderRadius.circular(7),
                            ),
                            child: const Icon(
                              Icons.open_in_new_rounded,
                              size: 14,
                              color: _primaryBlue,
                            ),
                          ),
                        ],
                      ),
                    ],
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
  // SERVICE TAP HANDLER — delegasi ke katalog bersama
  // ============================================================
  void _onServiceTap(ServiceItem service) {
    ServiceCatalog.openService(
      context,
      service,
      fromSheet: widget.showAllServices,
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
      ),
    );
  }
}
