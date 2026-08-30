import 'package:flutter/material.dart';

import '../bantuan/bantuan_screen.dart';
import '../agenda/agenda_screen.dart';
import '../layanan/kegawatdaruratan/kegawatdaruratan_screen.dart';
import '../layanan/kemiskinan/kemiskinan_screen.dart';
import '../layanan/keuangan/keuangan_screen.dart';
import '../layanan/bus_sekolah/bus_sekolah_screen.dart';
import '../layanan/pajak/pajak_screen.dart';
import '../layanan/pendidikan/pendidikan_screen.dart';
import '../layanan/pengaduan/pengaduan_screen.dart';
import '../layanan/perdagangan/perdagangan_screen.dart';
import '../layanan/layanan_mpp/layanan_mpp_screen.dart';
import '../layanan/layanan_screen.dart';
import '../layanan/pariwisata/pariwisata_screen.dart';
import '../layanan/poli_rsud/poli_rsud_screen.dart';
import '../layanan/geospasial/geospasial_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int selectedNavigation = 0;

  // ============================================================
  // COLORS
  // ============================================================

  static const Color primaryBlue = Color(0xFF007EA7);
  static const Color lightBlue = Color(0xFF58D8EC);
  static const Color darkBlue = Color(0xFF315579);
  static const Color darkText = Color(0xFF202124);
  static const Color greyText = Color(0xFF737B86);
  static const Color serviceBox = Color(0xFFE5E9EE);
  static const Color pageBackground = Color(0xFFF8FAFC);

  // ============================================================
  // DATA LAYANAN
  // ============================================================

  final List<ServiceItem> services = [
    ServiceItem(
      title: 'Kegawatdaruratan',
      icon: Icons.emergency,
      iconColor: Color(0xFFD92D2D),
      backgroundColor: Color(0xFFF7E4E4),
    ),
    ServiceItem(title: 'Kemiskinan', icon: Icons.insert_chart_outlined),
    ServiceItem(title: 'Keuangan', icon: Icons.payments_outlined),
    ServiceItem(title: 'Pengaduan', icon: Icons.campaign_outlined),
    ServiceItem(title: 'Layanan MPP', icon: Icons.business_outlined),
    ServiceItem(title: 'Pariwisata', icon: Icons.explore_outlined),
    ServiceItem(title: 'Pajak', icon: Icons.account_balance_wallet_outlined),
    ServiceItem(title: 'Bus Sekolah', icon: Icons.directions_bus_outlined),
    ServiceItem(title: 'Pendidikan', icon: Icons.school_outlined),
    ServiceItem(title: 'Poli RSUD', icon: Icons.medical_services_outlined),
    ServiceItem(title: 'Perdagangan', icon: Icons.storefront_outlined),
    ServiceItem(title: 'Geospasial', icon: Icons.map_outlined),
    ServiceItem(title: 'Inovasi', icon: Icons.lightbulb_outline),
  ];

  // ============================================================
  // DATA AGENDA KOTA
  // ============================================================

  final List<AgendaItem> agendas = [
    AgendaItem(
      title: "Pameran 'The Land Of Java Man'",
      location: 'Museum Sangiran Sragen',
    ),
  ];

  // ============================================================
  // BUILD
  // ============================================================

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: pageBackground,

      // ========================================================
      // BOTTOM NAVIGATION
      // ========================================================
      bottomNavigationBar: _buildBottomNavigation(),

      // ========================================================
      // BODY
      // ========================================================
      body: _buildBody(),
    );
  }

  // ============================================================
  // BODY - SWITCH BERDASARKAN SELECTED NAVIGATION
  // ============================================================

  Widget _buildBody() {
    switch (selectedNavigation) {
      case 1:
        // Layanan Screen
        return const LayananScreen(showBottomNav: false);
      case 2:
        // Agenda Screen
        return AgendaScreen(showBottomNav: false);
      default:
        // Home Screen (Beranda)
        return Stack(
          children: [
            SafeArea(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                padding: const EdgeInsets.only(bottom: 30),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // HEADER
                    _buildHeader(),

                    // SEARCH
                    _buildSearch(),

                    // WELCOME
                    _buildWelcomeCard(),

                    const SizedBox(height: 25),

                    // LAYANAN
                    _buildServicesSection(),

                    // AGENDA KOTA
                    _buildAgendaSection(),

                    // JARAK
                    const SizedBox(height: 20),

                    // AGENDA BULAN INI
                    _buildMonthlyAgenda(
                      month: 'OKT',
                      date: '24',
                      title: 'Agenda Bulan Ini',
                      subtitle: 'Pameran The Land Of Java Man',
                    ),

                    const SizedBox(height: 10),

                    _buildMonthlyAgenda(
                      month: 'OKT',
                      date: '28',
                      title: 'Agenda Bulan Ini',
                      subtitle: 'Pekan Budaya Sragen',
                    ),

                    // RUANG BAWAH AGAR HELP TIDAK MENUTUP CONTENT
                    const SizedBox(height: 90),
                  ],
                ),
              ),
            ),

            // ====================================================
            // PUSAT BANTUAN
            // FIXED DI DEPAN
            // TIDAK IKUT SCROLL
            // ====================================================
            Positioned(right: 26, bottom: 14, child: _buildHelpButton()),
          ],
        );
    }
  }

  // ============================================================
  // HEADER
  // ============================================================

  Widget _buildHeader() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(24, 17, 24, 5),
      child: const Text(
        'Sragen Smart City',
        style: TextStyle(
          fontSize: 22,
          fontWeight: FontWeight.w700,
          color: primaryBlue,
        ),
      ),
    );
  }

  // ============================================================
  // SEARCH
  // ============================================================

  Widget _buildSearch() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(24, 11, 24, 15),
      child: Container(
        height: 50,
        decoration: BoxDecoration(
          color: const Color(0xFFEFF1F4),
          borderRadius: BorderRadius.circular(15),
        ),
        child: const Row(
          children: [
            SizedBox(width: 15),

            Icon(Icons.search, size: 23, color: greyText),

            SizedBox(width: 11),

            Expanded(
              child: Text(
                'Cari layanan pemerintah...',
                style: TextStyle(
                  fontSize: 13,
                  color: greyText,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ============================================================
  // WELCOME CARD
  // ============================================================

  Widget _buildWelcomeCard() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Container(
        height: 165,
        width: double.infinity,
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Color(0xFF1EA7D3), Color(0xFF087CA4)],
          ),
          borderRadius: BorderRadius.circular(23),
          boxShadow: [
            BoxShadow(
              color: primaryBlue.withValues(alpha: 0.14),
              blurRadius: 10,
              offset: const Offset(0, 5),
            ),
          ],
        ),
        child: Stack(
          clipBehavior: Clip.hardEdge,
          children: [
            Positioned(
              right: -35,
              bottom: -45,
              child: Container(
                width: 145,
                height: 145,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: Colors.white.withValues(alpha: 0.15),
                    width: 13,
                  ),
                ),
              ),
            ),

            Padding(
              padding: const EdgeInsets.fromLTRB(22, 17, 22, 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 5,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white.withValues(alpha: 0.13),
                      borderRadius: BorderRadius.circular(18),
                    ),
                    child: const Text(
                      'TERBARU',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 10,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),

                  const SizedBox(height: 9),

                  const Text(
                    'Selamat Datang',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.w500,
                    ),
                  ),

                  const SizedBox(height: 4),

                  const SizedBox(
                    width: 310,
                    child: Text(
                      'Satu identitas digital untuk akses seluruh layanan publik Sragen dengan aman.',
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 13,
                        height: 1.3,
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

  // ============================================================
  // LAYANAN DIGITAL
  // ============================================================

  Widget _buildServicesSection() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Layanan Digital',
                style: TextStyle(
                  fontSize: 21,
                  fontWeight: FontWeight.w700,
                  color: darkText,
                ),
              ),

              GestureDetector(
                onTap: () => _showAllServices(),
                child: const Text(
                  'Lihat Semua',
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                    color: darkBlue,
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(height: 13),

          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: 12,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 4,
              crossAxisSpacing: 11,
              mainAxisSpacing: 12,
              mainAxisExtent: 94,
            ),
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () {
                  final String title = services[index].title;
                  if (title == 'Kegawatdaruratan') {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => const KegawatdaruratanScreen(),
                      ),
                    );
                  } else if (title == 'Kemiskinan') {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => const KemiskinanScreen(),
                      ),
                    );
                  } else if (title == 'Keuangan') {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => const KeuanganScreen()),
                    );
                  } else if (title == 'Bus Sekolah') {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => const BusSekolahScreen(),
                      ),
                    );
                  } else if (title == 'Pajak') {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => const PajakScreen()),
                    );
                  } else if (title == 'Pendidikan') {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => const PendidikanScreen(),
                      ),
                    );
                  } else if (title == 'Pengaduan') {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => const PengaduanScreen(),
                      ),
                    );
                  } else if (title == 'Perdagangan') {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => const PerdaganganScreen(),
                      ),
                    );
                  } else if (title == 'Layanan MPP') {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => const LayananMppScreen(),
                      ),
                    );
                  } else if (title == 'Pariwisata') {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => const PariwisataScreen(),
                      ),
                    );
                  } else if (title == 'Poli RSUD') {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => const PoliRsudScreen(),
                      ),
                    );
                  } else if (title == 'Geospasial') {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => const GeospasialScreen(),
                      ),
                    );
                  }
                },
                child: _buildServiceItem(services[index]),
              );
            },
          ),
        ],
      ),
    );
  }

  // ============================================================
  // LIHAT SEMUA — BOTTOM SHEET SEMUA LAYANAN
  // ============================================================

  void _showAllServices() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return Container(
          height: MediaQuery.of(context).size.height * 0.75,
          decoration: const BoxDecoration(
            color: pageBackground,
            borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
          ),
          child: Column(
            children: [
              // Handle bar
              const SizedBox(height: 12),
              Container(
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: const Color(0xFFD9DEE5),
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              const SizedBox(height: 16),

              // Title
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 24),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Semua Layanan Digital',
                    style: TextStyle(
                      fontSize: 21,
                      fontWeight: FontWeight.w700,
                      color: darkText,
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 16),

              // Grid semua layanan
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: GridView.builder(
                    physics: const BouncingScrollPhysics(),
                    itemCount: services.length,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 4,
                          crossAxisSpacing: 11,
                          mainAxisSpacing: 12,
                          mainAxisExtent: 94,
                        ),
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () {
                          Navigator.pop(context); // tutup bottom sheet
                          final String title = services[index].title;
                          if (title == 'Kegawatdaruratan') {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => const KegawatdaruratanScreen(),
                              ),
                            );
                          } else if (title == 'Kemiskinan') {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => const KemiskinanScreen(),
                              ),
                            );
                          } else if (title == 'Keuangan') {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => const KeuanganScreen(),
                              ),
                            );
                          } else if (title == 'Bus Sekolah') {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => const BusSekolahScreen(),
                              ),
                            );
                          } else if (title == 'Pajak') {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => const PajakScreen(),
                              ),
                            );
                          } else if (title == 'Pendidikan') {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => const PendidikanScreen(),
                              ),
                            );
                          } else if (title == 'Pengaduan') {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => const PengaduanScreen(),
                              ),
                            );
                          } else if (title == 'Perdagangan') {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => const PerdaganganScreen(),
                              ),
                            );
                          } else if (title == 'Layanan MPP') {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => const LayananMppScreen(),
                              ),
                            );
                          } else if (title == 'Pariwisata') {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => const PariwisataScreen(),
                              ),
                            );
                          } else if (title == 'Poli RSUD') {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => const PoliRsudScreen(),
                              ),
                            );
                          } else if (title == 'Geospasial') {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => const GeospasialScreen(),
                              ),
                            );
                          }
                        },
                        child: _buildServiceItem(services[index]),
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  // ============================================================
  // SERVICE ITEM
  // ============================================================

  Widget _buildServiceItem(ServiceItem service) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 60,
          height: 60,
          decoration: BoxDecoration(
            color: service.backgroundColor ?? serviceBox,
            borderRadius: BorderRadius.circular(13),
          ),
          child: Icon(
            service.icon,
            size: 27,
            color: service.iconColor ?? darkBlue,
          ),
        ),

        const SizedBox(height: 5),

        SizedBox(
          height: 27,
          child: Text(
            service.title,
            textAlign: TextAlign.center,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              fontSize: 9,
              height: 1.1,
              color: darkText,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ],
    );
  }

  // ============================================================
  // AGENDA KOTA
  // ============================================================

  Widget _buildAgendaSection() {
    return Padding(
      padding: const EdgeInsets.only(top: 28),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Row(
              children: [
                Container(
                  width: 4,
                  height: 34,
                  decoration: BoxDecoration(
                    color: primaryBlue,
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),

                const SizedBox(width: 10),

                const Text(
                  'Agenda Kota',
                  style: TextStyle(
                    fontSize: 21,
                    fontWeight: FontWeight.w700,
                    color: darkText,
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 13),

          // ====================================================
          // AGENDA (full width)
          // ====================================================
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: _buildAgendaCard(agendas.first),
          ),
        ],
      ),
    );
  }

  // ============================================================
  // AGENDA CARD
  // ============================================================

  Widget _buildAgendaCard(AgendaItem agenda) {
    return Container(
      width: double.infinity,
      height: 290,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(17),
        border: Border.all(color: const Color(0xFFD9DEE5)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.04),
            blurRadius: 6,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      clipBehavior: Clip.antiAlias,
      child: Column(
        children: [
          // ====================================================
          // GAMBAR
          // LEBIH PANJANG KE BAWAH
          // ====================================================
          SizedBox(
            height: 180,
            width: double.infinity,
            child: Stack(
              children: [
                Container(
                  width: double.infinity,
                  height: double.infinity,
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [Color(0xFF76C3D4), Color(0xFF3B94A9)],
                    ),
                  ),
                  child: const Center(
                    child: Icon(
                      Icons.account_balance,
                      size: 57,
                      color: Colors.white70,
                    ),
                  ),
                ),

                // FEATURED
                Positioned(
                  left: 13,
                  top: 12,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 11,
                      vertical: 5,
                    ),
                    decoration: BoxDecoration(
                      color: const Color(0xFFB57A00),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: const Text(
                      'FEATURED',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 8,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),

          // ====================================================
          // DETAIL AGENDA
          // ====================================================
          Expanded(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(14, 8, 14, 8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // JUDUL
                  Text(
                    agenda.title,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w700,
                      color: darkText,
                    ),
                  ),

                  const SizedBox(height: 4),

                  // LOKASI
                  Row(
                    children: [
                      const Icon(
                        Icons.location_on_outlined,
                        size: 14,
                        color: greyText,
                      ),

                      const SizedBox(width: 3),

                      Expanded(
                        child: Text(
                          agenda.location,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(fontSize: 9, color: greyText),
                        ),
                      ),
                    ],
                  ),

                  const Spacer(),

                  // RESERVASI
                  Align(
                    alignment: Alignment.centerRight,
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Text(
                          'Reservasi',
                          style: TextStyle(
                            color: darkBlue,
                            fontSize: 9,
                            fontWeight: FontWeight.w700,
                          ),
                        ),

                        const SizedBox(width: 3),

                        const Icon(
                          Icons.confirmation_number_outlined,
                          size: 14,
                          color: darkBlue,
                        ),
                      ],
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
  // AGENDA BULAN INI
  // ============================================================

  Widget _buildMonthlyAgenda({
    required String month,
    required String date,
    required String title,
    required String subtitle,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Container(
        height: 82,
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 7),
        decoration: BoxDecoration(
          color: const Color(0xFFEAF7FC),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: const Color(0xFFD2E9F1)),
        ),
        child: Row(
          children: [
            // ==================================================
            // TANGGAL
            // ==================================================
            Container(
              width: 60,
              height: 64,
              decoration: BoxDecoration(
                color: primaryBlue,
                borderRadius: BorderRadius.circular(13),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    month,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 8,
                      fontWeight: FontWeight.w700,
                    ),
                  ),

                  const SizedBox(height: 1),

                  Text(
                    date,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      height: 1,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(width: 9),

            // ==================================================
            // TEXT
            // ==================================================
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w700,
                      color: darkText,
                    ),
                  ),

                  const SizedBox(height: 3),

                  Text(
                    subtitle,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(fontSize: 9, color: greyText),
                  ),
                ],
              ),
            ),

            const SizedBox(width: 7),

            // ==================================================
            // ICON
            // ==================================================
            Container(
              width: 44,
              height: 44,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(11),
              ),
              child: const Icon(
                Icons.calendar_month_outlined,
                size: 21,
                color: primaryBlue,
              ),
            ),
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
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const BantuanScreen()),
          );
        },
        child: Container(
          width: 58,
          height: 58,
          decoration: BoxDecoration(
            color: primaryBlue,
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
            color: Colors.white,
            size: 29,
          ),
        ),
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
              child: _buildNavItem(
                index: 0,
                icon: Icons.home_outlined,
                activeIcon: Icons.home_rounded,
                label: 'Beranda',
              ),
            ),

            Expanded(
              child: _buildNavItem(
                index: 1,
                icon: Icons.grid_view_rounded,
                activeIcon: Icons.grid_view_rounded,
                label: 'Layanan',
              ),
            ),

            Expanded(
              child: _buildNavItem(
                index: 2,
                icon: Icons.calendar_month_outlined,
                activeIcon: Icons.calendar_month_rounded,
                label: 'Agenda',
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ============================================================
  // NAV ITEM
  // ============================================================
  Widget _buildNavItem({
    required int index,
    required IconData icon,
    required IconData activeIcon,
    required String label,
  }) {
    final bool isSelected = selectedNavigation == index;

    return GestureDetector(
      onTap: () {
        setState(() {
          selectedNavigation = index;
        });
      },
      child: Center(
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          width: 95,
          height: 52,
          decoration: BoxDecoration(
            color: isSelected ? lightBlue : Colors.transparent,
            borderRadius: BorderRadius.circular(27),
          ),

          // NAIKKAN ISI NAVBAR SEDIKIT
          child: Transform.translate(
            offset: const Offset(0, -1),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  isSelected ? activeIcon : icon,
                  size: 22,
                  color: isSelected ? darkBlue : const Color(0xFF374151),
                ),

                const SizedBox(height: 1),

                Text(
                  label,
                  style: TextStyle(
                    fontSize: 9,
                    fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
                    color: isSelected ? darkBlue : const Color(0xFF374151),
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
// SERVICE MODEL
// ================================================================

class ServiceItem {
  final String title;
  final IconData icon;
  final Color? iconColor;
  final Color? backgroundColor;

  const ServiceItem({
    required this.title,
    required this.icon,
    this.iconColor,
    this.backgroundColor,
  });
}

// ================================================================
// AGENDA MODEL
// ================================================================

class AgendaItem {
  final String title;
  final String location;

  const AgendaItem({required this.title, required this.location});
}
