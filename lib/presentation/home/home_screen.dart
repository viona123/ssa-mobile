import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

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
import '../layanan/layanan_search_delegate.dart';
import '../layanan/pariwisata/pariwisata_screen.dart';
import '../layanan/pariwisata/reservasi_screen.dart';
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
    ServiceItem(title: 'Layanan MPP', icon: Icons.apartment_rounded),
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
        return AgendaScreen(
          showBottomNav: false,
          onBack: () {
            setState(() {
              selectedNavigation = 0;
            });
          },
        );
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
                    GestureDetector(
                      behavior: HitTestBehavior.opaque,
                      onTap: () {
                        setState(() {
                          selectedNavigation = 2;
                        });
                      },
                      child: Column(
                        children: [
                          _buildMonthlyAgenda(
                            month: 'OKT',
                            date: '21',
                            title: 'Festival UMKM Sragen',
                            subtitle: '21 Okt - 25 Okt',
                          ),
                          const SizedBox(height: 10),
                          _buildMonthlyAgenda(
                            month: 'OKT',
                            date: '28',
                            title: 'Sumpah Pemuda',
                            subtitle: '28 Okt - 29 Okt',
                          ),
                        ],
                      ),
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
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: _openSearch,
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
      ),
    );
  }

  // ============================================================
  // BUKA PENCARIAN LAYANAN
  // ============================================================

  Future<void> _openSearch() async {
    await showSearch(
      context: context,
      delegate: LayananSearchDelegate(),
    );
  }

  // ============================================================
  // WELCOME CARD
  // ============================================================

  Widget _buildWelcomeCard() {
    const borderRadius = 30.0;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(borderRadius),
        child: AspectRatio(
          aspectRatio: 2.0,
          child: LayoutBuilder(
            builder: (context, constraints) {
              final bannerWidth = constraints.maxWidth;
              final bannerHeight = constraints.maxHeight;
              final titleFontSize = (bannerWidth * 0.073)
                  .clamp(22.0, 48.0)
                  .toDouble();
              final descriptionFontSize = (bannerWidth * 0.028)
                  .clamp(8.5, 24.0)
                  .toDouble();
              final textGap = (bannerHeight * 0.045)
                  .clamp(7.0, 28.0)
                  .toDouble();

              return Stack(
                fit: StackFit.expand,
                children: [
                  // fix.png sudah memiliki komposisi 2:1 dengan manusia
                  // dan batu Sangiran utuh di sisi kanan.
                  Image.asset(
                    'assets/images/home/fix.png',
                    fit: BoxFit.cover,
                    alignment: Alignment.center,
                    errorBuilder: (context, error, stackTrace) {
                      return const DecoratedBox(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.centerLeft,
                            end: Alignment.centerRight,
                            colors: [Color(0xFF007F98), Color(0xFF0798B5)],
                          ),
                        ),
                      );
                    },
                  ),

                  // Deep cyan pekat di kiri, lalu memudar lembut hingga
                  // transparan agar menyatu dengan pemandangan.
                  DecoratedBox(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.centerLeft,
                        end: Alignment.centerRight,
                        colors: [
                          const Color(0xFF007F98),
                          const Color(0xFF008FA8).withValues(alpha: 0.97),
                          const Color(0xFF0798B5).withValues(alpha: 0.72),
                          const Color(0xFF0798B5).withValues(alpha: 0.30),
                          Colors.transparent,
                        ],
                        stops: const [0.0, 0.32, 0.42, 0.52, 0.60],
                      ),
                    ),
                  ),

                  // Hanya judul dan deskripsi, seluruhnya di area biru kiri.
                  Positioned(
                    left: bannerWidth * 0.055,
                    top: bannerHeight * 0.17,
                    width: bannerWidth * 0.40,
                    child: FittedBox(
                      fit: BoxFit.scaleDown,
                      alignment: Alignment.topLeft,
                      child: SizedBox(
                        width: bannerWidth * 0.40,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Selamat\nDatang',
                              style: GoogleFonts.poppins(
                                color: Colors.white,
                                fontSize: titleFontSize,
                                fontWeight: FontWeight.w700,
                                height: 1.05,
                                letterSpacing: -0.35,
                              ),
                            ),
                            SizedBox(height: textGap),
                            Text(
                              'Satu identitas digital untuk\n'
                              'akses seluruh layanan publik\n'
                              'Sragen dengan aman.',
                              style: GoogleFonts.poppins(
                                color: Colors.white,
                                fontSize: descriptionFontSize,
                                fontWeight: FontWeight.w400,
                                height: 1.35,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
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
          const Text(
            'Layanan Digital',
            style: TextStyle(
              fontSize: 21,
              fontWeight: FontWeight.w700,
              color: darkText,
            ),
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
              // Sel terakhir = "Lainnya" -> buka halaman kategori layanan.
              if (index == 11) {
                return GestureDetector(
                  onTap: () => _showAllServices(),
                  child: _buildServiceItem(
                    ServiceItem(
                      title: 'Lainnya',
                      icon: Icons.grid_view_rounded,
                    ),
                  ),
                );
              }
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
                      MaterialPageRoute(builder: (_) => const PoliRsudScreen()),
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
  // LAINNYA — BOTTOM SHEET SELURUH LAYANAN
  // ============================================================

  Future<void> _showAllServices() async {
    await showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      useSafeArea: true,
      backgroundColor: Colors.transparent,
      barrierColor: Colors.black.withValues(alpha: 0.45),
      builder: (sheetContext) {
        return const FractionallySizedBox(
          heightFactor: 0.88,
          child: ClipRRect(
            borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
            child: LayananScreen(showBottomNav: false, showAllServices: true),
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
          child: service.title == 'Lainnya'
              ? _buildMoreServicesIcon(service.iconColor ?? darkBlue)
              : Icon(
                  service.icon,
                  size: 27,
                  color: service.iconColor ?? darkBlue,
                ),
        ),

        const SizedBox(height: 5),

        SizedBox(
          height: 27,
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
              color: darkText,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildMoreServicesIcon(Color color) {
    Widget square() {
      return Container(
        width: 12,
        height: 12,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(3),
        ),
      );
    }

    return Center(
      child: SizedBox(
        width: 28,
        height: 28,
        child: Wrap(
          spacing: 4,
          runSpacing: 4,
          children: [
            square(),
            square(),
            square(),
            SizedBox(
              width: 12,
              height: 12,
              child: Icon(Icons.add_rounded, size: 15, color: color),
            ),
          ],
        ),
      ),
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
            child: GestureDetector(
              behavior: HitTestBehavior.opaque,
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const ReservasiScreen(
                      namaWisata: 'Museum Purbakala Sangiran',
                      lokasi: 'Kalijambe, Sragen',
                      deskripsi:
                          'Situs prasejarah warisan dunia UNESCO, menyimpan '
                          'koleksi fosil manusia purba...',
                    ),
                  ),
                );
              },
              child: _buildAgendaCard(agendas.first),
            ),
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
