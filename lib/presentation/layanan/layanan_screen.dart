import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../agenda/agenda_screen.dart';
import 'geospasial/geospasial_screen.dart';
import 'inovasi/inovasi_screen.dart';
import 'kegawatdaruratan/kegawatdaruratan_screen.dart';
import 'poli_rsud/poli_rsud_screen.dart';
import 'puskesmas/puskesmas_screen.dart';
import 'ketenagakerjaan/ketenagakerjaan_screen.dart';
import 'sewa_gedung/sewa_gedung_screen.dart';
import 'kemiskinan/kemiskinan_screen.dart';
import 'keuangan/keuangan_screen.dart';
import 'perdagangan/perdagangan_screen.dart';
import 'pajak/pajak_screen.dart';
import 'bus_sekolah/bus_sekolah_screen.dart';
import 'pariwisata/pariwisata_screen.dart';
import 'pengaduan/pengaduan_screen.dart';
import 'pendidikan/pendidikan_screen.dart';
import 'layanan_mpp/layanan_mpp_screen.dart';

class LayananScreen extends StatefulWidget {
  final bool showBottomNav;

  const LayananScreen({super.key, this.showBottomNav = true});

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
  // DATA KATEGORI
  // ============================================================
  final List<ServiceCategory> _categories = [
    ServiceCategory(
      title: 'DPMPTSP Kabupaten Sragen',
      subtitle: 'Portal utama, perizinan, pengaduan, SKM...',
      icon: Icons.account_balance_rounded,
      iconColor: const Color(0xFF315579),
      iconBackground: const Color(0xFFE8F0F7),
      services: [
        ServiceItem(
          title: 'Website DPMPTSP',
          subtitle: 'DPMPTSP Kabupaten Sragen',
          icon: Icons.language_rounded,
          iconBackground: Color(0xFF315579),
          url: 'https://dpmptsp.sragenkab.go.id/portal/',
        ),
        ServiceItem(
          title: 'SIPONER',
          subtitle: 'Sistem Perizinan Online Sragen',
          icon: Icons.gavel_rounded,
          iconBackground: Color(0xFF1779B8),
          url: 'https://sipioner.sragenkab.go.id/index',
        ),
        ServiceItem(
          title: 'SKM Online',
          subtitle: 'Survei Kepuasan Masyarakat',
          icon: Icons.rate_review_rounded,
          iconBackground: Color(0xFF2E9E6B),
          url: 'https://dpmptsp.sragenkab.go.id/skm',
        ),
        ServiceItem(
          title: 'SIAP',
          subtitle: 'Sistem Informasi Administrasi Perizinan',
          icon: Icons.assignment_rounded,
          iconBackground: Color(0xFFA26B16),
          url: 'https://dpmptsp.sragenkab.go.id/pengaduan',
        ),
        ServiceItem(
          title: 'SIPELANGI',
          subtitle: 'Sistem Pelayanan Langsung Jadi',
          icon: Icons.flash_on_rounded,
          iconBackground: Color(0xFF7B2D8B),
          url: 'https://sipelangi.sragenkab.go.id/',
        ),
        ServiceItem(
          title: 'PASTIOL',
          subtitle: 'Pelayanan Administrasi Satu Pintu Online',
          icon: Icons.verified_rounded,
          iconBackground: Color(0xFF278CA9),
          url: 'https://pastiol.sragenkab.go.id/beranda',
        ),
      ],
    ),
    ServiceCategory(
      title: 'Mal Pelayanan Publik',
      subtitle: 'Website MPP dan antrean online',
      icon: Icons.business_rounded,
      iconColor: const Color(0xFF315579),
      iconBackground: const Color(0xFFE8F0F7),
      services: [
        ServiceItem(
          title: 'Website MPP',
          subtitle: 'Mal Pelayanan Publik Sragen',
          icon: Icons.web_rounded,
          iconBackground: Color(0xFF315579),
          url: 'https://mpp.sragenkab.go.id/web/',
        ),
        ServiceItem(
          title: 'Antrean Online',
          subtitle: 'Ambil nomor antrean online',
          icon: Icons.event_available_rounded,
          iconBackground: Color(0xFF1779B8),
          url: 'https://mpp.sragenkab.go.id/antrian/',
        ),
      ],
    ),
    ServiceCategory(
      title: 'Kesehatan & Keselamatan',
      subtitle: 'Layanan darurat medis dan informasi kes...',
      icon: Icons.local_hospital_rounded,
      iconColor: const Color(0xFFD92D2D),
      iconBackground: const Color(0xFFFDE8E8),
      services: [
        ServiceItem(
          title: 'Kegawatdaruratan',
          subtitle: 'Layanan Darurat Kabupaten Sragen',
          icon: Icons.emergency_rounded,
          iconBackground: Color(0xFFD92D2D),
          url: '',
        ),
        ServiceItem(
          title: 'Layanan Poli RSUD',
          subtitle: 'RSUD Kabupaten Sragen',
          icon: Icons.medical_services_rounded,
          iconBackground: Color(0xFF2E9E6B),
          url: '',
        ),
        ServiceItem(
          title: 'Layanan Puskesmas',
          subtitle: 'Dinas Kesehatan Kabupaten Sragen',
          icon: Icons.add_box_rounded,
          iconBackground: Color(0xFF1B8A5A),
          url: '',
        ),
      ],
    ),
    ServiceCategory(
      title: 'Kependudukan & Sosial',
      subtitle: 'Layanan administrasi kependudukan dan ...',
      icon: Icons.people_rounded,
      iconColor: const Color(0xFFA26B16),
      iconBackground: const Color(0xFFFFF3E0),
      services: [
        ServiceItem(
          title: 'Layanan Kependudukan',
          subtitle: 'Disdukcapil Kabupaten Sragen',
          icon: Icons.badge_rounded,
          iconBackground: Color(0xFFA26B16),
          url: 'https://pandu-online.sragenkab.go.id/signin.html',
        ),
        ServiceItem(
          title: 'Data Kemiskinan',
          subtitle: 'Dinas Sosial Kabupaten Sragen',
          icon: Icons.insert_chart_rounded,
          iconBackground: Color(0xFF315579),
          url: '',
        ),
      ],
    ),
    ServiceCategory(
      title: 'Ekonomi, Keuangan & Pajak',
      subtitle: 'Pajak daerah, harga pasar, dan keuangan',
      icon: Icons.account_balance_wallet_rounded,
      iconColor: const Color(0xFF2E9E6B),
      iconBackground: const Color(0xFFE6F7EF),
      services: [
        ServiceItem(
          title: 'Keuangan',
          subtitle: 'BPKAD Kabupaten Sragen',
          icon: Icons.payments_rounded,
          iconBackground: Color(0xFF2E9E6B),
          url: '',
        ),
        ServiceItem(
          title: 'Perdagangan',
          subtitle: 'Dinas Perdagangan Kabupaten Sragen',
          icon: Icons.storefront_rounded,
          iconBackground: Color(0xFFA26B16),
          url: '',
        ),
        ServiceItem(
          title: 'Pajak',
          subtitle: 'Bapenda Kabupaten Sragen',
          icon: Icons.receipt_long_rounded,
          iconBackground: Color(0xFF315579),
          url: '',
        ),
        ServiceItem(
          title: 'Layanan Ketenagakerjaan',
          subtitle: 'Disnaker Kabupaten Sragen',
          icon: Icons.work_rounded,
          iconBackground: Color(0xFF007EA7),
          url: '',
        ),
      ],
    ),
    ServiceCategory(
      title: 'Pendidikan & Transportasi',
      subtitle: 'Layanan operasional bus sekolah dan pen...',
      icon: Icons.school_rounded,
      iconColor: const Color(0xFF1779B8),
      iconBackground: const Color(0xFFE3F2FD),
      services: [
        ServiceItem(
          title: 'Bus Sekolah',
          subtitle: 'Dinas Perhubungan Kabupaten Sragen',
          icon: Icons.directions_bus_rounded,
          iconBackground: Color(0xFF1779B8),
          url: '',
        ),
      ],
    ),
    ServiceCategory(
      title: 'Pariwisata & Budaya',
      subtitle: 'Destinasi wisata, agenda budaya, dan eko...',
      icon: Icons.explore_rounded,
      iconColor: const Color(0xFF7B2D8B),
      iconBackground: const Color(0xFFF3E5F5),
      services: [
        ServiceItem(
          title: 'Pariwisata',
          subtitle: 'Disporapar Kabupaten Sragen',
          icon: Icons.terrain_rounded,
          iconBackground: Color(0xFF7B2D8B),
          url: '',
        ),
      ],
    ),
    ServiceCategory(
      title: 'Tata Kelola & Inovasi',
      subtitle: 'Inovasi daerah, portal geospatial, dan kan...',
      icon: Icons.hub_rounded,
      iconColor: const Color(0xFFA26B16),
      iconBackground: const Color(0xFFFFF8E1),
      services: [
        ServiceItem(
          title: 'Inovasi',
          subtitle: 'Bapperida Kabupaten Sragen',
          icon: Icons.lightbulb_rounded,
          iconBackground: Color(0xFFA26B16),
          url: '',
        ),
        ServiceItem(
          title: 'Pengaduan',
          subtitle: 'Pemerintah Kabupaten Sragen',
          icon: Icons.campaign_rounded,
          iconBackground: Color(0xFFD92D2D),
          url: '',
        ),
        ServiceItem(
          title: 'Geospasial',
          subtitle: 'Diskominfo Kabupaten Sragen',
          icon: Icons.map_rounded,
          iconBackground: Color(0xFF2E9E6B),
          url: '',
        ),
        ServiceItem(
          title: 'Sewa Gedung / Area Terbuka',
          subtitle: 'Disperkimtaru Kabupaten Sragen',
          icon: Icons.domain_rounded,
          iconBackground: Color(0xFF0E4C7A),
          url: '',
        ),
      ],
    ),
  ];

  // ============================================================
  // BUILD
  // ============================================================
  @override
  Widget build(BuildContext context) {
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
  // SERVICE TAP HANDLER
  // ============================================================
  void _onServiceTap(ServiceItem service) {
    // Layanan dengan halaman internal khusus
    final Widget? screen = _internalScreenFor(service.title);
    if (screen != null) {
      Navigator.push(context, MaterialPageRoute(builder: (_) => screen));
      return;
    }

    if (service.url.isNotEmpty) {
      _openExternalUrl(Uri.parse(service.url));
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Layanan ${service.title} akan segera hadir.'),
          behavior: SnackBarBehavior.floating,
          duration: const Duration(seconds: 2),
        ),
      );
    }
  }

  /// Mengembalikan halaman internal untuk sebuah layanan, atau null bila
  /// layanan tersebut dibuka via URL / belum tersedia.
  Widget? _internalScreenFor(String title) {
    switch (title) {
      case 'Geospasial':
        return const GeospasialScreen();
      case 'Inovasi':
        return const InovasiScreen();
      case 'Kegawatdaruratan':
        return const KegawatdaruratanScreen();
      case 'Layanan Poli RSUD':
        return const PoliRsudScreen();
      case 'Layanan Puskesmas':
        return const PuskesmasScreen();
      case 'Layanan Ketenagakerjaan':
        return const KetenagakerjaanScreen();
      case 'Sewa Gedung / Area Terbuka':
        return const SewaGedungScreen();
      case 'Data Kemiskinan':
        return const KemiskinanScreen();
      case 'Keuangan':
        return const KeuanganScreen();
      case 'Perdagangan':
        return const PerdaganganScreen();
      case 'Pajak':
        return const PajakScreen();
      case 'Bus Sekolah':
        return const BusSekolahScreen();
      case 'Pariwisata':
        return const PariwisataScreen();
      case 'Pengaduan':
        return const PengaduanScreen();
      case 'Pendidikan':
        return const PendidikanScreen();
      case 'Layanan MPP':
        return const LayananMppScreen();
      default:
        return null;
    }
  }

  // ============================================================
  // OPEN EXTERNAL URL
  // ============================================================
  Future<void> _openExternalUrl(Uri uri) async {
    final bool launched = await launchUrl(
      uri,
      mode: LaunchMode.externalApplication,
    );

    if (!launched && mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Tidak dapat membuka tautan layanan.'),
          behavior: SnackBarBehavior.floating,
        ),
      );
    }
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

// ============================================================
// MODEL CLASSES
// ============================================================
class ServiceCategory {
  final String title;
  final String subtitle;
  final IconData icon;
  final Color iconColor;
  final Color iconBackground;
  final List<ServiceItem> services;

  const ServiceCategory({
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.iconColor,
    required this.iconBackground,
    required this.services,
  });
}

class ServiceItem {
  final String title;
  final String subtitle;
  final IconData icon;
  final Color iconBackground;
  final String url;

  const ServiceItem({
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.iconBackground,
    required this.url,
  });
}
